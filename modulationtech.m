function varargout = modulationtech(varargin)
% MODULATIONTECH M-file for modulationtech.fig
%      MODULATIONTECH, by itself, creates a new MODULATIONTECH or raises the existing
%      singleton*.
%      H = MODULATIONTECH returns the handle to a new MODULATIONTECH or the handle to
%      the existing singleton*.
%      MODULATIONTECH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODULATIONTECH.M with the given input
%      arguments.
%      MODULATIONTECH('Property','Value',...) creates a new MODULATIONTECH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modulationtech_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modulationtech_OpeningFcn via varargin.
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help modulationtech
% Last Modified by GUIDE v2.5 06-Oct-2016 19:50:51
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modulationtech_OpeningFcn, ...
                   'gui_OutputFcn',  @modulationtech_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before modulationtech is made visible.
function modulationtech_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modulationtech (see VARARGIN)
% Choose default command line output for modulationtech
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modulationtech wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = modulationtech_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
function pushbutton1_Callback(hObject, eventdata, handles)
F1=50;F2=5;A=4;t=0:0.001:1;
x=A.*sin(2*pi*F1*t);u=A/2.*square(2*pi*F2*t)+A/2;
v=x.*u;subplot(3,1,1);plot(t,x,'r');ylabel('Amlitude');
title('Carrier');grid on;subplot(3,1,2);plot(t,u);
ylabel('Amlitude');title('Square pulses');grid on;
subplot(3,1,3);plot(t,v,'g');
xlabel('Time');
ylabel('Amplitude');
title('Ask signal');
axes1(handles,axes1)
grid on;
function pushbutton2_Callback(hObject, eventdata, handles)
fc1=12; fc2=55; fp=5; amp=4; amp=amp/2;t=0:0.001:1;
c1=amp.*sin(2*pi*fc1*t); c2=amp.*sin(2*pi*fc2*t);
subplot(4,1,1);plot(t,c1,'r')
ylabel('Amplitude')
title('Carrier 1 Wave')
subplot(4,1,2); plot(t,c2);
ylabel('Amplitude')
title('Carrier 2 Wave')
m=amp.*square(2*pi*fp*t)+amp;
subplot(4,1,3); plot(t,m,'c')
ylabel('Amplitude')
title('Binary Message Pulses')
for i=0:1000
if m(i+1)==0
mm(i+1)=c2(i+1);
else
mm(i+1)=c1(i+1);
end
end
subplot(4,1,4); plot(t,mm,'g');
xlabel('Time') ;ylabel('Amplitude');
title('Modulated Wave')
axes(handles,axes1)
function pushbutton3_Callback(hObject, eventdata, handles)
F1=30; F2=5; A=4; t=0:0.001:1; x=A.*sin(2*pi*F1*t);
subplot(3,1,1); plot(t,x,'r');
ylabel('Amlitude');
title('Carrier');
grid on;
u=square(2*pi*F2*t);
subplot(3,1,2); plot(t,u);
ylabel('Amlitude');
title('Square pulses');
grid on;
v=x.*u;
subplot(3,1,3);
plot(t,v,'g');
axis([0 1 -6 6]);
xlabel('Time');
ylabel('Amplitude');
title('PSK signal');
grid on;
axes(handles,axes1)
function pushbutton4_Callback(hObject, eventdata, handles)
data=[0 1 0 1 1 1 0 0 1 1];
data_NZR=2*data-1;
s_p_data=reshape(data_NZR,2,length(data)/2);
br=10.^6; f=br; T=1/br; t=T/99:T/99:T;
y=[]; y_in=[]; y_qd=[];
for(i=1:length(data)/2)
    y1=s_p_data(1,i)*cos(2*pi*f*t); 
    y2=s_p_data(2,i)*sin(2*pi*f*t) ;
    y_in=[y_in y1]; y_qd=[y_qd y2]; y=[y y1+y2];
end
Tx_sig=y; tt=T/99:T/99:(T*length(data))/2;
subplot(3,1,1); plot(tt,y_in,'r');
grid on;
title(' wave form for inphase component in QPSK modulation ');
xlabel('time');
ylabel(' Amplitude');
subplot(3,1,2); plot(tt,y_qd);
grid on;
title(' wave form for Quadrature component in QPSK modulation ');
ylabel(' Amplitude');
subplot(3,1,3); plot(tt,Tx_sig,'g');
grid on;
title('QPSK (sum of inphase and Quadrature phase signal)');
xlabel('time');
ylabel('Amplitude');
axes(handles,axes1)
function pushbutton5_Callback(hObject, eventdata, handles)
t = 0:0.0001:20; c=2; part = -1:0.1:1;
codebook = -1:0.1:1.1; msg = cos(t);
[~,quants] = quantiz(msg,part,codebook);
subplot(3,1,1); plot(t,msg,'r');
title('Message Signal');
subplot(3,1,2); plot(t,quants);
title('Quantized Signal');
y = uencode(quants,c);
ybin=dec2bin(y,c);
subplot(3,1,3); plot(t,y,'g');
title('PCM');
axes(handles,axes1)
function pushbutton6_Callback(hObject, eventdata, handles)
 a=4; t=0:2*pi/50:2*pi; x=a*sin(t); l=length(x);
 plot(x,'r'); delta=0.2;
 hold on
 xn=0;
for i=1:l;
 if x(i)>xn(i)
   d(i)=1;
   xn(i+1)=xn(i)+delta;
 else
   d(i)=0; 
   xn(i+1)=xn(i)-delta;
 end
end
stairs(xn)
hold on
for i=1:d
if d(i)>xn(i)
d(i)=0;
xn(i+1)=xn(i)-delta;
else
d(i)=1; xn(i+1)=xn(i)+delta;
end
end
plot(xn,'g');
legend('Analog signal','Delta modulation','Demodulation')
title('DELTA MODULATION/DEMODULATION ')
axes(handles,axes1)
function pushbutton7_Callback(hObject, eventdata, handles)
t = 0:0.001:1; fc =100; fm =20; a = 10;vc = square(2*pi*fc*t);
vm = a.*sin(2*pi*fm*t); n = length(vc);
for i = 1:n
    if (vc(i)<=0)
        vc(i) = 0;
    else
        vc(i) = 1;
    end
end
y = vc.*vm;
subplot(3,1,1); plot(t,vm,'r');
xlabel('Time Axis');
ylabel('Amplitude');
title('Message Signal');
subplot(3,1,2); plot(t,vc);
xlabel('Time Axis');
ylabel('Amplitude');
title('Carrier Signal');
axis([0 1 0 1.5]);
subplot(3,1,3); plot(t,y,'g'); 
xlabel('Time Axis');
ylabel('Amplitude');
title('Sampled Signal(Natural)');
axis([0 1 -a-3 a+3])
axes(handles,axes1)
function pushbutton8_Callback(hObject, eventdata, handles)
close all hidden