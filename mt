
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MBTI로 포켓몬 찾기 💛</title>
<style>
* { box-sizing: border-box; }
body {
  margin: 0; padding: 24px 16px;
  font-family: sans-serif;
  background: #fff8e7; color: #60482f;
  text-align: center;
}
main { max-width: 650px; margin: auto; }
h1 { font-size: 34px; }
p { line-height: 1.8; }
.panel, .result {
  background: #fffdf7; border: 2px solid #f1dfb7;
  border-radius: 24px; padding: 22px;
  box-shadow: 0 6px 0 #f1e5ce;
}
.grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
}
button {
  border: 2px solid #f0d99f; border-radius: 13px;
  padding: 13px 4px; background: #fff1c7;
  color: #60482f; font-size: 17px;
  font-weight: bold; cursor: pointer;
}
button:hover { background: #ffdf86; }
.result { display: none; margin-top: 24px; }
.emoji { font-size: 100px; margin: 12px 0; }
.name { font-size: 36px; margin: 0; }
.reason {
  background: #fff5d9; border-radius: 15px;
  padding: 15px; margin: 18px 0;
}
.match {
  background: #e6efd9; border-radius: 15px;
  padding: 15px;
}
.reset { margin-top: 20px; background: #ffd36a; }
footer { margin: 30px 0; color: #99866b; font-size: 13px; }
@media(max-width:400px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}
</style>
</head>
<body>
<main>
  <h1>✨ MBTI로 포켓몬 찾기 ✨</h1>
  <p>내 성격이랑 찰떡궁합인 포켓몬은 누구일까?</p>

  <section class="panel" id="picker">
    <h2>🌼 내 MBTI를 골라 줘!</h2>
    <p>16가지 유형 중 하나를 선택해 봐.</p>
    <div class="grid" id="grid"></div>
  </section>

  <section class="result" id="result" aria-live="polite">
    <p id="type"></p>
    <div class="emoji" id="emoji"></div>
    <h2 class="name" id="name"></h2>
    <p id="subtitle"></p>
    <h3>💌 너와 잘 어울리는 이유</h3>
    <div class="reason" id="reason"></div>
    <div class="match">
      <h3>💚 잘 맞는 MBTI</h3>
      <strong id="matchType"></strong>
      <p id="matchText"></p>
    </div>
    <button class="reset" id="reset">↩ 다시 고르기</button>
  </section>
  <footer>포켓몬과 MBTI의 만남 💛 재미로 즐겨 봐!</footer>
</main>

<script>
const data = {
 INTJ:["뮤츠","🧠","차갑고 지적인 전략가",
 "깊이 생각하고 큰 그림을 그리는 모습이 뮤츠와 닮았어.",
 "독립적으로 목표를 향해 나아가는 모습도 멋져.","ENFP","새로운 에너지와 아이디어로 네 세계를 넓혀 줄 수 있어."],
 INTP:["메타몽","🟣","호기심 가득한 탐구자",
 "무엇이든 궁금해하고 새로운 가능성을 찾는 타입이야.",
 "틀에 얽매이지 않는 독특한 사고방식이 매력이야.","ENTJ","네 아이디어를 현실로 만드는 데 도움을 줄 수 있어."],
 ENTJ:["리자몽","🔥","목표를 향해 날아가는 리더",
 "목표가 정해지면 강한 추진력으로 도전하는 모습이 닮았어.",
 "어려운 일에도 앞장서는 카리스마가 매력이야.","INTP","깊은 분석과 새로운 아이디어로 서로를 보완할 수 있어."],
 ENTP:["팬텀","👻","장난기 넘치는 아이디어 뱅크",
 "기발한 생각과 재치로 분위기를 바꾸는 모습이 닮았어.",
 "새로운 도전과 흥미로운 대화를 좋아하는 타입이야.","INFJ","깊은 통찰력과 독특한 시각이 재미있는 조합을 만들어."],
 INFJ:["루카리오","💙","마음을 읽는 수호자",
 "다른 사람의 마음을 세심하게 살피는 모습이 닮았어.",
 "소중한 사람과 신념을 지키려는 마음이 따뜻해.","ENFP","밝은 에너지와 진솔한 대화로 서로를 이해할 수 있어."],
 INFP:["이브이","🦊","가능성이 반짝이는 감성파",
 "풍부한 상상력과 섬세한 감성이 이브이와 잘 어울려.",
 "자신만의 가치와 소중한 마음을 지키는 타입이야.","ENFJ","따뜻한 응원으로 네 가능성을 발견하도록 도와줄 수 있어."],
 ENFJ:["가디안","💖","모두를 지키는 따뜻한 리더",
 "주변 사람을 응원하고 챙기는 모습이 가디안 같아.",
 "다른 사람의 장점을 발견하는 능력이 매력이야.","INFP","섬세한 감성과 따뜻한 배려가 잘 어울릴 수 있어."],
 ENFP:["피카츄","⚡","에너지 넘치는 행복 전도사",
 "밝은 에너지와 호기심으로 주변을 즐겁게 만들어.",
 "새로운 경험과 사람을 좋아하는 모습이 피카츄 같아.","INTJ","서로 다른 관점으로 새로운 아이디어를 발견할 수 있어."],
 ISTJ:["거북왕","🐢","믿음직한 책임감의 소유자",
 "약속과 원칙을 중요하게 생각하는 모습이 닮았어.",
 "맡은 일을 꼼꼼하게 해내는 든든한 타입이야.","ESFP","일상에 즐거움과 새로운 활력을 더해 줄 수 있어."],
 ISFJ:["해피너스","🥚","마음을 보듬는 친구",
 "다른 사람을 세심하게 챙기는 모습이 해피너스 같아.",
 "말보다 행동으로 배려를 보여 주는 따뜻한 사람이야.","ESFP","밝고 활기찬 에너지로 즐거운 추억을 만들 수 있어."],
 ESTJ:["괴력몬","💪","일을 척척 해내는 행동 대장",
 "목표를 세우고 효율적으로 일을 처리하는 모습이 닮았어.",
 "책임감과 실행력이 너의 큰 장점이야.","ISFP","유연한 감성과 차분한 시각이 균형을 더해 줄 수 있어."],
 ESFJ:["푸린","🎤","모두를 웃게 하는 친구",
 "사람들과 어울리며 즐거운 분위기를 만드는 모습이 닮았어.",
 "주변 사람의 기분을 살피는 다정함이 매력이야.","ISFP","서로의 감정을 존중하며 편안한 시간을 보낼 수 있어."],
 ISTP:["메타그로스","🤖","침착한 문제 해결사",
 "복잡한 상황에서도 원인을 파악하는 모습이 닮았어.",
 "실용적인 해결책을 찾는 능력이 정말 멋져.","ESTP","과감한 행동과 침착한 분석으로 함께 도전할 수 있어."],
 ISFP:["치코리타","🍃","잔잔한 힐링 메이트",
 "부드럽고 다정하며 자신만의 감각을 소중히 여겨.",
 "주변을 편안하게 만드는 자연스러운 매력이 있어.","ESFJ","다정한 관심과 배려로 서로를 돌볼 수 있어."],
 ESTP:["갸라도스","🌊","망설임 없는 모험가",
 "기회가 오면 빠르게 행동하고 대담하게 도전해.",
 "현장에서 문제를 해결하는 능력이 강점이야.","ISTP","침착한 분석과 과감한 행동이 좋은 조합이 될 수 있어."],
 ESFP:["파치리스","🐿️","사랑스러운 행복 전도사",
 "지금 이 순간을 즐기고 주변에 웃음을 전해.",
 "사람들과 함께하는 활동을 좋아하는 밝은 타입이야.","ISFJ","든든한 배려가 네 밝은 에너지에 편안함을 더해 줘."]
};

const types = [
 "ISTJ","ISFJ","INFJ","INTJ",
 "ISTP","ISFP","INFP","INTP",
 "ESTP","ESFP","ENFP","ENTP",
 "ESTJ","ESFJ","ENFJ","ENTJ"
];

const grid = document.getElementById("grid");

types.forEach(function(t) {
  const b = document.createElement("button");
  b.textContent = t;
  b.onclick = function() { show(t); };
  grid.appendChild(b);
});

function show(t) {
  const d = data[t];
  document.getElementById("type").textContent = "나의 MBTI · " + t;
  document.getElementById("emoji").textContent = d[1];
  document.getElementById("name").textContent = d[0];
  document.getElementById("subtitle").textContent = d[2];
  document.getElementById("reason").textContent =
    "✦ " + d[3] + "\n✦ " + d[4];
  document.getElementById("reason").style.whiteSpace = "pre-line";
  document.getElementById("matchType").textContent = d[5];
  document.getElementById("matchText").textContent = d[6];

  document.getElementById("picker").style.display = "none";
  document.getElementById("result").style.display = "block";
  window.scrollTo(0, 0);
}

document.getElementById("reset").onclick = function() {
  document.getElementById("result").style.display = "none";
  document.getElementById("picker").style.display = "block";
  window.scrollTo(0, 0);
};
</script>
</body>
</html>
