function plotHistogram(idx, obsLength, filesPerClass, nClasses)

% Plot classwise histogram
datapointsInEachClass = sum(reshape(obsLength,[filesPerClass nClasses]));
prev = 0;
for i = 1:nClasses
    data(i).vals = idx(prev+1:prev + datapointsInEachClass(i));
    prev = datapointsInEachClass(i);
end

subplot(3,2,1)
histogram(data(1).vals)
title('Beat3')
hold on
subplot(3,2,3)
histogram(data(2).vals)
title('Beat4')

subplot(3,2,5)
histogram(data(3).vals)
title('Circle')

subplot(3,2,2)
histogram(data(4).vals)
title('Eight')

subplot(3,2,4)
histogram(data(5).vals)
title('Infinity')

subplot(3,2,6)
histogram(data(6).vals)
title('Wave')


end

