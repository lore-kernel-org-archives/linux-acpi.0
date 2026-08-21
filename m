Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AF2C3257
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787296034; cv=none; b=Jlguy2Dl54i3n4hxDgvBGVJg0dPpEgpj5L1APWAnIm9D7x4Q3J5sa5YoBMiEgGVjFl2JavePaTgC5YWD9EO+AWO+Q7xE/InnVwuA7SPFUvNHhf43dh2ds7WTMP2u5/xfFrvy/0tVgqvkz4Hn0Te3KWvAim25/LBLNuhTulfhIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787296034; c=relaxed/simple;
	bh=KHiT9Uz3L1tUUvPiMn+ljKbKUXigLaVXOr8hzafaS7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMGBDxbqDwr64LfMl3N2wVHiYLZ1jKnhx8MsDk6VjmHYkB7jqYUePGTHmXJpmJpAmzzsAyz7G9t6iutfFuzi4hioMBp8vVv7eh4RGt2Jp4weADjlEfAlVXqoKFi2vO4U7yah/SWozhVhsvPS/yhJkimbFNrTJsz8Ev/fnLiY+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3+iFbah; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3+iFbah"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2022323c37so109997866b.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787296031; x=1787900831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/P0D6GBeuWoJ3fKJc4nQEvpIIn/RZFrAaGDwh5r7l8=;
        b=n3+iFbahR4rSqm2LoLtHV9HvbAc0jP+2Gm8W2zAu0ryEkju/THb03W3oELy8jHtYW4
         YuWVb7U2VrfaPn9wCf7p9Jw8UeppLWClazCwsFna/Jwmq72mddE0S72BbRaBXQ5DjozV
         AkfIGqrxChVv0akQYi2l7nZGzYSHOalK8h9PJYPI+UH82OCy/MaYq8fQZc4bBOUPH0AB
         tD6aRNE520p6mi50qz1w9vqrBwdSo8xLWy5QJB/oUPG7yVpqGXOcQAfYpaAp10rvoIhm
         KJdjw46h4ozala4k/gJHO5jZpclcZOaPgPezhTp7QjCrStpIiLgd3/JvLQNMo1i+25QI
         1gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787296031; x=1787900831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/P0D6GBeuWoJ3fKJc4nQEvpIIn/RZFrAaGDwh5r7l8=;
        b=PoJAqomd0y0aX+kMILVoM0AmofUOGVoyoQclhTVGTvdmhR66poLY2zqC1yRKqRdHBx
         UjtDg3+QYlSkGRkzbi0BswrPBT5LGL/kQjo6ZshA/M1HLlrHeKcIrVaz1Aa7rjGFyAF9
         vX1dMx4jdCb4YB0XO/jxlxdyCswu/3fRUYNQabPaAXWTZbgwBSya1+YnkIuChGuPoYXc
         qY4vTfmxwbvatJsSouXMvKq2iY1g/0efUlLrgStu0E/nL05i/lD+5zHstzBaP6r8VXmC
         0KAYNEuxkCBMK74At36mHUD0Mgh1WTYO8CqE+yNrHhCUh+2ZGN3P2F2VWsao4eQ7F6/s
         CODw==
X-Forwarded-Encrypted: i=1; AHgh+RqPchjBQccuX2PfP2lruC6a5J0vbVyD3u/GvvdX/EjAxMPc9cH9/3JfNtB1CFLsN59E/gTSlPxqK8e5@vger.kernel.org
X-Gm-Message-State: AFuF++kNvxL9zLLvxn+lhv1xoeej1Ur57JRivuLuDYnqY0ffIoIbylld
	xqXtoT6rZ75lAOZuaMq6CJ/c+R3dz2NvrZBC1mUAiqTeab7GD11vJ4dZ
X-Gm-Gg: AR+sD13U2v2zzrSNJMQyS8ZLKi7ed2uJ6y6FpOdrAy3Zww6R2anwnFPzwR15wxckZr9
	1TY4c/NuFxKsOqLeoJ/7IzzTfgVgKjnU5ck5QWwC9hYDZqvPX1zwMSd3YxST7A+nKwTwULWNxaQ
	rFvKGkbNj8frbhhqwLRrCUXyBeaet7IV4Xkr5Pz8sxrfzbhZlkJAky/she17pfrvVtn+N49PC2j
	eLyXCnIe6qObipkKLHPdpxw6rIZjEdPT9cFnKEv5UQVV3V7WAIQvlfSQnkrEwIsn5NEw2wnH8Lz
	Oj5RbjDdRLdmut5aK1/Zb5663yAPcqw3YJhRruX+aJZji98r7KDpMW5cB9ezuDvMj+kZTsIsUbL
	fV495xdZ9+uhIKkJxbGXc7FhiFr6tA4VQz4ELUJYddvHGiy3z1Gg0nfD3UR9tBOLy2S3KyFMCro
	MiukCYMf1EFzmHpJepi2WMCKzhY+3FtIsXKomCcLbE4dZX6CPT1Dyh7PxyIIx3k0xhQo4zU0hwc
	6zpeH3FOmG2wL+bCnV2WIZxAXXY8rSENdI6gJMohe+yzNeHLy++hy9/+1oIpTG0HHXBiMLPfl09
	aOMPgUorPw7ANHw=
X-Received: by 2002:a17:907:7ba7:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c246a6836bcmr403412566b.21.1787296030701;
        Fri, 21 Aug 2026 00:07:10 -0700 (PDT)
Received: from localhost.localdomain ([5.22.132.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df622sm332597366b.46.2026.08.21.00.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:07:10 -0700 (PDT)
From: Kivan <vaknins33@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kivan <vaknins33@gmail.com>
Subject: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
Date: Fri, 21 Aug 2026 10:06:50 +0300
Message-ID: <20260821070651.39763-1-vaknins33@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
to stay suspended in s2idle (Modern Standby), prematurely waking
after 1-3 seconds with 0% hardware sleep achieved.

In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
\_SB.PCI0.GPP3:

    GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
             "\\_SB.GPIO", ...) { 0x0018 }

When the SoC powers down PCIe root ports into low-power states during
s2idle, an electrical edge transition triggers a spurious wake interrupt
on GPIO Pin 24. This signals the AMD GPIO controller (AMDI0030:00 / IRQ 7
via pinctrl_amd), aborting sleep across the system.

Booting with kernel parameter "gpiolib_acpi.ignore_wake=AMDI0030:00@24"
completely resolves the issue: amd_gpio reports ignoring the wakeup on
pin 24, and interrupt counts in /proc/interrupts remain at 0 during sleep
cycles, allowing uninterrupted s2idle until intentionally woken by the
user.

Add a DMI quirk entry to ignore wake events on AMDI0030:00@24 for this
system.

Signed-off-by: Kivan <vaknins33@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f0..dd4db58 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from GPP3 PCIe bridge interrupt
+		 * Found in BIOS UX425UA.301
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA_UM425UA"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "AMDI0030:00@24",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.55.0

