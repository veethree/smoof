-- Smoof: A tiny tweening library for lua
--
--
-- MIT License
-- 
-- Copyright (c) 2021 Pawel Þorkelsson
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local smoof = {
    stack = {},
    default_smoof_value = 10,
    default_completion_threshold = 1
}

local function in_stack(object) 
    local duplicate = false
    for i,item in ipairs(smoof.stack) do
        if item.object == object then
            if not duplicate then duplicate = {} end
            duplicate[#duplicate + 1] = {
                key = i,
                item = item
            }
        end
    end
    return duplicate
end

function smoof:setDefaultSmoofValue(val)
    self.default_smoof_value = val
end

function smoof:setCompletionThreshold(threshold)
    self.default_completion_threshold = threshold
end

function smoof:tween(object, target, smoof_value, completion_threshold)
    smoof_value = smoof_value or self.default_smoof_value
    completion_threshold = completion_threshold or self.default_completion_threshold

    -- Checking if exists
    local duplicates = in_stack(object)
    local remove_list = {}
    
    -- If object is already in stack, Remove it.
    -- TODO: Have it check if the new tween has different targets, Then combine them 
    -- instead of just removing the older one
     if duplicates then
         for _, duplicate in ipairs(duplicates) do
            table.remove(self.stack, duplicate.key)
         end
     end

    -- Adding to stack
    self.stack[#self.stack + 1] = {
        object = object,
        target = target,
        smoof_value = smoof_value,
        completion_threshold = completion_threshold
    }
end

function smoof:update(dt)
    for _,item in ipairs(self.stack) do
        local finished = true
        for key,val in pairs(item.target) do
            -- Smoofing
            item.object[key] = item.object[key] + (val - item.object[key]) * item.smoof_value * dt
            -- Checking if the value is within the threshold
            if math.abs(item.object[key] - val) > item.completion_threshold then
                finished = false
            end 
        end
        if finished then
            -- Removing from stack if finished
            table.remove(self.stack, _)     
        end
    end
end

return smoof