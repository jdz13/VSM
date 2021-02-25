function [samplefol, BGfol] = VSM_BGSH_plotter (figno,datain) 

    if datain == 1
        disp 'please find the sample data folder'
        samplefol = fol_data_ext_function();
        disp 'please find the background data folder'
        BGfol = fol_data_ext_function();
    elseif datain == 0

    else
        disp 'please choose either 1 or 0 for datain field'
    end
%%
    raw = 10;
    field = 9;
    actual = 11;

    deg0 = 3;
    deg0SH = 1;

    deg90 = 3;
    deg90SH = 1;

    datafields = find(arrayfun(@(x) ~isempty(x.data), samplefol));
    shfields = find(arrayfun(@(x) ~isempty(x.data), BGfol));

    ras = (1); % 1 for raw, 2 for actual

    rwac = [raw, actual]; 

    figure(figno); clf;
    %%
    subplot(2,2,1)
    plot(BGfol(shfields(deg0SH)).data(:,field), samplefol(datafields(deg0)).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title (['Using raw data - ', samplefol(shfields(1)).name(1:6)])
    subplot(2,2,2)
    vsmplot(BGfol(shfields(deg0SH)).data(:,field), samplefol(datafields(deg0)).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title (['Using VSMplot to remove slope   -   S (', num2str(deg0), '), SH (', num2str(deg0SH),')'])
    subplot(2,2,3)
    plot(BGfol(shfields(deg90SH)).data(:,field),samplefol(datafields(deg90)).data(:,rwac(ras))-BGfol(shfields(deg90SH)).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using raw data (subtracting for SH)'
    subplot(2,2,4)
    vsmplot(BGfol(shfields(deg90SH)).data(:,field),samplefol(datafields(deg90)).data(:,rwac(ras))-BGfol(shfields(deg90SH)).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using VSMplot to remove slope (subtracting for SH)'
       
end 
