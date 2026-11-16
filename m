Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837160;
	b=jf/ebBdeyi+dRSVpQdpXZYViABojILiDdIsSpMiPM4LQ/iET5XJUn5AEV0j4bmqbNFch
	 3WL2AQN5KCvwv2oDM2TFmORXZzxEvmOYQDE+4FRaIlrdTVemQi48GkFmBO8QjFNIKB/k4
	 7ho5U8jCcyl7Py2+4sT3z7tPbvEURh1ORM4YS1mSITug1i8LKMMj9ahsb/VWwc2B12h3G
	 F18Kd0yAbMUypMT42TVKAjExMcwBLnH87TJFZl2DPSOiDcyOLrD89CRyazqqPjZDFTy/5
	 55iA5RrLaPHbf43MtWj2thvqXDuwvfhkUKwBvJLPsEQtECk3P+nj3X4xkzWmn0OBpjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837160;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=10tSiQq9qCU62IQsmnIT5keO6pddi/erCeijrEXvMUI=;
	b=IsdSCnTBaQUwMQ1jlJ33XJ4WIXOcqzF12PZpiHGhpvpihmTUrUOMo4wz6UwARJxB4p+8
	 i9ecbSi5X/bMwLyAxQ3CEpqPsTMtMc0GFtw6+V3oGF3B2zi/gtQ1wWjeG6QZpYkvYGg+z
	 wQElso/Afg+E1B/bGJ1uvZ1TL5pMytjWhr0lcbQlTkxWUvZ1afK4b318wZm/jdiqAfL/u
	 PCJ3FhLvUv1wxDUlGsFoBx2EVZ8bQR38+Ac3AJtr3cG5YoVUR06Lqamhve5kG+aP4C0Ly
	 zlh9MN3eQqU7HC11IdgvpS7HEQcKHfzxm1CNh6aIQGg9jYOzYOTyQxqN6Au0Ij3/4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OLlXulJj;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08D606A335
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E08D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OLlXulJj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F19E1A168E
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:52:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 056976023F;
	Mon, 16 Nov 2026 13:52:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDA3011BC183B;
	Mon, 16 Nov 2026 14:52:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794837158; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=10tSiQq9qCU62IQsmnIT5keO6pddi/erCeijrEXvMUI=;
	b=OLlXulJju5sf2hao84stt3rkKFJvqK95+EnO56KnPj2rNCAJZbDrz8dJRMcR5dD+OJxtwK
	IHT0DgrX6R77Z/1uodoHDoinyx3ZlpqbY2rqS+kx3oR1BM4ZtwACOriuJwlY7U/rambTGA
	8DcPfFvTFu/cIIrvK0gWMBmdie0Hq+j380SAkFwKSZUIx5LuWdeyFEAOpDYQnPi3gsucvu
	1kcuDgKAXO66QcX+cNp/JOJrv+d0673nutQcuZMiDeZ8QXkTLmPMJN9k5DJXLBWmKR/Fcd
	pzO4+6uxAys6CSEmg0q45kmxTUCFtB6ogB0XbLCEIEkHOPwIn6iFf9+Tx6X0aA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 2/2] ACPI: platform: Add basic support for ACPI 6.5 fixed clock resources
Date: Mon, 16 Nov 2026 14:52:17 +0100
Message-ID: <20261116135217.37038-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116135217.37038-1-paul.cercueil@bootlin.com>
References: <20261116135217.37038-1-paul.cercueil@bootlin.com>
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

