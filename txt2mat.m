%syw
%2018.08.14
%转换result文件夹下所有txt文件（去掉第一行表头）
function txt2mat()
    if(exist('results/','file')==0||exist('matresults/','file')==0)
        error('缺少results或matresults文件夹')
    else
        %遍历list文件夹下所有文件
        PathRoot='results/';
        list=dir(fullfile(PathRoot));
        fileNum=size(list,1)-2;
        donefile='';
        for k=3:fileNum+2
            %转mat并保留到matresults文件夹
            fidr = fopen(['results/' list(k).name]);
            lines = 0;
            while ~feof(fidr)
                if(lines==0) 
                    fgetl(fidr);
                    lines=lines+1;
                end
                output=fgetl(fidr);
                outputsplit(lines,:)=strsplit(output,'\t');
                lines = lines +1;
            end
            save(['matresults/' list(k).name '.mat'],'outputsplit');
            fclose(fidr);
            donefile=['done:results/' list(k).name];
            disp(donefile);
        end
    end
end

