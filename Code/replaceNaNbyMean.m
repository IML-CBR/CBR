function [ X_parsed ] = replaceNaNbyMean( X )
    % Replace the NaN values by the mean of the values of the other
	% values that takes the attribut in the other instances of the dataset
    
    for i=1:1:size(X,1)
        prov_attribute = X(i,:);
        if isnumeric(prov_attribute)
			notNaN = ~isnan(prov_attribute);
			prov_attribute(~notNaN) = 0;
			howMany = sum(notNaN);
			columnTot = sum(prov_attribute);
			colMean = columnTot / howMany;
			if isnan(colMean)
				X_parsed(i,:)=[];
			else
				prov_attribute(find(notNaN==0))=colMean;
				X_parsed(i,:) = prov_attribute;
            end
        else
            X_parsed(i,:) = prov_attribute'
        end
    end

end

