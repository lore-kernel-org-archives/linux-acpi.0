Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEC44D021
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071023; cv=none; b=Fcpni9Kjec9eJr5M+Sj0GS/jA/ci9qUG35eMsOcgM6n/vtWLmmFXdl7zCJ2CRP/ufcRVkfHv5Vo/BelH6zWXzWVVjL+HPHDH8hTgPsvGzk8jm3gwMRjTPZFM+JQltqJ++YYxfAkMz5gvCi8LKkHxXLoV4iTRTB8STVhIwoNPnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071023; c=relaxed/simple;
	bh=KKiO622uH2fJq1/tL0XKTF01Sy2g4i8eF9XE0Orhm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMe5Aeo073WEr3oGHhw2wMhJfcI4f4hJiLaIv9H/peupVwC2MS3BpDaGN823R3MRUanRUcCyK9bcCxDrNKVxGQamAW0HD9gC7IWcA2n58hH9nFHVgjMvOzCCtsdHtO8fzWbki8zMjkvbubeGClN2k6eJHw2XgiQmvg0/BGx5lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDLMjJeq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDLMjJeq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso75163685e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071018; x=1778675818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zYEKZkZ0zrzlHgzw7EqsB6P1zONDhRzS0uvOcHxVKk=;
        b=DDLMjJeqfTt+pEmhiVbxIWjuCSo1pS8fYkZHJAV2Lm2kPrDR9hipn5o70o6gGtM9CU
         BMLqFmC9OeWnRUQtDFA3RDpBCcJwFx+TG8Br2nB6NdB/yxVkc0Mitu2WSEcaKs68G2e1
         e0/zBJNjPQu94RSfla8zWzXwHdF2OfZV4jKhn9Pd8TVaLRopyeONPn2H8gzbBhefSY0D
         9Lz4vXXh23Erwq/EYiU0wdqaiiH4KJC3B9f55ZlfY2XhHweU4aKeHioZ8sd0Wp+5ElA2
         4ZX6eh7Bga0T0qi6WxvFRHZ8McDyAra7X4nH7Q/Qfjm0K5FUQomI5vIrcYrj242Kak9q
         FfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071018; x=1778675818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zYEKZkZ0zrzlHgzw7EqsB6P1zONDhRzS0uvOcHxVKk=;
        b=myIvE4632zw57eJNLft7pMcF4qYSFkI3SulJYL+CpqTx8OzjTYWIUiULOqeLrqcDNy
         yWLTWcUKdyg0Jq/YuEm/Uysa+dPQ8yLiNTJxapUfu0Pt16Uw25CXk952sK10LSL3ePnZ
         5XCx3tF2nZMxh/Yh6EVu59UioenEKeEoHoukqBkOKWkkTi/xnYU6K698MVnLGK0ex/rz
         72ClMvMfce2mUwntFhtvfmX5LNV95x69nBXZ1IYaddl8eVKv+vBxP6azE4yhwV35hfyK
         QjW7Gvum4sETLJd7Qg6bM6LiJqhl0es9f0hsip8jk/GMGygTx5qrKDjLb+DnKf9kBKU5
         COJw==
X-Forwarded-Encrypted: i=1; AFNElJ860M/o1GIZ5uArvmiGOA3psawGHrwn5PAc5BvdxRBUvfPNgznbL4obTta4GWdOCiDZfuxV4QzAz+qO@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKq0yUlbJK/nSeEkikSYZZywc3u2mYdgmZsuG/mjpSD/Vr/Z3
	mU20zBuq0DxoHUrJtWMS1ZddXWLvdeNGiQai0RBuhT1ZIw8+3cUSaKvn
X-Gm-Gg: AeBDieu8d4HAHHdXHXGIA0eadNDO8IfSrduGl+qSwdVkiPToYvT+sdo7qQ0QgOgLKkV
	W+P6OGxhVskNTeMVRbBjYM57SOGSmX1qkhEPR0HzS4oYtvaikK1fR85M9mdmA2hNS5go2MOn4ht
	8tn8NiZPF2V8UO9eOY9RubB4LnilI79n88PMF3rZm8ujfzGoFihAN9edzLEjz7FHU8BMUUsgt/V
	6FOmWgptC9ixsBAtrqR9MVJAP4/19ho1jPJGcLO+A50d9MsDXbTPSpF2ryzuln73TYhusrimuN5
	K0l5F2MSHENgUSGweXp1GP9vC5j/KgzNqL/iEvKRaNjDmZCSd9SJ5z4LQcr6x+4zpRbvOXFOEcs
	Jr/Fo03XUpBH8Tw3ijNUzBszQAYyYQBc6YmpaWrXfWRfC8XTJGMNRyQUtA9cUrrh3N/SdiVOCRW
	RCtr9p1sBRteN34UuT5DTwWSCeacrdfzzStslr
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-48e51e08ce3mr40215835e9.1.1778071017611;
        Wed, 06 May 2026 05:36:57 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530cf964sm31767485e9.1.2026.05.06.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:36:57 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: mika.westerberg@intel.com
Cc: mathias.nyman@intel.com,
	andriy.shevchenko@intel.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v2 1/3] [PATCH 1/3] gpio: acpi: modernize resource management using cleanup.h
Date: Wed,  6 May 2026 14:35:34 +0200
Message-ID: <20260506123637.1077421-3-mscardovi95@gmail.com>
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
 drivers/gpio/gpiolib-acpi-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..7c17bffcd4e7 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -7,6 +7,8 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/cleanup.h>
+#include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/errno.h>
@@ -23,6 +25,16 @@
 #include "gpiolib.h"
 #include "gpiolib-acpi.h"
 
+DEFINE_FREE(free_gpio_desc, struct gpio_desc *, {
+	if (_T)
+		gpiochip_free_own_desc(_T);
+})
+
+DEFINE_FREE(acpi_free, void *, {
+	if (_T)
+		ACPI_FREE(_T);
+})
+
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
  *
@@ -361,6 +373,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	struct acpi_gpio_event *event;
 	irq_handler_t handler = NULL;
 	struct gpio_desc *desc;
+	struct gpio_desc *desc_guard __free(free_gpio_desc) = NULL;
 	unsigned int pin;
 	int ret, irq;
 
@@ -370,6 +383,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	handle = ACPI_HANDLE(chip->parent);
 	pin = agpio->pin_table[0];
 
+	if (pin >= chip->ngpio) {
+		dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, out of range\n", pin);
+		return AE_OK;
+	}
+
 	if (pin <= 255) {
 		char ev_name[8];
 		sprintf(ev_name, "_%c%02X",
-- 
2.54.0

