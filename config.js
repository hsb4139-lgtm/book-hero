// Vercel 서버 함수: 환경변수를 읽어 게임(index.html)에 전달합니다.
// 여기에 값을 직접 적지 마세요. Vercel 프로젝트 설정 > Environment Variables 에서 넣습니다.
module.exports = (req, res) => {
  res.setHeader('Cache-Control', 'no-store');
  res.status(200).json({
    supabaseUrl: process.env.SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL || null,
    supabaseAnonKey: process.env.SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || null,
    classCode: process.env.CLASS_CODE || null
  });
};
