const healthText = document.getElementById('health-text');
const healthSub = document.getElementById('health-sub');
const statusDot = document.querySelector('.status-dot');
const result = document.getElementById('api-result');
const modeChip = document.getElementById('mode-chip');
const connectBtn = document.getElementById('connect-btn');
const pulseBtn = document.getElementById('pulse-btn');
const apiBaseInput = document.getElementById('api-base');

function normalizeBase(value) {
  const trimmed = value.trim();
  if (!trimmed) return window.location.origin;
  return trimmed.replace(/\/$/, '');
}

function activeBase() {
  return normalizeBase(apiBaseInput.value || sessionStorage.getItem('lz_api_base') || '');
}

async function checkHealth() {
  const base = activeBase();
  try {
    const response = await fetch(`${base}/healthz`);
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const data = await response.json();
    healthText.textContent = 'API online';
    healthSub.textContent = `${data.service} | v${data.version}`;
    statusDot.classList.add('online');
  } catch (error) {
    healthText.textContent = 'API unavailable';
    healthSub.textContent = base;
    statusDot.classList.remove('online');
  }
}

async function connectTenant(apiKey, orgId) {
  const base = activeBase();
  result.textContent = 'Connecting...';
  try {
    const headers = {'X-API-Key': apiKey};
    if (orgId) headers['X-LZ-Organization'] = orgId;
    const response = await fetch(`${base}/v1/netting/USD`, {headers});
    const body = await response.json();
    if (!response.ok) throw new Error(body.detail || `HTTP ${response.status}`);
    modeChip.textContent = 'TENANT CONNECTED';
    modeChip.style.borderColor = 'rgba(101,241,223,.45)';
    result.textContent = JSON.stringify({
      status: 'connected',
      api_base: base,
      organization: orgId || 'bound-to-key',
      usd_net_positions: body
    }, null, 2);
    sessionStorage.setItem('lz_api_base', base);
    sessionStorage.setItem('lz_key', apiKey);
    sessionStorage.setItem('lz_org', orgId || '');
    checkHealth();
  } catch (error) {
    modeChip.textContent = 'SIMULATION';
    result.textContent = `Connection failed: ${error.message}`;
  }
}

document.getElementById('connect-form').addEventListener('submit', event => {
  event.preventDefault();
  connectTenant(
    document.getElementById('api-key').value.trim(),
    document.getElementById('org-id').value.trim()
  );
});

connectBtn.addEventListener('click', () => document.getElementById('api-key').focus());

pulseBtn.addEventListener('click', () => {
  document.querySelectorAll('.float-card').forEach((element, index) => {
    element.animate([
      {transform: 'translateY(0) scale(1)'},
      {transform: `translateY(-${10 + index * 3}px) scale(1.035)`},
      {transform: 'translateY(0) scale(1)'}
    ], {
      duration: 650 + index * 90,
      easing: 'cubic-bezier(.2,.8,.2,1)'
    });
  });
  const value = (35.8 + Math.random() * 2.4).toFixed(1);
  document.getElementById('core-available').textContent = `$${value}M`;
});

document.querySelectorAll('.nav-item').forEach(element => element.addEventListener('click', () => {
  document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
  element.classList.add('active');
}));

const savedBase = sessionStorage.getItem('lz_api_base');
const savedKey = sessionStorage.getItem('lz_key');
const savedOrg = sessionStorage.getItem('lz_org');
if (savedBase && savedBase !== window.location.origin) apiBaseInput.value = savedBase;
if (savedKey) document.getElementById('api-key').value = savedKey;
if (savedOrg) document.getElementById('org-id').value = savedOrg;

apiBaseInput.addEventListener('change', checkHealth);
checkHealth();
setInterval(checkHealth, 30000);
