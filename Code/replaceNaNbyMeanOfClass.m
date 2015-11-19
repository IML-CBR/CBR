function [ data_parsed ] = replaceNaNbyMeanOfClass( X, Y )

% Add the value for each instance
	data_parsed = X;
    classes = unique(Y);
    for i=1:1:size(X,1)
        prov_attribute = X(i,:);
        for j=1:1:size(classes,1)
            instancesfromClass = find(Y~=classes(j));
            if isnumeric(prov_attribute)
                notNaN = (intersect(instancesfromClass,find(~isnan(prov_attribute))))';
                yesNaN = (intersect(instancesfromClass,find(isnan(prov_attribute))))';
%                 prov_attribute(yesNaN) = 0;
                howMany = size(notNaN,2);
                columnTot = sum(prov_attribute(notNaN));
                colMean = columnTot / howMany;
                if isnan(colMean)
                    data_parsed(i,instancesfromClass)=[];
                else
                    prov_attribute(yesNaN)=colMean;
                end

            else
                data_parsed(:,i) = prov_attribute';
            end
        end
        data_parsed(i,:) = prov_attribute;
    end

end

