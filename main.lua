function love.load()
    love.graphics.setBackgroundColor(0.05, 0.05, 0.15)
    
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    
    pixelSize = 4
    
    colors = {
        snake = {0.2, 1, 0.3},
        snakeDark = {0.1, 0.5, 0.15},
        obstacle = {1, 0.2, 0.3},
        obstacleDark = {0.5, 0.1, 0.15},
        number = {1, 1, 0.2},
        numberGlow = {1, 1, 0.5},
        ground = {0.2, 0.15, 0.3},
        sky = {0.1, 0.1, 0.25},
        text = {0.9, 0.9, 1}
    }
    
    snake = {
        segments = {},
        baseY = screenHeight * 0.7,
        speed = 200,
        jumpVelocity = 0,
        jumpPower = -300,
        gravity = 900,
        isJumping = false,
        waveOffset = 0,
        segmentSpacing = 16
    }
    
    for i = 1, 8 do
        table.insert(snake.segments, {
            x = -i * snake.segmentSpacing,
            y = snake.baseY,
            angle = 0
        })
    end
    
    obstacles = {}
    obstacleSpawnTimer = 0
    obstacleSpawnInterval = 2
    
    numbers = {}
    numberSpawnTimer = 0
    numberSpawnInterval = 3
    
    score = 0
    gameTime = 0
    
    groundY = screenHeight * 0.75
    
    stars = {}
    for i = 1, 30 do
        table.insert(stars, {
            x = math.random(0, screenWidth),
            y = math.random(0, groundY - 50),
            size = math.random(1, 2),
            twinkle = math.random() * math.pi * 2
        })
    end
    
    scanlineAlpha = 0.15
    scanlineTimer = 0
end

function love.update(dt)
    gameTime = gameTime + dt
    scanlineTimer = scanlineTimer + dt
    
    snake.waveOffset = snake.waveOffset + dt * 3
    
    local headX = snake.segments[1].x + snake.speed * dt
    snake.segments[1].x = headX
    
    if love.keyboard.isDown("space") and not snake.isJumping then
        snake.jumpVelocity = snake.jumpPower
        snake.isJumping = true
    end
    
    if snake.isJumping then
        snake.jumpVelocity = snake.jumpVelocity + snake.gravity * dt
        snake.segments[1].y = snake.segments[1].y + snake.jumpVelocity * dt
        
        if snake.segments[1].y >= snake.baseY then
            snake.segments[1].y = snake.baseY
            snake.jumpVelocity = 0
            snake.isJumping = false
        end
    end
    
    for i = 2, #snake.segments do
        local target = snake.segments[i - 1]
        local segment = snake.segments[i]
        
        local dx = target.x - segment.x - snake.segmentSpacing
        segment.x = segment.x + dx * 8 * dt
        
        if i <= 3 or not snake.isJumping then
            local targetY = snake.baseY + math.sin(snake.waveOffset + i * 0.5) * 5
            if i == 2 and snake.isJumping then
                targetY = target.y + (snake.baseY - target.y) * 0.3
            end
            local dy = targetY - segment.y
            segment.y = segment.y + dy * 8 * dt
        else
            local dy = target.y - segment.y
            segment.y = segment.y + dy * 6 * dt
        end
        
        segment.angle = math.atan2(target.y - segment.y, target.x - segment.x)
    end
    
    if snake.segments[1].x > screenWidth + 100 then
        for i = 1, #snake.segments do
            snake.segments[i].x = snake.segments[i].x - (screenWidth + 200)
        end
    end
    
    obstacleSpawnTimer = obstacleSpawnTimer + dt
    if obstacleSpawnTimer >= obstacleSpawnInterval then
        obstacleSpawnTimer = 0
        obstacleSpawnInterval = math.random(1.5, 3)
        
        table.insert(obstacles, {
            x = screenWidth + 50,
            y = groundY,
            width = math.random(20, 40),
            height = math.random(30, 60),
            passed = false
        })
    end
    
    for i = #obstacles, 1, -1 do
        obstacles[i].x = obstacles[i].x - snake.speed * dt
        
        if not obstacles[i].passed and obstacles[i].x < snake.segments[1].x then
            obstacles[i].passed = true
            
            local headY = snake.segments[1].y
            local obstacleTop = obstacles[i].y - obstacles[i].height
            
            if headY > obstacleTop - 10 then
                score = math.max(0, score - 5)
            end
        end
        
        if obstacles[i].x < -100 then
            table.remove(obstacles, i)
        end
    end
    
    numberSpawnTimer = numberSpawnTimer + dt
    if numberSpawnTimer >= numberSpawnInterval then
        numberSpawnTimer = 0
        numberSpawnInterval = math.random(2, 4)
        
        table.insert(numbers, {
            x = screenWidth + 50,
            y = math.random(groundY - 150, groundY - 50),
            value = math.random(1, 9),
            collected = false,
            floatOffset = math.random() * math.pi * 2
        })
    end
    
    for i = #numbers, 1, -1 do
        numbers[i].x = numbers[i].x - snake.speed * dt
        numbers[i].floatOffset = numbers[i].floatOffset + dt * 2
        
        local headX = snake.segments[1].x
        local headY = snake.segments[1].y
        local dist = math.sqrt((headX - numbers[i].x)^2 + (headY - numbers[i].y)^2)
        
        if dist < 30 and not numbers[i].collected then
            numbers[i].collected = true
            score = score + numbers[i].value
        end
        
        if numbers[i].x < -50 or numbers[i].collected then
            table.remove(numbers, i)
        end
    end
    
    for _, star in ipairs(stars) do
        star.twinkle = star.twinkle + dt * 2
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(1, 1)
    
    for _, star in ipairs(stars) do
        local alpha = 0.3 + math.sin(star.twinkle) * 0.2
        love.graphics.setColor(1, 1, 0.8, alpha)
        love.graphics.rectangle("fill", star.x, star.y, star.size * pixelSize, star.size * pixelSize)
    end
    
    love.graphics.setColor(colors.ground)
    love.graphics.rectangle("fill", 0, groundY, screenWidth, screenHeight - groundY)
    
    for x = 0, screenWidth, 32 do
        love.graphics.setColor(0.15, 0.1, 0.2, 0.3)
        love.graphics.rectangle("fill", x, groundY, 2, screenHeight - groundY)
    end
    
    for _, obstacle in ipairs(obstacles) do
        love.graphics.setColor(colors.obstacleDark)
        love.graphics.rectangle("fill", 
            obstacle.x - obstacle.width/2 + 2, 
            obstacle.y - obstacle.height + 2, 
            obstacle.width, 
            obstacle.height)
        
        love.graphics.setColor(colors.obstacle)
        love.graphics.rectangle("fill", 
            obstacle.x - obstacle.width/2, 
            obstacle.y - obstacle.height, 
            obstacle.width, 
            obstacle.height)
        
        love.graphics.setColor(colors.obstacleDark)
        love.graphics.rectangle("fill", 
            obstacle.x - obstacle.width/2 + 4, 
            obstacle.y - obstacle.height + 4, 
            obstacle.width - 8, 
            obstacle.height - 8)
    end
    
    for _, num in ipairs(numbers) do
        local floatY = num.y + math.sin(num.floatOffset) * 5
        
        love.graphics.setColor(colors.numberGlow[1], colors.numberGlow[2], colors.numberGlow[3], 0.3)
        for dx = -8, 8, 4 do
            for dy = -8, 8, 4 do
                love.graphics.print(tostring(num.value), num.x + dx - 8, floatY + dy - 12, 0, 3, 3)
            end
        end
        
        love.graphics.setColor(colors.number)
        love.graphics.print(tostring(num.value), num.x - 8, floatY - 12, 0, 3, 3)
    end
    
    for i = #snake.segments, 1, -1 do
        local segment = snake.segments[i]
        
        love.graphics.push()
        love.graphics.translate(segment.x, segment.y)
        love.graphics.rotate(segment.angle)
        
        love.graphics.setColor(colors.snakeDark)
        love.graphics.rectangle("fill", -8, -6, 18, 14)
        
        love.graphics.setColor(colors.snake)
        love.graphics.rectangle("fill", -8, -8, 16, 16)
        
        if i == 1 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 4, -4, 4, 4)
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 5, -3, 2, 2)
        end
        
        love.graphics.setColor(colors.snakeDark)
        love.graphics.rectangle("fill", -6, -6, 12, 12)
        
        love.graphics.pop()
    end
    
    love.graphics.setColor(colors.text)
    love.graphics.print("SCORE: " .. score, 20, 20, 0, 2, 2)
    love.graphics.print("SPACE TO JUMP", screenWidth - 200, 20, 0, 1.5, 1.5)
    
    love.graphics.setColor(1, 1, 1, scanlineAlpha * math.sin(scanlineTimer * 3))
    for y = 0, screenHeight, 2 do
        love.graphics.rectangle("fill", 0, y, screenWidth, 1)
    end
    
    love.graphics.setColor(0, 0, 0, 0.1)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    
    love.graphics.pop()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end