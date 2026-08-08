Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48F2F7F01
	for <linux-acpi@vger.kernel.org>; Sat,  8 Aug 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204566; cv=none; b=T3qQ2n466oPqM62bYHmCdxttKNrphop2eV+rZRyLRlBIsXdRgwn1a2V3qG2T+02vcVrku/kn3c1hSZqkAt6V5KGJS/G557pErGNPIKtEfws6ChXYm7N7Tj54gmPdZxwCjcwZQN+tzGqNiALGv4REQ5FUFx1L5n1pnTmgmW0Z21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204566; c=relaxed/simple;
	bh=i696J/gXK+RpkG0zn/Hf7Ox8aMAw6efUnT10D+Ea+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPZ+AMZP0O2wLP2oRPi4z0ZKgLyjMMJ/2F1l0s5jm4vZQXBi9acm36WinYH4LthYp/uB9MbOt64wBuMW4XFhxM6s39mcwsJl0/SKiZFenAxvpboRpzcggbSfQe+lhUGSd5Ey+9T6hegymscnn6bGDG5N6DT/6AcNvNo5SdDXjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHHM68p6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHHM68p6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caed617615so6333585ad.3
        for <linux-acpi@vger.kernel.org>; Sat, 08 Aug 2026 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204565; x=1786809365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1fnok8b1HIkkpNvGzYE+StwjNqCvQ2feItOzMlKbV0=;
        b=qHHM68p6IV9Y3e+ryKAy65kmSKjR0oyn2FCqgh0qJVhWHV6otw6FoBplFNZ4fu4CEk
         masPSyUyH7QZf5w2d8CZEcd0iyWx0H0O7L3ZDXQpYcoi6OBtjv3CguOzoKj7tv2vtl06
         igJ4Ksy/xIwnJy7+KtVSmKZBIspbtwjReBAhDRJFvTAJbbZ0btVzt8rI0mP7JoLjl+hg
         2uVyNOMTmzMtqkb4BuaI0srmibxpMU/khFW17YTylsa+Jyg+wrKu+DXPXBE2303RM6Rh
         smtg8ZiUmoDHx2xbVVTBIQIMZAi/+GTU0GFLzFKH0jRFGRAK0+aACXksiDS35leYR2oa
         8kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204565; x=1786809365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1fnok8b1HIkkpNvGzYE+StwjNqCvQ2feItOzMlKbV0=;
        b=f/AgFjpAfGhL6iywNcyNH+ZpRQ+xu02NB1T6sZzSgQFFVvkY11qRDEWoIk/JToDKwn
         T8IA8I7mfyXuPfbhmLsiWxgERvnmHoxz8XF9vyGxNwvCH6dsmd6Ez6/L/hnPk53Lp8m8
         ak2n0Oi8te9ykY/N/Ih2K5IMTmzArWc85XvUyHYuEj6r2npi2/wCsvqbhVn2UchIIwS7
         wN0SAmxyUPg47AgpiNSN2O6QLOc0a8yys9fj/vtLjPpxzWm2HIyBs0ho/mSDuOrdNSNp
         r9Wr5iDJv8imaJOaXUxgpFD6Q0SQXi5dKGH2uzSpQYEyX7gcUYaXUzqR+I9hXAF3rqob
         30cg==
X-Forwarded-Encrypted: i=1; AHgh+RrkybyBZ3nXh0y88xn9NxeZddATG2Le0NcBknhqkdcQH6dmhPPWio997OW0eJUTOnCPCLGNJWDTT9fm@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUrUqs8JqVYkPGJusTcbrn2NLz61Krg8TEHdh8KZ792gboWda
	viOR/rMOX+k5ThOZtXAXFEgqwDPDzlI445QLyJU4Uw4DAUvAN7QVAu8=
X-Gm-Gg: AR+sD10g3yZBEKbzdkYG4x4Bdfhw9jiYcyAR93NKnuH2XPBi04EdGNrE8HV2OXb2w52
	dPupDisGlxs8NAdzemDsTYeZDevZdCZA5b1RWI0dTqY2WHUNd50+bOeiFySxQLzNulnJjx1t5Oq
	rQoYK2yEfkJbwZFBcSXr//cYM47MNjH7/dy3jaLMgZNIUUarZjm8MAJdBr0TvWbglr9/hvtirmC
	A4UpzeoNm80nH4OMIZ37k4jbFGOYNmT78X+ioIgcbT/dhZN2OpZ3TJTJb5OENmLssAQ/icQY7zB
	l1A5gQH+04OhvwjeMUFv3+E8aPPCccbgLGVWqUwzkbde7IiM1EIjsZQqRoDbRT2fR+d2bbeSQ9J
	cQfBZnH248J82h/r+gMLbfqOe5m2YtxsboKCzymw1M+3RXWhCDpMxyj9f/m/ANBBzT6zem5Bfn1
	RWNe+KiA7IuudMZZ7T0U2CpQMfM20Ob1PO4Eb1DCp/E+LnSLyiNUV/49WKT0mrag==
X-Received: by 2002:a17:902:ccca:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2d0ca962f22mr363775835ad.21.1786204564842;
        Sat, 08 Aug 2026 08:56:04 -0700 (PDT)
Received: from DBA71591436.local ([38.76.196.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4ea157sm19404345ad.78.2026.08.08.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:56:03 -0700 (PDT)
From: Yao Qi <xnorigc@gmail.com>
To: westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linusw@kernel.org,
	brgl@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Qi <xnorigc@gmail.com>
Subject: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air FA401GM
Date: Sat,  8 Aug 2026 15:55:13 +0000
Message-ID: <20260808155513.2221976-1-xnorigc@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
(Modern Standby) when suspended with an external HDMI display connected.

This issue is caused by spurious ACPI event signaling routed through
GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.

Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
unwanted wakeups. This has been runtime-tested and verified using the
`gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.

Signed-off-by: Yao Qi <xnorigc@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004..8d7d18b62 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from s2idle when suspended with an
+		 * external HDMI display connected.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TX Air FA401GM"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "AMDI0030:00@24",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.55.0

