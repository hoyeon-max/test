
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MBTI로 포켓몬 찾기 🌼</title>
<style>
:root {
  --cream:#fff9e9;
  --yellow:#ffdf78;
  --brown:#493b2c;
  --muted:#85745f;
  --pink:#ffe8df;
}
* { box-sizing:border-box; }
body {
  margin:0; padding:22px 14px 40px;
  background:var(--cream); color:var(--brown);
  font-family:"Malgun Gothic","Apple SD Gothic Neo",sans-serif;
  font-size:17px; line-height:1.7;
}
button { font:inherit; cursor:pointer; }
.container { max-width:760px; margin:auto; }
header { text-align:center; padding:20px 8px 28px; }
.logo {
  display:inline-block; background:var(--yellow);
  border-radius:24px; padding:4px 16px;
  font-size:14px; font-weight:bold; margin-bottom:12px;
}
h1 { font-size:clamp(30px,6vw,43px); line-height:1.3; margin:0; }
.subtitle { color:var(--muted); margin-top:14px; }
.panel {
  padding:25px; background:white; border:2px solid #f4e6c5;
  border-radius:26px; box-shadow:0 8px 0 #f3e7cd;
}
h2.section-title { font-size:23px; margin:0 0 4px; }
.hint { color:var(--muted); font-size:15px; margin:0 0 20px; }
.grid {
  display:grid; grid-template-columns:repeat(4,minmax(0,1fr));
  gap:10px;
}
.mbti {
  min-height:52px; border:2px solid #f0e6d3;
  border-radius:14px; background:#fffdf7;
  color:var(--brown); font-weight:bold;
}
.mbti:hover,.mbti:focus-visible {
  background:#fff2c7; border-color:#e7bd4d;
}
.result { display:none; margin-top:28px; text-align:center; }
.result.show { display:block; animation:appear .3s ease; }
@keyframes appear {
  from { opacity:0; transform:translateY(10px); }
  to { opacity:1; transform:translateY(0); }
}
.result-card {
  padding:28px 18px; border:2px solid #f4d77c;
  border-radius:24px;
  background:linear-gradient(#fff3bf,#fffaf0);
}
.tag {
  display:inline-block; padding:4px 14px;
  border-radius:20px; background:white; font-weight:bold;
}
.artwork {
  width:min(100%,260px); height:230px; margin:14px auto 4px;
  display:flex; justify-content:center; align-items:center;
}
.artwork img {
  max-width:100%; max-height:100%; object-fit:contain;
}
.emoji { font-size:110px; line-height:1.2; }
.pokemon-name { margin:0; font-size:36px; font-weight:900; }
.type { color:var(--muted); margin:4px 0 0; font-size:15px; }
.info {
  padding:18px; margin-top:18px; background:white;
  border-radius:17px; text-align:left;
}
.info h3 { margin:0 0 8px; font-size:19px; }
.info p { margin:0; white-space:pre-line; color:#655644; }
.match { background:var(--pink); }
.match-type {
  display:inline-block; padding:3px 14px;
  border:2px solid #f4b7a9; border-radius:12px;
  background:white; font-size:22px; font-weight:900;
}
.match small { display:block; margin-top:8px; color:#655044; }
.reset {
  width:100%; margin-top:18px; padding:14px;
  border:0; border-radius:15px; background:var(--yellow);
  color:var(--brown); font-size:18px; font-weight:900;
}
.reset:hover { background:#f4c94f; }
footer { padding:24px 8px 0; text-align:center; color:#9b8b75; font-size:13px; }
@media(max-width:440px) {
  .panel { padding:18px 14px; }
  .grid { gap:7px; }
  .mbti { min-height:48px; font-size:15px; }
  .artwork { height:200px; }
  .emoji { font-size:95px; }
}
@media(prefers-reduced-motion:reduce) {
  * { animation:none!important; transition:none!important; }
}
</style>
</head>
<body>
<main class="container">
  <header>
    <div class="logo">🌼 나만의 포켓몬 찾기</div>
    <h1>내 MBTI는<br>어떤 포켓몬일까? ⚡</h1>
    <p class="subtitle">나와 닮은 포켓몬과 잘 맞는 유형을 찾아봐요!</p>
  </header>

  <section class="panel">
    <h2 class="section-title">🎯 MBTI를 선택해 주세요</h2>
    <p class="hint">16가지 유형 중 하나를 눌러 보세요.</p>
    <div class="grid" id="grid"></div>

    <section class="result" id="result" aria-live="polite">
      <div class="result-card">
        <span class="tag" id="selected"></span>

        <div class="artwork" id="artwork">
          <span class="emoji" id="emoji">⚡</span>
        </div>

        <h2 class="pokemon-name" id="pokemonName"></h2>
        <p class="type" id="pokemonType"></p>

        <div class="info">
          <h3>💛 너와 닮은 이유</h3>
          <p id="reason"></p>
        </div>

        <div class="info match">
          <h3>🤝 잘 맞을 것 같은 유형</h3>
          <div class="match-type" id="matchType"></div>
          <small id="matchReason"></small>
        </div>
      </div>
      <button class="reset" id="reset">↩ 다시 고르기</button>
    </section>
  </section>

  <footer>
    포켓몬 이미지 사용 시 권한을 확인해 주세요.<br>
    MBTI 궁합은 재미를 위한 설정이며, 실제 관계는 사람마다 달라요.
  </footer>
</main>

<script>
const data = {
  INTJ:["뮤츠","🧠","에스퍼 타입",
    "깊이 생각하고 큰 그림을 그리는 전략가!",
    "분석적으로 문제를 해결하고 자신만의 목표를 향해 나아가는 모습이 닮았어요.",
    "ENFP","차분한 계획과 자유로운 아이디어가 만나 새로운 가능성을 발견할 수 있어요."],
  INTP:["메타몽","🟣","노말 타입",
    "호기심이 많고 가능성을 탐구하는 생각쟁이!",
    "독특한 관점으로 세상을 바라보고 새로운 아이디어를 탐구하는 모습이 잘 어울려요.",
    "ENTJ","깊이 있는 분석과 추진력이 만나 서로에게 좋은 자극이 될 수 있어요."],
  ENTJ:["리자몽","🔥","불꽃 · 비행 타입",
    "목표를 향해 힘차게 나아가는 리더!",
    "큰 목표를 세우고 어려운 상황에서도 해결책을 찾으려는 모습이 닮았어요.",
    "INTP","결단력과 분석력이 만나 서로의 생각을 넓혀 줄 수 있어요."],
  ENTP:["루카리오","🥊","격투 · 강철 타입",
    "새로운 도전을 즐기는 아이디어 뱅크!",
    "색다른 방법을 찾아보고 흥미로운 토론을 즐기는 모습이 잘 어울려요.",
    "INFJ","톡톡 튀는 발상과 깊이 있는 통찰이 서로의 시야를 넓혀 줄 수 있어요."],
  INFJ:["가디안","🌙","에스퍼 · 페어리 타입",
    "다른 사람의 마음을 살피는 따뜻한 이상주의자!",
    "의미 있는 관계를 소중히 여기고 자신의 가치를 지키는 모습이 닮았어요.",
    "ENTP","깊이 있는 생각과 새로운 발상이 만나 색다른 관점을 발견할 수 있어요."],
  INFP:["이브이","🦊","노말 타입",
    "풍부한 상상력과 특별한 가능성을 가진 친구!",
    "자신의 가치관을 소중히 여기고 여러 방향으로 성장할 수 있다는 점이 잘 어울려요.",
    "ENFJ","섬세한 감성과 따뜻한 응원이 만나 서로를 이해하는 데 도움이 될 수 있어요."],
  ENFJ:["푸린","🎤","노말 · 페어리 타입",
    "주변에 즐거움을 전하는 분위기 메이커!",
    "사람들을 격려하고 모두가 함께 즐거울 수 있는 분위기를 만드는 모습이 닮았어요.",
    "INFP","따뜻하게 이끄는 힘과 진솔한 감성이 좋은 조화를 이룰 수 있어요."],
  ENFP:["피카츄","⚡","전기 타입",
    "밝은 에너지와 호기심으로 활기를 전하는 친구!",
    "새로운 경험을 좋아하고 주변 사람들과 즐거운 순간을 나누는 모습이 잘 어울려요.",
    "INTJ","자유로운 상상력과 차분한 계획이 만나 아이디어를 발전시킬 수 있어요."],
  ISTJ:["꼬부기","🐢","물 타입",
    "차근차근 자기 할 일을 해내는 노력가!",
    "책임감을 가지고 약속을 지키며 꾸준히 노력하는 모습이 닮았어요.",
    "ESFP","안정적인 계획과 즐거운 즉흥성이 일상에 균형을 더할 수 있어요."],
  ISFJ:["해피너스","🥚","노말 타입",
    "주변을 세심하게 돌보는 다정한 친구!",
    "작은 변화도 잘 알아차리고 소중한 사람을 정성껏 챙기는 모습이 잘 어울려요.",
    "ESFP","세심한 배려와 밝은 에너지가 즐거운 시간을 만드는 데 도움이 될 수 있어요."],
  ESTJ:["윈디","🐕","불꽃 타입",
    "책임감이 강하고 든든한 리더!",
    "해야 할 일을 정리하고 약속을 지키며 방향을 잡는 모습이 닮았어요.",
    "ISFP","추진력과 유연한 감성이 만나 서로의 장점을 배울 수 있어요."],
  ESFJ:["파치리스","🐿️","전기 타입",
    "친근한 매력으로 즐거운 분위기를 만드는 친구!",
    "주변 사람들과 잘 어울리고 서로 챙겨 주는 관계를 중요하게 여기는 모습이 닮았어요.",
    "ISFP","다정한 소통과 섬세한 감각이 편안한 관계를 만드는 데 도움이 될 수 있어요."],
  ISTP:["메타그로스","🤖","강철 · 에스퍼 타입",
    "침착하게 문제를 해결하는 실전형 전문가!",
    "복잡한 상황에서도 원인을 찾고 직접 해결해 보려는 모습이 잘 어울려요.",
    "ESTP","차분한 문제 해결 능력과 과감한 행동력이 좋은 팀이 될 수 있어요."],
  ISFP:["치코리타","🍃","풀 타입",
    "부드럽고 자연스러운 매력을 가진 친구!",
    "자신만의 취향을 소중히 여기고 행동으로 다정함을 표현하는 모습이 닮았어요.",
    "ESFJ","자유로운 감성과 다정한 관심이 편안한 관계를 만드는 데 도움이 될 수 있어요."],
  ESTP:["개굴닌자","🐸","물 · 악 타입",
    "민첩한 판단력으로 기회를 잡는 행동파!",
    "직접 경험하며 배우고 변화하는 상황에 빠르게 대응하는 모습이 잘 어울려요.",
    "ISTP","빠른 실행력과 침착한 문제 해결 능력이 함께 도전하는 데 도움이 될 수 있어요."],
  ESFP:["마릴","💧","물 · 페어리 타입",
    "명랑한 에너지로 즐거움을 전하는 친구!",
    "지금 이 순간을 즐기고 친구들과 재미있는 추억을 만드는 모습이 닮았어요.",
    "ISTJ","즐거움을 찾는 에너지와 든든한 안정감이 서로를 보완할 수 있어요."]
};

// 이미지가 있을 때 이곳에 사용 권한이 확인된 이미지의
// data URL을 넣으세요. 예: "data:image/png;base64,iVBOR..."
// 외부 인터넷 주소는 넣지 마세요.
// 비어 있으면 해당 포켓몬의 이모지가 표시됩니다.
const embeddedImages = {
  INTJ: "",
  INTP: "",
  ENTJ: "",
  ENTP: "",
  INFJ: "",
  INFP: "",
  ENFJ: "",
  ENFP: "",
  ISTJ: "",
  ISFJ: "",
  ESTJ: "",
  ESFJ: "",
  ISTP: "",
  ISFP: "",
  ESTP: "",
  ESFP: ""
};

const grid = document.getElementById("grid");
const result = document.getElementById("result");

Object.keys(data).forEach(type => {
  const button = document.createElement("button");
  button.className = "mbti";
  button.textContent = type;
  button.type = "button";
  button.addEventListener("click", () => showResult(type));
  grid.appendChild(button);
});

function showResult(type) {
  const p = data[type];
  document.getElementById("selected").textContent = "나의 MBTI · " + type;
  document.getElementById("pokemonName").textContent = p[0];
  document.getElementById("pokemonType").textContent = p[2];
  document.getElementById("reason").textContent = p[3] + "\n" + p[4];
  document.getElementById("matchType").textContent = p[5];
  document.getElementById("matchReason").textContent = p[6];

  const artwork = document.getElementById("artwork");
  artwork.replaceChildren();

  const imageData = embeddedImages[type];

  if (imageData && imageData.startsWith("data:image/")) {
    const img = document.createElement("img");
    img.src = imageData;
    img.alt = p[0] + " 포켓몬 이미지";

    img.onerror = () => {
      artwork.replaceChildren();
      const fallback = document.createElement("span");
      fallback.className = "emoji";
      fallback.textContent = p[1];
      artwork.appendChild(fallback);
    };

    artwork.appendChild(img);
  } else {
    const emoji = document.createElement("span");
    emoji.className = "emoji";
    emoji.textContent = p[1];
    artwork.appendChild(emoji);
  }

  result.classList.add("show");
  result.scrollIntoView({behavior:"smooth", block:"start"});
}

document.getElementById("reset").addEventListener("click", () => {
  result.classList.remove("show");
  document.getElementById("grid").scrollIntoView({
    behavior:"smooth", block:"start"
  });
});
</script>
</body>
</html>
