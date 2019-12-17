function [] = VSM_BGSH_plotter (figno,datain) 

    if datain == 1
        disp 'please find the sample data folder'
        samplefol = fol_data_ext_function();
        disp 'please find the background data folder'
        BGfol = fol_data_ext_function();
    elseif datain == 0

    else
        disp 'please choose either 1 or 0 for datain field'
    end

    raw = 10;
    field = 9;
    actual = 11;

    deg0 = 5;
    deg0SH = 9;

    deg90 = 13;
    deg90SH = 7;

    datafields = find(arrayfun(@(x) ~isempty(x.data), samplefol));
    shfields = find(arrayfun(@(x) ~isempty(x.data), BGfol));

    ras = (1); % 1 for raw, 2 for actual

    rwac = [raw, actual]; 

    figure(figno); clf;
    
    subplot(2,2,1)
    plot(PyrexSH(deg0SH).data(:,field), SHSP8309(deg0).data(:,rwac(ras)) - PyrexSH(deg0SH).data(:,rwac(ras)) )
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using raw data (subtraction)'
    subplot(2,2,2)
    vsmplot(PyrexSH(deg0SH).data(:,field), SHSP8309(deg0).data(:,rwac(ras)) - PyrexSH(deg0SH).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using VSMplot to remove slope'
    subplot(2,2,3)
    plot(PyrexSH90(deg90SH).data(:,field),SHSP8309(deg90).data(:,rwac(ras))-PyrexSH90(deg90SH).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using raw data (subtraction) - (HA)'
    subplot(2,2,4)
    vsmplot(PyrexSH90(deg90SH).data(:,field),SHSP8309(deg90).data(:,rwac(ras))-PyrexSH90(deg90SH).data(:,rwac(ras)))
    xlabel 'Field [Oe]'
    ylabel ' Moment [\muemu]'
    title 'Using VSMplot to remove slope - (HA)'
       
end 
