Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391674;
	b=X2oU9VAMQTdrKTGEMmzoY5wmWUYsLCql2PyIpxfxZY59s1wwfX+a0tcBRvI2pmJCKM5N
	 /iGXCuEFYp8ZwXuICHhkfqc0Wg5miTpRIhQVgu4CsoR5GgXCWL6/97wBhflnETnuqnQJG
	 enhNqS+Y93f2Z/lCmpYJ2t6S45NwXpkZ9JQMPdDA9SYXBWhS4z3/3q8KS9guW/e2KFQa1
	 e4DhH+RNfJ8p2VY4+Yd291081W9BNOOnN134hFR1Um/x8DSQZPNtHCDG5pzeoR/KZJsCO
	 NqSIIxp7Br6QeGv7Y0YZDXZKk/fZ4fk157ej3kiwg/DxygvGGIcnitrqJz5TSLrERXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391674;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=zFxZ30Yd6+cASw+ho8AgTjmy6X4iO+1Xfo3Xj4WmfaA=;
	b=nAErsdFIrZe/XZJs2qAsI0BRMpGfUPK/wT5XYQFxrROxVe7cCnGEjV+nxJBgAzCabyec
	 8Nz68EyU1TzmM09WNyj7Tg5e0iZXTbVR+nwztBrQQkaGcKEm2i7pzSKziYbDZDDiqseAF
	 YA7h87V4Iujh5Ou3w26vhgQ2gZt9WKDu19wQeUs/JBtr47IsbcTLv5aeribI8ALpNDBxJ
	 11v3DasfvcdmD9HqjwjAakAV19Y+xVMlObzgDE4vtnWjnEK+aV3sozqMzxJYW6Oo3tc4L
	 Ap3jAyaJDS3M8MqUlDuUHA3bFweTRrB+n5r7Ffo3sAfHKjxDSND9Y1QO8qO04bXe5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iVe5YcxN;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FD606A321;
	Wed, 11 Nov 2026 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iVe5YcxN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 78FB21A1609;
	Wed, 11 Nov 2026 10:07:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F61B6017E;
	Wed, 11 Nov 2026 10:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D00711BC126B;
	Wed, 11 Nov 2026 11:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794391671; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=zFxZ30Yd6+cASw+ho8AgTjmy6X4iO+1Xfo3Xj4WmfaA=;
	b=iVe5YcxN6iMcNdy7ct5ge10LPW/BDSJLHEzidAyzNx+mVg4ZP0bpAGhYu/2b1yDeGePLHd
	skMnkdvrs8K3lWj+U8df0uJQqbyX/5QxVohWtK/sCCy+5NzpC1Lf21gG7DaePyODqnHLig
	fkVO86dEsndYrFRHVO3hCsIdgI/lDt9b4qzhbs7lBPEAokzzFFSR7SGTKIMKHV6SNINgnN
	5nNcjabsKk1bxgtDZy5f5UNrJps/WmnE+bx5Ykk4Yl3LPEM14fhQDsB7drmHuSH/FIVAUa
	rgqnrYXNvc4GBEMJVNzQm74AoCOBZwHzHx6Q5+yBOEWai/HUW3MyavZDQBrKgA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2] ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources
Date: Wed, 11 Nov 2026 11:07:36 +0100
Message-ID: <20261111100736.98364-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

ACPI 6.5 introduced a clock input resource descriptor, which allows to
specify in the ACPI tables what clocks are connected to a given device.

This patch adds support for the most basic clock resource, which is the
one that represents a fixed clock. The new code will then create a
clk_hw for each fixed clock resource, which is then made available to
the device drivers, that can obtain it through a regular call to
clk_get(NULL).

Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

Related:
https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercueil@bootlin.com/T/

v2:
- Use the calculated clock name in devm_clk_hw_register_fixed_rate()
  instead of the device name
- Make sure clkres->scale is <= 2. The field is 2 bits but the value
  clkres->scale == 3 is not defined in the spec.
- Compute the fraction numerator using 64-bit math, to make sure it
  won't overflow on 32-bit systems.
- Initialize clocks only when the device_type matches
  ACPI_BUS_TYPE_DEVICE.
- Use a shorter name for clocks as the hard limit is 16 characters
  including the terminator.
---
 drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 80ea7121744d..71322cdcf0dd 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -10,17 +10,27 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 
 #include "internal.h"
 
+struct acpi_clk_data {
+	struct device *dev;
+	unsigned int idx;
+};
+
 /* Exclude devices that have no _CRS resources provided */
 #define ACPI_ALLOW_WO_RESOURCES		BIT(0)
 
@@ -130,6 +140,57 @@ static unsigned int acpi_platform_resource_count(struct acpi_resource *ares, voi
 	return AE_CTRL_TERMINATE;
 }
 
+static int acpi_add_fixed_clock(struct acpi_resource *res, void *d)
+{
+	static const unsigned long clk_scale[] = { 1, HZ_PER_KHZ, HZ_PER_MHZ };
+	struct acpi_resource_clock_input *clkres;
+	struct acpi_clk_data *data = d;
+	struct device *dev = data->dev;
+	struct clk_hw *clk;
+	unsigned long rate;
+	char name[64];
+	int err;
+
+	if (res->type == ACPI_RESOURCE_TYPE_CLOCK_INPUT) {
+		clkres = &res->data.clock_input;
+
+		if (clkres->mode) {
+			dev_warn(dev, "Only fixed rate clocks supported for now.\n");
+			return 1; /* keep going */
+		}
+
+		if (clkres->frequency_divisor == 0 || clkres->scale > 2)
+			return -EINVAL;
+
+		rate = DIV_ROUND_UP_ULL((u64)clkres->frequency_numerator * clk_scale[clkres->scale],
+					clkres->frequency_divisor);
+
+		snprintf(name, sizeof(name), "%s-%u", dev_name(dev), data->idx++);
+
+		clk = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		err = devm_clk_hw_register_clkdev(dev, clk, name, dev_name(dev));
+		if (err)
+			return err;
+	}
+
+	return 1;
+}
+
+static void acpi_platform_init_clocks(struct acpi_device *adev)
+{
+	struct device *dev = &adev->dev;
+	struct acpi_clk_data data = { .dev = dev };
+	LIST_HEAD(list);
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &list, acpi_add_fixed_clock, &data);
+	if (ret < 0)
+		dev_err(dev, "Failed to add clock resources: %d\n", ret);
+}
+
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -196,6 +257,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 			}
 			acpi_dev_free_resource_list(&resource_list);
 		}
+
+		if (IS_ENABLED(CONFIG_COMMON_CLK))
+			acpi_platform_init_clocks(adev);
 	}
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
-- 
2.47.3

