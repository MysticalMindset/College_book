% -- Start/Reading File Section -- %
clc; clear;
% Reading Excel File
T = readtable('PMMI-2025.xls',VariableNamingRule='preserve');
% Displays the rows
disp(T)

% -- Average for all hospitals, all months Section -- %
all_data = T{:,4:end}; % Extract numeric month data
overall_avg = mean(all_data(:));
fprintf('Overall average PMMI (all hospitals, all months): %.2f\n', ...
    overall_avg);

% -- Average per Hospital (entire year) -- %
T.Hospital_Avg = mean(all_data, 2);
fprintf('\n'); disp(T(:,{'Hospital-code','City','Hospital_Avg'}));

% -- Average per province or area -- %
provinces = unique(T.Province);
province_avg = zeros(length(provinces), 1);

for i = 1:length(provinces)
    idx = strcmp(T.Province, provinces{i});
    province_avg(i) = mean(T.Hospital_Avg(idx));
end

results = table(provinces, province_avg, 'VariableNames', {'Province','Avg_PMMI'});
disp(results)


% -- Month-by-month average per province -- %
% Automatically get month columns (exclude Hospital_Avg if present)
month_cols = T.Properties.VariableNames(4:15);  % 4–15 = Jan–Dec
months = month_cols;

month_by_province = zeros(length(provinces), length(months));

for i = 1:length(provinces)
    idx = strcmp(T.Province, provinces{i});
    month_by_province(i,:) = mean(T{idx, month_cols}, 1);
end
% Display
month_by_province_table = array2table(month_by_province, ...
    'VariableNames', months, 'RowNames', provinces);
disp(month_by_province_table)

% Plot
figure;
plot(month_by_province', '-o');
legend(provinces, 'Location', 'best');
title('Month-by-Month Average PMMI by Province');
xlabel('Month'); 
ylabel('Average PMMI');
set(gca, 'XTick', 1:length(months), 'XTickLabel', months);
xlim([1 length(months)]); xtickangle(45); grid on;

% -- Month-by-month average of all hospitals -- %
months = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
monthly_avg_all = mean(all_data, 1);

figure;
plot(monthly_avg_all, '-o', 'LineWidth', 1.5);
title('Month-by-Month Average PMMI (All Hospitals)');
xlabel('Month');
ylabel('Average PMMI');
set(gca, 'XTick', 1:length(months), 'XTickLabel', months);
xlim([1 length(months)]); xtickangle(45); grid on;

% -- Raw data for all hospitals -- %
figure;
hold on;
for i = 1:height(T)
    plot(T{ i, 4:15 }, '-o', 'DisplayName', T.("Hospital-code"){i});
end
hold off;
legend('Location','bestoutside');
title('PMMI Data for All Hospitals');
xlabel('Month'); ylabel('PMMI');
set(gca, 'XTick', 1:length(months), 'XTickLabel', months);
xlim([1 length(months)]); xtickangle(45); grid on;

% -- -- %
toronto_idx = strcmp(T.City, 'Toronto');
toronto_data = T(toronto_idx,:);

figure;
subplot(2,1,1);
plot(toronto_data{1,4:15}, '-o');
title(['Toronto Hospital: ' toronto_data.("Hospital-code"){1}]);
set(gca, 'XTick', 1:length(months), 'XTickLabel', months);
xlim([1 length(months)]); xtickangle(45); grid on;

subplot(2,1,2);
plot(toronto_data{2,4:15}, '-o');
title(['Toronto Hospital: ' toronto_data.("Hospital-code"){2}]);
set(gca, 'XTick', 1:length(months), 'XTickLabel', months);
xlim([1 length(months)]); xtickangle(45); grid on;

% -- PMMI Category Visualization -- %

edges = [0 15 31 49 99 inf];
labels = {'Very Good','Good','Moderate','Poor','Very Poor'};

categories = discretize(all_data(:), edges, 'categorical', labels);

monthly_avg_cat = zeros(5, 12); % 5 categories, 12 months

for m = 1:12
    month_data = all_data(:, m); % all hospitals for month m
    cat_counts = countcats(discretize(month_data, edges, 'categorical', labels));
    monthly_avg_cat(:, m) = cat_counts / height(all_data); % average per hospital
end

% Plot
figure;
bar(1:12, monthly_avg_cat', 'stacked');
colormap([0 1 0; 0.5 1 0; 1 1 0; 1 0.5 0; 1 0 0]); % colors for each category
xticks(1:12); xticklabels(months);
ylabel('Average Patients'); xlabel('Month'); legend(labels);
title('Average Muscle Movement Categories per Month');


% -- Fit Analysis -- %
monthly_avg_all = mean(all_data, 1); % average PMMI across all hospitals per month
p = polyfit(1:12, monthly_avg_all, 1); % linear fit
trend = polyval(p, 1:12);

figure;
plot(1:12, monthly_avg_all, '-o'); hold on;
plot(1:12, trend, '--r', 'LineWidth', 1);
xticks(1:12); xticklabels(months);
ylabel('Average PMMI'); xlabel('Month');
legend('Monthly Avg','Trendline'); title('Monthly Average PMMI and Trend');
xlim([1 length(months)]); xtickangle(45); grid on;


% -- Montreal V.S. Vancouver -- %
montreal_data = all_data(strcmp(T.("Hospital-code"),'Montreal'), :);
vancouver_data = all_data(strcmp(T.("Hospital-code"),'Vancouver'), :);

mont_moderate = sum(discretize(montreal_data(:), edges, 'categorical', labels) == 'Moderate');
van_moderate = sum(discretize(vancouver_data(:), edges, 'categorical', labels) == 'Moderate');

if mont_moderate > van_moderate
    fprintf('Montreal has more Moderate level movements (%d vs %d)\n', mont_moderate, van_moderate);
else
    fprintf('Vancouver has more Moderate level movements (%d vs %d)\n', van_moderate, mont_moderate);
end

% -- 2 International V.S. Vancouver -- %
intl_data = all_data(ismember(T.("Hospital-code"), {'Intl1','Intl2'}), :);
van_data = all_data(strcmp(T.("Hospital-code"),'Vancouver'), :);

intl_poor = sum(discretize(intl_data(:), edges, 'categorical', labels) == 'Poor');
van_poor = sum(discretize(van_data(:), edges, 'categorical', labels) == 'Poor');

if intl_poor > van_poor
    fprintf('International hospitals have more Poor movements (%d vs %d)\n', intl_poor, van_poor);
else
    fprintf('Vancouver has more Poor movements (%d vs %d)\n', van_poor, intl_poor);
end

% -- Average "Very Good" Level per Hospital -- %
avg_verygood = zeros(height(T),1);

for i = 1:height(T)
    hospital_data = all_data(i,:);
    verygood_vals = hospital_data(discretize(hospital_data, edges, 'categorical', labels) == 'Very Good');
    avg_verygood(i) = mean(verygood_vals);
end

table(T.("Hospital-code"), avg_verygood)

% -- Month-by-month averages of "Very Good" level -- %
vg_monthly_avg = zeros(1,12);

for m = 1:12
    month_data = all_data(:,m);
    vg_vals = month_data(discretize(month_data, edges, 'categorical', labels) == 'Very Good');
    vg_monthly_avg(m) = mean(vg_vals);
end

figure;
plot(1:12, vg_monthly_avg, '-o');
xticks(1:12); xticklabels(months);
ylabel('Average Very Good PMMI'); xlabel('Month'); title('Very Good PMMI Monthly Average');

% -- Month-by-month averages of Good level per province -- %
province_list = unique(T.Province); % 6 areas maybe (4 provinces + 2 international)
good_monthly_avg = zeros(length(province_list), 12);

for i = 1:length(province_list)
    prov_data = all_data(strcmp(T.Province, province_list{i}), :);
    for m = 1:12
        month_vals = prov_data(:, m);
        good_vals = month_vals(discretize(month_vals, edges, 'categorical', labels) == 'Good');
        good_monthly_avg(i, m) = mean(good_vals);
    end
end

figure;
plot(1:12, good_monthly_avg', '-o'); 
xticks(1:12); xticklabels(months);
ylabel('Average Good PMMI'); xlabel('Month'); 
legend(province_list, 'Location','bestoutside'); title('Good PMMI Monthly Average per Province');
