%31/7/2018
%syw
%qgjhg@qq.com
%详细注释版
function main(subId, subName, subGender)
% if nargin~=3                                                               %检测输入
%     error('输入被试信息')
% end
if nargin < 3
    subId = '0';
    subName = 'Test';
    subGender = 'M';
end

try
%% 参数设置===================================================================
    Screen('Preference', 'SkipSyncTests', 1);                              %笔记本显卡
    clear InputName MovieData                                              %清除变量；释放内存
    screenNumber = max(Screen('Screens'));                                 %记录屏幕参数
    
    numdistance=1;                                                         %数字间距（倍数）
    picdistance=1;                                                         %图片间距（倍数）
    deltatime=0.02;                                                        %时间间隔
    starttime=0.12;                                                        %开始时间（包含）
    endtime=0.9;                                                           %结束时间（包含）
    
    
    number_interval=0.15;                                                  %数字时间
    eyeblank_interval=0.15;                                                %注视点呈现时间
    obj_interval=0.15;                                                     %记忆项时间
    mask_interval=0.1;                                                     %mask时间
    blank_interval=0.5;                                                    %blank
    cue_interval=0.1;                                                      %线索
    reac_interval=0.8;                                                     %反应时间
    numreac_interval=0.8;                                                  %数字复述检测时间
    trial_min_interval=1;                                                  %trial间时间最小值
    trial_max_interval=2;                                                  %trial间时间最大值
    
    backgroundcolor=[128,128,128];                                         %背景色
    relaxduration=150;                                                     %休息间隔（多少试次休息1次）
    ttimes=1440;                                                           %试次
    
%% 屏幕呈现===================================================================
    [w, wRect]=Screen('OpenWindow',screenNumber, 0,[],32,2);               %打开屏幕(设置颜色、像素等)
    Screen(w,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [a,b]=WindowCenter(w);
    priorityLevel=MaxPriority(w);                                          %速度
    Priority(priorityLevel);
    
%% 坐标设置===================================================================
    cm2pixel = 30;                                                         %单位转换（厘米—像素）
    
%% 定义按键===================================================================
    KbName('UnifyKeyNames');                                               %如需更改按键只需要更改KbName里面的就行
    F = KbName('F'); 
    J = KbName('J');
    escapekey = KbName('Escape');

%% 图片录入===================================================================
    fix_img = imread('material\FIXATION.JPG');                             %注视点
    fix = Screen('MakeTexture',w,fix_img);
    fixRect = Screen('Rect', fix);
    num1_img = imread('material\number_1.jpg');                            %数字
    num1 = Screen('MakeTexture',w,num1_img);
    num1Rect = Screen('Rect', num1);
    num2_img = imread('material\number_2.jpg');                            %数字
    num2 = Screen('MakeTexture',w,num2_img);
    num3_img = imread('material\number_3.jpg');                            %数字
    num3 = Screen('MakeTexture',w,num3_img);
    num4_img = imread('material\number_4.jpg');                            %数字
    num4 = Screen('MakeTexture',w,num4_img);
    num5_img = imread('material\number_5.jpg');                            %数字
    num5 = Screen('MakeTexture',w,num5_img);
    num6_img = imread('material\number_6.jpg');                            %数字
    num6 = Screen('MakeTexture',w,num6_img);
    num7_img = imread('material\number_7.jpg');                            %数字
    num7 = Screen('MakeTexture',w,num7_img);
    num8_img = imread('material\number_8.jpg');                            %数字
    num8 = Screen('MakeTexture',w,num8_img);
    num9_img = imread('material\number_9.jpg');                            %数字
    num9 = Screen('MakeTexture',w,num9_img);
    numPageIndex=[num1,num2,num3,num4,num5,num6,num7,num8,num9];
    
    pic1_img = imread('stimuli\l1.jpg');                                   %刺激图片
    pic1 = Screen('MakeTexture',w,pic1_img);
    picRect=Screen('Rect', pic1);
    pic2_img = imread('stimuli\l2.jpg');
    pic2 = Screen('MakeTexture',w,pic2_img);
    pic3_img = imread('stimuli\l3.jpg');
    pic3 = Screen('MakeTexture',w,pic3_img);
    pic4_img = imread('stimuli\r1.jpg');
    pic4 = Screen('MakeTexture',w,pic4_img);
    pic5_img = imread('stimuli\r2.jpg');
    pic5 = Screen('MakeTexture',w,pic5_img);
    pic6_img = imread('stimuli\r3.jpg');
    pic6 = Screen('MakeTexture',w,pic6_img);
    pic7_img = imread('stimuli\y1.jpg');
    pic7 = Screen('MakeTexture',w,pic7_img);
    pic8_img = imread('stimuli\y2.jpg');
    pic8 = Screen('MakeTexture',w,pic8_img);
    pic9_img = imread('stimuli\y3.jpg');
    pic9 = Screen('MakeTexture',w,pic9_img);
    pic10_img = imread('stimuli\b1.jpg');
    pic10 = Screen('MakeTexture',w,pic10_img);
    pic11_img = imread('stimuli\b2.jpg');
    pic11 = Screen('MakeTexture',w,pic11_img);
    pic12_img = imread('stimuli\b3.jpg');
    pic12 = Screen('MakeTexture',w,pic12_img);
    colorl_img = imread('stimuli\lx.jpg');                                 %颜色
    colorl = Screen('MakeTexture',w,colorl_img);
    colorr_img = imread('stimuli\rx.jpg');
    colorr = Screen('MakeTexture',w,colorr_img);
    colory_img = imread('stimuli\yx.jpg');
    colory = Screen('MakeTexture',w,colory_img);  
    picIndex=[pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9,pic10,pic11,pic12,colorl,colorr,colory];
    
    mask_img = imread('material\mask.jpg');                                %掩蔽
    mask = Screen('MakeTexture',w,mask_img);
    maskRect=Screen('Rect', mask);
    Xcue_img = imread('material\X.jpg');                                   %cue
    Xcue = Screen('MakeTexture',w,Xcue_img);
    cueRect = Screen('Rect', Xcue);
    Scue_img = imread('material\S.jpg');                                   %cue
    Scue = Screen('MakeTexture',w,Scue_img);
    cueIndex=[Xcue,Scue];
    
    startpic_img = imread('material\start.jpg');                                   %刺激图片
    startpic = Screen('MakeTexture',w,startpic_img);
    startpicRect=Screen('Rect', startpic);
    relaxpic_img = imread('material\pause.jpg');                                   %刺激图片
    relaxpic = Screen('MakeTexture',w,relaxpic_img);
    relaxpicRect=Screen('Rect', relaxpic);
    endpic_img = imread('material\end.jpg');                                   %刺激图片
    endpic = Screen('MakeTexture',w,endpic_img);
    endpicRect=Screen('Rect', endpic);
        
%% 鼠标设置===================================================================
    HideCursor;                                                            %隐藏鼠标

%% 随机化试次=================================================================
    condition={'11','12','21','22'};                                       %1=X线索,2=S线索;1=检测形状，2=检测颜色（11,22=线索有效，12,21=线索无效）
    newcondition='';
    for i=1:9                                                              %1-9:l1-l3,r1-r3,y1-y3
        for j=1:4
            newcondition=[newcondition,{[num2str(i),condition{j}]}];
        end
    end
    condition=newcondition;
    newcondition='';
    timepoints=floor((endtime-starttime+deltatime)/deltatime);             %时间点数
    for i=1:timepoints                                                     %01-40:时间点
        for j=1:36
            if(i<10) 
                fujia=['0',num2str(i)];
            else
                fujia=num2str(i);
            end
            newcondition=[newcondition,{[condition{j},fujia]}];
        end
    end
    rng(sum(clock*100));                                                   %重要，必须在
    temp=randperm(length(newcondition));
    newcondition(1,:)=newcondition(1,temp);
    rng(sum(clock*100));
    temp=randperm(length(newcondition));
    newcondition(1,:)=newcondition(1,temp);                                %重复两次随机以增强随机性
    trialindex=newcondition;

    shunxu={'1','2'};                                                      %1=目标在左,2=目标在右
    shunxu = repmat(shunxu,1,9*2*timepoints);
    temp=randperm(length(shunxu));
    shunxu(1,:)=shunxu(1,temp);
    temp=randperm(length(shunxu));
    shunxu(1,:)=shunxu(1,temp);
    objposIndex=shunxu;                                                    %目标呈现位置

%% 输出文件===================================================================
    if exist(['results/' subId '-' subName '-' subGender '.txt'],'file')==0      %检测文件是否存在，如存在则输出到_wrong，避免数据丢失
        fid=fopen(['results/' subId '-' subName '-' subGender '.txt'],'w');
    else
        fid=fopen(['results/' subId '-' subName '-' subGender '_wrong.txt'],'w');
    end
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n','Sub','Name','Gender','trial','rememberNum','rememberObj','cue','testtype','cuepos','SOA','response','responsetime','testnum','numresponse','numresponsetime');
  
%% 屏幕呈现===================================================================
    Screen('TextSize', w, 30);                                             %设置字号
    Screen('Flip',w);
    Screen('FillRect', w, backgroundcolor);                                  %背景
    Screen('Flip',w);
    
%% 实验序列===================================================================
    keyisdown = 1;                                                         %重要！确保按键前无按键
    while(keyisdown)
        [keyisdown,~,~] = KbCheck;
        WaitSecs(0.001);
    end
    Screen('Flip',w);
    Screen('DrawTexture', w, startpic, [],[a-startpicRect(3)/2 b-startpicRect(4)/2 a+startpicRect(3)/2 b+startpicRect(4)/2]); 
                                                                           %实验开始
    Screen('Flip',w);
    KbWait;
    for trial=1:ttimes
        rng(sum(100*clock));                                               %随机种子
        numberindex=randperm(9);
        number1=numberindex(1);                                            %随机取得复述数字
        number2=numberindex(2);
        remembernum=[num2str(number1) ',' num2str(number2)]; 
        Screen('DrawTexture', w, numPageIndex(number1), [],[a-num1Rect(3)*(1/2+numdistance) b-num1Rect(4)/2 a+num1Rect(3)*(1/2-numdistance) b+num1Rect(4)/2]);
        Screen('DrawTexture', w, numPageIndex(number2), [],[a-num1Rect(3)*(1/2-numdistance) b-num1Rect(4)/2 a+num1Rect(3)*(1/2+numdistance) b+num1Rect(4)/2]);        
                                                                           %复述数字
        Screen('Flip',w);
        WaitSecs(number_interval);
        Screen('Flip',w);
        Screen('DrawTexture', w, fix, [],[a-fixRect(3)/2 b-fixRect(4)/2 a+fixRect(3)/2 b+fixRect(4)/2]);
                                                                           %注视点
        Screen('Flip',w);
        WaitSecs(eyeblank_interval);
        Screen('Flip',w);
        Screen('DrawTexture', w, picIndex(str2num(trialindex{trial}(1))), [],[a-picRect(3)/2 b-picRect(4)/2 a+picRect(3)/2 b+picRect(4)/2]); 
                                                                           %记忆项
        Screen('Flip',w);
        WaitSecs(obj_interval);
        Screen('Flip',w);
        Screen('DrawTexture', w, mask, [],[a-maskRect(3)/2 b-maskRect(4)/2 a+maskRect(3)/2 b+maskRect(4)/2]); 
                                                                           %mask
        Screen('Flip',w);
        WaitSecs(mask_interval);        
        Screen('Flip',w);
        WaitSecs(blank_interval);                                          %空屏     
        Screen('Flip',w);   
        Screen('DrawTexture', w, cueIndex(str2num(trialindex{trial}(2))), [],[a-cueRect(3)/2 b-cueRect(4)/2 a+cueRect(3)/2 b+cueRect(4)/2]); 
                                                                           %cue
        Screen('Flip',w);
        WaitSecs(cue_interval);          
        Screen('Flip',w);
        SOAtime=str2num(trialindex{trial}(4))*10+str2num(trialindex{trial}(5));
        WaitSecs(starttime+SOAtime*deltatime);                             %SOA
        outSOAtime=starttime+SOAtime*deltatime;
        Screen('Flip',w);     
        
        keyisdown = 1;                                                     %重要！确保检测呈现前无按键
        while(keyisdown)
            [keyisdown,~,~] = KbCheck;
            WaitSecs(0.001);
        end
        if(objposIndex{trial}=='1')                                        %检测项左/右设置
            isleft=1;
            cuepose='left';
        elseif(objposIndex{trial}=='2')
            isleft=-1;
            cuepose='right';
        end
        if(str2num(trialindex{trial}(3))==1)                               %检测形状
            if(str2num(trialindex{trial}(1))==1||str2num(trialindex{trial}(1))==4||str2num(trialindex{trial}(1))==7)
                 Screen('DrawTexture', w, picIndex(10), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 Screen('DrawTexture', w, picIndex(floor(rand()*2)+11), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            elseif(str2num(trialindex{trial}(1))==2||str2num(trialindex{trial}(1))==5||str2num(trialindex{trial}(1))==8)
                 Screen('DrawTexture', w, picIndex(11), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 ran=floor(rand()*2);
                 if(ran==0)
                     testk=10;
                 elseif(ran==1)
                     testk=12;
                 end
                 Screen('DrawTexture', w, picIndex(testk), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            elseif(str2num(trialindex{trial}(1))==3||str2num(trialindex{trial}(1))==6||str2num(trialindex{trial}(1))==9)
                 Screen('DrawTexture', w, picIndex(12), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 Screen('DrawTexture', w, picIndex(floor(rand()*2)+10), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            end
        elseif(str2num(trialindex{trial}(3))==2)                           %检测颜色
            if(str2num(trialindex{trial}(1))==1||str2num(trialindex{trial}(1))==2||str2num(trialindex{trial}(1))==3)
                 Screen('DrawTexture', w, picIndex(13), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 Screen('DrawTexture', w, picIndex(floor(rand()*2)+14), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            elseif(str2num(trialindex{trial}(1))==4||str2num(trialindex{trial}(1))==5||str2num(trialindex{trial}(1))==6)
                 Screen('DrawTexture', w, picIndex(14), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 ran=floor(rand()*2);
                 if(ran==0)
                     testk=13;
                 elseif(ran==1)
                     testk=15;
                 end
                 Screen('DrawTexture', w, picIndex(testk), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            elseif(str2num(trialindex{trial}(1))==7||str2num(trialindex{trial}(1))==8||str2num(trialindex{trial}(1))==9)
                 Screen('DrawTexture', w, picIndex(15), [],[a-picRect(3)*(1/2+isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2-isleft*picdistance) b+picRect(4)/2]); 
                 Screen('DrawTexture', w, picIndex(floor(rand()*2)+13), [],[a-picRect(3)*(1/2-isleft*picdistance) b-picRect(4)/2 a+picRect(3)*(1/2+isleft*picdistance) b+picRect(4)/2]);                  
            end
        end
        Screen('Flip',w);
        stime=GetSecs;
        isresponse=0;
        while(GetSecs-stime<=reac_interval)                                %反应处理
            [~,~,keycode] = KbCheck;
            if(keycode(J) || keycode(F) || keycode(escapekey))
                isresponse=1;
                response_time=GetSecs-stime;
                response_value='';
                if(keycode(J))
                    response_value='J';
                elseif(keycode(F))
                    response_value='F';
                elseif(keycode(escapekey))
                    fclose(fid);
                    Screen('Close',wi);
                    clear all;
                    return;
                end
                Screen('Flip',w);
                break;
            end
        end
        if(isresponse==0)                                                  %无反应处理
            response_time=reac_interval;
            response_value='noresponse';
        end
        
        keyisdown = 1;                                                     %重要！确保检测呈现前无按键
        while(keyisdown)
            [keyisdown,~,~] = KbCheck;
            WaitSecs(0.001);
        end
        Screen('Flip',w);                                                  %数字检测
        testnumuse=floor(rand()*8)+1;
        testnum=num2str(testnumuse);
        Screen('DrawTexture', w, numPageIndex(testnumuse), [],[a-num1Rect(3)*1/2 b-num1Rect(4)/2 a+num1Rect(3)*1/2 b+num1Rect(4)/2]);
        Screen('Flip',w);
        
        stime=GetSecs;
        isnumresponse=0;
        while(GetSecs-stime<=numreac_interval)                             %数字反应处理
            [~,~,keycode] = KbCheck;
            if(keycode(J) || keycode(F) || keycode(escapekey))
                isnumresponse=1;
                numresponse_time=GetSecs-stime;
                numresponse_value='';
                if(keycode(J))
                    numresponse_value='J';
                elseif(keycode(F))
                    numresponse_value='F';
                elseif(keycode(escapekey))
                    fclose(fid);
                    Screen('Close',wi);
                    clear all;
                    return;
                end
                Screen('Flip',w);
                break;
            end
        end
        if(isnumresponse==0)                                               %无反应处理
            numresponse_time=reac_interval;
            numresponse_value='noresponse';
        end
        
        Screen('Flip',w);                                                  %trial间空屏
        bettrial_interval=rand()*(trial_max_interval-trial_min_interval)+trial_min_interval;
        WaitSecs(bettrial_interval);          
        Screen('Flip',w);
        
        rememberObj='';
        switch(str2num(trialindex{trial}(1)))
            case 1 
                rememberObj='l1';
            case 2
                rememberObj='l2';
            case 3
                rememberObj='l3';
            case 4 
                rememberObj='r1';
            case 5
                rememberObj='r2';
            case 6
                rememberObj='r3';
            case 7 
                rememberObj='y1';
            case 8
                rememberObj='y2';
            case 9
                rememberObj='y3';    
        end
        cuetype='';
        if(str2num(trialindex{trial}(2))==1)
            cuetype='X';
        elseif(str2num(trialindex{trial}(2))==2)
            cuetype='S';
        end
        testtype='';
        if(str2num(trialindex{trial}(3))==1)
            testtype='X';
        elseif(str2num(trialindex{trial}(3))==2)
            testtype='S';
        end
                                                                           %trial输出
        fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%4.3f\t%s\t%4.3f\t%s\t%s\t%4.3f\r\n',subId,subName,subGender,num2str(trial),remembernum,rememberObj,cuetype,testtype,cuepose,outSOAtime,response_value,response_time,testnum,numresponse_value,numresponse_time);
        
        if(mod(trial,relaxduration)==0 && trial~=ttimes)                   %relax
            keyisdown = 1;                                                 %重要！确保按键前无按键
            while(keyisdown)
                [keyisdown,~,~] = KbCheck;
                WaitSecs(0.001);
            end
            Screen('Flip',w);
            Screen('DrawTexture', w, relaxpic, [],[a-relaxpicRect(3)/2 b-relaxpicRect(4)/2 a+relaxpicRect(3)/2 b+relaxpicRect(4)/2]); 
                                                                           %relax
            Screen('Flip',w);
            KbWait;
        end
        
    end
    keyisdown = 1;                                                         %重要！确保按键前无按键
    while(keyisdown)
        [keyisdown,~,~] = KbCheck;
        WaitSecs(0.001);
    end
    Screen('Flip',w);
    Screen('DrawTexture', w, endpic, [],[a-endpicRect(3)/2 b-endpicRect(4)/2 a+endpicRect(3)/2 b+endpicRect(4)/2]); 
                                                                           %实验结束
    Screen('Flip',w);
    KbWait;
    
%% 实验结束===================================================================
    fclose(fid);
    Screen('Close',w);
    ShowCursor;                                                            %显示鼠标
    Screen('Closeall') 
    clear all 
catch
%% 异常处理===================================================================
    Screen('Closeall')	
    rethrow(lasterror);
end
    clear all
end