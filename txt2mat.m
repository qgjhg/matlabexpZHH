%syw
%2018.08.14
%ת��result�ļ���������txt�ļ���ȥ����һ�б�ͷ��
function txt2mat()
    if(exist('results/','file')==0||exist('matresults/','file')==0)
        error('ȱ��results��matresults�ļ���')
    else
        %����list�ļ����������ļ�
        PathRoot='results/';
        list=dir(fullfile(PathRoot));
        fileNum=size(list,1)-2;
        donefile='';
        for k=3:fileNum+2
            %תmat��������matresults�ļ���
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

