function out = v_c(n,nup,ndn,str)
    rs = 1./(2*n);
    ksi = ksi_f(n,nup,ndn);
    dgde1 = ksi.^2;
    dgde0 = 1 - ksi.^2;
    drsdn = (-1)./(2*n.^2);
    dksidn = -(nup - ndn)./(n.^2);
    de0drs = de0_drs(rs);
    de1drs = de1_drs(rs);
    e0 = e0_f(rs);
    e1 = e1_f(rs);
    
    temp1 = e0 + (ksi.^2).*(e1 - e0);
    
    if (strcmp(str,'up'))
        dksidnup = 1./n;
        temp2 = dgde1.*de1drs.*drsdn + ...
                dgde0.*de0drs.*drsdn + ...
                2*ksi.*(e1 - e0).*dksidnup + ...
                2*ksi.*(e1 - e0).*dksidn;
    elseif (strcmp(str,'dn'))
        dksidndn = (-1)./n;
        temp2 = dgde1.*de1drs.*drsdn + ...
                dgde0.*de0drs.*drsdn + ...
                2*ksi.*(e1 - e0).*dksidndn + ...
                2*ksi.*(e1 - e0).*dksidn;
    else
        fprintf('>> v_c: which derivative, again?\n');
    end
    out = temp1 + n.*temp2;
end

function out = e0_f(rs)
    
    A = 18.40;
    B = 0.0;
    C = 7.501;
    D = 0.10185;
    E = 0.012827;
    a = 1.511;
    b = 0.258;
    m = 4.424;
    
    out = (-1/2)*(rs + E*rs.^2)./(A + B*rs + C*rs.^2 + D*rs.^3).*log(1 + a*rs + b*rs.^m);
end

function out = e1_f(rs)
    
    A = 5.24;
    B = 0.0;
    C = 1.568;
    D = 0.1286;
    E = 0.00320;
    a = 0.0538;
    b = 1.56e-5;
    m = 2.958;
    
    out = (-1/2)*(rs + E*rs.^2)./(A + B*rs + C*rs.^2 + D*rs.^3).*log(1 + a*rs + b*rs.^m);
end

function out = ksi_f(n,nup,ndn)
    out = (nup - ndn)./n;
end

function out = de0_drs(rs)

    x = rs;

    A = 18.40;
    B = 0.0;
    C = 7.501;
    D = 0.10185;
    E = 0.012827;
    a = 1.511;
    b = 0.258;
    m = 4.424;
    
    temp = (((E*x + 1).*(a*x + b*m*x.^m).*(A + x.*(B + x.*(C + D*x))))...
         ./(a*x + b*x.^m + 1) + (2*E*x + 1).*(A + x.*(B + x.*(C + D*x)))...
         .*log(a*x + b*x.^m + 1) - x.*(E*x + 1).*(B + x.*(2*C + 3*D*x))...
         .*log(a*x + b*x.^m + 1))./(A + x.*(B + x.*(C + D*x))).^2;
     out = (-1/2)*temp;
end

function out = de1_drs(rs)

    x = rs;
    
    A = 5.24;
    B = 0.0;
    C = 1.568;
    D = 0.1286;
    E = 0.00320;
    a = 0.0538;
    b = 1.56e-5;
    m = 2.958;
    
    temp = (((E*x + 1).*(a*x + b*m*x.^m).*(A + x.*(B + x.*(C + D*x))))...
         ./(a*x + b*x.^m + 1) + (2*E*x + 1).*(A + x.*(B + x.*(C + D*x)))...
         .*log(a*x + b*x.^m + 1) - x.*(E*x + 1).*(B + x.*(2*C + 3*D*x))...
         .*log(a*x + b*x.^m + 1))./(A + x.*(B + x.*(C + D*x))).^2;
     out = (-1/2)*temp;
end