Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F53DBD7A
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059780; cv=none; b=uDRgpRGOtqcQIFDIU4PpOHt3vRQVR0RPbwu0at0dwS0GMOAIAhUVLoTo1o3KtGp+mDIWsnWA/ejN5k/nj0BOrdbzccWGyYz2c4Uwg68UJXbF7kgQ6qSsT+XUdMKvaJap4LDBbQ09tZ+wHspkqja34ZNzUpizN8OmIQ3WpAaovdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059780; c=relaxed/simple;
	bh=b6KDebbwB9y2ayWmTDcDF7ZXzrnROwC7atimGy8vf0g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=jgdChDsX0Efa0K47SnjtXB5PYr/xzQd8KuM8+hqUlnwGRDzYa04HDiNQ/+3m/LDIiUtpRCA2eluOUA2qJ74DZw0r4qGvMzJwS3a4qtuEGb/7FYQb6rjKVlsyio3OQVWOvuWuEhGzD4erWTPi0QvSvPak+fpQZWViWdxyD298dRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjGFkPW/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjGFkPW/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2901691f8f.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059778; x=1778664578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/I8gmtTJP4V7dsNote1TQ7GwmlIxPNJ693ojN9z7bA=;
        b=BjGFkPW/6bSGbXo3NSVroU6XqXBQIXXcmCw+xNmUY3StCPVICQornGq/IpS7rY29ej
         hvseDjPgmP9O9TTpsoFB7uQ8rLgsLKsylGyg2MzPBPdOc7ZoEfmFu/CGLF8YcoUzRP5V
         meJauL5a2/a0bc0vwlrce915K4tgqG3gU5qeQEXE6svMBvKibSPKpFdUSFjtcVYZzrg1
         AJW4Pihm6bTj94XL691TOLRAXv25NPV9Y5SMvvhTqP5rmPtNwZfR6fQ5ShGxwoio1AZS
         E+9rJNb7SF+MlSuhr0SxpyZZRFm1yaorVkga1MeBExBnEeU5zrXJsfeOZ7ziHV6NcBiL
         omaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059778; x=1778664578;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/I8gmtTJP4V7dsNote1TQ7GwmlIxPNJ693ojN9z7bA=;
        b=dXknXnu9hdPK5h+aLvzPdnYc6+vJ+2Ys47H67OVgo3Q+pkIuuZMs+DvVoxQl1+I+9Z
         dVYBYZwa8UbIlh7tN4zG5SRjBZ0wZPsEoWUqZRuqgwQ/sFboXCVOms9/L92inlApXQqD
         mCrENncGQfmzIZd8n5FANqlrbCk+/wo1t0ZsO9U2CgSwyyYxqfsFcGC5FulgtN9rlSdc
         t4mz30tXUJplnGfBvvvNez892x0cbWKsJ6vmHFJmYkB/Dct7rgMRPbCQWKJ7+MrhuqmM
         GJ3SKOKEIhJEWxq/vi9MkBfGrCVjdvYWZ65/79VqTBqJu4BrO1wkdMmVudLWbC4qMCAw
         JzuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zq9XwSGdSBOk5Hv6IwfTrJ9COp5cps7xKh5K/0wGoTKd2gJsJhDlqdrGHGxre5mShGlhBS5Wo6Uw4@vger.kernel.org
X-Gm-Message-State: AOJu0YxvfGnXtyTitJ+DDfuRT/NFxPlQ0fHLroXay/si7S9EcPQCJu7E
	+rOCya4IptVu8uiDrtOT7e7ddE6q2PAXLdy2JDf3vUejAUYqGQfpvll5
X-Gm-Gg: AeBDiesnS1KibFZz7lmDPFfrQrKumBExKObRCP5qJwsW/3pHIPYkaD5Bbx4zfetLxC3
	FOlq8oXholXthO3R15cAV799m7M0uYt9k1A7uKY4iWxR4SfzPJbs0QCWt8BkTaa3TVlYdbY/OCQ
	Yr6Wg6plxZGKvWjvWynAoSrhWbCF16jspbcTPN+a2I/Dav0lN/0a/rEXvy80XfbcvtxFmL5Dceo
	904q6HS0zWPM5D+wZUIeJpaMJ6nCi2ef7FnQjqHpLbEcpApquOWc0APLUOW+TGQL+fEQg74jtkx
	XUb9PAtE/+kIKfoo84uBRP9Oz3fAZFYU3+1GJ5fqKUdbIQWrEHQb5MB4ugkqXdtPgThWQTXvKns
	LyUbUU7uiC8QkhvPcxrRK7H8+fckiPjX9dliDLa9BbX7EEACOlWkylS50j6nL8cL+jgDDFNLP4Y
	oZWKKsAHfzr1DDZu5BxWCwNvrLNtAVIEMAv4gb726Ef1KZ/fMQMaKSIgsegyJGfecnfClvnj2KQ
	rol4dk=
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48e521e6085mr44681375e9.16.1778059777373;
        Wed, 06 May 2026 02:29:37 -0700 (PDT)
Received: from ?IPV6:2a01:e11:202b:40:68b1:8d59:e348:c16e? ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm38017295e9.5.2026.05.06.02.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:29:36 -0700 (PDT)
Message-ID: <59174ed2-dc3a-4891-929f-bf513deecdc2@gmail.com>
Date: Wed, 6 May 2026 11:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mika.westerberg@linux.intel.com, mathias.nyman@linux.intel.com
From: Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH] gpio: acpi: modernize resource management using cleanup.h
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi everyone,

I was looking for ways to switch to modern cleanup guards and auto-freeing
pointers to simplify error paths and synchronization in gpiolib-acpi-core.c
so I came up with the patch you can find below.

Here you can see the main points I've worked on:
- Use DEFINE_FREE() for gpio_desc and ACPI resources.
- Use guard(mutex)() within the OpRegion handler loop for automatic locking.
- Use __free() for automatic descriptor and memory cleanup.
- Fix off-by-one error in GPIO pin bounds check.
- Return AE_OK on out-of-range pins to allow processing other resources
   even if one is misconfigured in firmware.
- Use break instead of goto in OpRegion handler for cleaner control flow
   leveraging auto-cleanup.

I've tested it (both build and functionality) against linux-next-20260430.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
  drivers/gpio/gpiolib-acpi-core.c | 94 
+++++++++++++++++++---------------------
  1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c 
b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..19a18222b7b2 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -7,6 +7,9 @@
   *          Mika Westerberg <mika.westerberg@linux.intel.com>
   */

+#include <linux/cleanup.h>
+#include <linux/slab.h>
+
  #include <linux/acpi.h>
  #include <linux/dmi.h>
  #include <linux/errno.h>
@@ -23,6 +26,16 @@
  #include "gpiolib.h"
  #include "gpiolib-acpi.h"

+DEFINE_FREE(free_gpio_desc, struct gpio_desc *, {
+    if (_T)
+        gpiochip_free_own_desc(_T);
+})
+
+DEFINE_FREE(acpi_free, void *, {
+    if (_T)
+        ACPI_FREE(_T);
+})
+
  /**
   * struct acpi_gpio_event - ACPI GPIO event handler data
   *
@@ -361,6 +374,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct 
acpi_resource *ares,
      struct acpi_gpio_event *event;
      irq_handler_t handler = NULL;
      struct gpio_desc *desc;
+    struct gpio_desc *desc_guard __free(free_gpio_desc) = NULL;
      unsigned int pin;
      int ret, irq;

@@ -370,6 +384,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct 
acpi_resource *ares,
      handle = ACPI_HANDLE(chip->parent);
      pin = agpio->pin_table[0];

+    if (pin >= chip->ngpio) {
+        dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, 
out of range\n", pin);
+        return AE_OK;
+    }
+
      if (pin <= 255) {
          char ev_name[8];
          sprintf(ev_name, "_%c%02X",
@@ -392,31 +411,26 @@ static acpi_status 
acpi_gpiochip_alloc_event(struct acpi_resource *ares,

      desc = acpi_request_own_gpiod(chip, agpio, 0, "ACPI:Event");
      if (IS_ERR(desc)) {
-        dev_err(chip->parent,
-            "Failed to request GPIO for pin 0x%04X, err %pe\n",
-            pin, desc);
+        dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, 
err %pe\n", pin, desc);
          return AE_OK;
      }
+    desc_guard = desc;

      ret = gpiochip_lock_as_irq(chip, pin);
      if (ret) {
-        dev_err(chip->parent,
-            "Failed to lock GPIO pin 0x%04X as interrupt, err %d\n",
-            pin, ret);
-        goto fail_free_desc;
+        dev_err(chip->parent, "Failed to lock GPIO pin 0x%04X as 
interrupt, err %d\n", pin, ret);
+        return AE_OK;
      }

      irq = gpiod_to_irq(desc);
      if (irq < 0) {
-        dev_err(chip->parent,
-            "Failed to translate GPIO pin 0x%04X to IRQ, err %d\n",
-            pin, irq);
-        goto fail_unlock_irq;
+        dev_err(chip->parent, "Failed to translate GPIO pin 0x%04X to 
IRQ, err %d\n", pin, irq);
+        goto err_unlock;
      }

      event = kzalloc_obj(*event);
      if (!event)
-        goto fail_unlock_irq;
+        goto err_unlock;

      event->irqflags = IRQF_ONESHOT;
      if (agpio->triggering == ACPI_LEVEL_SENSITIVE) {
@@ -444,17 +458,15 @@ static acpi_status 
acpi_gpiochip_alloc_event(struct acpi_resource *ares,
      event->irq = irq;
      event->irq_is_wake = acpi_gpio_irq_is_wake(chip->parent, agpio);
      event->pin = pin;
-    event->desc = desc;
+    /* Transfer ownership to event, prevent auto-free */
+    event->desc = no_free_ptr(desc_guard);

      list_add_tail(&event->node, &acpi_gpio->events);

      return AE_OK;

-fail_unlock_irq:
+err_unlock:
      gpiochip_unlock_as_irq(chip, pin);
-fail_free_desc:
-    gpiochip_free_own_desc(desc);
-
      return AE_OK;
  }

@@ -1086,7 +1098,7 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
      struct acpi_gpio_chip *achip = region_context;
      struct gpio_chip *chip = achip->chip;
      struct acpi_resource_gpio *agpio;
-    struct acpi_resource *ares;
+    struct acpi_resource *ares __free(acpi_free) = NULL;
      u16 pin_index = address;
      acpi_status status;
      int length;
@@ -1097,20 +1109,17 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
      if (ACPI_FAILURE(status))
          return status;

-    if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO)) {
-        ACPI_FREE(ares);
+    if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO))
          return AE_BAD_PARAMETER;
-    }

      agpio = &ares->data.gpio;

      if (WARN_ON(agpio->io_restriction == ACPI_IO_RESTRICT_INPUT &&
-        function == ACPI_WRITE)) {
-        ACPI_FREE(ares);
+        function == ACPI_WRITE))
          return AE_BAD_PARAMETER;
-    }

      length = min(agpio->pin_table_length, pin_index + bits);
+    status = AE_OK;
      for (i = pin_index; i < length; ++i) {
          unsigned int pin = agpio->pin_table[i];
          struct acpi_gpio_connection *conn;
@@ -1118,7 +1127,7 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
          u16 word, shift;
          bool found;

-        mutex_lock(&achip->conn_lock);
+        guard(mutex)(&achip->conn_lock);

          found = false;
          list_for_each_entry(conn, &achip->conns, node) {
@@ -1150,17 +1159,15 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
          if (!found) {
              desc = acpi_request_own_gpiod(chip, agpio, i, 
"ACPI:OpRegion");
              if (IS_ERR(desc)) {
-                mutex_unlock(&achip->conn_lock);
                  status = AE_ERROR;
-                goto out;
+                break;
              }

              conn = kzalloc_obj(*conn);
              if (!conn) {
                  gpiochip_free_own_desc(desc);
-                mutex_unlock(&achip->conn_lock);
                  status = AE_NO_MEMORY;
-                goto out;
+                break;
              }

              conn->pin = pin;
@@ -1168,8 +1175,6 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
              list_add_tail(&conn->node, &achip->conns);
          }

-        mutex_unlock(&achip->conn_lock);
-
          /*
           * For the cases when OperationRegion() consists of more than
           * 64 bits calculate the word and bit shift to use that one to
@@ -1188,8 +1193,6 @@ acpi_gpio_adr_space_handler(u32 function, 
acpi_physical_address address,
          }
      }

-out:
-    ACPI_FREE(ares);
      return status;
  }


