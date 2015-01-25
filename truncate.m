function answer = truncate(series, A, B);

% truncate(series, A, B) truncates series to [A,B] so that all NaNs remain
% in places

if B<A
    C = B;
    B = A;
    A =C;
end

I = isnan(series);
answer = min(series,B);
answer = max(answer,A);
answer(I) = NaN;