Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DB7E0FF;
	Thu,  1 Oct 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868593; cv=none; b=P9g65B70bXPl31pRrnfgU4DIMHKiMfzDvpCQir7zM0T1W3emH88BeDD7zKcoBmCYgEJjoM924iloV2VEuXgEO5YNdKCtC1rszx4HVI+Cw/y2FX0KgVcYK5TL64lJGLgprUxu7vkSKdbLU3fAZ7RY2XgSru6VfSnDVldEdS42NPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868593; c=relaxed/simple;
	bh=pdcQFYrCXKAfJZqdFTT/YCCgzXze87XHZwRyjcsbWAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u57QmE7WdqLdyznW27Mzrdcv5Fz+0dHqu0fXuMabWHlaTLuPE5LZ7eCa5bSrWOViW9v0oAgVer5ErslupSsz9ugRmm4wB5oPdItbIir6esoFfbuOkrnty1GhaO1DzOZZuKHplSgcAcBPkYJfPDGKJXEhORHKoom/hRi5JjpTxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 1D4564282CF;
	Thu,  1 Oct 2026 17:24:08 +0200 (CEST)
Received: from albans-vm.. (unknown [213.61.137.106])
	(Authenticated sender: albeu@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 6C59B13F8A9;
	Thu,  1 Oct 2026 17:23:51 +0200 (CEST)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alban Bedel <alban.bedel@lht.dlh.de>
Subject: [PATCH] gpiolib: acpi: Fix GPIO lookup using relative path
Date: Thu,  1 Oct 2026 17:23:43 +0200
Message-Id: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI allow to use relative path in resources, pass the device handle
to acpi_get_gpiod() to allow resolving such path.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
---
 drivers/gpio/gpiolib-acpi-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 220f0ac4204ef..16f0196ad0742 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -116,7 +116,8 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
 
 /**
  * acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usable with GPIO API
- * @path:	ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
+ * @parent:	parent ACPI handle to resolve relative path
+ * @path:	ACPI GPIO controller path name, (e.g. "\\_SB.GPO1" or "^GP01")
  * @pin:	ACPI GPIO pin number (0-based, controller-relative)
  *
  * Returns:
@@ -128,12 +129,13 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
  * controller does not have GPIO chip registered at the moment. This is to
  * support probe deferral.
  */
-static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
+static struct gpio_desc *acpi_get_gpiod(acpi_handle parent,
+					char *path, unsigned int pin)
 {
 	acpi_handle handle;
 	acpi_status status;
 
-	status = acpi_get_handle(NULL, path, &handle);
+	status = acpi_get_handle(parent, path, &handle);
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
@@ -733,7 +735,8 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		if (info->quirks & ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER)
 			desc = gpio_to_desc(agpio->pin_table[pin_index]);
 		else
-			desc = acpi_get_gpiod(agpio->resource_source.string_ptr,
+			desc = acpi_get_gpiod(acpi_device_handle(info->adev),
+					      agpio->resource_source.string_ptr,
 					      agpio->pin_table[pin_index]);
 		lookup->desc = desc;
 		info->pin_config = agpio->pin_config;
-- 
2.39.5

