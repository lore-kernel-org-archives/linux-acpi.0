Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41343E168B
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090860; cv=none; b=QGzRMlQxzW74SQ6F2t/sglNJ7hdgpW+bPW87IkMFSx+/G+BPk42RXaN5S2xn8SBIwQR+G2HhDieKwrbqgE+6DE8vLaexiV4U+7C4t551j6MxOG2b1tI8vQiBBI4qOcJ8FvcvhpYAKfiqMZDVRTZWce0X+zLFzU6xOaoWNejoRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090860; c=relaxed/simple;
	bh=uhZ27U3v2eIZ0NhfXUZbpGVdOwqMl7qp6vCvulhWUwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWB23ZeRiYKccHruNhFtlILaSQplAJABgLsM2cz6xnzOAZZAwGvDMmB4XoQBZXFT7ZZ0lVxOe9o6++BRVE4a2BcmzlBMPrLI3yRNB+8WO3QQSoh/DSTIjOpR3po/VETWXgcR4FiSfCtwbDq3+87HjZQFShrkpgtF872azHOdKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEwQimiI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEwQimiI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45d96d21e82so1010114f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090847; x=1779695647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lodDQ5HjiyAy7FWFWZrwQQYQkHD0GGXCtZQuFp7Bmbw=;
        b=rEwQimiIiCUgiyyeBngjdrFRMgkWn9NbMbMGSHM5IoaKiVqIDLGQvBLuoI6WCVXVuJ
         JLZ6CLtuCjbQulNbrEZ1Kus7CBEKTIfTBEix3PNw7PCNY0MR5j5Af5F7T8q9skDsJkjq
         K9dq0XRY9XTYyHii2XwSbH6u1RYemiP6dutwVpFImhCia0e2FKf5FHGTjuPJ1/3np/NM
         2M8ao1dBcnWczgaxwLFL+dPowv+C1XaY91UrlGoSLwTSvpooC+T4vZOwgq5P3qKhocIr
         sl3VcjnHhdmtY1XqzHOwiH9KzLXpUOo8DII+C1it2vK9ANm4bXuotESZyycJVC/8lYtW
         4rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090847; x=1779695647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lodDQ5HjiyAy7FWFWZrwQQYQkHD0GGXCtZQuFp7Bmbw=;
        b=kdbem9MdGYLUtubWGgTs7yT6hh+HKYlFSttmFujCqN1+TVXD0qY8S3heUVBEdObHhO
         KlRQTo/fZ+SNLf6oGV0UDdqM5W/z1gOWEoJRfoeo6Fm1MAmlMRd16FQYaP6gUvCfMs9/
         SRviG5XPGUmCcvF3oYhUqpFpKBsqELpY7DUUMQ5cMuVJiuonSexz1gjHbFKhvmho+BxB
         SVQeDxuDIScTCXvzM4G1TGZnQHH9fJ1roY80CaUGSuGjSx8Cf39b1o7oY9yzV3cTXPWR
         MiLOCSijQnBkeSg30GiafmnZLb3jAJ/R0oQ1TgYna7wJ/FpAa63ycrboqeUybElQPr0O
         mJAg==
X-Forwarded-Encrypted: i=1; AFNElJ+n6K/S1fJtN3WA3zFd4ez71C3r5Je8fDWGBmfi1HGH5sV5qD+VeJjTXZkT7RIpQuvbWeTh+WtUlfG0@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjZsKm0Q7azKfM5YRFxOLT3bK8dubIuVVIq5A6F3pqGT26ClO
	DuxtO0HYdZ1qYlaEa8myE6N2mMeqk09aBkUrVZ7SebFyft9ZMVU6E2K3
X-Gm-Gg: Acq92OHagj86bNwBh8aI9q4ncuSz0YK/ZVnI0n0Xk2e2s15udBN1AIEeUR4usqd5FvH
	ndqQyo18Vl0dvdz8V1k4UxPaiiH1YKNlq+3tdxPAiaG7E1EMYGE2UtKWhKEOfs/GeGS4+F2BXvE
	iuNMfUTYrlth6JYECLBfSAzk4fjFGKqx2/Y+slXsZjHwIRROqqk0PLnsEcp2DBslpyNTRXtqDUb
	adrDVn8FlV2lISs31TyBMutgp/x4+MiNb+6a8CJ6jpRp2reR7imzNSb+Wd/CU01TzDV5YwYd60r
	C8/KljBfWPJW8cOJ0WIHNl9zVIAC5pdrSPYau/TE1VxZgPPPrwrYNJ7zxGptz/Os//O9w1sU7uR
	NME5MDCgwolOIZtj9sXbOgHLdWiMqD05fJAKmtqYa2V8/p22qpE96822QxbujtJITaBZOfVSPjg
	yetbIwuOjpRzosDt58AgIMnQcz5w==
X-Received: by 2002:a05:600c:a406:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-48fe6514865mr169798555e9.24.1779090847293;
        Mon, 18 May 2026 00:54:07 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:06 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 05/12] gpiolib: acpi: Declare shared structures in gpiolib-acpi.h
Date: Mon, 18 May 2026 09:53:50 +0200
Message-ID: <20260518075357.112584-6-mscardovi95@gmail.com>
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
 drivers/gpio/gpiolib-acpi-core.c | 43 --------------------------------
 drivers/gpio/gpiolib-acpi.h      | 39 +++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 4c8cd2038aa1..7217ec5c7fae 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -23,50 +23,7 @@
 #include "gpiolib.h"
 #include "gpiolib-acpi.h"
 
-/**
- * struct acpi_gpio_event - ACPI GPIO event handler data
- *
- * @node:	  list-entry of the events list of the struct acpi_gpio_chip
- * @handle:	  handle of ACPI method to execute when the IRQ triggers
- * @handler:	  handler function to pass to request_irq() when requesting the IRQ
- * @pin:	  GPIO pin number on the struct gpio_chip
- * @irq:	  Linux IRQ number for the event, for request_irq() / free_irq()
- * @irqflags:	  flags to pass to request_irq() when requesting the IRQ
- * @irq_is_wake:  If the ACPI flags indicate the IRQ is a wakeup source
- * @irq_requested:True if request_irq() has been done
- * @desc:	  struct gpio_desc for the GPIO pin for this event
- */
-struct acpi_gpio_event {
-	struct list_head node;
-	acpi_handle handle;
-	irq_handler_t handler;
-	unsigned int pin;
-	unsigned int irq;
-	unsigned long irqflags;
-	bool irq_is_wake;
-	bool irq_requested;
-	struct gpio_desc *desc;
-};
 
-struct acpi_gpio_connection {
-	struct list_head node;
-	unsigned int pin;
-	struct gpio_desc *desc;
-};
-
-struct acpi_gpio_chip {
-	/*
-	 * ACPICA requires that the first field of the context parameter
-	 * passed to acpi_install_address_space_handler() is large enough
-	 * to hold struct acpi_connection_info.
-	 */
-	struct acpi_connection_info conn_info;
-	struct list_head conns;
-	struct mutex conn_lock;
-	struct gpio_chip *chip;
-	struct list_head events;
-	struct list_head deferred_req_irqs_list_entry;
-};
 
 /**
  * struct acpi_gpio_info - ACPI GPIO specific information
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index a90267470a4e..bd857ead9dcc 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -8,10 +8,13 @@
 #ifndef GPIOLIB_ACPI_H
 #define GPIOLIB_ACPI_H
 
+#include <linux/acpi.h>
 #include <linux/err.h>
-#include <linux/types.h>
-
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
 
 struct device;
 struct fwnode_handle;
@@ -20,6 +23,38 @@ struct gpio_chip;
 struct gpio_desc;
 struct gpio_device;
 
+struct acpi_gpio_event {
+	struct list_head node;
+	acpi_handle handle;
+	irq_handler_t handler;
+	unsigned int pin;
+	unsigned int irq;
+	unsigned long irqflags;
+	bool irq_is_wake;
+	bool irq_requested;
+	struct gpio_desc *desc;
+};
+
+struct acpi_gpio_connection {
+	struct list_head node;
+	unsigned int pin;
+	struct gpio_desc *desc;
+};
+
+struct acpi_gpio_chip {
+	/*
+	 * ACPICA requires that the first field of the context parameter
+	 * passed to acpi_install_address_space_handler() is large enough
+	 * to hold struct acpi_connection_info.
+	 */
+	struct acpi_connection_info conn_info;
+	struct list_head conns;
+	struct mutex conn_lock;
+	struct gpio_chip *chip;
+	struct list_head events;
+	struct list_head deferred_req_irqs_list_entry;
+};
+
 #ifdef CONFIG_ACPI
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
-- 
2.54.0

