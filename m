Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191033;
	b=tTsJ0j23BjVQB3YEaCAj1XolyVv9kWxnAcekA6kwlNPIHYYMVfE8gx0CblrR6CsDded9
	 T2siS5smoT5gk37styK26UZCdYdH+lN9BpO5cik+3496aRwSpW9YzOrI65W7RftS4mXl6
	 74ULDOGBEOo3HDEvIAxCC3krUYEKO1ZJUZGzsp3fjOVeeQbY0Qyo6a1DoCUKtzQH2RgKx
	 v1KnYlrcFy0iRCVycd2jyeTGy3vXXmwfzOoNAez/jd18Ig2B47e07VbsxcMINvslY6aBv
	 Fm9NAZev9IWJ30BQ7iY0cBxVbtYL1iQyznOCmb9+sULwwvNTM2JrWV6NUgly/3Fc7Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191033;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=D2u30klZAU8HgL1857DedX1zI7Ifou+LyV4dyCzH2g8=;
	b=D0S2UoRNiyZcCIIzYQcXjaan7NLqMV0GsNZnE6oTMw55nhah7QGd9na9kLfnob0IC4P2
	 E+kc8NCp2CZqU/vD5Tdoa1uZuXmBAMfcR4HCmYD/QXCjCuVD1FPZu8FCc17JswEruVUNY
	 sPTbjbDeHM7gnlp4u+gNGk/yrzuaCCgmuQNQYMPG4oJJmjACcQ4OUQBkKE39xuEbt77kf
	 nZhrt1PiHBhUM/2y4IB/ikcSf8S+A/XYkQJjMuFrQtfAVbsGJ5AtQU9e6ViWmxntBXSK0
	 CK6oDKbcASabhhLRMOuh9oXisWgyOI44kXnezLd7VcoDWx97sIkNMiOi8cWqrvtqVTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KZ8+kX6p;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40657606A32A;
	Fri, 20 Nov 2026 16:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40657606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KZ8+kX6p
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB1B0C62222;
	Fri, 20 Nov 2026 16:10:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3E88601B9;
	Fri, 20 Nov 2026 16:10:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A36911BC0422;
	Fri, 20 Nov 2026 17:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795191031; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=D2u30klZAU8HgL1857DedX1zI7Ifou+LyV4dyCzH2g8=;
	b=KZ8+kX6pqXruJjuw3ZP88IX6yu+tO/hgCfGlE0qTs8IBTDwx8GNqYHwH8C/Xw/FDd2US5m
	QuTpXt3PwJR1tZUcsD5QTL3+e/HyWe/05QTl78LjKkc3HdQZ4lIWbWR7WOzta4kZq7MKG8
	V7Frds0oOWrSh9QLlPH6UFwUxotqqElZpOpKgH4bC96ee1gz5rCxaD+a23tKXnLTy1s6oZ
	C1E9iP6WMvk2iDcM3NKP6uI/OB+c19YJWIDHgKtRBue6Qt4FcBDUUpUTd68WNLpMx+aQN0
	H3c/h8j7zf6nnhUBtBuZ/69F0hFxeZ/1z7RHs2vEY1NvHyPx3Ajt0OY0QqWaoQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 1/1] ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources
Date: Fri, 20 Nov 2026 17:10:20 +0100
Message-ID: <20261120161020.297735-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120161020.297735-1-paul.cercueil@bootlin.com>
References: <20261120161020.297735-1-paul.cercueil@bootlin.com>
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

v5: Register fixed clock as "<ACPI_ID>-clkX" because we need a
    system-wide identifier there, and we don't have the 16-characters
    limit there.
    Register the first clock to clkdev without a name, so that
    clk_get(NULL) will obtain it.
    Register every other clock for that ACPI device with a "acpi-clkX"
    name.

v4: Change clock names to "acpi-clkX", because ACPI devices names can be
    up to 17 characters long, and our clock name must be 16 characters
    max.

v3: No change

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
 drivers/acpi/acpi_platform.c | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 80ea7121744d..b4f2ccf3e51f 100644
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
 
@@ -130,6 +140,68 @@ static unsigned int acpi_platform_resource_count(struct acpi_resource *ares, voi
 	return AE_CTRL_TERMINATE;
 }
 
+static int acpi_add_fixed_clock(struct acpi_resource *res, void *d)
+{
+	static const unsigned long clk_scale[] = { 1, HZ_PER_KHZ, HZ_PER_MHZ };
+	struct acpi_resource_clock_input *clkres;
+	struct acpi_clk_data *data = d;
+	struct device *dev = data->dev;
+	const char *name = NULL;
+	struct clk_hw *clk;
+	unsigned long rate;
+	unsigned int idx;
+	char buf[64];
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
+		idx = data->idx++;
+
+		/* When registering a clk_hw the name must be unique across all devs */
+		snprintf(buf, sizeof(buf), "%s-clk%u", dev_name(dev), idx);
+
+		clk = devm_clk_hw_register_fixed_rate(dev, buf, NULL, 0, rate);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		if (idx > 0) {
+			/* When registering a clkdev the name must be <= 16 characters */
+			snprintf(buf, sizeof(buf), "acpi-clk%u", idx);
+			name = buf;
+		}
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
@@ -196,6 +268,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
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

