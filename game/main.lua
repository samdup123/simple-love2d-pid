function love.load()
  -- the height of a meter our worlds will be 64px
  love.physics.setMeter(64)
  -- create a world for the bodies to exist in with horizontal gravity
  -- of 0 and vertical gravity of 9.81
  world = love.physics.newWorld(0, 9.81*64, true)
 
  objects = {} -- table to hold all our physical objects
 
  objects.cart = {}
  objects.cart.body = love.physics.newBody(world, 325, 305, 'dynamic')
  objects.cart.shape = love.physics.newRectangleShape(25, 25)
  objects.cart.fixture = love.physics.newFixture(objects.cart.body,
                                                   objects.cart.shape, 5)
  objects.cart.body:setFixedRotation(true);
  objects.cart.fixture:setCategory(2)

  objects.pole = {}
  objects.pole.body = love.physics.newBody(world, 325, 235, 'dynamic')
  objects.pole.shape = love.physics.newRectangleShape(2, 95)
  objects.pole.fixture = love.physics.newFixture(objects.pole.body,
                                                 objects.pole.shape, 1)
  objects.pole.fixture:setCategory(1)
  objects.pole.fixture:setMask(2)
  objects.pole.body:setLinearDamping(.1)  
  objects.pole.body:setInertia(.1)
  objects.pole.body:setAngularDamping(4)

  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 325, 325, 'static')
  objects.ground.shape = love.physics.newRectangleShape(650, 10)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body,
                                                            objects.ground.shape)   
  objects.ground.fixture:setCategory(2)           

  objects.leftWall = {}
  objects.leftWall.body = love.physics.newBody(world, 0, 0, 'static')
  objects.leftWall.shape = love.physics.newRectangleShape(10, 650)
  objects.leftWall.fixture = love.physics.newFixture(objects.leftWall.body,
                                                            objects.leftWall.shape)   
  objects.leftWall.fixture:setCategory(2)  
  
  objects.rightWall = {}
  objects.rightWall.body = love.physics.newBody(world, 650, 0, 'static')
  objects.rightWall.shape = love.physics.newRectangleShape(10, 650)
  objects.rightWall.fixture = love.physics.newFixture(objects.rightWall.body,
                                                            objects.rightWall.shape)   
  objects.rightWall.fixture:setCategory(2)   
     

  love.physics.newRevoluteJoint(objects.cart.body, objects.pole.body, 325, 305, 325, 305, false)                                               
 
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.window.setMode(650, 650) -- set the window dimensions to 650 by 650
end
 
 
function love.update(dt)
  world:update(dt * .85) -- this puts the world into motion
 
  if love.keyboard.isDown("right") then
    objects.cart.body:applyForce(600, 0)
  elseif love.keyboard.isDown("left") then
    objects.cart.body:applyForce(-600, 0)
  end

  objects.cart.body:setY(305)
end
 
function love.draw()
  -- set the drawing color to green for the cart
  love.graphics.setColor(0.28, 0.63, 0.05)
  love.graphics.polygon("fill", objects.cart.body:getWorldPoints(
                           objects.cart.shape:getPoints()))
 
  -- set the drawing color to red for the pole
  love.graphics.setColor(0.76, 0.18, 0.05)
  love.graphics.polygon("fill", objects.pole.body:getWorldPoints(
                          objects.pole.shape:getPoints()))

  -- set the drawing color for the ground
  love.graphics.setColor(0.13, 0.67, 0.87)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(
                          objects.ground.shape:getPoints()))
  love.graphics.polygon("fill", objects.leftWall.body:getWorldPoints(
                          objects.leftWall.shape:getPoints()))
  love.graphics.polygon("fill", objects.rightWall.body:getWorldPoints(
                          objects.rightWall.shape:getPoints()))
end
