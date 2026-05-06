Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FDC44CF40
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071024; cv=none; b=X+M8gvhn9wa7POO03mrQ0gPX/41t1nYaojHik88BulKvSBAESYmaH72WlTClEwvkuDnDDMOp+GHrlfybOLk6/2Cx0OZoeOlD8DyY7VgJbL4uxkYxiQVThYHfD3VO+MEFjVWYAVwDoCQazezxQWbExis7WC0s33hPgqJ0PgIA2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071024; c=relaxed/simple;
	bh=v/NK4ob2BdQrRgRECswCj/ZvHO8mcxQCL6EyTUOg2XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxBJ03ZXsTEAWX641NIOWroiX8Je0v/r4KyGfN9yUT84jNcY4enfxf7X3gVoPOXq47hoDVkMA32OSBOJpzbJd25qe4Z8KUio6clLaDJc6y2VLNrL62s3tHGah+IrZQtgaHuVsRMVN0WgR06GtJ55lODaQ6XPClOfJ/xA0m5b7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=engmf561; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="engmf561"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso35534235e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071018; x=1778675818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmPjvjob3FbjNKESIZvrg3JwdYT3+owCLHCZhOf9FAE=;
        b=engmf561V+xtEFyjJdib7qGpkxbU57rxXX16u2gOE+u29xoDh9xDQ6jzwdnwm6rkVZ
         TzJOPlclWgrgJbYybU/Rs1qx7OIfAs0vmwvmGVQ/CRhU5oBMqSN1yhw4k4Z3KN8nj+ow
         86Pt3k54mdILmIF3XDXxv3yRxzw0/8Bk+TdhfjUbFMZz/vxqrfv/8ost32XP0VK7WTOm
         wJsko8LF9x35YUidrhUAMVL5IvIzloWm71bfcjVLD+Z6baRYc5i36DJjtzhe0BvO8uSJ
         QAAvxMrn2dFHHERs1nE1PKaSROGXX/YaABE0+nwxiCyekkVd/lPmW2pxaCczcuuxZbPG
         fdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071018; x=1778675818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmPjvjob3FbjNKESIZvrg3JwdYT3+owCLHCZhOf9FAE=;
        b=KNJQVYtZ0QcMoJOczx16IGxBLXeHgqL+Dau1vddgVKQi79uTciRJX+S4RBRfTwAyJK
         7YKb6OYO7pkhRBq1WDTGd/dm/6LphiFb0TyP72t/U255tF2HbU8gX0TbWz91yBiuBDUI
         a6K2HeB6GTDxNAu2kM6wQ8eWlN6gwuoT87Y7aG+/TjI/phO/32/k+YbQJUQbCEa7R/GP
         /hAtBjgLYy8+dqG3DZpBFeZ+cYFB9D++eCbx6JA1sB+UHTGXZkGLZtduCrVkk9aigx08
         22EpC60M8/OfT5VFgg18mu3vXzkVAc14Pyga4lOIl+PjBFL1dgFs5OiK/26L3rMaTiyb
         eHMg==
X-Forwarded-Encrypted: i=1; AFNElJ9Rx/FV3GddJ1yhx3j/j7FiV4CW7u3UNILpmFjmaNqzjj2EAkafEuMw5G203I/ORnHx3lTPVnOVEPZ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/T9pirdSY3lDaAwUxEcX0lUaNL8VDjZhw0t3gfCLbMNZoHll
	vsb1gWWKRy4UmMQXgBYa1DrqcWFUXJsmyrpNo3cmb0CwQEOmnKBnkj2W
X-Gm-Gg: AeBDiesOf6wYbdXmimqG+ZCc5Fre+ZTFIMeWr/Vfts5JkSiIEleIJtVkquJeVyoQk9m
	bRQlk7qyJodZTaQ7NLy/GM86VswHQjvl8ZdyAvCF4TuyLeG6ysZrpuQf53Qt+NbUDoa4RNLnMra
	5Zb+pusvn9amDEHwFkqne/dW8/aNAlOVhUDr8vEbziu9GTFjkCVA/zkfp7StoCX6zObVTttPjWT
	IPEovZN1CWRp7pbj9e6Rs3dnx7ZmbBPiQ23U3l6u//2CRVWAx1w/5aNbk/4x0vlG7KKFbCyCQUP
	Vn/mldaAIFZMdGfevn+evVqtQEuNBQXKE5wcLk5+T15lPq5kgruzcZJeMoObm30eVKzEaO6WraN
	9Z97cMLqd3DVyxz7FKR1VQsjn/HWsvYyr4r+GuqWeWjGAkdlUXKhIJwfnxTJ6xDncXGFh3E8HML
	Oc5TLujcIQFW0vjd/bItceW5agOQ==
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr56620385e9.20.1778071018538;
        Wed, 06 May 2026 05:36:58 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530cf964sm31767485e9.1.2026.05.06.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:36:58 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v2 2/3] [PATCH 2/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:35:35 +0200
Message-ID: <20260506123637.1077421-4-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506123637.1077421-1-mscardovi95@gmail.com>
References: <20260506113215.GK6785@://intel.com>
 <20260506123637.1077421-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpio/gpiolib-acpi-core.c | 38 ++++++++++++--------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 7c17bffcd4e7..b6accbaba04d 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -410,31 +410,26 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 
 	desc = acpi_request_own_gpiod(chip, agpio, 0, "ACPI:Event");
 	if (IS_ERR(desc)) {
-		dev_err(chip->parent,
-			"Failed to request GPIO for pin 0x%04X, err %pe\n",
-			pin, desc);
+		dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, err %pe\n", pin, desc);
 		return AE_OK;
 	}
+	desc_guard = desc;
 
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
@@ -462,17 +457,15 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
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
 
@@ -1104,7 +1097,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_gpio_chip *achip = region_context;
 	struct gpio_chip *chip = achip->chip;
 	struct acpi_resource_gpio *agpio;
-	struct acpi_resource *ares;
+	struct acpi_resource *ares __free(acpi_free) = NULL;
 	u16 pin_index = address;
 	acpi_status status;
 	int length;
@@ -1115,20 +1108,17 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
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
+	status = AE_OK;
 	for (i = pin_index; i < length; ++i) {
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
-- 
2.54.0

