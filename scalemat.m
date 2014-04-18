function a = scalemat(a)

Min = min(a(:));
Max = max(a(:));

a(:) = (a-Min)/(Max- Min);
a = 2*a -1;