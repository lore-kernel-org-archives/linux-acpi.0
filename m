Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E63E1231
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090861; cv=none; b=KTzfA86ziUShQlbDl94ZD6ic6BAJL8BwT9GQB7DVI4VWzPtioG/t7G6f46ZWGXftlR9d15OKnFdhAZyCj6iWu7kjkNpEhRMfTe25N2PTj4WU0ZmY3t/pz9VTJBZWCnEXsJBukeYrsrMevyugBlvghZVaxWaDKDX0bphVy/Nxcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090861; c=relaxed/simple;
	bh=6jCkAsjud1Zew6Eupayu3eGAx57fbcfqT17ig7jDJGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngK8PtAHXrO9cMud1gd3w6QBFDalSG1rg5kWYpB1X3bvkujABHFN0OIiQFNUDiHMEyg0IrKozPs6ouqcqdMeDM/QaByqACIaIyi4gmhUBBaKJtZADxfGY4vFOhkws3jMFHswDQ/MH9a/wjetIwbDarOE8um/77RWYglVzLKYD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTSk2XB/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTSk2XB/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48909558b3aso20932325e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090850; x=1779695650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5wcBSnBAu4P8z9YIJvNxTD5MJsyGPmP5qLZmGh8Sm4=;
        b=RTSk2XB/vaONKiSbrM2zaYxrumw6CiWDS9e/1XasylTFHSfO+luANnkW+eKb9fJTMO
         ROPqp1iHy/mzeV7tjE9P6sfxjAcXe98YBSPdDIl3srkL/VwCcnaJszdkMlJYsBdmOtBr
         dCGu8q1lQG86VLgHxv1zCT6N/YhWfSk+oWkGNjWQPt2O3ajlu/BLO2sHin9rJ0TJxYI3
         8obA28yblKjpIKNCBJuKplGTHhSaSHnmPADZA3eW+4/PO4tcURd8sITFHA9uj3zxWBfU
         /Xl5M1MMjhznho8VdZX9PiY7mmRTPTSuGzynWP9J2LEQUA3CqPo0XFSNYtkXk4V/fTAq
         2ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090850; x=1779695650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5wcBSnBAu4P8z9YIJvNxTD5MJsyGPmP5qLZmGh8Sm4=;
        b=Xd/nujctlesWNgRqw51iiRAigU8ZmuZ34ueTITQe7qklyB478htXKpKEGb25gZ5lDA
         LGz2HSPeUSLKPAvJBrgLaVuD8HToa/lEau8+zIvXb34umimzvmvXJj9Fue98l2zoR4Yq
         EGqcf16opaYSOC6awJ089EXy4qiEOngpTSWNLzbCPePao/6yo8O6FDZiViOdOlWxc+mc
         le8OqbGJRZDU1iZIOr2T6MKSguwlUQY8RyC3Ry3rczO2Svv69AN3GnsPuzCrOWMk7GpQ
         TI4FXEem+RRkCpd8a+29C9QWrsyo3wHTd7Fo6GtH8NJEz1WG7p2CNPYCsqCIYEUYpo8R
         whZg==
X-Forwarded-Encrypted: i=1; AFNElJ9l2Tx0mudmnu+FieCtZivXXfBhQ/VJ1ziVC3YPp8orTBAuwRrzMHDdKHDWdeHJHIuL0eae7KMt34jh@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLr0nruoLM3beSXyXcdyPtPA3z3UXKjEKH8rmmgmVULlESf8A
	egm38FUznCHcWrv1f/s5InCBllQfHwrCCjlSGJGGks/oaUQ7Szm9H+Px
X-Gm-Gg: Acq92OFL6AYrhvvyQc0TYlD/r0Kz37Pa/QPpbckKKL+r7xbeM1Yw7SBtq+Zw8obDlyh
	EYvguxqSLqRNaQfQ50ggJYFIehbh0mFp5hwBLyWmMH5V5oywr1TGB8BI5UbepbGQZTPlE38YOCp
	YlsNGjmkpuk1Gyv80ICdcU0BbfJq/mbOA9uzgHepcNpZpq87YZuDKTjpJ88FDFa10BDEA/fph0J
	9Alc3ozvgcvkYFiSs3HWXVoM0B7GVYKBqFuA222BOntMHN0pvhEUsFPwufxe5/ce+flWs8ggCc0
	xKS6Cewo64+vBPQUvukGB2e0u4yeRuoFMW5fAydBhYWskXixfqXrvpPcpD3z6sBVbddLuET1/gd
	aat5nP7d+qCI4xQZRiq9ntURbwn5xSLAQIpEn6b4geS11orSCuWCB3yQ5JUiSIlRkomAwlCARax
	O+cRYP+7C3LDDCvBU=
X-Received: by 2002:a05:600c:528c:b0:48f:d612:3c6e with SMTP id 5b1f17b1804b1-48fe60de745mr205788715e9.2.1779090850135;
        Mon, 18 May 2026 00:54:10 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:09 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 07/12] gpiolib: acpi: Add dedicated Operation Region module
Date: Mon, 18 May 2026 09:53:52 +0200
Message-ID: <20260518075357.112584-8-mscardovi95@gmail.com>
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
 drivers/gpio/Makefile                |   2 +-
 drivers/gpio/gpiolib-acpi-opregion.c | 175 +++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpiolib-acpi-opregion.c

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b267598b517d..1a416305465b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 obj-$(CONFIG_GPIO_CDEV)		+= gpiolib-cdev.o
 obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
-gpiolib-acpi-y			:= gpiolib-acpi-core.o gpiolib-acpi-quirks.o
+gpiolib-acpi-y			:= gpiolib-acpi-core.o gpiolib-acpi-quirks.o gpiolib-acpi-opregion.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-swnode.o
 obj-$(CONFIG_GPIO_SHARED)	+= gpiolib-shared.o
 
diff --git a/drivers/gpio/gpiolib-acpi-opregion.c b/drivers/gpio/gpiolib-acpi-opregion.c
new file mode 100644
index 000000000000..77b1ee32ddce
--- /dev/null
+++ b/drivers/gpio/gpiolib-acpi-opregion.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Operation Region helper for GPIO API
+ *
+ * Copyright (C) 2026, Intel Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+#include "gpiolib.h"
+#include "gpiolib-acpi.h"
+
+static acpi_status
+acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
+			    u32 bits, u64 *value, void *handler_context,
+			    void *region_context)
+{
+	struct acpi_gpio_chip *achip = region_context;
+	struct gpio_chip *chip = achip->chip;
+	struct acpi_resource_gpio *agpio;
+	struct acpi_resource *ares;
+	u16 pin_index = address;
+	acpi_status status;
+	int length;
+	int i;
+
+	status = acpi_buffer_to_resource(achip->conn_info.connection,
+					 achip->conn_info.length, &ares);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	if (WARN_ON(ares->type != ACPI_RESOURCE_TYPE_GPIO)) {
+		ACPI_FREE(ares);
+		return AE_BAD_PARAMETER;
+	}
+
+	agpio = &ares->data.gpio;
+
+	if (WARN_ON(agpio->io_restriction == ACPI_IO_RESTRICT_INPUT &&
+	    function == ACPI_WRITE)) {
+		ACPI_FREE(ares);
+		return AE_BAD_PARAMETER;
+	}
+
+	if (pin_index >= agpio->pin_table_length) {
+		ACPI_FREE(ares);
+		return AE_BAD_PARAMETER;
+	}
+
+	length = min(agpio->pin_table_length, pin_index + bits);
+	for (i = pin_index; i < length; ++i) {
+		unsigned int pin = agpio->pin_table[i];
+		struct acpi_gpio_connection *conn;
+		struct gpio_desc *desc;
+		u16 word, shift;
+		bool found;
+
+		mutex_lock(&achip->conn_lock);
+
+		found = false;
+		list_for_each_entry(conn, &achip->conns, node) {
+			if (conn->pin == pin) {
+				found = true;
+				desc = conn->desc;
+				break;
+			}
+		}
+
+		/*
+		 * The same GPIO can be shared between operation region and
+		 * event but only if the access here is ACPI_READ. In that
+		 * case we "borrow" the event GPIO instead.
+		 */
+		if (!found && agpio->shareable == ACPI_SHARED &&
+		     function == ACPI_READ) {
+			struct acpi_gpio_event *event;
+
+			list_for_each_entry(event, &achip->events, node) {
+				if (event->pin == pin) {
+					desc = event->desc;
+					found = true;
+					break;
+				}
+			}
+		}
+
+		if (!found) {
+			desc = acpi_request_own_gpiod(chip, agpio, i, "ACPI:OpRegion");
+			if (IS_ERR(desc)) {
+				mutex_unlock(&achip->conn_lock);
+				status = AE_ERROR;
+				goto out;
+			}
+
+			conn = kzalloc_obj(*conn);
+			if (!conn) {
+				gpiochip_free_own_desc(desc);
+				mutex_unlock(&achip->conn_lock);
+				status = AE_NO_MEMORY;
+				goto out;
+			}
+
+			conn->pin = pin;
+			conn->desc = desc;
+			list_add_tail(&conn->node, &achip->conns);
+		}
+
+		mutex_unlock(&achip->conn_lock);
+
+		/*
+		 * For the cases when OperationRegion() consists of more than
+		 * 64 bits calculate the word and bit shift to use that one to
+		 * access the value.
+		 */
+		word = i / 64;
+		shift = i % 64;
+
+		if (function == ACPI_WRITE) {
+			gpiod_set_raw_value_cansleep(desc, value[word] & BIT_ULL(shift));
+		} else {
+			if (gpiod_get_raw_value_cansleep(desc))
+				value[word] |= BIT_ULL(shift);
+			else
+				value[word] &= ~BIT_ULL(shift);
+		}
+	}
+
+out:
+	ACPI_FREE(ares);
+	return status;
+}
+
+void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
+{
+	struct gpio_chip *chip = achip->chip;
+	acpi_handle handle = ACPI_HANDLE(chip->parent);
+	acpi_status status;
+
+	INIT_LIST_HEAD(&achip->conns);
+	mutex_init(&achip->conn_lock);
+
+	status = acpi_install_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
+						    acpi_gpio_adr_space_handler,
+						    NULL, achip);
+	if (ACPI_FAILURE(status))
+		dev_err(chip->parent,
+			"Failed to install GPIO OpRegion handler\n");
+}
+
+void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
+{
+	struct gpio_chip *chip = achip->chip;
+	acpi_handle handle = ACPI_HANDLE(chip->parent);
+	struct acpi_gpio_connection *conn, *tmp;
+	acpi_status status;
+
+	status = acpi_remove_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
+						   acpi_gpio_adr_space_handler);
+	if (ACPI_FAILURE(status)) {
+		dev_err(chip->parent,
+			"Failed to remove GPIO OpRegion handler\n");
+	}
+
+	list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) {
+		gpiochip_free_own_desc(conn->desc);
+		list_del(&conn->node);
+		kfree(conn);
+	}
+}
-- 
2.54.0

