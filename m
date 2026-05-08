Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF537268B
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221088; cv=none; b=dR38mVxeR34olf/cwI/x+d6l/uS4idyLToXLX3YQxbdb1Mj9RSpuNu+iev17DZprUwcMvKWudq050qkoEb9QeXn7O8qzq0n910qmHiu5Cr6xEYnIllJMWqQOO7oqqXbAjq3lFa+W05hE0BkXI7Liqeq1oVCIqY70dqmHhQkJiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221088; c=relaxed/simple;
	bh=vXzQCDc9L1TnkgaJ2V/CUD7F8PnBdDZXe97ITMRJsds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGYVrURt1z6/3eD1puPf2GvMYpXHvCBNAce4uXxgSQRs8gu8jKYcWfgLzimJ0bWHjxYkKJbPWbQO7K7+FGHfhAgwZqunaMBtdlWos7G5liU1r2zI+48SF0CEw5+WIYhHI3nZ9fZRXZ11ZGS/xMBoWq8XjKRq1jrHzFMTd39kWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTMjZQta; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTMjZQta"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so18477005e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221076; x=1778825876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw5+LRl2yUPLo+LV3S+sRIQay0YVPQ+KYOpW/ni1u98=;
        b=JTMjZQtaWmRHnFRdBIIPiIGNhMsXF1muMTkOcRVwcGVaN1/8uzU6iGjXvKQ4ZzKHtp
         gZ+ni/WMUaNcQOE6nLe/yHurfpVTjb0m/jgcKz746mgZ9SAwK1Y15W6W8qChrFMaj4ju
         uHgUCQycedRwT9LrFAv83T5Q+sxkLPqIXft7reU3BArExS5T67o+E8mkzVr66SisAcTd
         RksP+4pYAjFS4IxafY/dSQXSxYdVGb7yrwfVrvaec9MSS+1Q5FBNYu8mC64wAOOCYpZ1
         FOft/Rgqz/RyXr4c1JCJqyA8iP3m481ImUO+eQrioLyz2/NVz3Rco3OyCwrdaT/aWHfW
         H4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221076; x=1778825876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bw5+LRl2yUPLo+LV3S+sRIQay0YVPQ+KYOpW/ni1u98=;
        b=AZwuNevgChKSC3sSC+PqT2S/DHxpwxvdoZfvLvUb1vKGlHkvSwcj/rDf7Dt66iUbLz
         QbTTwXULFEE2nnzCGstr2cA49qxBWJqWzcA7Mzul1nchTV4/MEDL8YP3FB+GKYqrhOXa
         LE9YNL+6MiS1RjsRKVUYoMgNI/ffmaKe0iiAakQ+7WTOzJGEIM39MobS9oal570+usDv
         QQNErikD3UDVT5irJBCvaQ/WoOYCMEL+tpuTMBwVAiJ6g2g6MgY8nIY1t3ItM3ObL9TF
         JobSuujwqmS8abm9K9NQq4h3rmRD6vd5VqsnGhzXpzbn3jArVv05K3nrz64vYV5qhrjG
         s2fA==
X-Gm-Message-State: AOJu0YyIki18hIl6ON5D5iA1iaQEXomKMqe1U8wbC+axavVdSOUhgyYc
	hG+qbbCnn/mNXIWBLVYK7FiLwelhxT0Fey7ArSi5auCDfGU8FW3pYZ/z
X-Gm-Gg: AeBDiet+1qg4t9aUTFtYYMVSdxbn1DPkzepqJfwbPghoDDnyXZdrwMqHCuJfT8jOqn+
	3e17zc2wfE4Wj3j9BPW82TpCcNDtjubd1ZoM06IqobHVlSs6G1KmOSjRixkNTKTwprBg+eMw4x7
	2Q+Okk5B3wp+05r3TGi8HvNX5xXkuzwSBhi7zpMDDCQU0yzd372UEtu3/waBl5HjPgtmb9yqHlv
	0UQ8TrOZVvsnuEgPYrIVk1fnOYW/QSf4Tm8eOv9yDtF/HfyI2e9aJhlxvCeWLdgXtvTts3E6E20
	1NMG/KSkwna7WQFZ1JT8L2WiTdr0cE27fVRsyfLujCv2VkStcCcc0VpzsgoJFm/4aXEIlaTOOls
	LdwF46uz+rwcxEHJg8M3J2S9wljE//ZfsI36xhuFjIBvqM1zRbCUgutIkswdeDc9SYYBCL1KsCJ
	SxTWwZWBRMMrIp+ZbzfxICuURXlg==
X-Received: by 2002:a05:600c:3b17:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48e51e15c37mr163854705e9.8.1778221076095;
        Thu, 07 May 2026 23:17:56 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:55 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 5/6] gpio: acpi: use cleanup.h for automated resource deallocation
Date: Fri,  8 May 2026 08:17:28 +0200
Message-ID: <20260508061729.9530-6-mscardovi95@gmail.com>
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

Refactor acpi_gpiochip_alloc_event() and acpi_gpio_adr_space_handler()
to use the __free() macro for GPIO descriptors and ACPI resources.
This simplifies error handling by removing manual cleanup calls and
reducing the need for goto labels.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 40 +++++++++++---------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 33d6c3b6cdf0..c9b12e24de14 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -397,31 +397,27 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 
 	desc = acpi_request_own_gpiod(chip, agpio, 0, "ACPI:Event");
 	if (IS_ERR(desc)) {
-		dev_err(chip->parent,
-			"Failed to request GPIO for pin 0x%04X, err %pe\n",
-			pin, desc);
+		dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, err %pe\n", pin, desc);
 		return AE_OK;
 	}
 
+	struct gpio_desc *desc_guard __free(free_gpio_desc) = desc;
+
 	ret = gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
-		dev_err(chip->parent,
-			"Failed to lock GPIO pin 0x%04X as interrupt, err %d\n",
-			pin, ret);
-		goto fail_free_desc;
+		dev_err(chip->parent, "Failed to lock GPIO pin 0x%04X as interrupt, err %d\n", pin, ret);
+		return AE_OK;
 	}
 
 	irq = gpiod_to_irq(desc);
 	if (irq < 0) {
-		dev_err(chip->parent,
-			"Failed to translate GPIO pin 0x%04X to IRQ, err %d\n",
-			pin, irq);
-		goto fail_unlock_irq;
+		dev_err(chip->parent, "Failed to translate GPIO pin 0x%04X to IRQ, err %d\n", pin, irq);
+		goto err_unlock;
 	}
 
 	event = kzalloc_obj(*event);
 	if (!event)
-		goto fail_unlock_irq;
+		goto err_unlock;
 
 	event->irqflags = IRQF_ONESHOT;
 	if (agpio->triggering == ACPI_LEVEL_SENSITIVE) {
@@ -449,17 +445,15 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	event->irq = irq;
 	event->irq_is_wake = acpi_gpio_irq_is_wake(chip->parent, agpio);
 	event->pin = pin;
-	event->desc = desc;
+	/* Transfer ownership to event, prevent auto-free */
+	event->desc = no_free_ptr(desc_guard);
 
 	list_add_tail(&event->node, &acpi_gpio->events);
 
 	return AE_OK;
 
-fail_unlock_irq:
+err_unlock:
 	gpiochip_unlock_as_irq(chip, pin);
-fail_free_desc:
-	gpiochip_free_own_desc(desc);
-
 	return AE_OK;
 }
 
@@ -1091,7 +1085,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_gpio_chip *achip = region_context;
 	struct gpio_chip *chip = achip->chip;
 	struct acpi_resource_gpio *agpio;
-	struct acpi_resource *ares;
+	struct acpi_resource *ares __free(acpi_free) = NULL;
 	u16 pin_index = address;
 	acpi_status status;
 	int length;
@@ -1102,18 +1096,14 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	if (ACPI_FAILURE(status))
 		return status;
 
-	if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO)) {
-		ACPI_FREE(ares);
+	if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO))
 		return AE_BAD_PARAMETER;
-	}
 
 	agpio = &ares->data.gpio;
 
 	if (WARN_ON(agpio->io_restriction == ACPI_IO_RESTRICT_INPUT &&
-	    function == ACPI_WRITE)) {
-		ACPI_FREE(ares);
+	    function == ACPI_WRITE))
 		return AE_BAD_PARAMETER;
-	}
 
 	length = min(agpio->pin_table_length, pin_index + bits);
 	for (i = pin_index; i < length; ++i) {
@@ -1189,8 +1179,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		}
 	}
 
-out:
-	ACPI_FREE(ares);
 	return status;
 }
 
-- 
2.54.0

