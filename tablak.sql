create table vasarlo (
    v_id int generated always as identity start with 1 increment by 1 primary key,
    vezeteknev varchar2(50) check ( regexp_like(vezeteknev,'^[[:alpha:]]+$') ),
    keresztnev varchar2(50) check ( regexp_like(keresztnev,'^[[:alpha:]]+$') ),
    szuletesi_datum date default sysdate
);

create sequence h_id_seq;

create table hangszer (
    h_id int default h_id_seq.nextval primary key,
    nev varchar2(50) 
);


create table zenesz (
    z_id int generated always as identity start with 1 increment by 1 primary key,
    nev varchar2(50) not null,
    anyanyelv varchar2(50)
);

create table z_h (
    z_id int,
    h_id int,
    primary key(z_id, h_id),
    foreign key(z_id) references zenesz(z_id),
    foreign key(h_id) references hangszer(h_id)
);

create table egyuttes (
    e_id int generated always as identity start with 1 increment by 1 primary key,
    nev varchar2(50) not null,
    alapitas_eve varchar(4)
);

create sequence szerep_id_seq;

create table szerep (
    szerep_id int default szerep_id_seq.nextval primary key,
    szerep varchar2(50)
);

create table tagja (
    z_id int,
    e_id int not null,
    foreign key(z_id) references zenesz(z_id),
    foreign key(e_id) references egyuttes(e_id),
    primary key(z_id, e_id)
);

create table t_sz (
    z_id int,
    e_id int,
    szerep_id int,
    primary key(z_id, e_id, szerep_id),
    foreign key(z_id, e_id) references tagja(z_id, e_id),
    foreign key(szerep_id) references szerep(szerep_id)
);

create sequence m_id_seq;

create table mufaj (
    m_id int default m_id_seq.nextval primary key,
    mufaj varchar2(50)
);

create table album (
    a_id int generated always as identity start with 1 increment by 1 primary key,
    cim varchar2(50) not null,
    ar number(8, 2) default 0 check (ar >= 0),
    brutto_ar as ( ar * 1.27 ),
    kiadás_éve varchar(4),
    e_id int,
    foreign key(e_id) references egyuttes(e_id)
);

create table a_m (
    a_id int,
    m_id int,
    primary key(a_id, m_id),
    foreign key(a_id) references album(a_id),
    foreign key(m_id) references mufaj(m_id)
);

create table zeneszam (
    s_id int generated always as identity start with 1 increment by 1 primary key,
    cim varchar2(50) not null,
    hossz varchar(8),
    e_id int not null,
    foreign key (e_id) references egyuttes(e_id),
    a_id int not null,
    foreign key(a_id) references album(a_id) 
);

create table vasarlas (
    v_id int,
    a_id int,
    primary key (v_id, a_id),
    foreign key (v_id) references vasarlo(v_id),
    foreign key (a_id) references album(a_id),
    datum date
);
