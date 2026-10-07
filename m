Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044174848B5
	for <linux-acpi@vger.kernel.org>; Wed,  7 Oct 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375003; cv=none; b=oH+EhzYkRk5KDcaee0BeMzhW/h+jKDETDJEusfbu/Uq1VLKHtS+fbXI/IW+tboiIoIUh+bCUhvDB+c0SecMhT4YNbyLV3Q2eARIqUzre6VZvJmXrZH4Zo7t9KNakFVKyxuyCuZeIlyygMNjw+x7bQPoYuo+6z7rf0tQDIUSZnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375003; c=relaxed/simple;
	bh=O5youO8u2fWJhbGf7dva3f94Sn+gozOkXy/DzZwSTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWPBFn4WR7Xfg5SyqRDyqEUn1UwxSqZaLVTJB4K88ukBNnG8MeMo35fhFfxDEKEW23bnikyGdyGO/xOCSXMEPs7VbHU+lDG9CDtrcYKS8xCUHSd7qIEOL+D5f73sh0tMYaGhwCNeUPSPRzP76r4mv8rZq7+Q6wSyssjPgraINWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7/dPJZY; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7/dPJZY"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19bcd2faso692028a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Oct 2026 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374990; x=1791979790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nlgaOQ7l/QuiqX+4bpqCa78LDT4CEiIeuVR98Vr9YE=;
        b=i7/dPJZYAbY5taE7kTTaUgoD8R7dPcQ1TFolGKtsPl8ScnB18BrlQ+xK0iZEGrOEPW
         QBfnLnYbJJxxY17DC65NcfcUb5FdvGsDNL3NhgAGKgOoO+fpiHTdHWAcNVm4GANFmPBs
         M+mfKtozQ0HyVng7b9pifmmv6Qm/p9nW9OHI/1gtORpVqFU9s6Dl7Puqq4UFXPkAq+4A
         QycldKq5dZZdWniiyMKKJYZmkPBo6zhYEyC0TqR4Wv9abTs/kx+deZROd9rh1VnHrnQ9
         2xyAfYbU1RrL0Dd63/dHhVEi6CO4tARu4jTdWBHKoVytMPrp97rg2I7aNMeDRa4gmbLO
         r/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374990; x=1791979790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nlgaOQ7l/QuiqX+4bpqCa78LDT4CEiIeuVR98Vr9YE=;
        b=LggRmub5P153zRMGGYewUHFi3k01bTVjjMTitjq/dnD16wP027TAEUhWjWIXiBFiaP
         +DYcT1ORl3qf0iFjULi/6hwpz/Wputq20xs3gWJ2fl/2S6WaMZl3ZuMKSGHBkXFj+PQb
         qMEUTO61j4cmnuD0AQgBzclqgugNLaF9EMNSg1CNCCmn9puAey4rk9TcHlI7ivHa4kl+
         xhYLbsGJjIZqZbX+ZlPRG67yl8fyMhF3PgY1TJKUdiGI1VTo8l2LB3Y+nr4LFQHpz6Qo
         sVZzZM5sIruFKId6XOGuMvszHCE0DkBBPwjwb6jajNjcIApQQlwSpj2Z9mc58vG71uE2
         5diw==
X-Forwarded-Encrypted: i=1; AKwUvBwobs0hNJMx4ULDpiOJt15TU44KgY+/WbgnPprgIms0p0IX88na7FF8V0DfNFMzSr5Y4i/buKx6VEOU@vger.kernel.org
X-Gm-Message-State: AFq9FYJeVPNALnmB1lwjswSk+dnqIS79OEURXR9FNvyOgtCURYzHcXj8
	h3NQQwh4VNhgI0dwpIo5HawXol1LaxGQNsboxwQ1OP7tIKjtJo0tWtrzsflsmPBH
X-Gm-Gg: AYBFou07UaZc64ZEWR2PS5N4wwf1IMCBlSpZig6a9+CKq/24OOyV0JvjR21f3BmNccx
	Ty8GKCxyndaI3dfmh4KlajzHb2ASffjI520fSUhxmV/PLKQ8bdMhAHsOYrCEcw0MyZ9ISCuVaii
	gh4bm7vVW/0McVei8IcyHZdLZay0RJWwe4xzGZXB6NrrLEx7SdGq7dmNUz1y8GGEVfFPYI/T7MH
	+Oi5GcnMMxt5bcdQdg5LQP9rkwV3lQjT7PlEYQDfMJugNHL1Ci9c/E42GvTl2NZsnIogUcV8Upj
	XjUlZgAg4eo8nqDQv805LX0glhNs2VUjMKBNPfkjhS9OEaTN8csShUe9dIqJAc+v5GLIaBqSTgu
	6msPzynWu6aHe9ymM6qfa+lG9nWxR1VJMu4Aj5jReid1QdOwbVwpI2MXBD3cJ07RGmQCskjzQiz
	2oWVEUUKFgTOGRlVpuI7JjZok2YXTYI5C030yLveM+KJtodB1w6k6Q0xQHMAThwH5L7FvXH+UNe
	bOuaaqyHahJ1p6RNTFHnSMy/s2IErvBf1hmdg==
X-Received: by 2002:a05:6402:11c8:b0:6ad:723:1d6c with SMTP id 4fb4d7f45d1cf-6aff3f4c199mr2172139a12.2.1791374989721;
        Wed, 07 Oct 2026 05:09:49 -0700 (PDT)
Received: from omarchy.onca-albacore.ts.net ([87.192.248.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aff2e1e406sm975245a12.18.2026.10.07.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:09:49 -0700 (PDT)
From: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org,
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
	Trijan Koju <trijankoju11@gmail.com>
Subject: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro 16S AI
Date: Wed,  7 Oct 2026 17:09:44 +0500
Message-ID: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nitro
V 16S AI: the firmware powers the internal USB camera (0408:4059)
through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Requesting
it as an input cuts the power, so the camera never enumerates. On this
model the same rail also powers the internal microphones, so they do
not work either.

Booting with gpiolib_acpi.ignore_interrupt=AMDI0030:00@11 fixes both
the camera and the microphones. Add a DMI quirk for this family too.

Tested-by: Trijan Koju <trijankoju11@gmail.com>
Assisted-by: LLM
Signed-off-by: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
---
This goes on top of commit 6da1f3437435 ("gpiolib: acpi: Ignore GPIO 11
interrupt on Acer Nitro V 16S AI") in the gpio-intel fixes branch.

DMI of the tested machine:
  sys_vendor:     Acer
  product_name:   Nitro AN16S-61
  product_family: Acer Nitro 16S AI
  board_name:     EV3_SKF
  bios_version:   V1.53

 drivers/gpio/gpiolib-acpi-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index dbfd820..9f2ede4 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -359,6 +359,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@11",
 		},
 	},
+	{
+		/*
+		 * Same camera power enable on GPIO 11 as the Acer Nitro V 16S AI
+		 * above. It also powers the internal microphones.
+		 * Found in BIOS V1.53
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro 16S AI"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{
 		/*
 		 * Wakeup only works when keyboard backlight is turned off
-- 
2.55.0

