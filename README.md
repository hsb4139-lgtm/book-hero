# 책의 용사 · 리브라리아 독서 RPG

매일의 독서 기록(쪽수·느낀 점·질문)으로 캐릭터를 키우는 6학년 교실용 RPG입니다.

## 폴더 구성
- `index.html` : 게임 전체 (화면, 규칙, 저장)
- `api/config.js` : Vercel 환경변수를 게임에 전달하는 서버 함수
- `supabase/schema.sql` : Supabase에 표를 만드는 SQL
- `.env.example` : 필요한 환경변수 이름 예시 (진짜 값은 Vercel에만)

## 배포 순서
1. Supabase 새 프로젝트 → SQL Editor에서 `supabase/schema.sql` 실행
2. 이 폴더를 GitHub 저장소에 올리기
3. Vercel에서 저장소 Import (Framework Preset: Other, 빌드 설정 비워 두기)
4. Vercel 환경변수 3개 입력 후 Redeploy
5. 사이트 접속 → 첫 화면에 "학급 서버에 연결됨"이 보이면 성공
6. 선생님 모드(처음 비밀번호 0000) → 설정에서 비밀번호 바꾸기

## 주의
- `CLASS_CODE`는 학생·선생님 비밀번호 암호화에 함께 쓰여요. 운영 중에 바꾸면 모든 비밀번호가 맞지 않게 됩니다.
- Supabase 무료 프로젝트는 일정 기간 아무도 쓰지 않으면 일시 정지될 수 있어요. 방학 뒤에는 대시보드에서 다시 켜 주세요.
- `service_role` 키는 절대 쓰지 마세요. 게임에는 `anon public` 키만 필요합니다.
