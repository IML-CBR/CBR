function CM = minimalGoodnessRetention(current_instance,retrieved_indexes,CM)
    K = CM.CB(retrieved_indexes,:);
    MC = mode(cell2mat(K(:,size(K,2))));
    MK = retrieved_indexes(cell2mat(K(:,size(K,2)))==MC);
    g = max(CM.GB(MK));
    Gmc = CM.GB(cell2mat(CM.CB(:,size(CM.CB,2)))==MC);
    gmax = max(Gmc);
    gmin = min(Gmc);
    threshold = (gmax+gmin)/2;
    if g <= threshold
        CM.CB = [CM.CB;current_instance];
        new_goodness = g;
        CM.GB = [CM.GB; new_goodness];
        CM.GB0 = [CM.GB0; new_goodness];
    end
end