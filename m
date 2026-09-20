Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6746EF94
	for <linux-acpi@vger.kernel.org>; Sun, 20 Sep 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926001; cv=none; b=cxN2pSTEyYu4Oeoj0ftynwt4So58OzT2B2tpjfqFgb8StYP9iCfsWCXWRenCz/Ad1Ju5SF/NWrAiAYso6/cpQRfEl/ylQNw71Y/o1a7yHndYrArEd+Q0qmGT8IANxXo4XXWniT7r/NVGSJf/5O09rqawg446Ag8M8RrkVt6jIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926001; c=relaxed/simple;
	bh=PuPjUAhVCvIyLt+F8HbC8M3l3dqN94RplXe2tL04gsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdgZxBFelA78AR61sL+6NgSlZKUjFNP8VTO8vbBnnANEm2WU3d11v/Rhhz72iAqxc3iRueg+07YOXbeOc/XBflMDMeZIjKnxWTYfHIaDgTJ/lFCn2iZ+b+Yy5acIkFegpeWcXwVeF9hEMUjp5zoM297pcZnq4PqGVTXa+yHbW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRtJe/FP; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRtJe/FP"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c67e52ff5dso1886952e0c.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Sep 2026 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789925998; x=1790530798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BfkoR1nBKmYEzeoAan0z3MBTr6L2D2UKk4WaZHViN3Y=;
        b=bRtJe/FPg0NQwEZ7u4CbOmh+qhfF7gws0hM/L1ByxSDxFLXmnJMwYy2PLUh2D+LchN
         1KIVKY7TMVphCVqaCXc4urW+uIc0Nvcy1ucC6GOgOV1TtBdPwyheAcDLbUsdx903n9fx
         yAHqXle/FWkeqPjfo3de6jLm2qcSqLvxtVs9vU2zjvLnPU3H/7nkqe2hGCcN1/lDsm99
         y4pHPNOFBRJsXWeNKjHloR2UMvwCa1u0BX76WPJdY/S07j1LolqKtLZh1wqMS38Hr9BO
         OC+Ap2sSmc6adV7eGCvfx67Fbgqu0+9o8KQ8ZbXShg4LnoDpS7r4+EjiQZ0vXFEblvOY
         i4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925998; x=1790530798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BfkoR1nBKmYEzeoAan0z3MBTr6L2D2UKk4WaZHViN3Y=;
        b=s+eUl4WoItI6MlFvqdF/9GCFe8D06hOuziTF+pDkopbA2V9m2npnpqTAgL/YWrNb5a
         MTL8pCqAqrp26IrPt8H2AFGs7dOf3gLMjYpuIdKJL6IGgfNq5x/3LwQ75YpLM6lzrdZw
         yJaqYb2/dbpVJy85621M8haex74k/GQVC92aE8UBYe5lEEE4/dQFo3HW/7npvJ/0WWdP
         /zH38U8qdZHBphq8h1b1O7SDO4o1VzqWQrpXiUYN1s7m/6jX6hFwVOT94Tor1uLjJccN
         Yv4bVH7d8rT/oUZ5WtLNGJ8lF/xwy31hDJ5WmgaDiVr4qnSVoeG4BR1JpITyuIyAS6ot
         a3pw==
X-Forwarded-Encrypted: i=1; AKwUvBygqe9NnIz4C0EIET0j8cF/l2ZhlMiD+nO3Hntpp7qW0weOutBEd/6Mc5pSD5Sz3IkdDXohm2HY5T3i@vger.kernel.org
X-Gm-Message-State: AFuF++muHpJP3kK208H90wP+40/IuayGt0RVhWgDudpsCZ8OPx1OSCW7
	/eN7F1Fff1Gq7z3ldnraauYwX4vuhu6QnL2kEqSv16R6u+of+EsKmcK9
X-Gm-Gg: AYBFou2QL2YINOYzsBtssuLY9CLSLuSpdMoof+MeBt8yS5bl0jHlpVGKweb5EpctCyq
	UeKZX9xc1wixYojZbeIx/i2B55Z/de2U9W6SwcCPq+SCdDJxM3K6W0KHAhE649XeoBEv/8/4cr+
	eHREO5gJffusmdISM3ma52I8iaIK/pShykeXt3cNu5ozCKOYMsqR5vpMZcz5R3mX4+b0jFO+cws
	CWPBvZdRyzIYjfV8UfMz1KPOiNf9sxXh6toMAanzkbyHaa/J57OSsb/mQLpkVVbwG+WnDj1U1Lu
	vhBF4fc5TZ0+VB+Y4fGnbD6Yt+UInOQtTKjSnUauLFl998X1OvYR9189QjSQmzR0Avv9jsxkDo9
	IhKM66D4OG4rZrphkCSOcNvfruwCzt7Pr+CtiQIBxSFpeCQ09cApXzQQSt1r9e7YxDGR6RYhkO7
	c2sxQnDi5kZ1GWLyUJE8NwKwGyHYeH5zrfk/u0mJxKUAs/mRdRDFjCeFqWO9N3R+jmMdDjAeFyr
	amJqkfpsw==
X-Received: by 2002:a05:6102:441b:b0:7a7:19aa:8a87 with SMTP id ada2fe7eead31-7a719aa9106mr1590422137.34.1789925998477;
        Sun, 20 Sep 2026 10:39:58 -0700 (PDT)
Received: from cachyos-x8664.lan ([2803:9810:39e5:6c08:c254:b3de:1d81:c052])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6accecc7esm5578973137.10.2026.09.20.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:39:57 -0700 (PDT)
From: Mateo Borda <mateob226@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateo Borda <mateob226@gmail.com>
Subject: [PATCH] gpiolib: acpi: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
Date: Sun, 20 Sep 2026 14:39:04 -0300
Message-ID: <20260920173904.6221-1-mateob226@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Lenovo IdeaPad Slim 3 15ABR8 (82XM), the touchscreen
(GTCH7503:00) GPIO interrupt on pin 10 is armed as a wake source. As
soon as the system enters s2idle suspend the interrupt fires, causing
an immediate spurious resume, so suspend is unusable.

Disabling wakeup for the device via sysfs or booting with
gpiolib_acpi.ignore_wake=GTCH7503:00@10 avoids the problem, so add
a DMI quirk that ignores wakeup on that pin.

Signed-off-by: Mateo Borda <mateob226@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004..22c5fb149 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,6 +392,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
+	{
+		/*
+		 * Lenovo IdeaPad Slim 3 15ABR8: the touchscreen wake IRQ fires as soon
+		 * as the system enters suspend, causing an immediate spurious resume.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82XM"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "GTCH7503:00@10",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.55.0

