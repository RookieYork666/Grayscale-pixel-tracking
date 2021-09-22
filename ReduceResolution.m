obj = VideoReader('vvvv.mp4');%original video
numFrames = obj.NumberOfFrames;% the total amount of frame 

%video zipped
newPath = obj.Path;
newName = ['size240x320',obj.Name];
newfps = obj.FrameRate;
newObj=VideoWriter([newPath,'\',newName]);  %创建一个avi视频文件对象，开始时其为空
newObj.FrameRate=newfps;
open(newObj);


hwait=waitbar(0,'transfering...');
for i = 1:numFrames
    frame = read(obj,i);
    newFrame = imresize(frame,[240 320]); 
    if mod(i,numFrames/100) == 0
        waitbar(i/numFrames,hwait);
    end
    %output
    writeVideo(newObj,newFrame);
end
close(newObj);
close(hwait);
