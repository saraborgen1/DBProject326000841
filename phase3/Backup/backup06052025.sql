PGDMP                      }           postgres    17.4    17.4 ;    3           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            4           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            5           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            6           1262    5    postgres    DATABASE     n   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE postgres;
                     postgres    false            7           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    4918            �            1259    24671    matches    TABLE     �   CREATE TABLE public.matches (
    match_id integer NOT NULL,
    team1_id integer,
    team2_id integer,
    match_date date NOT NULL,
    stadium_id integer,
    score_team1 integer DEFAULT 0,
    score_team2 integer DEFAULT 0,
    stage_id integer
);
    DROP TABLE public.matches;
       public         heap r       postgres    false            �            1259    24670    matches_match_id_seq    SEQUENCE     �   CREATE SEQUENCE public.matches_match_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.matches_match_id_seq;
       public               postgres    false    224            8           0    0    matches_match_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.matches_match_id_seq OWNED BY public.matches.match_id;
          public               postgres    false    223            �            1259    24792    matchevents    TABLE     �  CREATE TABLE public.matchevents (
    event_id integer NOT NULL,
    match_id integer,
    player_id integer,
    event_type text NOT NULL,
    minute integer,
    CONSTRAINT matchevents_event_type_check CHECK ((event_type = ANY (ARRAY['Goal'::text, 'Yellow Card'::text, 'Red Card'::text, 'Substitution'::text]))),
    CONSTRAINT matchevents_minute_check CHECK (((minute >= 1) AND (minute <= 120)))
);
    DROP TABLE public.matchevents;
       public         heap r       postgres    false            �            1259    24791    matchevents_event_id_seq    SEQUENCE     �   CREATE SEQUENCE public.matchevents_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.matchevents_event_id_seq;
       public               postgres    false    229            9           0    0    matchevents_event_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.matchevents_event_id_seq OWNED BY public.matchevents.event_id;
          public               postgres    false    228            �            1259    24739    players    TABLE       CREATE TABLE public.players (
    player_id integer NOT NULL,
    team_id integer,
    name character varying(100) NOT NULL,
    "position" character varying(50) NOT NULL,
    birth_date date NOT NULL,
    goals integer DEFAULT 0,
    assists integer DEFAULT 0
);
    DROP TABLE public.players;
       public         heap r       postgres    false            �            1259    24738    players_player_id_seq    SEQUENCE     �   CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.players_player_id_seq;
       public               postgres    false    226            :           0    0    players_player_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;
          public               postgres    false    225            �            1259    24775    playersinmatches    TABLE     �   CREATE TABLE public.playersinmatches (
    is_substitute boolean NOT NULL,
    player_id integer NOT NULL,
    match_id integer NOT NULL
);
 $   DROP TABLE public.playersinmatches;
       public         heap r       postgres    false            �            1259    24663    stadiums    TABLE     �   CREATE TABLE public.stadiums (
    stadium_id integer NOT NULL,
    name character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    capacity integer NOT NULL,
    CONSTRAINT check_capacity_positive CHECK ((capacity >= 1000))
);
    DROP TABLE public.stadiums;
       public         heap r       postgres    false            �            1259    24662    stadiums_stadium_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stadiums_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.stadiums_stadium_id_seq;
       public               postgres    false    222            ;           0    0    stadiums_stadium_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.stadiums_stadium_id_seq OWNED BY public.stadiums.stadium_id;
          public               postgres    false    221            �            1259    16806    teams    TABLE     �   CREATE TABLE public.teams (
    team_id integer NOT NULL,
    team_name character varying(100) NOT NULL,
    coach character varying(100),
    team_group character(1),
    fifa_ranking integer DEFAULT 180
);
    DROP TABLE public.teams;
       public         heap r       postgres    false            �            1259    16805    teams_team_id_seq    SEQUENCE     �   CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.teams_team_id_seq;
       public               postgres    false    218            <           0    0    teams_team_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;
          public               postgres    false    217            �            1259    16822    tournamentstages    TABLE     g  CREATE TABLE public.tournamentstages (
    stage_id integer NOT NULL,
    name text NOT NULL,
    matches_count integer,
    start_date date NOT NULL,
    finish_date date NOT NULL,
    CONSTRAINT tournamentstages_name_check CHECK ((name = ANY (ARRAY['Group Stage'::text, 'Round of 16'::text, 'Quarter Finals'::text, 'Semi Finals'::text, 'Final'::text])))
);
 $   DROP TABLE public.tournamentstages;
       public         heap r       postgres    false            �            1259    16821    tournamentstages_stage_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tournamentstages_stage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.tournamentstages_stage_id_seq;
       public               postgres    false    220            =           0    0    tournamentstages_stage_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.tournamentstages_stage_id_seq OWNED BY public.tournamentstages.stage_id;
          public               postgres    false    219            q           2604    24921    matches match_id    DEFAULT     t   ALTER TABLE ONLY public.matches ALTER COLUMN match_id SET DEFAULT nextval('public.matches_match_id_seq'::regclass);
 ?   ALTER TABLE public.matches ALTER COLUMN match_id DROP DEFAULT;
       public               postgres    false    223    224    224            w           2604    24922    matchevents event_id    DEFAULT     |   ALTER TABLE ONLY public.matchevents ALTER COLUMN event_id SET DEFAULT nextval('public.matchevents_event_id_seq'::regclass);
 C   ALTER TABLE public.matchevents ALTER COLUMN event_id DROP DEFAULT;
       public               postgres    false    229    228    229            t           2604    24923    players player_id    DEFAULT     v   ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);
 @   ALTER TABLE public.players ALTER COLUMN player_id DROP DEFAULT;
       public               postgres    false    226    225    226            p           2604    24924    stadiums stadium_id    DEFAULT     z   ALTER TABLE ONLY public.stadiums ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadiums_stadium_id_seq'::regclass);
 B   ALTER TABLE public.stadiums ALTER COLUMN stadium_id DROP DEFAULT;
       public               postgres    false    221    222    222            m           2604    24925    teams team_id    DEFAULT     n   ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);
 <   ALTER TABLE public.teams ALTER COLUMN team_id DROP DEFAULT;
       public               postgres    false    217    218    218            o           2604    24926    tournamentstages stage_id    DEFAULT     �   ALTER TABLE ONLY public.tournamentstages ALTER COLUMN stage_id SET DEFAULT nextval('public.tournamentstages_stage_id_seq'::regclass);
 H   ALTER TABLE public.tournamentstages ALTER COLUMN stage_id DROP DEFAULT;
       public               postgres    false    220    219    220            +          0    24671    matches 
   TABLE DATA           {   COPY public.matches (match_id, team1_id, team2_id, match_date, stadium_id, score_team1, score_team2, stage_id) FROM stdin;
    public               postgres    false    224   `J       0          0    24792    matchevents 
   TABLE DATA           X   COPY public.matchevents (event_id, match_id, player_id, event_type, minute) FROM stdin;
    public               postgres    false    229   8L       -          0    24739    players 
   TABLE DATA           c   COPY public.players (player_id, team_id, name, "position", birth_date, goals, assists) FROM stdin;
    public               postgres    false    226   �l       .          0    24775    playersinmatches 
   TABLE DATA           N   COPY public.playersinmatches (is_substitute, player_id, match_id) FROM stdin;
    public               postgres    false    227   �       )          0    24663    stadiums 
   TABLE DATA           D   COPY public.stadiums (stadium_id, name, city, capacity) FROM stdin;
    public               postgres    false    222   V�       %          0    16806    teams 
   TABLE DATA           T   COPY public.teams (team_id, team_name, coach, team_group, fifa_ranking) FROM stdin;
    public               postgres    false    218   ��       '          0    16822    tournamentstages 
   TABLE DATA           b   COPY public.tournamentstages (stage_id, name, matches_count, start_date, finish_date) FROM stdin;
    public               postgres    false    220   ��       >           0    0    matches_match_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.matches_match_id_seq', 63, true);
          public               postgres    false    223            ?           0    0    matchevents_event_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.matchevents_event_id_seq', 1368, true);
          public               postgres    false    228            @           0    0    players_player_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.players_player_id_seq', 501, true);
          public               postgres    false    225            A           0    0    stadiums_stadium_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.stadiums_stadium_id_seq', 15, true);
          public               postgres    false    221            B           0    0    teams_team_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.teams_team_id_seq', 311, true);
          public               postgres    false    217            C           0    0    tournamentstages_stage_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.tournamentstages_stage_id_seq', 74, true);
          public               postgres    false    219            �           2606    24678    matches matches_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (match_id);
 >   ALTER TABLE ONLY public.matches DROP CONSTRAINT matches_pkey;
       public                 postgres    false    224            �           2606    24801    matchevents matchevents_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.matchevents
    ADD CONSTRAINT matchevents_pkey PRIMARY KEY (event_id);
 F   ALTER TABLE ONLY public.matchevents DROP CONSTRAINT matchevents_pkey;
       public                 postgres    false    229            �           2606    24746    players players_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);
 >   ALTER TABLE ONLY public.players DROP CONSTRAINT players_pkey;
       public                 postgres    false    226            �           2606    24779 &   playersinmatches playersinmatches_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.playersinmatches
    ADD CONSTRAINT playersinmatches_pkey PRIMARY KEY (player_id, match_id);
 P   ALTER TABLE ONLY public.playersinmatches DROP CONSTRAINT playersinmatches_pkey;
       public                 postgres    false    227    227            �           2606    24668    stadiums stadiums_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.stadiums
    ADD CONSTRAINT stadiums_pkey PRIMARY KEY (stadium_id);
 @   ALTER TABLE ONLY public.stadiums DROP CONSTRAINT stadiums_pkey;
       public                 postgres    false    222            }           2606    16811    teams teams_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);
 :   ALTER TABLE ONLY public.teams DROP CONSTRAINT teams_pkey;
       public                 postgres    false    218                       2606    16830 &   tournamentstages tournamentstages_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tournamentstages
    ADD CONSTRAINT tournamentstages_pkey PRIMARY KEY (stage_id);
 P   ALTER TABLE ONLY public.tournamentstages DROP CONSTRAINT tournamentstages_pkey;
       public                 postgres    false    220            �           2606    24689    matches matches_stadium_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_stadium_id_fkey FOREIGN KEY (stadium_id) REFERENCES public.stadiums(stadium_id) ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.matches DROP CONSTRAINT matches_stadium_id_fkey;
       public               postgres    false    224    4737    222            �           2606    24694    matches matches_stage_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.tournamentstages(stage_id) ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.matches DROP CONSTRAINT matches_stage_id_fkey;
       public               postgres    false    220    224    4735            �           2606    24679    matches matches_team1_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_team1_id_fkey FOREIGN KEY (team1_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.matches DROP CONSTRAINT matches_team1_id_fkey;
       public               postgres    false    224    218    4733            �           2606    24684    matches matches_team2_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_team2_id_fkey FOREIGN KEY (team2_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.matches DROP CONSTRAINT matches_team2_id_fkey;
       public               postgres    false    4733    218    224            �           2606    24802 %   matchevents matchevents_match_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matchevents
    ADD CONSTRAINT matchevents_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(match_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.matchevents DROP CONSTRAINT matchevents_match_id_fkey;
       public               postgres    false    224    4739    229            �           2606    24807 &   matchevents matchevents_player_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.matchevents
    ADD CONSTRAINT matchevents_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.matchevents DROP CONSTRAINT matchevents_player_id_fkey;
       public               postgres    false    226    229    4741            �           2606    24747    players players_team_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.players DROP CONSTRAINT players_team_id_fkey;
       public               postgres    false    4733    218    226            �           2606    24785 /   playersinmatches playersinmatches_match_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.playersinmatches
    ADD CONSTRAINT playersinmatches_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(match_id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.playersinmatches DROP CONSTRAINT playersinmatches_match_id_fkey;
       public               postgres    false    227    4739    224            �           2606    24780 0   playersinmatches playersinmatches_player_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.playersinmatches
    ADD CONSTRAINT playersinmatches_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.playersinmatches DROP CONSTRAINT playersinmatches_player_id_fkey;
       public               postgres    false    226    4741    227            +   �  x�eT[�� ���̊�ڻ��ϱ��P��h���m���,�u���i�}��j/\��}p�� �e[���.ۧ����l�l�'2`��+� Ԙ�����z�D�aU*���!��y��+1�����~:��u��qd�i��DIltd�q2�E9z��zPC�ِ�(�joF�1�D�wЃ�CL�H�QD �$�B��.�7A
t�.΃tL��:^�8�=�u\tpY�y� fHV�桅�'=��y��������7;+�Km�Gp���#�fg�G�\#��u��r��[�W�"�D����Uh[9��u��H��א�fFy�ZF�S���]��]���2��
��ɉ����{�ʉ#����.�������p��U�#�o8hΎ!��	�m$'��3g�̧�^��W:Y�J�bȝ&�mi�u4�SO�3��o��ܺ��<�` 	7���h���������      0      x�u]��5�m�Ϲ�\A�����R$U 7�"����~f��g%J���PKQ\��Dj��	��_��O��O��?}�7���o�������o�����'}���
���ڷl������ߎ�Ͽ���������7�/��I�����3�
�����7�G�,M�7�O��M�7�k�,��>��=^ߘ0P��,s��L8�,���B��,K��8~Ĳ���~f�5}S$'�ob��YX��M�?�r|S���lK��n���z�fv���_G[���Q����&O����'}�s����:�2r#<��o�Ĝ�K�� �L��o���6�'�]ߒ��t��JY����P��'���Z�9����{�oe�u�h׷�Uum|���jj�-s*���U�1}[&<�<b�tb}�lh7���-&f���l�|���u�A坽w?�ҷ�eU'�T����F�m��V ?朗�q�Ϫ������*�n��U!|ϸ�f��v�(�;�73�E��}'!�(�O� J�\�m��u��
u3��C�Kh8r��CG[�4����Bz/m�� {FdR>�A�9#��O]�~/�!d����:��X$Z�:C� rT��];���3����~��|�5e��FV:ݺO0�0oD֥��6�����[��҅����KC�i�6��J����j����y�(d��W�(�l,0����ws6YC�����DVӒ���x����2N�]$�bX!{��޴bA�"��
K`t�[�gL)�m���b@
�a1�����W�C�B����`�Hp�ֈh�'W�н{��d^L��{7NaH��<Qh�&"���0$�po���9�7�a4����޸A��iH4d�"�Q�y3�b��#�� �!��[��W<eAnMb41�yQ�~�T�NT2��*d��m��b�'�S`��6��\��F>q�`ga�"�H�yD�v	)�ۆ��%�<7�],&PI޲D"�L��D "��9� l���	_V+���^&3K%�a��q������j��/�X�Q&�D�Umu�G��F[og�aaL�?�[�<��`7`�#�%�ڶ�bFy f0#An�H߬�V~�;6뵭��/�5�L�vN��@	0t"��^e:�?��d�`!�0м7t�,��q��Os��h��'��چF;���h���V�֫g�0�Xoʲ��N�܍0��O�7GS��#��_���n�ɈW�ڌtv������R�x�f�;2)7�e��@��.q�AcW5{~\��,\�t܄�`�-�#Џ���T�_��xc�2�V̹أ���)�d��Ǔ�-�ٿ̝�h��?�R�8PQ���~1�4n{��)(l�~T���� `jN�������Gs�mѤK���;���- JW6Һ�J��;�ɬi�w��6�a�8H��v����7��G��/-�q6�EKl\���K�g ���X����S4�㵭�MDqpL�D�#vM��C_P�Q�6�h�ƶ �X�Ǘ)�ȇ|��h�H���H2$�e�ې2����b��X��I�7��u:tv܍2�nv:uK	�#�ځ���ɖm89.�N�6&�ˤl�ʏ�&_P.�ⳉ�ߝc�&_^���RL�>:B8�����.��-�L�xHj��Kw�#�1�t�cl�C@u��:�y[������H��:ǜh���Xj6�6�1kj����W*��?NP�y�|~4�O���v��gzC1�>	����g�Є�(��%Z~B�$&�a��;��Ywr&�b���|L8�&���m��,�|�I��e�jR��ɫT�s�4ޤL�g����;��Ag�y1��d�c�;�lж���D�s�x��~������l��!�F"T��ASNR��Z"r炤D��6�p28�	�y�MJ��I�m�.�7ð��3����/|����7W9ٰҴ\8�d�:I�F�O�	�����䘍�z4Y��f�لy�5UƳ�����!�z�n�6Y���1cw+xK�dlADi�]I�������<���,e]G���b}��Mc�\Q��X$��r����g�T�$&��LM��%/1a�~R��_�N�EZ7�\�W�LD�Z\<}n&T�q'�5���g��$�Va�)�4������	vӾ�g���s����ף�܃�a��s��=.�V�۸��l��ۨf_�ie���I��������v~�{��cBLP8B����F�&6���w���8܊�O��dϒ b�9/�].��?��
 ��'7ʥ��c���m�?j*�8Q��ǳx����
v	Q��	͔��/��+:������y��(A]nv��tQ�/x(�!��,9�X14�;�B��=Ľ�@��դt6m"�g�lޅ�8	v�о&5ר�$	�/��J�,��M� ���lx��˜�,���םSɒc��hO_>��eS�����h�+S����жW�9_�6��amZ��t�sQ�)���%�d�`_�@e��j�"��)|F�xci����9J-�ޕ	P�Ɛ��k[��L�O��А7�>}7�׍�O�
-vctI�X7�@]�Rh�s���,MB��x�Bsܘ}B�B;�>�"r����l�K�\�ѣL]2�7)]"��b�7&B�D9�ig.� �I�3phO�ٙ��<���7_[h\��s±аveG׾AF��F���ʔ��Ƶ+M�N�R)L/������Ɩݠ9�K���ǔ�7ZҡT�<M*��P�ԕ�T�ҡ|��W�ʡL������C�����F�4>�`t�ø��5Z�q,QR��ʒ�@�Җ�K�s�MLoM��k49�;�k2�<{Y�`r&�i��E�>�79SY<Ah-ĩش�v��4�T~'Q��u}`Z�j=�5���� ��YM�ǲSMgZ�+z�g����^&X�2۝�b7<�� ��	���)_��~�Q���A[YFEg��V:����.�$hx�Z�)c�G�^ދ�*�)��M��
�a���� w��	=�@��۰J�<^�isՠy�J��}�z���`��fU9Jw�8��x^m�y��-
�շ����1�A?�L�nt3�-ܔg�UZ���-���Б�x�Г�6������L��Ӕ!�7�6se�)C��g�W��_�t`�iw���_V��I��G�r�48�����[���mE<��<+;�E�5�e-%kpd���L ٴ��lxZЛ�l�ċ[��/�;*�&a��1���k�d�kTܢ��\�����0��)I��p44���'�l�X3g��j�X"��������4�$��l�������~�6�<���_T=�v���E�y_cadQ񀩁P7(oj@t/��[�M�w[x���E��~�����l�mK�)�*檍VlLu/Zk��� غ���Z��αA�6\p���q���ZK�[5)��[�����1E��jJ�M}�OjJ".+���)����Y�����n�4��0��"���~N+.@֩76q����� ��6MICw�ѯf�5�/�[�
D�J����O�@JFZ�#�Hi����s1l���� ��$�fк>��,�������)�^�p�=���2̣��޳��C��|���h��5؁<L@_��*�h�l�bڎ�{2��*mt
9�P��>���_�;�s���t�wtOؗ.r��M��d�se_�	E�2�.0턇����8��1��^�&̼[��Y6��6<�}L�B?1���N�p�Gv��I�7�9�ovu�G��_��F�>��p" ^i).}�m��iS��%>�}�@�7N=�dY�_�FgSo��25܄9��j<5��٦��H�
�6O��`��%�g۳��_�)f`�X�Z/�T߆]|/&��m�
��(0�5��6�n�tV��N�.���>({�o���N7�Ȫ����u�%��L�{7Q�{�wӕ���ML�ư����|J�������Y��.�/����rT�M�q]F�m/�ҀԼ���(��i�TD
[� Q�K/�K���p\&i�ΞF0Iú5    �����|�ވ�+���V���,���*�5�r���6R������u��0h(�\������t�T�8b4��[&C�2�ϒ���\m�T��(o�� OAn}b�Ʉ�վ�l#�<iKd��>��H&��i0<##���R�ssPe2U>^��&�����\Y�To�G�FꏣY)���cH�,���|�z��$�����/Y��l���u��v�4���h��(ғ�$�a�V�3��>��W���s5��@0N�UÐE3Br���[� gQޘb�UQ��1�E���¼��mL,���*�h�����x��l@O���`��@�n�{w@O)�5{�ו�:��s�	~�<<#�����ޞ{ ��T��o�Ǿ��
y�{�(x�����yߚ[��f!��|`��bπ[�!;隳�~�p�ѣ\QW��g0������'��%g����z����÷o��f�	
8��:�R�~2٬�n�u�ه�t])��
���|�U�s_8�&���o/x��*��b��p�*��T�̪$�||<��OeT�K��Ry�f�n���1�b��247�@	���] Vˍ�U���IM����?7�~A����i�];�,ؗY�$��6#e	�%me��t��[�.f|�m����ELj���V�I98G��pP�� H��.��ɬW�6�ᢿ�3��- 	面�D��?�S�b ��=�(>���;���ߣ�z�$y��B�?>KY)P���K�"g����O����<)����k�W���
/"^E�g�ȋxW�����\?I{���?w��=Ã�2We�I�'�Q\f_�&J٢/��H��A���j�_�XMҾ��@$�؊Aɢ�3�%�؎��%���)Ae�m�w]>g*�]�0��\�)����w���2��a�r��a���<��@%�7]��_Ф�h��<�Lox� �I�}*z�뛡х���\�t!:*=���]��J�;/�0��/�����QY��X0lۆ*���3/��Cq3a�Zb��ۦ7p�"�<P�h�Υ���M歲�=E:��=�d����}n�U�i��g�7�E���ST7K��z��j�����U��n���:�]���t&�s���*iM��[�t=�����ԵHkyb�N��;.3j���x���jF�[[��o�5?8J�wx�G'h�C�A�f��a��}� {.�ho6X7l������wg8rac��B5��{�:�3l��$�5�����L��f�a�U��b�C�1���1P��]ۧ�>P��|�Y�d�9q�G���XP�T���/Q�"�Ł����]�n薊j��ZE�k���}���h�FsKJ�f�y��nX�"�O�uo��o��*{�BU����E�+U��͈�j�i���@u�ˮ�HWT����@��'�/7n�� ���~_���O"�e��D�[M]�2}�J�e�ƌ[ɖkF{����au��HO�Z&�/�Ĺ(�������@����,��h��v����u���/)'����M_���ͻ7J�L9�;c���KWj�OM^ i-;Ԍp�K��E뿚�@�	s�6�gLR]w��
~� �2�hoc�udai�t;]i�uZf���U�m�OI.��_&6�"*Z��Ejm�>~�^�
��rԗHkR3Pg�(�گ
/PY¶�@}��>�A����r�A!¶�_�:i>�������.�j���1P)��B1�P��5{���"�7�(�;��L��F%��*NpUC�J��z����N1hA.�-R5�smZX3�|0t��2�c�:������AE�F���p��.�0agg`\L`�D2�þ��:D�Ճ��X�{q�:b��Fq�RW�=�-�����tu#��� ��ў�)@���5$������
Lй:��&��<���l ���J��K�� ]
w��h��Hϕ]~�)ڐ�w
ԨH�3E?PU����-�Z��i���@���pԶp��!?�V��-�B����4��{�,P#����jF�爍<���7��Iu��S�^gOR�\�]���X]�J����L�W\3�O���=�`�jK5l�2_�HE������j���ޔ_�p���O��u�}��ޫ�>]� �ۮ������7���|�g�X�6��m�=C�oB��n����O�y��o�yj��e�U�{.� x����>�0��aN[�k5o��G����������߮��)����+�|��ߝ�\��V�&t�{�*2?������������#C�-Œ���(��4�+�5��kV1�
թ^�N
�gz�1X�&�)�ej�O��0���[F�w����-3=�#w����24h#/C�q3r�$��4~�3���j�p���1'��8�Hi�>��b�C=x����;�8�zB٠���p<>�'�����M��)��{���B�9�Or�?E/�;��<���rjf�6=�r��e;1��"�XX5�~v*�o����K)�߄����~��.k���R�p3v�lao��$��ؽ(YC�Qx{�L/�&���ue�вK��/#����0f���e��kV�%�B�"�g���0%��YK'��K%���$�{*m�T����ʊ������.k��������U��J�V�$����Q��D�����.ߌ6���b��Z[��z+��SU$����W��tύu/���#I�q�CV�ڹ�T���{sK�)�������G���NOhr���F�������������KX�=�\��2��1~�9�t��9�5sײ�LR���xw��7A�}���Fك+���}^��z�b<ʢ��i�.�/چ��|�ݼ�\ǥD�.1�D� �k�p��x{���r�����Q���z��$E�~�]����gY�/ߌ~u�~Q�����)��g&��D������2o����W�B׉�s�).��EwY��b�O���t���~�[=��r;�j��	L�fR�w���I���WV�����K��#^�(J;I�f�<4f>������F�zj��ya�����%���fz��Y��>�]�/��	��ǉ����x6Fu�s�{�����h'��x�l���O�V`����\��$��F�EQm��f�&�ɬ�[x���&,.�����R9}k����y;�c��=�sڐNO�5�[1QB�Q�٦�m�Me7@��M�i"&��g�v�tL?�����J��:$N���(��D�<2cSܖ�[].�p��M�7R�]ɞG�rzB_��:^ߌ&?p�_>U �	��i�ٜ)��Zv�R�L�W<�sc���	?�<���ˤ��{~?HU�vs�C:s�.�h^���X�(��"�yD&o�=��)�A�
�gy�8���vy�~:�Q�AG����I]{�'Y��嫭[���t�7�F��j��$��Y�ӻ��z�x�Nr�&v����#{�Wߠ_��U��w=U�ՈLٓ���Y}8��t�pQ��_}Aߙ�7��u罺�ʽ��:(!?�P�'��/����'��@��"*��<��O������"�2��Ɲ����V��t�+�^D�<{�!/G��Jnl	�H�7�����p@ ��5��u~������g4�\�S)<ř7�d*�n���-��k�G��]�<CO��7yֻ���2M�XN5��bkf{�q���A8|�B���h��4^��)��/��.�}�	�4q�'�����n�����M��G�&,���O�����0W��t�������E��?���,�����C:h�
��n��깘��� ��v���%����E�uQ|{Dk�w?R���i8�:m:Q��8�,]N�Y�v����_'?��	���C��$ϡ�'����O~a4<��E�C<=���W�WSނ�A7�?�>�� �Ԕ��L�������}w���/��{'�"�u����PK<*�t�b�Ou���q?2o�<��\���Ϝ�n��$ϜWs;1�'W�9o
����S�2�%�b��mS�4/J��Q�A~n���(�	U�&
D��؞7�oϏ�V}"�g!x�����kw;W}< m   j8��_/m�ǯ�3����;�)���ϭ�\y��ſÕ����o�����#����q������΍����&-�6�o��G�h=�֘#Z�������?U�E�      -      x�u[�r�H�]�_��lFx?�e[�(�C�쮎٤�,-�I�诟sn&@�`G(���Hd�ǹ�>zq��T]W��Z�w��~�nU�������²�n��&(�0�p�o�Q;�߶�~�~~+�㛠��
/��l�yI�}�L�<�{�x��v]q�7a�^N�����P5�OU���[`Q�M��	_^L�2��ǝj֭�W+�n����~��	��p�Nr/��GU�L��o�jףK�<�0��!�i��ZyM���惃^�e�!ʽ�
���˕���:7q���^:��xDa{�?�=�=�\��$7�]�L�ċ!D�������'r��#a�^�L &<4Sz�Z�V����Ҋ&�Q���A
/��5��W�ƛY��7t�z�֔��������_�}�e�M �(�(��oy\7�����0�����O`�bS����f �'Y����PLXH�}�M[)Y��@�s{�	"��2�6#�k�W�OS��=��BvM=�o>�o�|W��Zaߏ�m�H��7�LVǐ���8�=�VG���V.Vy8DLwI�;�>�4lӼ���Z�K��!�MR��8�\�\�Û��	�I��L�-���U���P�ơ�Љq;�"�����:���sg�J���$���]��N��,�)d}�P��$�鞟k��D_aYk�dkU!�����ݫ����ƿ;4+Ռ�Y��A�8u9�2��l�[�?3�M{�!�F�Pey�=�v��zg^�����8K=,,�d��Kr(.
���>��O"b-���@�a���G0�,��
&%N�z3S��}ݍ_
����$�covh���b��9k(�L��PA@?l���>�v�9���s��$~>c��j����Ϋ�35��R�絁F?iӾ�sS�h�@�x���l����c��w�r1|�^\
�U��U���'),"�db�w��Z�?+b�[�Q�xsHMe1���ۭj��th����.�M�[y�ԓ7������X��2�,�UL򄪟�5vۘ��sܞ��ͪ�[�iv���w�tx�`֙:%���٤��-�n����aFh@1q"���D�e,������s/�TФ��[ɽ1kO����\�KR���H�V������>ΔsѴW}�Z���
�� Y��v��N7"4�q�L��e��aˌQO��A��aYJ#�S��	jv<b��P4�GU�HLY�ֽ�Z�xa ���wp <վ�"�ڒ��%�Q#�w�kX �b�r�Oև]C�}/k�޼�����B�+�	��O���4�.̈m'K�u}P/𷇦z��{+���:ؐq)�`x�� �z��p;?i�%g��A�S�O�3��li,��CH��G����_�xg�g]�n!S%a��6�z�i�c��V �4�.�����
�@�y�����(��[c��p8fFC+��ٻ3�yǢ�y�cI .$���J����*�]���>%�S�1u}|��@���w1�BP�{G|���s�y�^Ɍ��JQ�5���/R���	�`&����{a
i=y��Q�]�R�?�w8����P*�� j��!o[�>"��:�K$�F<&��B�>Y�8��� `�L��=���{����j1qe�L$೪YU;x�/��ncӢh|X�� �ZZ��0�C,=[ ����_�pV�頽��,����(�Ǫ�H��'�1�;��� �m�O�֍sZ%g5��#`}5��g�]3\o5Qqx"!� �4����q���V�=�#q�;7`e�`����~@�>�_��)����r�0�,cZk%�)ׇ3���;K���������Q4���M�BH����_pa���$?�PR��P�JSA�FjlH0a��Baߒ�u�ڊ(���R��^�mp����ߑ�^���c-�\��^8n��r
�6��kX�fB�լ�������
���Ϡ�����_r4�pN�B�9B0�L.Ŭ�Վ�_�����XJ*�$2�t��X�Hw��!t"�g�Ja�[D�5r�.	����!D�\��A�M]n�%w�>��à
�܌�tg@�>���F2P����4P��a�R�	�֔[���d��j��.]b�K�A�!GPI�?����E�P��rA�#��3���jkvg�Lh�֑����ز�����'v,��U*����|���D���L�]!��Dq��=1+9�=�!J�l�˃X�$F˳'tX�0!�cx�A���@�LG�2#�����y���=K��2��� *��_�)�ՙ�$%�&0@h��vw�9��Z��*$v!� 
X#�0�����ʲXA=�/�^�E�=���;E�B��釢�/H9}D����^$�j���ޙm�T�> P�ڴݕsze��x.1gQ�Q�+�]l▒x?T��G:�[��B爸eiK���>5��,�$��G�Gާj�!>�	�
�]UtN��IO"p'*�*���_�g����"؄�Z�L%S�������5�x��� L" N����~�����X%�g �0>���Z����+�¼E�P�`)������#�q���G���O��J�<���/��
f�΋٥����s�v��6�e�Ù"C���� ���$E'c�	��80)H���@��U���B�	��9�{:y��@�Nx���/�f�����U��y_A�Dd��;>�HL��*ސ��X�fvAּ2�������&c�� I��=�fm~������R��A�cFl�Q�}�U缉�H�I���ཻ7��H�7��(�S�D�ނp����<�]$��<%��l0c��ħ�}<�B�l���[�"`1s4�qE��x���S�uDӵ���þ�k�RN�>���j	WG�^��A����e��R��~z #�yF?Bj�E����Z�$��#'������A�i#��X�<��l��1����"F쮙!iaf	d	�������=!�hh!����`��r>ح���Z�۪�T��L��ϕ�C���_$�I�HYb��fLff�[sw\�(救�Di=�W�ON��\�d�[�)H;�.�H�CJ��سK���9��B��8kT%��'��V~oWgj��I�+h�ؽ���{�����X2�!�gN����)�(A_��c��/#�4�j
�!���v�.��b�E��T������w�Q8�
&I$����E���\E����2�$���Sk�0�A�6�09�"B4�A�]���3F���zWye���V������Z5>�a�UgR�k�0N3��H)Z]�'
Z�Wò��l����Y �g�I���KU�X����O� [`���0��9,kt{���r%d��)q�NK��q�
~Pi-3g�!�>AƖ��2��ھ��EB��ҥ�<sN>��U�Z7�־HM�b��g�/f�9(d�j��cO,\h�^RIQ�A
��T��"�M �I���+q¾1tB�ܑ{7�l��L���pV�vY��Ʊ����^�Ӻ�}�dOGM&1�����ا��9!.��}�}9ԕ�D��r~NhSK��T��oz�w����l^ȉ3�TJ�~�1�F�^h��V��8�A�)��Zbgl� .)8��*pq^n%�ƙtQ�)����
l�L�Xfν��6k�J˫Y������K�5΅\�X��S/�E�U���:a:n�Ъ6�|#���^*!զ=3�(���������J1�@��Od���9���u�W|
W( �����᫪�I ��xO8-g����@�G����N��Nl�V���������ZӐ�`Y�d���^���ݞ��Fv�-Rb\V5��wu�%��a��]�8�z壦�?� �+�%tK�JZy��r>`��>�!dfs�d�����н�s�R����q�ի���BO����zh��,�[��Y��v�v%�$�a�9hp��&����YS,JmS,;*��T/�Z#�К�	{m]R�!0�t]:���3<�����]��)	)R)��昐�4�IX�P[~�\�3,�9��m��{(��d�j����uܦ� 	  <��r{�D҅ن='ե��ǮFL��Ű�H�C�i��0���^dKi!� �X����k�ƴ=&Z�$6Ǌ�$3o�׬�Zoո�xa!���,��;]�����ar7P��i\�������K��i�
xt�U��Ҿ檾V#�T���6[���U=i��[�A,%��{��D��&K2�O��9�ܝ�>�c5�����pJݵ(�Z� 4/�ޟB���&V휑���p�e�q:K�K0d6��i�4���b�	.���]rh	�v���m5.��r*CY IO�9�Xﯭ�K����e�Xƒ]�?J]��u]�ܕܥ�[��)��{�4W�,��t�x�1�i�/�&�*	s������7k�T���%��T���6#x>�GbC(6��=U[t���M;l��r֜t9!yL�Q\W���_h�w.qt֩������ʁ+7�4X>%j�Z�@�C]W�jCl��֥"����/U��]�¡JBI9���Ȯw�+��V�\�=�rɥ`{l�� �Q�6����#(g$w����׫_ m-��l�^�W�a��4����$lt^�xh�o��Q
X�(e)�H,�8Fջŉ���MB�=�������4u�~��	fשK�G�N,8��[%v���po߆���K��
;�p>���=���`m�~ی�����N
����S�q��a@Y�l+���P��	��Z�^��g���5�<&Fn[࠺1��ր�o>�pdӪ�Ȑ��:�ݴ-G�[1�f_����EF����-�s8��S<فm�?M�zF�S7��J�x38��Vs}��d[R�OD�:8C%'�hޜLH�$Kg8Iɴ�^W�
8��us�[���ez�b�u��\cv���q!���V�5�3(U��rH)iP,0�JE��p"��^������I���L�r�D�c7�}Jy��x�4fcx2�]�
}[m�պHO��e��}�	�Q�:��%w�-.�t�3�����vWJ)%�RQ\�h��4�1c&�8~���X9{�}O�2��s�X����Z�X۹�Q�$qҲ"�&<`���:� �9����%a�u�w�S]3E;�+�wRpd�7G����ʾ�`ȋe��8�wתW}u��;+O�A�Y�d0�T�jX�s��-�V���LIk�ïa��dƎ��?��"�o�e�)l+&�{�O���m�E�*sJ%� ��KM|���.�{��Ǒ�e�a[��u1L��JF�G-���xh�$۱]�����0�kA��SD�F��,�Y��������7v(SI0H����}ϋ�3�M�0���n�MxE�d�+fɛc�*��Q0���¯H�G����'`��F�n���HW�\�60����r*�����2輕2�w/���v1!�A��_��.������r�j�`ؿ�v�˜ON¼$���ò�dj2��Zb�l++��G͹=���ZOP�@�r�[c?`\Kz��H)��r�Zލ�`g�K)�������/u��Ei��Ʌ+���;�6�^��`-5�����v��)���BEsŤl�g���'[؛W}y9�MX�b��E����c��lJ��m�Zح~�����R����p��He�-׳3E�3���-��XR��C L���v�2rd��Pɺ��~���/��Q.���c,:�,�7���`qA�{�~�:Z+��%"��*��\%udݥ�H�X@K��v������)$�Bj����l�f$��e�p[X�B�5iU�2����Y~�È��ZI���o�O�9����mk�������k$���Bb�v�gn�����2;n���>�fO3��Gc�ݠ6y���c��/Z�F�UI��/Ңs#��� �1���B��Fj��A^�6�ٍ6���cgs�����G�>�+K3;1���~Nt�߻���|lR�zRm��i.l��r[�/�-�lw]�K��:8� ��� 3�!��"��͹C��q���#�n���#K����^�M�O��ǯM�F�t%�Lƨ��^4W�jn֙S � 4R&9r�y�^���"��P����Ĭ�Esyّ&;�J�"ɥ�lK�?9T3��C�����S� ���:`��m��2�l���H���/��-�k�1v_�IJ,`-`���� �f@����'ڂ�Lm��h�']@�1l��ʧ3���~'1�k�ebr�����kՋPrk�2;�������0�T8)�&
���^H�|��a)_Mk��$#}��8v)%���W3/�#���o��3I�������}eȦ	�TJ���Ϊ�R�y�T��'"�$�+�*Ҕ�k���ܹ2�������&���O�0�      .   S  x�=WI��H[�ӑ@λ��N���րk���r $$�������}�Ϫ�����Y|��3/^��gsɬ���C���˵x������ƛx�fsM\���z�y;y`�G?���=g�^�wE�g%/,)�0p/@���=3�ǿ�GA��C���GĽ����,R7����ơX�3.�8��s����/�IT-�=H�tϫ����.��W�et�5����EA�k͚WճC�^�M#s������k^yNv�:m�z�b�㗰�;� ֛>,k�`1�?�Q�W�OA���͸�s������,�a�~��*ˡ�Ql�z6b�:�bY�O��K�Nש;Sy�\
ɐ�"��O�Ͽ�ee�-�L�
����H���B�"�D|�Fa$*��
���RL����7�9�j����I0��Ck�EB���4u1|�vzf���n��PL� L:7
��E7A+<A����
������1�T�V�ﺦH�H�g�k��H���lʀw[����!@�ENmA�bAe���
��D>)�i���� � u�2ur���K�;1(��և	��W�+u@�2i���h9�z?-&�D뚁 Z�a�������Z1)*:~�O�w��}���{G��f�?�;A�4ч�H�Yĩ�"MK}�5��N����RJ�YupR�y�+_��n�-���8�� ������ɓ�SOa�S��)����BRTy���mh��������㤄t�o�E�*���%�k"�=T�c�o: �\޴7f���*)�݇�`E_��pڰ(o�gِ(xS`������ÁP�T�Dqt:�V��4k�œr�@>�ΧZ���"I����%�������U�?������i�;�_�g7���\&c�(ȶv�=��|��:���X� �ҦX쒚 X�O���i�O϶��-f[4��1�/�οPLM�����S�o����9۫����m���پ��ۃ
,Wh!��-���R�AŹ��)́F7u�]A��}~�Qo�$�g�彟��q��+	���Z&Bf�N�@�%�<�<Q�R|�(�m��#��{����39�8�3�ԣ в��
�;Z����\3]5��a;<ߌ�=�w�a��g��a���P5^�1�	�4���PJ��q$�Z�3�B�������r��C��rΏ�bZE,t�3y��4;��/��#
9*��5��Qo��ٵv��|S��w���Ud���*�;%m�=)�X[+��k����O�a][<I�Ws�'ټ�:]C `<;�ew�Q)�>hߍ�k��
�� џ��D�����Y`��D�*�V�azʙ�h�k��nB�B��x,x�f��_�o��l�ηC�f%~I�8ְ:�T�WA�i!=�;� ]�!9^�>�,R���uG�:��PMk���:|~&8Ŷ���M�Q�k���k�)��;{�cg�ϑn;D��O��.������r�jF/D�*���=�=�Xf�r�(��j���Ի?�Ĝ�|!���g��3�8z�٩*��ނ�)�)��},�Zm��}j�[�報�#�W�5�?�IW��Y!���V�!(������)��      )   T   x�3��)-N��Q�L���LV.IL�,ͅ�rZ ��c��Sbe	\����/�4���^�y��I�*���38M�jb���� I�      %   �  x�-T�r�8<�_�/ز~m��d�T���V���c�t�T���oә���h4����Ό퇁�q���wt�Bt�5B;��G��o>���P�J:^�8z������V��О*U��u�]KO^,�{k?�`�j��2��M�`�mM���Ղ�}Hcǖ���޷��9ӎjNO�z	7���~��CL�#�T+�Kl'z�heʭd��Rk:H���dY?9�-�U1�]�Ӄ����rAK{*f�(��i��wA���Ɋ8���qh]@��n���ڋרĦ��RmƘ
��A�Y�)��X������ܥ<!|�s'���VŜ�?C9�x�hK�\:�����h�����|��PŒ}�M�醝i8Ka �ԥ*V�3���m�L�~��D I�RŚv�����`:Ӳ~6����{Vf����z}�0�k,���\𢜩��}3r��Z��~1�|SY�����c:�)��AR�΂���n�$z�`���sg�,+U��̎�MH�4�	I9g֪��Ƣ`	�G����ʹ*t��äw�c���$!�zȖʅ*�(���/�a0�� ��ό�T�
�;Qdӆ~4���+W���<H�X�7o�'�ψ�?��,�ZU�����Iô�xg�V�▪���?�n�C~p�j��Y3��nV��J��u�3Z�	}����QU���c���o;}���	����5�����Oq��NI2H��lA�b�Hי��n1S��jA��]������B����BUK���L�-�����dr�KU�0�g�<��Ô���T������K����Y1o��_{]�zFw�7�W8C�4g���@�L�E���,�j�d�Y�.���{\@8�o�=˼��Tu��Õ��0T���+U׀��ĞM((z�����K7�#�P���x7��&�r�sU/h�%M�_�2��i�Ѯ� �P�P���@+bX}4������^�|�����͓~��N�W�߿�R����f      '   u   x�M�A
�0����S���8)���n���P����Nw�����ۍ5N	:@�h����FV�r[.?����q�#�-���;�k\>P[O�I1����Ħ�~쉄�~ �/�Z*     