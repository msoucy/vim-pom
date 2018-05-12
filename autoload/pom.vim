" Phase of Moon
" Author: Matt Soucy

function! pom#calculate(y, m, d)
    " Adapted from https://www.voidware.com/moon_phase.htm
    " calculates the moon phase (0-7), accurate to 1 segment.
    " 0 = > new moon.
    " 4 => full moon.

    let l:y = a:y
    let l:m = a:m
    let l:d = a:d

    if l:m < 3
        let l:y -= 1
        let l:m += 12
    endif

    let l:m += 1
    let l:c = trunc(365.25 * l:y)
    let l:e = trunc(30.6 * l:m)
    " jd is total days elapsed
    let l:jd = l:c + l:e + l:d - 694039.09
    " divide by the moon cycle (29.53 days)
    let l:jd = l:jd / 29.53
    " int(jd) -> b, take integer part of jd
    let l:b = trunc(l:jd)
    " subtract integer part to leave fractional part of original jd
    let l:jd -= l:b
    " scale fraction from 0-8 and round by adding 0.5
    let l:b = l:jd * 8 + 0.5
    " 0 and 8 are the same so turn 8 into 0
    let l:b = fmod(l:b, 8)
    return float2nr(l:b)
endfunction

function! pom#phaseFor(y, m, d)
    let phase = pom#calculate(a:y, a:m, a:d)
    if phase == 0
        return 'New Moon'
    elseif phase == 1
        return 'Waxing Crescent'
    elseif phase == 2
        return 'First Quarter'
    elseif phase == 3
        return 'Waxing Gibbous'
    elseif phase == 4
        return 'Full Moon'
    elseif phase == 5
        return 'Waning Gibbous'
    elseif phase == 6
        return 'Third Quarter'
    elseif phase == 7
        return 'Waning Crescent'
    else
        return ''
    endif
endfunction

function! pom#uphaseFor(y, m, d)
    let phase = pom#calculate(a:y, a:m, a:d)
    if phase == 0
        return '🌑'
    elseif phase == 1
        return '🌒'
    elseif phase == 2
        return '🌓'
    elseif phase == 3
        return '🌔'
    elseif phase == 4
        return '🌕'
    elseif phase == 5
        return '🌖'
    elseif phase == 6
        return '🌗'
    elseif phase == 7
        return '🌘'
    else
        return ''
    endif
endfunction

function! pom#phase()
    let l:y = str2nr(strftime('%Y'))
    let l:m = str2nr(strftime('%m'))
    let l:d = str2nr(strftime('%d'))
    return pom#phaseFor(l:y, l:m, l:d)
endfunction

function! pom#uphase()
    let l:y = str2nr(strftime('%Y'))
    let l:m = str2nr(strftime('%m'))
    let l:d = str2nr(strftime('%d'))
    return pom#uphaseFor(l:y, l:m, l:d)
endfunction
