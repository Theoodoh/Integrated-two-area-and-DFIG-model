%% this m-file perfrmes small-signal analysis
Initialising_SMIB_DFIG
small_d=[
    0  1 1.1 10
    1  1.00 1 1];
s_Efd_max = 7; s_Efd_min = 0;

%  AEO
x = [5.12198222193764,25.5175397453365,11.6029796911343,0.268220173569527,0.0557193334839566,0.636071142643984,0.789656078343357,0.444153913409216,0.594018977112684,0.00141910042460604,0.408079820255534,0.623997161282463,0.297653877169688,0.691107209000628,0.315283555398446];
% x = [0.00101379    0.0010991      48.3238     0.314716      0.37921     0.278077     0.803437    0.0101038     0.890123     0.430694     0.570821     0.983181    0.0200817     0.996247    0.0200835];
% x = [0.00162122   0.00101132      49.8061   0.00142347     0.799702    0.0713073     0.422225     0.101718     0.951391     0.003942     0.960913     0.999774    0.0280857     0.998189    0.0219526];
Tw = 10;
KG1 = x(1);
T11 = x(4);
T12 = x(5);
T13 = x(6);
T14 = x(7);
Kpss1 = KG1*T11*T13/(T12*T14);

KG2 = x(2);
T21 = x(8);
T22 = x(9);
T23 = x(10);
T24 = x(11);
Kpss2 =  KG2*T21*T23/(T22*T24);

KG4 = x(3);
T41 = x(12);
T42 = x(13);
T43 = x(14);
T44 = x(15);
Kpss4 =  KG4*T41*T43/(T42*T44);

%% Linearize Power System
% f11=linmod('SMIB_with_DFIG');
% f11=linmod('SMIB_with_DFIG_IO');
% f11=linmod('SMIB_with_DFIG_PSS');
f11=linmod('Copy_of_SMIB_with_DFIG_PSS');

% dx/dt = A.x + B.u
% y = C.x + D.u
Asys=f11.a;
Bsys=f11.b;
Csys=f11.c;
Dsys=f11.d;

%% Calculate Eigenvalues
egs = eig(Asys)
Ns=length(egs);

Damp=-real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq=abs(imag(egs))/(2*pi)


%% calculae Participation Factors
[Vs,D_eig] = eig(Asys);
Ws=inv(Vs);
for i=1:Ns
    for k=1:Ns
        Pfact1(k,i)=abs(Vs(k,i))*abs(Ws(i,k));
    end
end

for i=1:Ns
     Pfact(i,:)=Pfact1(i,:)/sum(Pfact1(i,:));
end

for i=1:Ns
    [s_val s_idx]=sort(Pfact(:,i),'descend');
    mod_idx(i,:)=s_idx(1:4)';
    pf_fact(i,:)=s_val(1:4)';
end
mod_idx;
pf_fact;