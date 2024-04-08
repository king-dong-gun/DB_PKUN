-- SEQ_DEPT_SEQUENCE라는 이름의 시퀀스를 생성
CREATE SEQUENCE SEQ_DEPT_SEQUENCE   -- 시쿼스를 시작하는 SQL문
    INCREMENT BY 10                 -- 시퀀스 값은 10씩 증가
    START WITH 10                   -- 시퀀스의 시작 값은 10입니다.
    MAXVALUE 90                     -- 시퀀스가 생성할 수 있는 최대 값은 90
    MINVALUE 0                      -- 시퀀스가 생성할 수 있는 최소 값은 0
    NOCYCLE                         -- 시퀀스가 순환하지 않음
    CACHE 2;                        -- 시퀀스 값을 캐시해 빠르게 가져오며, 캐시 크기는 2
