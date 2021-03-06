return function(p, i, d, setpoint, max, min)
   local integral = 0
   local previous_error = 0
   
   return function (value, dt)
      local error = value - setpoint

      local pOut = p * error

      local integral = integral + (error * dt)
      local iOut = i * integral

      local derivative = (error - previous_error) / dt
      local dOut = d * derivative

      local output = pOut + iOut + dOut

      if output > max then 
         output = max
      elseif output < min then 
         output = min 
      end

      previous_error = error
      
      return output
   end
end
