Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB93F1AD5
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013933; cv=none; b=L+ZRzc+vzH+lblocLysmcdlq3sZqZPHPciJ0MJ0rP4lrXlYCF2O8gGF3MMVfK1RaBk2PQki4Hz/tXkqUq7gzhtoyA/vjLSAx7hBEnN9zhrDClI0dzwBNeqXvR39l8FzClp5k6bFrssNdeNY3U3NXG7bc8t9imh07oeCpqH2UlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013933; c=relaxed/simple;
	bh=kJbP1vlIDZGNW5MhH9yj5Dhvo1y5G4Ye6VxXeN1kpPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDNu08GJBXa8DhYNe+SSrdFd81V4wrVQNEsQCpV/ESu2//FShAujaYSIR6Ksz3sgJyTlVj1L0uJWqczoRvkV7lo2Lj62v534e/BLyjAXtDfsqjVFOhWywUC9mUWngCx7aAMq72C83ekrRXbRI4dsiDxp14P9eprgomKckMKV/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YMRWD7kB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YMRWD7kB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so15980985e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784013929; x=1784618729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d3yYjM1iQh/krpKsxuFz4T1SZtWWbdIXNuzKjoaUC1k=;
        b=YMRWD7kB6JNRSrf58vgM8V7oadQKXawKNkHbdiT7o3qwS5N49MCu6/mqbcCthwlswT
         /9KXiq1/n9fyYJMNYub/ZoqSrPttNWY0opqaa8ojIILPQL5VChX8G0dzR7q3aHIoDzBt
         Ecr2tkZBU+6PbMKUzfjXufeT6AzkIH065GsPtXPmaoCJCC9krGovtDYJxjNfF9nyD34I
         rW8ALajACt74+rnJe6zORln0MidYRJcqYatBLyB0NXSzRv4DNIc86AAQEOiX7L965eZy
         LkinTEDQJhYfwzvjYHDyVO8cden1Utrj6jRsKxEUznkZaK2VjgI0ZvphntjnITyHVLq5
         X6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013929; x=1784618729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3yYjM1iQh/krpKsxuFz4T1SZtWWbdIXNuzKjoaUC1k=;
        b=GSZjYv7s9rbIL0LXrQ7CZb+6Z0/JGAmnINg8/CvjBAQhdZckxgV/Cb/l2eb/b9LO9F
         xiI744eefZRxlCY/vT/nDSHwSqaqCKrHBT3y7X+R865h/H2NuSdoCthtollU2klp+0tY
         2yvWgCoO3KmJKXMfGh9rcTuHZF74HyrJ6r6g8T0aVF9CI1ibQFDzWn01Jjb+Q3Zi9ywU
         DFWW01L4UHO4jyDPpxF46v3cmZ3JQAqili/dOhYFe1JBWyHw/YyOn2aotxQf6aEv7mse
         PdVgBLhnrtb6KPvwZuGaYbd3FRumJg53DDsvri/IPsHk1bMnP6oIZTiiNjGvL2te6fU5
         d4yA==
X-Forwarded-Encrypted: i=1; AHgh+RrwUDY4rETmRk4MBrjhpgHl2GzsX5bHRw5Y0JN7xsfMr54erJ8SGK0i8zGZKTWPk+I2lBiD32v4uXi1@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuE7buvZb1eBnrTpc+RbBxS1aTN48f+SI7B3BwOWBGlhlhTES
	jcKiklgHM+jjTbyVfHFWUYyL6qxiZ8qqqgQzCL9smintXCdAllnyFi+F9W8uUVYH378=
X-Gm-Gg: AfdE7ckOZq18CV9AGdQQYU9TV5zzNsZyIVKjuocr4tjADhgi+9AdSUugu7s38KkVlSz
	OKCPgYqki1rSxaUXws+lK7ZhXignfu/3crP1hRVOzsRr6f3R4Fcc3XTqUObh/aRLPdg+AG1KYJy
	/n/ulGnZOpdFELExOyYmZZnPVxEluDmdGCTPdV+gEAYKU47LphbbovBT7xAFrg+vSdVvxyAhnYt
	6d49XKyvzBmfvX1BfqhFgO9CM6fliI47Hm8wopJYmogY/K0pI1BE1VE6n0/aY4cjfR2STj8Fxr9
	FibrQ093MSBaF6m+rBEwJIb47R2yVsbNTHCWx6SrcHkcriCQ3zkivIFKESa+ePqNegj7ZvAyh3O
	8iP50w+NDSvOR1PYAmRhjwT77O4l2QD402ADBqBg6SAzZRUNg6qumvm0c50XLqUi0344oaqtKop
	lx6sVM9IdRauWG711jSJsliBTA3tMFs1P1HM1CNWrQ7uWAYbOhLXMfrTlIk/bftlFWQ6fMrUnNG
	br4
X-Received: by 2002:a05:600c:620c:b0:493:bc4a:fb56 with SMTP id 5b1f17b1804b1-493f883dbd7mr116701805e9.39.1784013929140;
        Tue, 14 Jul 2026 00:25:29 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950872424asm58244745e9.1.2026.07.14.00.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:25:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v1 09/20] gpio: Add missing dmi module annotations
Date: Tue, 14 Jul 2026 09:24:10 +0200
Message-ID:  <eb1fdcce0f07e274e5590b8821d9dd7835f1ce0a.1784013063.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kJbP1vlIDZGNW5MhH9yj5Dhvo1y5G4Ye6VxXeN1kpPY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqVeQyE9sV85pZ6HApzs2xBoUi/jv8SIAhyTeGK JrzbtP3BTmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalXkMgAKCRCPgPtYfRL+ TruxB/9ds/H3HeOoZwboTo7tiqDemGhQudmIdmfMK5eY6UQ6tyyRZHVzIpM0MowrkE1Rrgu1+8i jlMbbs7lpd4s+pjYFpMQU2t7/zwn+1uxlBKzuETcvoWzWZVTGCTssIShhDvUEVMLMzGqZm5i/4w WavrmZ7UvLlvZEbsDwysdzRlsPiwnNCThyMTMv1REGcpSAMBQhC779F8+y/LBEW06+rSshOjkVl t2RboGW07K34FZeWC5ab7C0qegqzAR5zrIbaCYDUe3mfXP4QEjlh1VMDZJDW6hXXeYFXVlquwYy FPfipsv57n5RdnZGeTAXhZOB9gi6ZjKEm0M/mNuJg+c+Q62H
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A driver module matching devices using an dmi device id table is
supposed to declare that in the module's metadata. Add this information
for two drivers that failed to declare these.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-pca953x.c        | 1 +
 drivers/gpio/gpiolib-acpi-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f6b870b7b352..a2d85ab1d01f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -177,6 +177,7 @@ static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(dmi, pca953x_dmi_acpi_irq_info);
 #endif
 
 static const struct acpi_device_id pca953x_acpi_ids[] = {
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975..5525c467c21d 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -394,6 +394,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 	},
 	{} /* Terminating entry */
 };
+MODULE_DEVICE_TABLE(dmi, gpiolib_acpi_quirks);
 
 static int __init acpi_gpio_setup_params(void)
 {
-- 
2.55.0.11.g153666a7d9bb

