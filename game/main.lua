function love.load()
  -- the height of a meter our worlds will be 64px
  love.physics.setMeter(64)
  -- create a world for the bodies to exist in with horizontal gravity
  -- of 0 and vertical gravity of 9.81
  world = love.physics.newWorld(0, 9.81*64, true)
 
  objects = {} -- table to hold all our physical objects
 
  objects.cart = {}
  objects.cart.body = love.physics.newBody(world, 325, 305, 'dynamic')
  objects.cart.shape = love.physics.newRectangleShape(40, 40)
  objects.cart.fixture = love.physics.newFixture(objects.cart.body,
                                                   objects.cart.shape, 1)
  objects.cart.body:setFixedRotation(true);
  objects.cart.fixture:setCategory(2)

  objects.pole = {}
  objects.pole.body = love.physics.newBody(world, 325, 200, 'dynamic')
  objects.pole.shape = love.physics.newRectangleShape(10, 175)
  objects.pole.fixture = love.physics.newFixture(objects.pole.body,
                                                 objects.pole.shape, 1)
  objects.pole.fixture:setCategory(1)
  objects.pole.fixture:setMask(2)
  -- objects.pole.body:setLinearDamping(.1)  
  -- objects.pole.body:setInertia(.1)
  -- objects.pole.body:setAngularDamping(4)
  objects.pole.body:setAngle(math.rad(3)) 

  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 325, 325, 'static')
  objects.ground.shape = love.physics.newRectangleShape(650, 10)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body,
                                                            objects.ground.shape)   
  objects.ground.fixture:setCategory(2)                                                                                       

  love.physics.newRevoluteJoint(objects.cart.body, objects.pole.body, 325, 305, 325, 305, false)                                               
 
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.window.setMode(650, 650) -- set the window dimensions to 650 by 650
end
 
 
function love.update(dt)
  world:update(dt) -- this puts the world into motion
 
  if love.keyboard.isDown("right") then
    objects.cart.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then
    objects.cart.body:applyForce(-400, 0)
  end

  local sx, sy = objects.pole.body:getLinearVelocity()
  local fx = -sx * .3
  objects.pole.body:applyForce(fx, 0)

  print(objects.pole.body:getAngle())
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

  -- set the drawing color to red for the ground
  love.graphics.setColor(0.23, 0.03, 0.89)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(
                          objects.ground.shape:getPoints()))
end
