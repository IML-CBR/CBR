function [ testX_parsed ] = replaceNaNbyMeanOfClassTrain( testX, testY, ...
    trainX, trainY )
    % Replace the NaN values by the mean of the values of the other
	% instances of the same class used previously on the training dataset
	% fragment
    testX_parsed = testX;
    classes = unique(testY);
    for i=1:1:size(testX,1)
        test_attribute = testX(i,:);
        train_attribute = trainX(i,:);
        for j=1:1:size(classes,1)
            testInstancesfromClass = find(testY~=classes(j));
            trainInstancesfromClass = find(trainY~=classes(j));
            if ~isempty(testInstancesfromClass)
                if isnumeric(test_attribute) && ~isempty(trainInstancesfromClass)
                    trainMean = mean(train_attribute(trainInstancesfromClass))';
                    testYesNaN = (intersect(testInstancesfromClass,...
                        find(isnan(test_attribute))))';
                    if isnan(trainMean)
                        test_attribute(testYesNaN)=[];
                    else
                        test_attribute(testYesNaN)=trainMean;
                    end
                else
                     if isnumeric(test_attribute)
                         error('IN:replaceNaNbyMeanOfClassTrain',...
                            ['Error. \nThe label %s, appears in the Test' ...
                            ' dataset but does not appear in the Train' ...
                            ' dataset %s.'],testY(j));
                     else
                         error('IN:replaceNaNbyMeanOfClassTrain',...
                            ['Error. \nThere are non numeric values in the'...
                            ' evaluated dataset.']);
                     end
                end
            end
        end
        testX_parsed(i,:) = test_attribute;
    end
end