create table votelist(
    num number primary key,
    question varchar2(200) not null,
    sdate date,
    edate date,
    wdate date default sysdate,
    type number default 1 not null,
    active number default 1
);

COMMENT ON COLUMN votelist.num IS '설문번호';
COMMENT ON COLUMN votelist.question IS '설문내용';
COMMENT ON COLUMN votelist.sdate IS '투표시작날짜';
COMMENT ON COLUMN votelist.edate IS '투표종료날짜';
COMMENT ON COLUMN votelist.wdate IS '설문작성날짜';
COMMENT ON COLUMN votelist.type IS '중복투표허용여부';
COMMENT ON COLUMN votelist.active IS '설문활성화여부';


create table voteitem(
    listnum number,
    itemnum number,
    item varchar2(50),
    count number default '0',
    primary key (listnum, itemnum)
);

COMMENT ON COLUMN voteitem.listnum IS '설문번호';
COMMENT ON COLUMN voteitem.itemnum IS '답변번호';
COMMENT ON COLUMN voteitem.item IS '답변내용';
COMMENT ON COLUMN voteitem.count IS '투표수';

create sequence seq_vote nocache;
alter sequence seq_vote nocache;
commit
