function [ data_parsed ] = replaceNaNbyMean( X )
% Add the value for each instance
    for i=1:1:size(X,1)
        prov_attribute = X(i,:);
        if isnumeric(prov_attribute)
			notNaN = ~isnan(prov_attribute);
			prov_attribute(~notNaN) = 0;
			howMany = sum(notNaN);
			columnTot = sum(prov_attribute);
			colMean = columnTot / howMany;
			if isnan(colMean)
				data_parsed(i,:)=[];
			else
				prov_attribute(find(notNaN==0))=colMean;
				data_parsed(i,:) = prov_attribute;
			end
			
        else
            %data_parsed(:,i) = prov_attribute';
        end
    end

end

