Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3753E0C5C
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090863; cv=none; b=PtaqXTmohx2Hsrto1jZHUOZylytiwuMW0Znmfhu6dnY7i6WN4pdHCOZ2OOIftHbY4ihJu/aodWEJ6VK3+rxGtzusNPfMS9B99tjASE0VTYQxg+jFEGDwj8OFloFpJPA3qqzSVqe/lbHK3tKCIDBzfptJrh33g4Hy791q+lVvrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090863; c=relaxed/simple;
	bh=TzAiXOXdFdd5ooTM1upT2oXPj+V4/6Q8UObelMDcd6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRVSwSKIuAXre01ABYJM9yjTikN5RJ0bVSChh5PQVgVV1U0OgTIIohYQXo3rMTGL5P9p41PLQBhn0fDVS1nAME8VKFCVJT5KEnm1BRwVKlECCW1uOBTeBwPIaLV1TVs1i+P/uCgrwt1VZ4hgcF8t3iNzr3CZw9fx9+3dHAH9VIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOVn2SWn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOVn2SWn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so20681595e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090854; x=1779695654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JK4uuLcystNEzU6NVyAqom5nzqSXsoYns1Ebnwqzbs=;
        b=eOVn2SWnZ0MMOxLDBT5aqn5j7APb+AerAJla7lAarjqoEy7/WsTIpdSXYN9p9Eba8Q
         yAhbV6Ic33n86am7D7GpMAVz67KVVOsyISgWSC4SmgCEvjiUHLWXMBj1BDMB0QvhEne6
         BxVnIXaGmbxtF379P71QaNuuZ7RACxRId48l/Uzo/7fb0zTqM5bU+KDXNN5nGX9iY/Og
         mNVuymRoEXynMHrcD1ChNXhRZc+Hzvlei44WdL24siwiPJYgBvT4KxXTQ6iYVdKHYayx
         vdjw3797cMcxuTMnQZyRPvbXu+Ig1L3Iri9s7N++BU/EIIjBpcApEZEbCofLwvikWnNy
         ztcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090854; x=1779695654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JK4uuLcystNEzU6NVyAqom5nzqSXsoYns1Ebnwqzbs=;
        b=Dcsfi6HTBso5uI4zL1uRKFltwI4NGqCXsecQW/GJxkeqNZpblKFq8RNWhtUsL6a9kf
         yk8v/CV+DZH/0SVKHTfRNavY68eFxHrzx/9ybIz3dS7ByQHm7sW+4ALB7oLqDhhzUEtl
         RSXDuZN3GD/F2N3/2HOExHVvOwsFBJSO95pweLD85+nLPv37+7JhcUSbHYwR3ctRnsAo
         iOQkT+KGchyp9WaRFC/9xdX7cvkThkKfXMyNUglSPsJMfiTRcgSkVzxmA5KEjlJ2WX1g
         TriffwOv4NAYG99XoMf1M0WgqHhUCmt5ow9fbsmKt+Y8Ta6etNOyrQT2blUyYKFzHt2D
         2Zig==
X-Forwarded-Encrypted: i=1; AFNElJ9yFbfJxeDosXhBsgwRfVPgcxG3+QfUlfW77U3Dp5pPIdw1QdisatfVq0TFxtVHuKBDoYOyMiRGUHXY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+SMQNXlYms96TbOSdBgPCccVWFDaG7MOaBQ01yCPYo7z62yA
	6knwA8H3zuBmN+GHeFAQl2OQC1tWaWQYdIHlTIMgJt1Vs8ZpYv4FukIB
X-Gm-Gg: Acq92OHUjEtWK+TBLH2VrcQ/mgCi8aXC4ZdIFLUMBLKngzHtab6IsEQWvy0U6U1EWB0
	29Uple4F10buKtyPa4XYRhN+PVmuUw5H2ZBXE5vSac1kCp4HL2Axk3bO3VVBZ6VOyrD+xB2b5pG
	WYYWzj9t04HCU/DpXr9z9CnrkNC2c9PDcD0Fgf9amhzI8JnBuF5w507ISPD0j+JsHrT4f+oSBjm
	7AwUr/GzaRhxa40BnUaungBARJItaM4vBgaUKyAGrGLZSMJUNnwFvm9OS/H3lDzVCDlrh3y4ftS
	7uQIx93GyfrhYadyTiIfJoagHy/MuOYy8rbe1Fs4kVI4NsteUyaeemq8vwf4LPJWAfYlfaopAOA
	7Sq+hi6aDjQPor3gnvHkLoJVk7pkLxoEGC1swZ9HtAb1mhcZ/4xrrQ72jbFWHB45fOeXhagXOO6
	a+Ab8ckarQfAL+pJQV+L+wKLkCghjHDLXlMGO/
X-Received: by 2002:a05:600c:6290:b0:48f:f199:7a33 with SMTP id 5b1f17b1804b1-48ff1997b3emr175348915e9.28.1779090854005;
        Mon, 18 May 2026 00:54:14 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:13 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 10/12] gpiolib: acpi: Declare shared event helpers in gpiolib-acpi.h
Date: Mon, 18 May 2026 09:53:55 +0200
Message-ID: <20260518075357.112584-11-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518075357.112584-1-mscardovi95@gmail.com>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 6729da5a6fb7..d209a4edb936 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -63,6 +63,9 @@ struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip);
 void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip);
 
+void acpi_gpio_chip_dh(acpi_handle handle, void *data);
+bool acpi_gpio_irq_is_wake(struct device *parent,
+			   const struct acpi_resource_gpio *agpio);
 #ifdef CONFIG_ACPI
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
-- 
2.54.0

