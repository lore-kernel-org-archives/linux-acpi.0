Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE044CAC1
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169418; cv=none; b=kWFv0XWfJbe19GCy0R4d9cHg1T2UGh9/IVJGbvLdTEDT3dycNTu/s4PAeU1jLQDJ87khnRBTNz7qkFvF0CmnFiSXgjwjlrv7oQDBGYaJBwgqr/q8FIY+3H+qf+bGjO7wEEj2R/XR0rhsowSIfaNC8xDk+wi5LX9TXe1pgn6YSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169418; c=relaxed/simple;
	bh=JKfWbQcS2aZrKBUHgGYO7zHFZG+4D4u0/hz9c0raEB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkgkQtDhREXc2mOugh2bCOJJU+wFzWVNYCVyR1v2SZi7TvUGSOwCV/0Rj6Dart8N5WACSRNf+tCNE+1N6QmlFrS2UHxJWOr7a1ySPTU+q9tJH7zQvArBJf1sjMyHkd4zg3MQcui+WV5MQ4uBBihZ+Yn/zBI0Yy+uuTeNFAgdYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8ogF8uT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8ogF8uT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0046078so9028655e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169415; x=1778774215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jMOR/c+xknZ+G4AyIB7a/iCclsR4nTxLy+1MdkOuPg=;
        b=d8ogF8uTPZSK7+3NtrdblT0OfkMbmuO0NTIsOBDszpUSOlCaEEXGZil0xYYRfDGcfg
         XCW7VmJZIpTybI/8Mix6KM7RFST6TDll1C0FRi6Bzzaud6+TnT/F0kQBG3hnzkmU9431
         qljqz1nQ6njuIiksUvqEopXdJFq4xQsdboN3ylq9vIeZhQVSF8OlyXJXhm2EXnj2TCd6
         mCGBTNApiJiQGPf3gjlt0zn50FzeJC2elPKkiz5cTyqqdKfnXX6GOENhg0iBP/9Kgdwu
         RyOtzoNbAQzr8a1YwlIpCge/IO2C1nJ8DFiFzS7r2YJPR4fmzdDLCTSUkvIIZ3jbxeMk
         gD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169415; x=1778774215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jMOR/c+xknZ+G4AyIB7a/iCclsR4nTxLy+1MdkOuPg=;
        b=R/bj3li6Zq1pOKm9vj/hNZXwcab4UnzcD5UlAuGMhPoB5K6gAYOJ46hLhaOowCK/Zx
         dGnkvF99r88yyBr3k89h2Te2MWZvxKxk2EvHpIoJVEjeJOPcrlABhAK+vdaIUljqr00r
         VHpYTKg7JTvgbLTqdLgmWJ/p3+bLEfs8eS2NECZqhaeeHLjQuk8tR3UcT5O6ang/3HX+
         Jt9pfqse66h9raPmvU4KlYKZg9QUzLJ34zONbBv36dSRnpGg+cJ+OFJS1lm08gqbzizr
         ks0l22b2lkLmLBUE0rLsEylJM5kWN2VqMkkU3lZA+Cwvn0VsWYOJ223/I1MPAVT1zUrI
         tyYA==
X-Forwarded-Encrypted: i=1; AFNElJ+4nH4obwG6Y/pdj/oDsIjuiWjOAMzJT1UbdexiZBN251a7lbPDsPhVLWLXuGASkYK4f+l6ZByRJL9m@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ3an6n+UxnRMJDGbEDVK2k4ENzhCAD541DxJ88ULbU38JJdQ
	nt4rvmwsyAYMm/gBxi4wSHL1RRVIlkrAoiD2wEgOjBjZ/E4zCp7vG6l/
X-Gm-Gg: AeBDieuPFsapUMQI3/7kKKolseKNfV1YE1ReuypbkE49OA1irO6PM4d+UDWc7RKjoGh
	G7P4DIyugzZHgUUGzYZAvdIdNe9hQG+gNu7vCJMRy7jkEclCkUaHhuOvoM3//aDMcMoh0g118mp
	Ujuhbj9nDDcElRTkY9xlGji1WKVLjt+iR93rpC1g4PEXekrH2tOeBQASZ0uIPXPLrLaSCYvX+qg
	qgZir3w9TESKmasi4ALmjkYMrygbTeNNaZvi1Bl3eojbtZPLAVKQNEaFvzWgc7tPRUAW1TL08+H
	rJql1w6xjXpw2/1EjfyyCaRDOhR8qZv9EDxGUmxe9ipveBCZ/9J++1voMF9fK+ZwQt5gSDVk2eG
	174nSPMomLxm38UgYqW5ePuQMMv+bAZEQOp3SwXYDROI9vWLJeH4Aw9A3hcVU+kAIxhScoxDkvb
	Dz8TovavMrvI6RbNcl9t8+rC8PmQ==
X-Received: by 2002:a05:600c:8b08:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48e51f32757mr152563955e9.16.1778169415087;
        Thu, 07 May 2026 08:56:55 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:54 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 2/6] gpiolib: Move DEFINE_FREE(free_gpio_desc) to driver header
Date: Thu,  7 May 2026 17:56:43 +0200
Message-ID: <20260507155647.403964-3-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 17511434ed07..7ee65b49056d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -807,6 +807,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
+DEFINE_FREE(free_gpio_desc, struct gpio_desc *, if (!IS_ERR_OR_NULL(_T)) gpiochip_free_own_desc(_T))
+
 struct gpio_desc *
 gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
-- 
2.54.0

