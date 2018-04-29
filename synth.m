%Defining figure UI
h.fig = figure;
set(h.fig, 'Name', 'Synthesizer', 'NumberTitle', 'off');
pianoImage = imread('piano.png');
image(10, 600, pianoImage);
xlim([0 800]);
ylim([0 800]);
axis off

setappdata(h.fig, 'currKey', zeros(2,0));
setappdata(h.fig, 'currRelease', zeros(2,0));
setappdata(h.fig, 'octave', 4);
setappdata(h.fig, 'waveform', 'sin');
setappdata(h.fig, 'harmonics', [1 0 0 0 0 0 0 0 0]);
setappdata(h.fig, 'attack', 0);
setappdata(h.fig, 'decay', 0);
setappdata(h.fig, 'sustain', 1);
setappdata(h.fig, 'release', 0.1);
setappdata(h.fig, 'lfo', 0);

h.octaveText2 = uicontrol('Style', 'text', 'String', 'Octave: ', 'Position', [450, 90, 50, 20]);
h.octaveText = uicontrol('Style', 'text', 'String', getappdata(h.fig, 'octave'), 'Position', [460, 65, 50, 30]);
h.octaveUp = uicontrol('Style', 'pushbutton', 'String', 'Up', 'Position', [500, 90, 35, 20], ...
                       'Callback', {@oUp,h});
h.octaveDown = uicontrol('Style', 'pushbutton', 'String', 'Down', 'Position', [500, 70, 35, 20], ...
                         'Callback', {@oDown,h});

h.waveText = uicontrol('Style', 'text', 'String', 'Base waveform', 'Position', [20, 390, 100, 20]);                   
h.waveBg = uibuttongroup('Visible', 'off', 'Position', [0.05, 0.67, 0.15, 0.25], 'SelectionChangedFcn', {@waveSelect, h});
h.wave1 = uicontrol(h.waveBg, 'Style', 'radiobutton', 'String', 'sin', 'Position', [10, 75, 100, 30], 'HandleVisibility', 'off');
h.wave2 = uicontrol(h.waveBg, 'Style', 'radiobutton', 'String', 'square', 'Position', [10, 50, 100, 30], 'HandleVisibility', 'off');
h.wave3 = uicontrol(h.waveBg, 'Style', 'radiobutton', 'String', 'triangle', 'Position', [10, 25, 100, 30], 'HandleVisibility', 'off');
h.wave4 = uicontrol(h.waveBg, 'Style', 'radiobutton', 'String', 'sawtooth', 'Position', [10, 0, 100, 30], 'HandleVisibility', 'off');
h.waveBg.Visible = 'on';

h.harText = uicontrol('Style', 'text', 'String', 'Harmonics', 'Position', [150, 390, 100, 20]);
h.harText1 = uicontrol('Style', 'text', 'String', '1', 'Position', [160, 370, 10, 20]);
h.harText2 = uicontrol('Style', 'text', 'String', '2', 'Position', [160, 340, 10, 20]);
h.harText3 = uicontrol('Style', 'text', 'String', '3', 'Position', [160, 310, 10, 20]);
h.harText4 = uicontrol('Style', 'text', 'String', '4', 'Position', [160, 280, 10, 20]);
h.harText5 = uicontrol('Style', 'text', 'String', '5', 'Position', [160, 250, 10, 20]);
h.harText6 = uicontrol('Style', 'text', 'String', '6', 'Position', [265, 370, 10, 20]);
h.harText7 = uicontrol('Style', 'text', 'String', '7', 'Position', [265, 340, 10, 20]);
h.harText8 = uicontrol('Style', 'text', 'String', '8', 'Position', [265, 310, 10, 20]);
h.harText9 = uicontrol('Style', 'text', 'String', '9', 'Position', [265, 280, 10, 20]);
h.har1Sld = uicontrol('Style', 'slider', 'Value', 1, 'Position', [170, 370, 80, 20], 'Callback', {@harmonicSelect, h, 1});
h.har2Sld = uicontrol('Style', 'slider', 'Position', [170, 340, 80, 20], 'Callback', {@harmonicSelect, h, 2});
h.har3Sld = uicontrol('Style', 'slider', 'Position', [170, 310, 80, 20], 'Callback', {@harmonicSelect, h, 3});
h.har4Sld = uicontrol('Style', 'slider', 'Position', [170, 280, 80, 20], 'Callback', {@harmonicSelect, h, 4});
h.har5Sld = uicontrol('Style', 'slider', 'Position', [170, 250, 80, 20], 'Callback', {@harmonicSelect, h, 5});
h.har6Sld = uicontrol('Style', 'slider', 'Position', [275, 370, 80, 20], 'Callback', {@harmonicSelect, h, 6});
h.har7Sld = uicontrol('Style', 'slider', 'Position', [275, 340, 80, 20], 'Callback', {@harmonicSelect, h, 7});
h.har8Sld = uicontrol('Style', 'slider', 'Position', [275, 310, 80, 20], 'Callback', {@harmonicSelect, h, 8});
h.har9Sld = uicontrol('Style', 'slider', 'Position', [275, 280, 80, 20], 'Callback', {@harmonicSelect, h, 9});

h.attackText = uicontrol('Style', 'text', 'String', 'Attack', 'Position', [420, 390, 40, 20]);
h.attackSld = uicontrol('Style', 'slider', 'Position', [420, 370, 80, 20], 'Callback', {@attackSelect, h});
h.decayText = uicontrol('Style', 'text', 'String', 'Decay', 'Position', [420, 345, 40, 20]);
h.decaySld = uicontrol('Style', 'slider', 'Position', [420, 325, 80, 20], 'Callback', {@decaySelect, h});
h.sustainText = uicontrol('Style', 'text', 'String', 'Sustain', 'Position', [420, 300, 40, 20]);
h.sustainSld = uicontrol('Style', 'slider', 'Position', [420, 280, 80, 20], 'Value', 1, 'Callback', {@sustainSelect, h});
h.releaseText = uicontrol('Style', 'text', 'String', 'Release', 'Position', [420, 255, 50, 20]);
h.releaseSld = uicontrol('Style', 'slider', 'Position', [420, 235, 80, 20], 'Value', 0.1, 'Callback', {@releaseSelect, h});
h.lfoText = uicontrol('Style', 'text', 'String', 'Tremolo', 'Position', [420, 210, 40, 20]);
h.lfoSld = uicontrol('Style', 'slider', 'Position', [420, 190, 80, 20], 'Callback', {@lfoSelect, h});


h.recEdit = uicontrol('Style', 'edit', 'string', 'file_name_here', 'Position', [240 180 100 20], 'Callback', {@record, h});
h.recToggle = uicontrol('Style', 'togglebutton', 'String', 'Record', 'Position', [140 170 80 40], 'Callback', {@record, h});

%Maps keyboard characters to frequencies
keyMap = containers.Map({'q','2','w','3','e','r','5','t','6','y','7','u','i','9','o','0','p'}, ...
                            [16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 27.50, ...
                             29.14, 30.87, 32.70, 34.65, 36.71, 38.89, 41.20]);
                    
device = audioDeviceWriter('SampleRate', 52500, 'BufferSize', 210);

%Timer which triggers sample frame generation
t = timer('ExecutionMode', 'fixedRate', 'Period', 0.004, 'TimerFcn', @(~,~) generate(h, keyMap, device));
start(t);

set(h.fig, 'WindowKeyPressFcn', {@keyDown, keyMap});
set(h.fig, 'WindowKeyReleaseFcn', {@keyUp, keyMap});
set(h.fig, 'CloseRequestFcn', {@close, t});

%Octave up button callback
function oUp(~, ~, h)
    octave = getappdata(h.fig, 'octave');
    if(octave < 7) 
        octave = octave + 1;
    end
    set(h.octaveText, 'String', num2str(octave));
    setappdata(h.fig, 'octave', octave);
end

%Octave down button callback
function oDown(~, ~, h)
    octave = getappdata(h.fig, 'octave');
    if(octave > 1) 
        octave = octave - 1;
    end
    set(h.octaveText, 'String', num2str(octave));
    setappdata(h.fig, 'octave', octave);
end

%Waveform radio button callback
function waveSelect(~, o, h)
    setappdata(h.fig, 'waveform', o.NewValue.String);
end

%Harmonic sliders callback
function harmonicSelect(o, ~, h, n)
    har = getappdata(h.fig, 'harmonics');
    setappdata(h.fig, 'harmonics', [har(1:n-1), o.Value, har(n+1:end)]);
end

%Attack slider callback
function attackSelect(o, ~, h)
    setappdata(h.fig, 'attack', 2*o.Value);
end

%Decay slider callback
function decaySelect(o, ~, h)
    setappdata(h.fig, 'decay', 2*o.Value);
end

%Sustain slider callback
function sustainSelect(o, ~, h)
    setappdata(h.fig, 'sustain', o.Value);
end

%Release slider callback
function releaseSelect(o, ~, h)
    setappdata(h.fig, 'release', o.Value);
end

%Tremolo slider callback
function lfoSelect(o, ~, h)
    setappdata(h.fig, 'lfo', 6*o.Value);
end

%Record toggle button callback
function record(o, ~, h)
    if(o.Value)
        setappdata(h.fig, 'writer', dsp.AudioFileWriter(strcat(get(h.recEdit, 'string'),'.wav'), 'SampleRate', 52500));
    end
    setappdata(h.fig, 'recording', o.Value);
end

%Window close callback
function close(f, ~, t)
    stop(t);
    delete(t);
    delete(f);
end

%Key down callback
function keyDown(f, keyObj, keyMap)
    currKey = getappdata(f, 'currKey');
    if(size(keyObj.Key,2) == 1 && ...
        isKey(keyMap, keyObj.Key) && ...
        ~any(any(currKey == keyObj.Key)))
        currKey(1, end+1) = keyObj.Key;
        currKey(2, end) = 0;
        setappdata(f, 'currKey', currKey);
    end
end

%Key up callback
function keyUp(f, keyObj, keyMap)
    currKey = getappdata(f, 'currKey');
    currRe = getappdata(f, 'currRe');
    if(size(keyObj.Key,2) == 1 && ...
        isKey(keyMap, keyObj.Key) && ...
        any(any(currKey == keyObj.Key)))
        n = (currKey(1,:) ~= keyObj.Key);
        currRe(1, end+1) = keyObj.Key;
        currRe(2, end) = currKey(2,~n);
        currRe(3, end) = currKey(2,~n);
        setappdata(f, 'currRe', currRe);
        setappdata(f, 'currKey', reshape(currKey([n;n]), 2, size(n, 2)-1));
    end
end

%Generates sample frame for a single note
function buffer = bsound(h, freq, time)
    octave = getappdata(h.fig, 'octave');
    waveform = getappdata(h.fig, 'waveform');
    harmonics = getappdata(h.fig, 'harmonics');
    attack = getappdata(h.fig, 'attack');
    decay = getappdata(h.fig, 'decay');
    sustain = getappdata(h.fig, 'sustain');
    lfo = getappdata(h.fig, 'lfo');
    
    if(strcmp(waveform, 'square'))
        buffer = sum(0.4.*square(((2.*pi.*time)*((freq.*2.^octave).*(1:9)))).*harmonics, 2)./sum(harmonics);
    elseif(strcmp(waveform, 'triangle'))
        buffer = sum(sawtooth(((2.*pi.*time)*((freq.*2.^octave).*(1:9))),0.5).*harmonics, 2)./sum(harmonics);
    elseif(strcmp(waveform, 'sawtooth'))
        buffer = sum(sawtooth(((2.*pi.*time)*((freq.*2.^octave).*(1:9)))).*harmonics, 2)./sum(harmonics);
    else
        buffer = sum(sin(((2.*pi.*time)*(freq.*2.^octave).*(1:9))).*harmonics, 2)./sum(harmonics);
    end
    
    buffer = [buffer(time < attack).*time(time < attack)./attack; ...
              buffer((time >= attack)&(time < attack+decay)).*(1 - ((time((time >= attack)&(time < attack+decay))-attack).*((1 - sustain)./decay))); ...
              buffer(time >= attack+decay).*sustain];
    buffer = buffer.*cos(time*2*pi*lfo);
end

%Combines sample frames from all pressed notes, connected to timer
function generate(h, keyMap, device)
    currKey = getappdata(h.fig, 'currKey');
    currRe = getappdata(h.fig, 'currRe');
    release = getappdata(h.fig, 'release');
    time = linspace(0, 209/52500, 210);
    if(size(currKey, 1) ~= 2) 
        return;
    end
    if(size(currRe, 1) == 3)
        currRe = currRe(:, currRe(2,:) < currRe(3,:)+release);
    end
    notes = size(currKey, 2);
    releases = size(currRe, 2);
    buffer = zeros(210, 1);
    for n = 1:notes
        buffer = buffer + bsound(h, keyMap(char(currKey(1,n))), (time+currKey(2,n)).');
    end
    for j = 1:releases
        buffer = buffer + bsound(h, keyMap(char(currRe(1,j))), (time+currRe(2,j)).').*(1-(((time+(currRe(2,j)-currRe(3,j)))/release).'));
    end
    if(max(buffer) ~= 0) 
       buffer = buffer./max(5, notes+releases);
    end
    device(buffer);
    if(getappdata(h.fig, 'recording'))
        writer = getappdata(h.fig, 'writer');
        writer(buffer);
    end
    if(notes ~= 0)
        setappdata(h.fig, 'currKey', [currKey(1,:);currKey(2,:)+(210/52500)]);
    end
    if(releases ~= 0)
        setappdata(h.fig, 'currRe', [currRe(1,:);currRe(2,:)+(210/52500);currRe(3,:)]);
    end
end