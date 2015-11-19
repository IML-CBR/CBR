function w = analyticLinearRegression(x,y)
    w = inv(x*x')*x*y;
end