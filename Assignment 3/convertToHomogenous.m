function points = convertToHomogenous(pnts)
    points = pnts ./ pnts(:,3);
end