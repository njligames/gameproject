local ScoreManager = {}
ScoreManager.__index = ScoreManager

setmetatable(
    ScoreManager,
    {
        __call = function (self)
            setmetatable({}, self)
            self:initialize()
            return self
        end
    }
)

local PriorityQueue = require 'NJLIC.PriorityQueue'

function ScoreManager:initialize()
    --[[  Initialization.

    Example:
        ScoreManager = require("ScoreManager")
        pq = ScoreManager()
    ]]--
    self.pq = PriorityQueue()
    self.shouldCalculateScore = true
    self.currentScore = 0
end

function ScoreManager:addScore(score)
    time = os.clock()
    self.pq:put(score, time)

    print("added a score of" , score)

    self.shouldCalculateScore = true
end 

function ScoreManager:getScore()
    if self.shouldCalculateScore then
        self:_calculate()
    end 
    return self.currentScore
end

function ScoreManager:_calculateRecurse(pt)
    if pt <= 0 then return 0 end
    if pt == 1 then return 1 end
    return (self:_calculateRecurse(pt - 1) + pt) * pt
end

function ScoreManager:_calculate()
    self.shouldCalculateScore = false

    local score = 0
    local pt = 0

    for i = 1, #self.pq.heap do
        local v = self.pq.heap[i][1]

        if v ~= 0 then
            pt = pt + 1
            score = score + self:_calculateRecurse(pt)
        else
            pt = 0
        end
    end

    self.currentScore = score
end

return ScoreManager

