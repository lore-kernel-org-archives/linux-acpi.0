Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DA423EAE;
	Sun, 18 Oct 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319438; cv=none; b=fpXbcZOqWHcIxgAUmAFWoNLC3CzPLBgcL3JIiFvtGWGVBDLd+CDir478yTrsvPAHotUvFBIvxSQRxKMz65Bgqt3qCwz6PQ8Ao2YzrJZyIwmp6AK7Ve8gEi8kly5nCygiydKezzj+4AeHeniOsVnwg7EzWr3iBsK8lwah2Fr1RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319438; c=relaxed/simple;
	bh=k4azeMsEcMX0vLsEsHdzYI72cNnhmcEMc7RHJ2aFhgc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmL5sekv5Sz+BgzDq0odUV1pimrnvbtE77/Du6bAb26pGgdUeBdIGeuxiZuJ3Rvt2GkQfNsFb09AnmMEF5tw5ptAvTdfTKbkay1mmzxbVZNxjYy2EGqO4q3YcWqQQq6QxY4+zOfhb3jT0pYUE3T05U7FsFM/71AW8//gOdkxV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cNn9qJ92; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cNn9qJ92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792319423;
	bh=9+tac1kUOadM9vAE85y4Jh6nzU4fgGmOPJOK+0dBviY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNn9qJ92Nq2HE/nN6etJjaUcyLKHk3mEOc5w4ijfidAPT+3HI/1jJ9MVMQd369A5w
	 /e2OsV5s4tYoA2c4OT7lgTJTRY73yTfl/+HrcJ3HLzWtiCF6RoyoREzGHxojlXAW4x
	 5z6bZOwXtME+oIZvktd1wmIcIxIXmHQdgriyl13o=
Received: from [192.168.31.199] ([223.66.52.202])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 793B226D; Sun, 18 Oct 2026 18:30:19 +0800
X-QQ-mid: xmsmtpt1792319419teepjg0l7
Message-ID: <tencent_36C6A22A8A475F824CB6BAC101A1F272E709@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA1kEBfkQj/9X703qu36CbeDbU19qVn5j4A/t5ydUmoAJNE6IujT
	 BSCshy9Y2DlAlQBi+YC+DycYszRvcvDKA3/D8QXkHuac9DNvu4PDIXswVoaigTmXF5A9+xpiI07I
	 jmkLSikJ9LqDCLwRJAbTVnx5eXDN8QwGUrjHFYmf8wTM6jK4hw8n0rApeeYiJHxVP8pWSPspVujn
	 X3RFaQkLWcJRQnk4njuo4yMJi7z+ywz8peIvYq8ERkd2+xaJQzu2ASI1zTnh71lkBGV1rfxK9Emp
	 OO69wfTMeWidSoh7vvAJg6msYIIaPyiJqOQ+LvcLRP+gclYjdDoyvfmHGOg5fPAZZMbAd/GvpO1+
	 hwQUrcrsY4SxsZa3gheS6pHHJEKjwQMjK3kj4EiwvcSpjGWjddBynrO2+rdZbHQNRvIWybw68Hvz
	 S+kvqPjy9n/yWMPMoaKG1CQSoc940dfF4fqgibY98Ee+q6uvMLn/mFauGp2IR8CRQfMfEQTOJgvF
	 bMS1xJPJzqDUpcvfsHk6Zf9QaWHsJT93YgTFE1RlOhzv9SvM9r2VuXjjvl3VbX0IDvygw8BPlsxI
	 bpiqXBPm7viCUNqbomkQvBkTWeGtMObKG/EFguYs2MWElhMbdt6eDxKlWtZchoCwJLYPicbXPWBd
	 TrsByDDDTEKS8QDCe0GgfySKAUgzKFjB377r8MeILz6gyAvFOc7+bbPxC0VgYFJ+4V8tFbpfqWQ+
	 xRvZB950LSnzwcP1RmTf1w9s0+9v/KI0zzOvWZnVqxjil4zBmNmjrhq7lKqfdQdqDVreygngZ50Y
	 qCr/uz/dogjlVnN1qaVAzJZw2Pr9tpLD+/h3BDy4SEn7s5USbOkPFLsKn3sy4lCUd/ZIJ28BmT01
	 kSp3Tc8yNjMrUC1RwLbJcOcBy87Oqi8U+TO/WFHpSHP3UGllwv3l+CoWgnY2pjLOvDMa8ei5q3Z5
	 AzGnzvCr3CkVsH8JCcz3XCO/mwg4NvvHXDMR41F5IXU/5OL6o7AWvH59awsEkDlt5Li0TXSmaYR5
	 4OeZH+bWoLV0IetiU7fl5N7L3jLJhOI5mqp2lsl8B/gq68ZhxY9brpTenQMbYHOrDJRLM8h4hO5C
	 frcQo1
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [RFC PATCH v3] platform/x86: panasonic-laptop: Add
 platform_profile support
Date: Sun, 18 Oct 2026 18:30:19 +0800
X-OQ-MSGID: <179231941920.15820.4873387845060184905@foxmail.com>
In-Reply-To: <2df90a2a-770b-4439-9d01-bd8105084719@gmail.com>
References: <20261007190446.38862-1-alexyeo362@gmail.com>
 <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
 <2df90a2a-770b-4439-9d01-bd8105084719@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1757479989642091602=="

--===============1757479989642091602==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Following up with the tests you asked for, on the same CF-SV1-2 (i5-1145G7,
BIOS V2.00L23 -> V2.00L24), AC, no userspace governor, EPP=3Dperformance unle=
ss
noted.

1. Corrected AC matrix

The 12 AC runs in my last mail were taken with EPP=3Dpower and a thermal tool
re-applying it, so their power columns were an artifact of that state.  Re-run
with EPP=3Dperformance, turbo on and the tool stopped (3 rounds x 4 states, 6=
0 s
sysbench cpu --threads=3D8, 1 Hz RAPL):

 state (EC)        profile       sysbench e/s   pkg W (median)   pkg max C
 active-locked     cool          8311           9.96             50
 quiet-locked      quiet         8272           9.95             60
 active-unlimited  performance   13070          26.32            84
 quiet-unlimited   custom        13153          25.63            88

MSR 0x610 stays 28 W / 60 W in every run, so the EC enforces its own limit.
Under EPP=3Dperformance the TDP toggle is a real power lever (~10 W vs ~26 W)=
 and
the fan toggle is a temperature lever at essentially equal power.  The
quiet-unlimited run reached 88 C, but it also posted the highest sysbench sco=
re
of the four, so it was not throttled below the others.

2. thermald

Boot capture with thermald disabled: PRE (no thermald) CEFM=3D0 EPLE=3D1
(active + locked =3D cool) -> POST (thermald started) EPLE=3D0 (unlocked).  A=
fter
that a cool write stayed put for 60 s, so it is the one-shot _OSC unlock you
described, not continuous governance.

3. Windows comparison

I re-imaged the unit to Windows 11 (build 26300, BIOS V2.00L24).  A full ACPI
dump from the Windows side shows all 15 firmware tables (DSDT, FACP, FACS and
the 12 SSDTs) byte-identical to the Linux dump, including the DptfTabl SSDT
(sha256 f0d92acf...), so the BIOS update changed nothing.  (GetSystemFirmware=
Table
alone cannot dump the 12 SSDTs; they come from HKLM\HARDWARE\ACPI.)

8-thread load (a custom xorshift64 integer loop, WinLoad.exe - not sysbench, =
so
the absolute wattage is a qualitative comparison), 60 s, 1 Hz
LibreHardwareMonitor plus a wall meter:

 state       EPP  fan    pkg W (median)   pkg max C   wall W
 perf-cool   0    cool   22.96            74          34.5-35.5
 perf-quiet  0    quiet  23.06            79          29.6-30.2
 eff-cool    100  cool   5.95             44          12.6-13.0
 eff-quiet   100  quiet  6.04             44          12.5-12.8

On Windows the power lever is the OS EPP, not the visible EC SEPL/PL register=
s:
EPP=3D0 gives ~23 W package / ~35 W wall and EPP=3D100 gives ~6 W / ~13 W.  M=
SR
0x610 stays 28/60 W and the EC 0xCA/0xCB registers never move.  The Panasonic
fan mode is a temperature lever (quiet runs ~5 C hotter at the same power), t=
he
same role SEFM plays on Linux.

Note that the Panasonic utility on this model exposes only fan control
(cool/quiet) - it has no performance mode - so the Windows performance lever =
is
the OS power mode (EPP).  The passive+unlocked combination stays unmapped and=
 is
reported as custom, so it is not reachable through the platform_profile ABI.

Peak/spike: with the battery removed (pure AC) the wall peak/hold is 34.7 W,
equal to the steady value, and a 100 ms package trace peaks at 29.7 W.  So th=
is
unit does not show the SR4's ~60 W Windows spike.  On this unit Windows susta=
ins
~23 W and peaks at ~30 W, while Linux unlocked plateaus at ~26 W - the same
ballpark, so Linux already gets essentially all of the headroom this platform
offers and there is no Windows-only power spike to chase.  (Absolute wattage =
is
model-specific; the meaningful comparison is Windows vs Linux on the same uni=
t.)

The Linux four-state matrix cannot be reproduced from Windows user mode: the
effective EC path is EC88 -> ASRV -> SMI on port 0xB2, which user mode cannot
drive.

4. Quirk status

Noted on holding the quirk until the power side is clear.  I saw Ilpo's review
suggesting reusing quirk_cf_sr4 for models with the same boolean mapping; SV1
does have the same CEFM/EPLE mapping, so a simple DMI alias would describe the
driver's behaviour.  One point I would like your call on: our SV1 table is
cool/quiet/performance, exactly like quirk_cf_sr4, but the RFC reserves COOL =
for
the SR4 ("aggressive fan + locked TDP").  If you would rather non-SR4 models =
not
expose COOL, the SV1 mapping should be limited to balanced/quiet/performance.
Either way I am happy to wait for v4, apply the exact version there and test =
it
before sending a formal Tested-by.

If there is anything else you would like measured on this unit, just let me
know - happy to run it.

Raw data: the 1 Hz CSVs, the full Windows ACPI dump and the harness scripts a=
re
at https://github.com/numuly/cf-sv1-2-platform-profile-evidence.  I am
attaching the summary CSVs (corrected AC matrix and the Windows run) for
convenience.

Wu Zhipeng <zepwu@foxmail.com>

--===============1757479989642091602==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="summary-ac-4state.csv"
MIME-Version: 1.0

c3RhdGUscHJvZmlsZSxlY19mYW4sZWNfdGRwLHN5c2JlbmNoX2VfcGVyX3MscGtnX3dfbWVkaWFu
LHBrZ19tYXhfYwphY3RpdmUtbG9ja2VkLGNvb2wsYWN0aXZlLGxvY2tlZCw4MzExLDkuOTYsNTAK
cXVpZXQtbG9ja2VkLHF1aWV0LHBhc3NpdmUsbG9ja2VkLDgyNzIsOS45NSw2MAphY3RpdmUtdW5s
aW1pdGVkLHBlcmZvcm1hbmNlLGFjdGl2ZSx1bmxvY2tlZCwxMzA3MCwyNi4zMiw4NApxdWlldC11
bmxpbWl0ZWQsY3VzdG9tLHBhc3NpdmUsdW5sb2NrZWQsMTMxNTMsMjUuNjMsODgK

--===============1757479989642091602==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="summary-windows.csv"
MIME-Version: 1.0

c3RhdGUsZXBwLGZhbixwa2dfd19tZWRpYW4scGtnX3dfbWF4LHRlbXBfY19tYXgsd2FsbF93CnBl
cmYtY29vbCwwLGNvb2wsMjIuOTYsMjMuNzAsNzQsMzQuNS0zNS41CnBlcmYtcXVpZXQsMCxxdWll
dCwyMy4wNiwyNy42MCw3OSwyOS42LTMwLjIKZWZmLWNvb2wsMTAwLGNvb2wsNS45NSw2LjEzLDQ0
LDEyLjYtMTMuMAplZmYtcXVpZXQsMTAwLHF1aWV0LDYuMDQsOC45Miw0NCwxMi41LTEyLjgKaWRs
ZSwwLGNvb2wsLCwsIjguMC05LjAiCnBlcmYtY29vbC1wZWFrLDAsY29vbCwyOS43MCwyOS43MCw4
MiwzNC43Cg==

--===============1757479989642091602==--

