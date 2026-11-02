Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602018;
	b=2Fs1Rx42dsNGawG45TUzx0ODEoAvAaA3m5c5jeEqL8xx1j6j7dCcfA+WtEhmevG4BflC
	 mkXu1BZMn+8lCJJ4GBgTszKs4rVl9kPsKkVXCNY1cKyvf/0V0Mm+Mi9m//x4H8x/4Y1cQ
	 ltE+UQc3d9m9ZWzvL/CieSHRFQjvMpNlwi7o7FnPM4UFQf/Bprj2xILxT4oAJvOK0sJt1
	 tRPDC5i7GHOszXR9HZGfpwuOctBs8y/2R22ioqPB8m0D0sLhRj6qZrC6aouEkbJ6CeLJa
	 ZQRldYo//c9Vw/JGBN6d1TBAWF5GaE2ZFFIfxz1yGabs0Omm5seqgM4IlGt3A92xSpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602018;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+d54rXQIumfUS1Nh4QPlKdXgz/z2AgDR5ARBD6dkc1w=;
	b=JV4wtbvXWlBsgG7w0qEBgc+WPFLTbZJ9rkla4igMc/eND0rEHymIdzEjXVjghy+q/JEe
	 fTJja2U0jHzs41K1z2wwTO7zKIz/81wIxz/KR/ACnEXQ+AaR36Pq2ebWEWCJL0ssa+Wdd
	 JW5M3Z/qCqNzKZf4pLKdG9IOY8agtvgdHrARNdUH3oWARiPoTOdRxPyOoZ84blunkXifr
	 VUYBO9zInc3ebf/v4/QFU5vUn47zpUdcx/e7iBAgiXNxTlAu3Kgd4fa7lPxZynbSrm8U/
	 3A5LQDzgB1TzJ82sX8xEhAgKmpz1W7Od5l3z0CWHggfECG3MVh2VUMbOKwvpfVC4luw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3jvXhhK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552D606A32E;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3jvXhhK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602017;
	b=brVc2HzIOUHtO0H4vj6VVPWM9a6/NlCX2CKAM9Z5FPlbukeVPPPpM643Rlpo20gQeRwe
	 VCv7Qlk4qMWdwxIfOAhG4R5b4oAwIfe9fRgWeHoz1dPwcfnKFBxjc6xu5entTbXEqSECo
	 8QpvQINs7IVFYxsbP7l3F4a7rZjPVyWd8CMC0gpwS+Cr7txsm/s6htZLE06gP/M35G+a2
	 arizs2IHQXYwnQsfJkY2T6JhTwGNA4woFswV79lH9kCiXTU8sI0wu9jb/kd7Ocl9lubaD
	 lF0UmIaB8xjbhRZTb8UYBR25TztMA1k/pwH7/PrQRVjoR0H4uPc7mN5x6m8R7Rr/jcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602017;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+d54rXQIumfUS1Nh4QPlKdXgz/z2AgDR5ARBD6dkc1w=;
	b=IAb0DLqm5No91Ct9E9uTClWyB0VfyMgGV4p6bP28UIeck79JS65q2Q/zVhqVpoEDDigE
	 zb8pqw5/0c8q8St75HytObGChLxHFvbzC4XU6uKzTvzjLhSISxMpV1EhXV1grCGDpxTlI
	 hZZePIUqYSMuY/Adl0Ls2rQjbcd3oZnPVsYK7dcIqlHDqDmxTVmkbr2gB4CmjIvpAAfGq
	 SKTHspGPjFOaupOHf4aYNQvF56dpiL28yqYZC09U+ToR+C6BabD1gHZWlVKrSIv8qrsb6
	 RsGTv8uBYBk5ni3+GUVfn6bHMIlLGNzoDYU2I6jYkr8s6x4EcWm9CVfq5ahdwGVJqwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17A231F0093A;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602017;
	bh=+d54rXQIumfUS1Nh4QPlKdXgz/z2AgDR5ARBD6dkc1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F3jvXhhKIGJvW6QmahuHJVLb2UgOv5cLkqoikOqEHNbXsKW+Am78BPSIHMRMfr255
	 tSsWjaTxaLPjzcte6Pt1pcql0i5dvBgr9biJQxgYm+jUhgvVmeWtaVfix9eL9NbZQN
	 q2VSL0y0NMrSHKS9fF5W3XjgYe5omdoZ4G9kjn0dqlWVBLZRCat0xERVJAmzLsiqix
	 4ZkxFQHfGpPT7lMPfLLLDfwfqnxamJFqA5DqRvuhOJs8qEPo5aleAspcYcrMWPk+go
	 m/dCvwb63unEqshQNWjakXm+9p5l8UQnYVbGHKO9avf9t5fivHFlu/4IZXHr12/Rz1
	 G7ZG1hqsQl0HA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E7DE463AF;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:55 +0800
Subject: [PATCH v13 02/13] gpiolib: regmap: add
 GPIO_REGMAP_QUIRK_SET_AFTER_DIR
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-cv75-gpio-v13-2-4f93114ea204@ambarella.com>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=3590;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=zPPnnWR+Tk9KmOlZqDgVRk/jbQEDkUVlLOB0ZfAU6RY=;
 b=xya+RIxUySmTgAO3/tZXy6E7REjmRT+sAtnS7uMJ6QpmWQGxKruDhiMBwHzsgIKiObXtMfhwm
 f9kKC0STSN7AXis9LtT7LMG1JGwl8oKirZvKg1y5+72/yh1JiS1pH+9
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Some controllers ignore output writes while a line is still an input.
Add a behaviour flag so the output value is written after the direction
change. This is a legacy quirk. New hardware must not use it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c  | 15 +++++++++++++--
 include/linux/gpio/regmap.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..0a44deae3d01 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -33,6 +33,7 @@ struct gpio_regmap {
 	unsigned int reg_dir_out_base;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
+	unsigned long quirks;
 
 #ifdef CONFIG_REGMAP_IRQ
 	int regmap_irq_line;
@@ -271,9 +272,17 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	if (!(gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR))
+		gpio_regmap_set(chip, offset, value);
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	ret = gpio_regmap_set_direction(chip, offset, true);
+	if (ret)
+		return ret;
+
+	if (gpio->quirks & GPIO_REGMAP_QUIRK_SET_AFTER_DIR)
+		gpio_regmap_set(chip, offset, value);
+
+	return 0;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -376,6 +385,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			    config->fixed_direction_output, chip->ngpio);
 	}
 
+	gpio->quirks = config->quirks;
+
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..f9090073c852 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_GPIO_REGMAP_H
 #define _LINUX_GPIO_REGMAP_H
 
+#include <linux/bits.h>
+
 struct device;
 struct fwnode_handle;
 struct gpio_regmap;
@@ -13,6 +15,14 @@ struct regmap;
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+/*
+ * Write the output value after the line is switched to output.
+ * Needed when hardware ignores output writes while the line is an input.
+ * This is a legacy quirk; new hardware must not use it. Direction changes
+ * will glitch.
+ */
+#define GPIO_REGMAP_QUIRK_SET_AFTER_DIR BIT(0)
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
@@ -48,6 +58,7 @@ struct regmap;
  *			(Optional) Bitmap representing the fixed direction of
  *			the GPIO lines. Useful when there are GPIO lines with a
  *			fixed direction mixed together in the same register.
+ * @quirks:		(Optional) Behaviour flags, OR of GPIO_REGMAP_QUIRK_*.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -98,6 +109,9 @@ struct gpio_regmap_config {
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
+	/* Regmap GPIO behaviour flags */
+	unsigned long quirks;
+
 #ifdef CONFIG_REGMAP_IRQ
 	struct regmap_irq_chip *regmap_irq_chip;
 	int regmap_irq_line;

-- 
2.34.1


