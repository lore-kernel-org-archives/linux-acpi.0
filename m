Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9B4534B0
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169421; cv=none; b=qdgvHziqUk4azTq6Zrxxi4IlGr9Zxs4ssHBV19Ozl/vciiQn0SES1x9C7XZJK4P6gTQTMY4x5d2SwVGso5glUEzmwHKJ0VTM1/DXpi7DUJlK2rd2IMEfVn2yCUpB+le3ZYpdXBDmw8BCZXoFIGHsMcnyeQeze1zXL53fMUGtOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169421; c=relaxed/simple;
	bh=JV3zZJ8rkmi4RMT6hpnGeDnQ0pKc5O/jB6na/dhq70A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By6hYmSAB4prWJTNXTNJEz1p4bXTHiOmb1CmWcUZBqCOxDWJSvfoCJvD719Y59+nH3coPtQBnzwKxzoYhas1OXxx3wdnJi3naO5yeynPv4TknPvbgPSQIbKx+oYJzPtpb8ixm5wENyy5mVjzpt05nvRH4tWkkWfW7ALsvI5raXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/McGVjT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/McGVjT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe62837baso579614f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169418; x=1778774218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuLklHkoZ90lipN8/stupsJdkmM0RVCMnCyoiMUX2OI=;
        b=o/McGVjTKIpSPlAJBkVFsQ5gQrlE76xrCJ1RIaGedoTmgBa+d9YGeL1ic4JZr+p+DQ
         lh/cC+LgOtxMXlhrDmSGh0gDRRNAFlU3l4i3DPrN5iplFslU/dzsmMTcJHJRIEg4KWu4
         nHiLZ7sj92teaAz8CI4Qs7hAc1Fsr/n1Ab82HhWi57H1RixY/fUsGf2boNnlHwovT9iq
         dWiiPOxINqpH0L3Kgu4g5BaZpvdFvWYCYZ11Hw3MwuzAj9alMtswTmjYpHSKA6GmdkBV
         FX4ozaDqTPT906g2l31ILF86vu5RPifs5n69IE45TfqOxT+Pl1uIpevf1Ykh1ZvRD+Vr
         NUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169418; x=1778774218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LuLklHkoZ90lipN8/stupsJdkmM0RVCMnCyoiMUX2OI=;
        b=rGaDS71l+JppvT5/p/D9eBrsgy9bAwRmpHYnSVPn8rNs4zOzNpFbJHD/OKCvzQhWL7
         7cg5hpAJqsGPuFZPzXSPK3bUMkmA6nuMMB0giLYne+ASo8NFcmEuG1IdfVX6my5c6/Hi
         xSejsARbx2ywu8AvYwCJaNt99tLB9x4x8E6cXJRL5kxJi8mecb4qiy0xPy+qIV7WuDNC
         XSWDqg8Wf8JoyX+BJF/MGLKn9+0bzXZ5l6pcJ/r6VIKW23ukJtiW0zvweWL5WEo4NP5E
         U60dh0RvEbZ2x691wu8jp9Cbj2SsDVYVX9S5Gb1XB/xAMn0IQ5mHbnhCqLu1AQzEaFUp
         v5cQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FV8cGYmVGWk9Nc1uu/IRH906Ygnm/HT0qm7k01Ff+oExtiEuAA1XKZDW30Z421BTQjkII/KzTHvFF@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwIseTsGlwuGTqTrlgb9mo5ECt7bYWvRITSIcpOfTUCHmo82D
	8T8ubsG8ERIIreDwOzt1f6JArp7Hc1izNHBVzKb6Pqmys1sPcI2HeLtn
X-Gm-Gg: AeBDievUHYmSLjqB+NLTP210npX1vRuLna088iX8Va8P0vrl/7uQ6fXqlj0ZF7tMjY6
	VHY2pd3UtoYR9iIXLJ1RfQ7vQ+JT6S0VP69fCugyKQ3S/WUyJRgDUWhmHfHfU2dJ/wNI/Y/IwhE
	/UXcI1VRLJ7mei9d/Z0llza51MWcKV4a27IplQjdB3Y9gWllsLj12I64hya0qmFVIDRe1/G502P
	y/fEhwj0TYzLfqv4SjtlZIAIFPUaDCJHx9VItGl8FPTMC+8+MQqfyvEzh4TPgAbgVbdumHxXhYW
	Zvoho2MN6ztDdWr9YQJJ5wy2vmTvmbKulImBkp7b2ePK9txqgoriwBFcptTP+d555B8HdAqg4/l
	zExno4ttqQrzL6oVPEeau39QlgiR272Bu6S1Y6UPu2yyJh4yaV0aMz0sGE6Yq/wgzvSC13RCcQL
	Ad/N2zhae0OaJHsbX6imL9do6kjA==
X-Received: by 2002:a05:6000:1acb:b0:44a:8c10:40d9 with SMTP id ffacd0b85a97d-4515cf126camr14427750f8f.23.1778169417791;
        Thu, 07 May 2026 08:56:57 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820463sm44581f8f.3.2026.05.07.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:56:57 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: andriy.shevchenko@intel.com,
	mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v3 5/6] gpio: acpi: use cleanup.h for automated resource deallocation
Date: Thu,  7 May 2026 17:56:46 +0200
Message-ID: <20260507155647.403964-6-mscardovi95@gmail.com>
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

