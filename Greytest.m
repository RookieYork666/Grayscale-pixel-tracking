% rgbpic=imread('CC1310_structure.jpg');
% grepic=rgb2gray(rgbpic);
% imshow(grepic);
clear;
% implay('EVM amplified.avi');
obj=VideoReader('baby.mp4');
rate=obj.FrameRate;
Duration=obj.Duration;
nFrames=obj.NumFrames;
height=obj.height;
width=obj.Width;
mov(1:nFrames)=struct('cdata',zeros(height,width,1,'uint8'),'colormap',[]);

% Use video viewer to locate the pixel in the selected area

% v=VideoWriter('baby_grey.avi');
% open(v);
t=linspace(0,Duration,nFrames);% the real time
for n=1:nFrames
    mov(n).cdata=rgb2gray(read(obj,n));
    frame=mov(n).cdata;
    % for the location of the pixel, the x and y should be inverted
    % because for the .cdata, the location is repersented by the matrix
    % counting method [row, coloumn], however, for the pixel, its
    % horizontal and vertical coordinated. 
    
%     pixel(number,n)=frame(y,x); should inverted

    pixel(1,n)=frame(135,291);% set the location of sampled pixels
    pixel(2,n)=frame(239,403);
    pixel(3,n)=frame(157,405);
    pixel(4,n)=frame(209,198);
%     pixel(5,n)=frame(200,200);
%     writeVideo(v,frame);
end
% implay(mov);
figure(1);
for k=1:4
    subplot(4,1,k)
    plot(t,pixel(k,:),'r'); %identify whether the signal exhibit periodic charactristic
    title(sprintf('sampled pixel %d',k));
    xlabel('time/sec');
    ylabel('grayscale');
    hold on;
end
% close(v);
figure(2);
% FFT to estimate the periodic frequency
y=fft(pixel(4,:)); % select pixel
y(1) = [];
plot(y,'ro')
xlabel('real(y)')
ylabel('imag(y)')
title('Fourier Coefficients')
figure(3);
nf = length(y);
power = abs(y(1:floor(nf/2))).^2; % power of first half of transform data
maxfreq = 1/2;                   % maximum frequency
freq = (1:nf/2)/(nf/2)*maxfreq;    % equally spaced frequency grid
beat_rate=freq*rate*60;
% convert the frequency to beats/min, unit for heart beat
% 60 sec each minute
plot(beat_rate,power);
xlabel('beat/sec');
ylabel('Power');
peak=find(power==max(power));
fprintf('The pulse rate is %.2f beats/sec. \n',beat_rate(peak));

