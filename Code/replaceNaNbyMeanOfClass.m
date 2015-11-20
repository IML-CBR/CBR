function [ X_parsed ] = replaceNaNbyMeanOfClass( X, Y )
	% Replace the NaN values by the mean of the values of the other
	% instances of the same class
    X_parsed = X;
    classes = unique(Y);
    for i=1:1:size(X,1)
        prov_attribute = X(i,:);
        for j=1:1:size(classes,1)
            instancesfromClass = find(Y~=classes(j));
            if isnumeric(prov_attribute)
                notNaN = (intersect(instancesfromClass,find(~isnan(prov_attribute))))';
                yesNaN = (intersect(instancesfromClass,find(isnan(prov_attribute))))';
                colMean = mean(prov_attribute(notNaN));
                if isnan(colMean)
                    prov_attribute(yesNaN)=[];
                else
                    prov_attribute(yesNaN)=colMean;
                end
            else
                error('IN:replaceNaNbyMeanOfClassTrain',...
                    ['Error. \nThere are non numeric values in the'...
                    ' evaluated dataset.']);
            end
        end
        X_parsed(i,:) = prov_attribute;
    end
end

