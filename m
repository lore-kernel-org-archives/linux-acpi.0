Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695661;
	b=sbNS60xCMjPPnHqVF2R1CSzr4Kjt8TO9TIFGYVjXSaaZasxaGFbNwTYEL57DU4skhxMI
	 W6+uq5kEDbjnJZOnTeUHs7tAT+l0g4Iyqg1vQKbK5kC+u/XTCXODtg7j/+oLmTHt9vfKy
	 LN3DM+LTlIAWsjJZuSPhR6yBXFh1uDxvNV95lFn7ieVaF0BwzivoPV5e+tdQbAb3j2y70
	 sq4+rBdo0MDAuyBCq2Nqzy0hKooB7H+iMKxwPViC/VjHccRimx6TtfFjU58AIvEnO/5Pa
	 EtXSSwJf2kx30BJ+1w83GvmL9YwglTD6dmQ79N6ZFC4mo66v9ofD8T8uck/qmnjXxbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695661;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=c3qK4FwglSng5Fj2jaUKFhFzwkFcNf8BcwxMiOOgqS0=;
	b=I9/W6netPsPPUMdOOD3T5moDsE4qBV1J6uNl2dtpA0D0KeO/aYw3xDhPMfX5gE1DybqE
	 NXcfctMFtp2Ad7OoS6Hqn5x2l8j/3YkT+41a0mBwhid5BpAx+ccDceruQ1U7/f7if5sex
	 6cKcor1CJyiN7YMJ3rrv1hXCYeBXb39Kc0IkggfWkDmI3sTPKrHEugkWVKV2VoIbHoVPN
	 2s8Gsdj+Dn4w+YfZ0FSAJwBO/FC7djA5gENqzoPn0+ueRQ1++DuOOE6FTxPSFpGW0LDlB
	 Z2UMAqUxcyQPQR+hpr5L8XUni2xCQlOS+OWil+HjSHfbnEFuB9XziRC9lTv1X/0dGmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sxSiMFiy;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3F606A329
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 08:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA3F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sxSiMFiy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 571161A1030
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 08:47:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24E576046C;
	Tue,  3 Nov 2026 08:47:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6075510328ED0;
	Tue,  3 Nov 2026 09:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793695651; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=c3qK4FwglSng5Fj2jaUKFhFzwkFcNf8BcwxMiOOgqS0=;
	b=sxSiMFiy7HNZ4xlSURfkDEPt/23DfqwfwlHea7pgOVh25nzrWPgfR0aTtdDtjYbJMfpzL0
	nEhm9q4vRWCX7pq7sGIJanZ6GD3+zbhyz2aa4VbNA/4hOz/zFsrXiRIMyg0x1ldnlT6LiW
	+4F2ggBzhMmaumtNbvL5sGdyXXA2miLWVcS/aFYKJr2W8iONLdcyUpv/LbAOiM9rhhP46a
	RuqZqL3mHKLGZWYglZm7ZkDJncWwz85Jb8xaBi3C/slubjgF9DXGY2jAbgn3H++laWQpHU
	g9Vgz3W1XsfTpNXO+TOYBjP1hJnnTqi4RnehwlKPGvQtJnFCJgx0qX6HSGzClg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH] ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources
Date: Tue,  3 Nov 2026 09:47:18 +0100
Message-ID: <20261103084718.8222-1-paul.cercueil@bootlin.com>
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
 drivers/acpi/acpi_platform.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 80ea7121744d..bae6a2eacd71 100644
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
+		if (clkres->frequency_divisor == 0)
+			return -EINVAL;
+
+		rate = DIV_ROUND_UP(clkres->frequency_numerator * clk_scale[clkres->scale],
+				    clkres->frequency_divisor);
+
+		clk = devm_clk_hw_register_fixed_rate(dev, dev_name(dev), NULL, 0, rate);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		snprintf(name, sizeof(name), "%s-clk%u", dev_name(dev), data->idx++);
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
@@ -217,6 +278,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	else
 		pdevinfo.dma_mask = 0;
 
+	if (IS_ENABLED(CONFIG_COMMON_CLK))
+		acpi_platform_init_clocks(adev);
+
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
-- 
2.47.3

