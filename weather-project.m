% Import the weather data from the CSV file
data = readtable('project.xlsx'); 

% Handle missing values (replace with NaN)
data.Temperature(ismissing(data.Temperature)) = NaN;
data.Humidity(ismissing(data.Humidity)) = NaN;

% Calculate average temperature and humidity
avg_temp = mean(data.Temperature, 'omitnan');
avg_humidity = mean(data.Humidity, 'omitnan');

% Find maximum and minimum temperature and humidity
max_temp = max(data.Temperature, [], 'omitnan');
min_temp = min(data.Temperature, [], 'omitnan');
max_humidity = max(data.Humidity, [], 'omitnan');
min_humidity = min(data.Humidity, [], 'omitnan');
% Create a time series plot of temperature and humidity
figure;
plot(data.Date, data.Temperature, 'b-', data.Date, data.Humidity, 'r--');
xlabel('Date');
ylabel('Value');
legend('Temperature', 'Humidity');
title('Time Series Plot of Temperature and Humidity');

% Create a bar chart of average temperature and humidity for each month (if monthly data is available)
if ismember('Month', data.Properties.VariableNames)
    monthly_avg_temp = grpstats(data, 'Month', 'mean', 'DataVars', 'Temperature');
    monthly_avg_humidity = grpstats(data, 'Month', 'mean', 'DataVars', 'Humidity');

    figure;
    bar(monthly_avg_temp.Month, monthly_avg_temp.GroupCount);
    hold on;
    bar(monthly_avg_humidity.Month, monthly_avg_humidity.GroupCount);
    xlabel('Month');
    ylabel('Average Value');
    legend('Temperature', 'Humidity');
    title('Average Temperature and Humidity by Month');
end

% Display results
fprintf('Average Temperature: %.2f\n', avg_temp);
fprintf('Average Humidity: %.2f\n', avg_humidity);
fprintf('Maximum Temperature: %.2f\n', max_temp);
fprintf('Minimum Temperature: %.2f\n', min_temp);
fprintf('Maximum Humidity: %.2f\n', max_humidity);
fprintf('Minimum Humidity: %.2f\n', min_humidity);

% Save the report as a PDF using MATLAB's publish feature
publish('weather_analysis', 'pdf');