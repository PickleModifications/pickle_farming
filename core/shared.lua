function lerp(a, b, t) return a + (b-a) * t end

function v3(coords) return vec3(coords.x, coords.y, coords.z), coords.w end

function dprint(...)
    if Config.Debug then 
        print(...)
    end
end