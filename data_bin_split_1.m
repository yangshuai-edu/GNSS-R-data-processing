function data_bin_split_1(settings)
% 分割数据
% 打开文件
fileID = fopen(settings.bin_filename, 'r'); % 'filename' 替换为实际文件名，'r'表示只读模式

% 设置35分割直射，设置36为分割反射通道1，设置37为分割反射通道2
fseek(fileID, 35, -1);

% 使用 fread 读取文件中所有通道1数据
data = fread(fileID, Inf, 'uint8', 2); % 'Inf' 表示读取文件中的所有数据，'uint8' 是数据类型

% 关闭文件
fclose(fileID);

bytes_to_read  = size(data,1);
bits_to_read = bytes_to_read*8;
clear bytes_to_read

ii = 1:2:bits_to_read-1;
clear bits_to_read

Data_int = [];

Data_b1 = de2bi(data,'left-msb');
clear data

Data_b2 = reshape(Data_b1',1,[]);
clear Data_b1

Data_int = (2*Data_b2(ii+1)+1).*(-1).^(Data_b2(ii)+1);
clear Data_b2

Data_int1 = int8(Data_int); % 转换为 int8 类型
clear Data_int

% 打开 .bin 文件以写入
fileID = fopen('Direct_signal_data.bin', 'w'); % 'w' 表示写模式

% 将数据写入文件
fwrite(fileID, Data_int1, 'int8'); % 以 int8 格式写入

% 关闭文件
fclose(fileID);

end

