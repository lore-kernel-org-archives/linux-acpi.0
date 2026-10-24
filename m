Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839439;
	b=GJ7DeA0aH/4GGrW9qVADR15ZmgG1E8tg/eH7rSL3bvqYxCjNvkmVuSbdor7ctxOadRv2
	 YxaOtOqwQ1Mus4Zcnw3+RCQ6kTKduFtgqbweiu5qNn5zY0cyjL+zFaxUPALYGUdtbXB3T
	 m+1cjRfwZ5KGganCmx0irmQbEzM3wWcbq66LYx6c7WGZXkYrP7I01fcGehlBdPFs6zIjd
	 HE77j+n1RchZnEbIDSjz6NdoMcD9CPEsLbHip6GfgCG0M8M/FD5FpvLKXI/vEL4A/pHHZ
	 iUa1M9o0urz9UmRmNH9rK1FCuw/SyCDTE2SoaZ64D7oliVmN4rKG7/Vn0SzU5DfBnXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RqkEm5pNimkHco66marb1ivKFJSwESRUnmku7Km2PgE=;
	b=jVfI1qQvs2PUVLt4ZZA2Acoan/Z84lI4glmBHPnelBqGQ5Kn5AHocD/u3bcK+jDkJIDo
	 wWDkSWHLX2ecyXXRwHUJAJAwKXCxlDJmlT8ixDlImcabAPDUu1qCA7qxuTuySJcBo5vyP
	 hUMbmuZw0sQzypbus7/+avkNE6A0igT42KjPmRxkWM8iAGHwll7VkYt5V87b6iQ5DdTnq
	 kneRIresnVj7ZizerKXVkGxOuY+QYzj9hK8WxM2KfnOOUIIZ8go67mTEC5fZBpEcpIBf1
	 MBwe0rmeFIngPi4EdCyJDxiRSFlaW8qO/m58r8gEUrpDKqccJzFNlB4xrUOIVFKlDbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MW2QbgrM;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23C606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 10:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E23C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MW2QbgrM
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd633ef819bso670319a12.2
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792839438; x=1793444238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqkEm5pNimkHco66marb1ivKFJSwESRUnmku7Km2PgE=;
        b=MW2QbgrMIWCcIkMPes4jDU0mhKwlVhkshfsar94ZYlwL5T0eY/7sjZiW4XFOUafrSR
         6bbjlHvpDnHubzNpwvXoKgke0f7WiZTLQcDbNvosoemrmp0/hra545TgLDg/iRQsEb3g
         APE6RoaJbWKHdiQGNQwcfuOf62Rhuu9RG9zcggArCmAvc57frHsXdBW+BI0iNCLLFX9Q
         IvNmANlpQUGNnohgpOEjH5LGE4x/vlw7i4rhQPjkX+StZWiT20iFZwz3MbUIJlqw+3JJ
         25weJy8oi8M+p0KsuL1ZQu/gQRjw3bo0mFmr6ZrxwMqeonfnR8R/AdVyqAoKMPN/T+VA
         agfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792839438; x=1793444238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqkEm5pNimkHco66marb1ivKFJSwESRUnmku7Km2PgE=;
        b=jScom5hZQbwWZ9Qu0at/xjrlvyp6eGppiaBuepAWwJo84dyAnFYgPKiHPq5gUoLqBW
         JFgnm09J1GVj2xWsYv8U1qOWvN59v6Ab0e0/RNKq3oIaUrtrpsiob61YohGS8bqSfgq4
         v5DbrKy+z3wusEqOv9sG0k7APM3j2yLp5/l8qqrKic71S5MBFd6m2fGUHS8ME5RifsaC
         gj/xaqR5f0faOads1FL5jTr8Yhc/lwGQBdlVgvydCvwNbhu0BKjlY/HuxyumoGXgDXsL
         DiaBd6RXr6GGEcRtA/MdoZWE0UFx7aFPuBXufoHCq85YlbIfTGARfCP9Skv0q50BFMf9
         E/hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXRqF31WuH9WxHDEfB9X5J0YbbL+pHnhZLztX8mcbYHLwQQr0MtlcOCSMXJtk2eoeyOJtfVX6cqVth@vger.kernel.org
X-Gm-Message-State: AFq9FYLdSVxjPPl91g9dUPPnhfPmmLr1ILvuSF9VHLtXTtF7XlyC89pw
	GLW5RZS//kY/KpO/uZ11H2JCBYp7oA8kGCYuETmD9s7iY/z7PR0I7QDqKiJPLPIv
X-Gm-Gg: AYBFou1bxyEtYYHU5oCERRuolQeLSX2mezsvwjiS+POSaluPH0jPHxz211dYeXE6Pi3
	4qPeUvpMafTW0X6KvZ3C70Jwoc0G4G6dlhT1oGMeIXYAItCQaj91rwmC7BDfH/ExmltHHtJnmbV
	9XZVn743ymZ4h1C2RTRgph4+r5cJpAToUnmT3DGsgSYh714zZE2+jB+TthTsui4nlfUlfMXBe/A
	+dPvv48D+ZRHJlyl6hg4Gzyn7yISiLrsUVMFG8KDwSmPJTKcB3ElavEvlfG8mYzKk8vxxTwkubm
	IZ9J25noMGRgGaWNbHc16AAu9sOz4h2ZgQeG5bPqLsFLbXFtSYKQWqSb+frVelyx67GxGoUYmap
	AhgWVZVYTOtwozNN1/RNJsnZnu33jh0DCkMgURZOq3NJm9pPxO6UPthWtwkMMJdYRUd9s1UaWVR
	bp9yaCJ2Owh+76sOZSViUsd+FJ3mDbMWwWIX8krEHPciHRk0duE6djqD0PxNH5ZgsMMlQth/Q3r
	JaKnTamrF+0fca0EBI7BQFaK7+5oH7uDCCMaL56SbEyFykQuDxJWunVOMAzCfGQcHSbkwGwCfa5
	o4DXgwdTTN7QVIknkhPNDqTrAsowIZtsmHWHfHoLGbUFOR0kFqdc8acfQRItftBi/8h374hoOd+
	R/p7Ia0G1Zb4gmUEw+t7leNVBiKfzUPrUwQD5sGLlhUWFR7jaZ5vfNfYKolUGiygTUnH96u7jEk
	pkffZIAlhzVFzv0Bn3MKsAiIQqD/bCmB6YL4t9pO7a3BsAXvrJU7u4gunDUtMV06t5xK5b1SD+f
	ACJMw==
X-Received: by 2002:a17:90b:2547:b0:3ad:25f6:1dd0 with SMTP id 98e67ed59e1d1-3adea9daa54mr1556925a91.11.1792839437806;
        Sat, 24 Oct 2026 03:57:17 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm2565666a91.4.2026.10.24.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:57:17 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Frederic MARIE-JOSEPH <fredericmariejoseph@protonmail.com>,
	Wolfgang Walter <linux@stwm.de>,
	Bob Anderson <kernel@ametros.net>,
	Domenico Suppa <domenicosuppa@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH 6.18.y 0/3] ACPI: scan: fix the fixed event power button since 6.18.57
Date: Sat, 24 Oct 2026 18:57:07 +0800
Message-ID: <20261024105710.593-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102308-twisting-bazooka-12b5@gregkh>
References: <2026102308-twisting-bazooka-12b5@gregkh>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 6.18.57, the ACPI power button is not bound to any driver when it
is a fixed event device (LNXPWRBN), so ACPI power-off requests are
ignored. This was reported for QEMU guests by Wolfgang Walter [1] and
Frederic MARIE-JOSEPH [2], and for Dell servers (power button and iDRAC
graceful shutdown) by Bob Anderson [1]. The ASRock H310CM-HDV report on
linux-acpi [3] (ff_pwr_btn "STS invalid") may be the same problem.

6.18.57 got 52d864019636 ("ACPI: button: Convert the driver to a
platform one") as a dependency of fe80251152fe ("ACPI: button: Fix ACPI
GPE handler leak during removal"), but not ab06eb920401 ("ACPI: scan:
Register platform devices for fixed event buttons"), so fixed event
buttons have no platform device to bind to. Bob found that
ab06eb920401 fixes it, Wolfgang confirmed that, and Sasha queued it for
6.18 [1]. 6.18.59-rc1 also converts the tiny power button driver to a
platform one, so with CONFIG_ACPI_TINY_POWER_BUTTON=y the fixed event
power button stops working in 6.18.59-rc1 as well (it still works in
6.18.58).

ab06eb920401 was then dropped from the 6.18 queue together with its two
upstream follow-up fixes (stable-queue c4d7fb7346 "drop acpi patches"),
with a FAILED report for f234fdaae1ca. With the three patches as they
were queued, drivers/acpi/acpi_platform.c does not build on 6.18.y:

  drivers/acpi/acpi_platform.c:92:21: error: implicit declaration of function '__resource_contains_unbound' [-Wimplicit-function-declaration]

__resource_contains_unbound() comes from edfaa81d5da5 ("resource: Add
__resource_contains_unbound() for internal contains checks"), which is
not in 6.18.y, so patch 3 uses resource_contains() instead; the note in
that patch explains why this is equivalent here. Patches 1 and 2 are
clean cherry-picks. aef7792cddca, which also has
"Fixes: ab06eb920401", only rewords a debug message and is not
included.

The series applies to both v6.18.58 and the current 6.18 queue
(6.18.59-rc1).

Testing: x86_64, QEMU q35 with KVM, an initramfs whose init waits for
the power button and then powers off, and QMP system_powerdown sent
after boot:

                                        without series   with series
  6.18.58,     CONFIG_ACPI_BUTTON=y     ignored          KEY_POWER, off in 0.5s
  6.18.59-rc1, CONFIG_ACPI_BUTTON=y     ignored          KEY_POWER, off in 0.5s
  6.18.59-rc1, ACPI_TINY_POWER_BUTTON   ignored          signal 38 to init, off in 0.5s
  6.18.58,     ACPI_TINY_POWER_BUTTON   works (still an ACPI driver there)

"ignored" means there is no "Power Button" input device, LNXPWRBN:00
has no physical node, and nothing happens until init gives up after 40
seconds. With the series, LNXPWRBN:00 gets a platform device bound to
acpi-button (or acpi-tiny-power-button), and the only new kernel
messages during boot are "input: Power Button as
/devices/platform/LNXPWRBN:00/input/input0" and "ACPI: button: Power
Button [PWRF]". A KASAN + PROVE_LOCKING + DEBUG_ATOMIC_SLEEP +
DEBUG_LIST build of 6.18.59-rc1 with the series boots and powers off
without splats, and there are no new W=1 or sparse warnings in
drivers/acpi/acpi_platform.c and drivers/acpi/scan.c.

Not tested: real hardware, and machines whose _CRS has overlapping
resources (the case patches 2 and 3 are about).

Tool use: most of this work was done with an LLM coding assistant
(Claude Code with Claude Opus 5.5). It found the regression reports and
the dropped queue patches while going through recent stable FAILED
mails, rebuilt 6.18.59-rc1 from stable-queue (its tree matches
linux-stable-rc), made the resource_contains() change in patch 3 and
wrote the notes in patches 1 and 3, wrote the test initramfs and
scripts, ran the builds and QEMU tests listed above, and drafted this
cover letter. Patches 1 and 2 are unmodified upstream code. I reviewed
the series and the test results before sending.

[1] https://lore.kernel.org/all/5fe757e7aa54c38df3525d313598db99@stwm.de/
[2] https://lore.kernel.org/all/20261022162655.231431-1-fredericmariejoseph@protonmail.com/
[3] https://lore.kernel.org/all/CADP5X9+xCTkxXZO1dcTodrwsfW=piV41c5f_zaOq6KsrxD0Hhw@mail.gmail.com/

Rafael J. Wysocki (3):
  ACPI: scan: Register platform devices for fixed event buttons
  ACPI: scan: Avoid registering platform devices with resource overlaps
  ACPI: scan: Do not combine resources that overlap completely

 drivers/acpi/acpi_platform.c | 79 ++++++++++++++++++++++++++++--------
 drivers/acpi/scan.c          |  4 ++
 2 files changed, 66 insertions(+), 17 deletions(-)


base-commit: 2926d88bb7fc4608fd942453d929c39e4e5ec006
-- 
2.53.0

