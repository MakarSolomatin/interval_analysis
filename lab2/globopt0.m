function [Z, WorkList, diams] = globopt0(ObjFunc, X)
    MaxStepNumber = 100;  
    X = infsup(X);
    NStep = 1; 
    Y = ObjFunc(X); 

    UpperEst = sup(Y);  

    WorkList(1) = struct( 'Box', X, 'Estim', inf(Y) );

    diams = [];
    while ( NStep <= MaxStepNumber ) 
        
        LL = size(WorkList,2);
        LeadEst = UpperEst;   
        for k = 1:LL 
            p = WorkList(k).Estim;
            if p < LeadEst 
                LeadEst = p;
                Leading = k; 
            end
        end
        
        D1 = WorkList(Leading).Box;   D2 = D1;    
        [radmax,imax] = max(rad(D1)); 
        
        if radmax < 1e-6
            break
        end

        s = D1(imax); 
        D1(imax) = infsup(inf(s),mid(s)); 
        D2(imax) = infsup(mid(s),sup(s)); 
        
        Y1 = ObjFunc(D1);   Y2 = ObjFunc(D2);  
        
        Rec1 = struct( 'Box', D1, 'Estim', inf(Y1) );
        Rec2 = struct( 'Box', D2, 'Estim', inf(Y2) );
        WorkList(end + 1) = Rec1;
        WorkList(end + 1) = Rec2;
        diams(end + 1) = (wid(Rec2.Box(1)) ^ 2 + wid(Rec2.Box(2)) ^ 2) ^ 0.5;
        
        WorkList(Leading) = [];  
        NStep = NStep + 1;  
    
    end
    Z = LeadEst; 
end