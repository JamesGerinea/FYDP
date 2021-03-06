% matlab + osx ptb demo that will open a window on every attached display
clear all;
Screen('Preference','SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
try
    fprintf('OSX many windows demo\n\n\t');
    fprintf('At the end of the demo, press any key to quit\n\n\t');

    input('Hit the return key to continue.','s');
    fprintf('Thanks.\n');

    screens=Screen('Screens'); % vector with valid screen numbers, main is 0

    % Open a double buffered fullscreen window  on each attached screen
    % and draw a gray background with a coloured square on it

    for screenNumber=screens
        i=screenNumber+1
        fprintf('Opening window on screen #%d\n', screenNumber);
        [w(i) sRect]=Screen('OpenWindow', screenNumber, 0,[],32,2);
        %white=WhiteIndex(w(i));
        %black=BlackIndex(w(i));
        %gray=round((white+black)/2);
        
        % not defining some values hangs the program
        %Screen('TextFont',w(i), 'Courier');
        %Screen('TextSize',w(i), 100);
        %Screen('TextStyle', w(i), 0);

        %[x,y] = RectCenter(sRect);
        %Screen('FillRect',w(i), gray);
        
        %Screen('DrawText',w(i), ['Screen #' num2str(i-1)],x-300,y,[255*rand(1,3)]);
        A = imread_rgb('eagle.jpg');
        A = imresize(A, [800,1280]);
        screen('PutImage',w(i),A);
        Screen('Flip', w(i));
    end

    while KbCheck; end
    tEnd=GetSecs+5;
    while ~KbCheck & GetSecs<tEnd; end
    Screen('CloseAll');
    fprintf('\nEnd of demo\n');

catch
    %this "catch" section executes in case of an error in the "try" section
    %above.  Importantly, it closes the onscreen window if its open.
    Screen('CloseAll');
    rethrow(lasterror);
end %try..catch..