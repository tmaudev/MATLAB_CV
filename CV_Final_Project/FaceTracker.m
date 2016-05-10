clear cam;

% Create the point tracker object.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Create the webcam object.
cam = webcam();

% Capture one frame to get its size.
frame = snapshot(cam);
frameSize = size(frame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)] + 30]);

runLoop = true;
numPts = 0;

while runLoop

    % Get the next frame.
    frame = snapshot(cam);
    %frame = flip(frame, 2);
    frameGray = rgb2gray(frame);

    if numPts < 10
        % Detection mode.

        % Find corner points inside the detected region.
        points = detectFASTFeatures(frameGray, 'MinQuality', 0.001);
        %points = detectMinEigenFeatures(videoFrameGray,'ROI', bbox(1, :));

        if points.Count ~= 0
            % Re-initialize the point tracker.
            xyPoints = points.Location;
            numPts = size(xyPoints,1);
            release(pointTracker);
            initialize(pointTracker, xyPoints, frameGray);

            % Save a copy of the points.
            oldPoints = xyPoints;

            % Display detected corners.
            frame = insertMarker(frame, xyPoints, '+', 'Color', 'white');
        else
            numPts = 0;
        end
    else
        % Tracking mode.
        [xyPoints, isFound] = step(pointTracker, frameGray);
        visiblePoints = xyPoints(isFound, :);
        oldInliers = oldPoints(isFound, :);

        numPts = size(visiblePoints, 1);

        if numPts >= 10
            % Estimate the geometric transformation between the old points
            % and the new points.
            [xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
                oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
            
            % Display tracked points.
            frame = insertMarker(frame, visiblePoints, '+', 'Color', 'red');

            % Reset the points.
            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);
        end

    end

    % Display the annotated video frame using the video player object.
    step(videoPlayer, frame);

    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
release(pointTracker);
release(faceDetector);