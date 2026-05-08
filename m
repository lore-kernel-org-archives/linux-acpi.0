Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC033FE02
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221085; cv=none; b=ueZCNBIBf/WjnKKk04Ckygc28v+YWY5ewIyMKPuadgpUwWm3DpUZbsI+c130SeVNZGOq7O4vU+AuXCZh25J6YF37hIjp5KO1MoaeVVaSysbOVLMEjl2QRPuf1cHqAHCHbDBfEvWGxl5Ea2/u2Rwj/eFT9CPyCGkFf1EUrqjCc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221085; c=relaxed/simple;
	bh=htgG8agL3qgdrhV6usqBHzQ8yuuUnR59c7IpqR6aYYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ0SLM7DsnTn6HuBbFUU+x0ORyEfk5i7P41yjjmTH5AFGhaMbTgjZcR18dxVC/vCp4N5x2Rho1MVO5rQK92dLjULWAcOvWVp+G422vfi2Z9+6rVnUv1qXjeUPBTo2wNbL3qWhkq5MQY+Uuku/i5q+SRIxEUj02c4WNxP0x2CnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyS28LDH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyS28LDH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso14604825e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221072; x=1778825872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuh0TWbP7Q2PxqCNCqYvtEE1jwhkHwY8twT6/h1P3VM=;
        b=AyS28LDHAL1+CprIFjF4DZxtxibzVwoBEReC/4UthEhmYO6nM0HMm7CQ41LAVTvBGu
         RFZIKJpjI7ayh+EI9Um5M5ER0IMD9+80ja6sMFIO+I2tzZd2hxwvoj/POIXaTIVnr7Hx
         RbZJcBwoTPoHoBQ6dNhn0YUHb8eGsU3SWJEVHSRCFM86D5DxWfxKIOcaI74x9UVyocuT
         XXqW4d5mkEqTZO154+TFfqVU8Y09IENNP0KBUqFNLkrdlJHCp9It8rMVvwEXpT08ebik
         UcssL2JT0zeIm+gnpN7JxFaHxhraDln0blTkC+FC01jUIFsA0ZULVhFgMdgs6iEsm/aj
         IaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221072; x=1778825872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kuh0TWbP7Q2PxqCNCqYvtEE1jwhkHwY8twT6/h1P3VM=;
        b=swiJX9vYVx/U/uKHj4mChTJPqiiL7oQVUlMrXUb/V4x+A/9YM48IPaXJjY5yXmWIYE
         Rng5vIZdDKaWev7lji+gDIVcjVUwuF7gwYXOIkk3MVH1wsjp8Y1SVsGjh3Lgys5CN0HO
         PC/IPWa7yKXkKYimTkrmYNbtIivyIWLdB6qH5/wXu6ZtPu2035BCBo+QQMn+0rqySdFu
         WB8TSS9Xh4js2pL/EamCLzh9ULeIDbVTRv4JRLkiYcpKCN6+rsje0hC4d4/2njS8pxsp
         V63pmQelEKzefWvzFeWJUy1PlB0ormAt1yxxKmGEzwipMxIuSCd4NqL7v/NJ2lxC9cBm
         4jwA==
X-Gm-Message-State: AOJu0YyCO+nilIGTBG60YWLVOK8KyQeFrIefLT/jNDli7TvTsa3al9PG
	UIYDmm7c0KirU7eHMKiTf3rLLs8CRF17IzVwexMmWvEMmoOvkTYSVaf+
X-Gm-Gg: AeBDies5XJNluQkkDZNObDqcB5pO6UVJNQ4t6R0E04eo6ngmIvxE0cH96EcJ15Q8hVt
	qTg8/9IJfavvIdwTqPeNa3dnnL5L9FPNRvsJEzoT0lVQPD6zV0IUrCcYnHWbS4j2azA5fcks6LQ
	ckymkuGs62U1MEeXJQKywtpSvtnY0e9IfgDLFxLgUcbG6kjJ9cwamY73tDZ4Fl/IiaYO2LtnK0b
	aBqm4q2TeOrXKA7ZmRgYC9SBD6OHQpt8RB9qsfYPVTbUiJC93czk/zI/ttWlTq7+fLcypIiK4/l
	qL4rEGxLA/Yz3WLyLD5lNE6zz2D+KakRisa5d1apAK7mDsHIi2TBSNyoES+G1KyrNNJMZCrzE13
	mnsZaNLXO5TA3F7AqDReFuJNNivh/hoFXJKrm0IlSONz3jPtl/rmVDVzxbhWhxGcHt/29l+06Rl
	8XcdcpcCZ/UCJV/Vg=
X-Received: by 2002:a05:600c:4512:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48e51f3a538mr171437455e9.21.1778221072181;
        Thu, 07 May 2026 23:17:52 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:51 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 2/6] gpiolib: Move DEFINE_FREE(free_gpio_desc) to driver header
Date: Fri,  8 May 2026 08:17:25 +0200
Message-ID: <20260508061729.9530-3-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508061729.9530-1-mscardovi95@gmail.com>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
 <20260508061729.9530-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the free_gpio_desc cleanup handler in include/linux/gpio/driver.h.
This allows drivers to use the __free(free_gpio_desc) attribute for
automated deallocation of GPIO descriptors obtained via
gpiochip_request_own_desc().

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
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

