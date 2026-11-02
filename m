Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602019;
	b=v/dWU6hu43gVJ920WYMD2/qXEET7fqQIEAj2BZIm4/mfWW7S+HIJobCankeIp15+1xX7
	 Ej6lb1ClXcSq6siSNA/Ax8sxXzO02RWSx5CL8PaWrxawPkGgOUAahqCQYEsv2zyfKZJvf
	 eDgO67wgu0fS7TSOhGo5FFvLiZaVHRoigN97UYvqe4n5BuU73WGUvIZPiGr8y1wBTtit+
	 fuS8P0fRj2Yr5Kod/dfp9OEEx2AM7MsJw8D4ICWivyTIFQL0GXwstCm7f5R//2W04f4Tj
	 JstnWRbuA5sc1ds+WK8hYRNu4D9Z3DZnHiFBdXART4w3FTgNxt2mLKJA2Z6GppYHqHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602019;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+BV2XxKdkCDmCph23X+rU19KYGP6JPt3AiobjVr4wX4=;
	b=3SgNqN3yGSvjl99UA7il3LiXnJ4ECuHYCdWOiZLYhjTmi7BFm3U4+f0VSNEGcOlHu0mM
	 AvSQXJo5mr7HuX+qTSasrINPUWvoUYk3MfWOaAQFNzJ0GWYywfY6VzUqaT/CgZsdKZpH4
	 uypTn5XjvWlkvOi7o5dII5MzHnOeO8dDewNF79CLK/XJBKQu0HWDqMtKz+YsplFaks1Ja
	 G5mZSWphYeRR9xV3WUH+eschNZ6DsCLSAlbXJBKJv5UDJofwNJN68jrqZPf0ytvKOVrKK
	 44XdC7wD4dWIeOYZ+YCvD5VJdMZBIbJNPlZUZiAkgkuVWenUP2PfJ2XZ3tuXsS/Dw3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8iew9NP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF4606A33C;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8iew9NP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602018;
	b=3RxTJ2VX+z8py4CNW90D27H7JqInx6Ea9G2tb3d4MnwNWRMfMdjmdr/AjOVZ9K9/DctM
	 o8CONTL8zKhGVXVni7p+SmMbjYncEDnCkGOMlLfoyRbkIxrO5Avw6YsRPMeUftE9cFXwc
	 WEra8FujAqd2Tlc5QO368wwcKhR1BgqcoYROGLGTGOQy/4T+8JrKOQeLATyVZGUDZXo+S
	 64eeqZ0X1UxYTPSUfBHoNLXJoDVoRJn29NjZZXrvVJSrveLU6LgRkMPxAPo4uzYEtlnhr
	 4iRs9lOccDCODrn7pOHJFuHPBuwyNG8g/9Z3fUPOfGtKtt3wnnRIQnpxljd1LDo6Xgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602018;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+BV2XxKdkCDmCph23X+rU19KYGP6JPt3AiobjVr4wX4=;
	b=mdv6G2YYgVvzAJbp8yvSTGvBmuPPXTSa4YipVCXvn8BIoIrB9fgYZd2f5tJZCceaP5IN
	 Eey7Mq4bA+gwA1N+5F9XGnPVo7uTNoGgOUuyoigsL7UYD3Zovsnl8aEnh0avoorv4rFwp
	 lM8XNLjPj0C/p/PRyXN6BdKj/l1rKZymSxr2SkmmzXctBymbIzxabm3exI4nwYujdVS91
	 vrBplCzEsZvvCm31QBaARuQ1SXzsuSvZHFZ8vaW+nnLKF5QrWsu9STvvO/B6+A5Xb5H8U
	 SL6/+FlzO/3+kqdfYtgSDGgIzleGCB0DuOWgB9DiGd6GPOs9tU0CUGdSasGhHfDSDog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A8AE1F00A18;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602018;
	bh=+BV2XxKdkCDmCph23X+rU19KYGP6JPt3AiobjVr4wX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=B8iew9NP6e6kSU22Tl+/Je4p93zhfU4ofto6F61YxXzkvrOrVhj1hfjwcoqyG+tBJ
	 IMYHexRmvAYK9gHQmfB/CEcPZh+GG1USTA++ujbVJka+KERmxBdaVWxN018sT3lg+m
	 KnFl8y3ohMNzlipLb+roleLUdE/NoplhUjjImp1WfMIA4fUgA04JI+HpYiNgRvuG9W
	 68WeVsIhtEM7lFFA7PRvJo2BlUM6uRJNsNslq+G01fynQmW4/cvyYhrasVaAe/q2xf
	 sQXsYr6gEvYjnxOyDu4m7d0wMyN4DTGZqCmpxSdBCoNZa+5gZaEQHKi33kMvIXNTj7
	 44VKfKTpNksJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C551E463BF;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:59 +0800
Subject: [PATCH v13 06/13] gpio: pl061: use cleanup helpers for locks
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
Message-Id: <20261102-cv75-gpio-v13-6-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=3548;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=e5A/nNp2mkLE1rfoTrTjsYU6GxM1J3kjTE+rcuksRMg=;
 b=wPNgd0fe8o38ZAsarpWDDfZJR4ao5PLRuIf619esiAtTbQC6wvnM9VBgE+Gel7/f7ZHVpTEU+
 9Pob6cfsnH3AQfs1whP8fipjzwZcI2RNJqMj5yLw5GwpKXGi996yAIL
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Convert raw_spinlock critical sections to guard()() from cleanup.h.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index e0ac8335bae4..a232b63fbc0b 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -10,6 +10,7 @@
  */
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -105,11 +106,10 @@ static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
+
 	regmap_clear_bits(pl061->regmap, GPIODIR, BIT(offset));
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -119,9 +119,9 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	unsigned int mask = BIT(offset);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
+
 	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
 			   BIT(offset), value);
 	regmap_set_bits(pl061->regmap, GPIODIR, mask);
@@ -132,7 +132,6 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 	 */
 	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
 			   BIT(offset), value);
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
 }
@@ -162,7 +161,6 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	unsigned int gpioiev = 0;
 	unsigned int gpioibe = 0;
 	unsigned int gpiois = 0;
-	unsigned long flags;
 
 	if (offset < 0 || offset >= PL061_GPIO_NR)
 		return -EINVAL;
@@ -175,8 +173,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		return -EINVAL;
 	}
 
-
-	raw_spin_lock_irqsave(&pl061->lock, flags);
+	guard(raw_spinlock_irqsave)(&pl061->lock);
 
 	regmap_read(pl061->regmap, GPIOIEV, &gpioiev);
 	regmap_read(pl061->regmap, GPIOIS, &gpiois);
@@ -236,8 +233,6 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	regmap_write(pl061->regmap, GPIOIBE, gpioibe);
 	regmap_write(pl061->regmap, GPIOIEV, gpioiev);
 
-	raw_spin_unlock_irqrestore(&pl061->lock, flags);
-
 	return 0;
 }
 
@@ -266,9 +261,8 @@ static void pl061_irq_mask(struct irq_data *d)
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 
-	raw_spin_lock(&pl061->lock);
-	regmap_clear_bits(pl061->regmap, GPIOIE, mask);
-	raw_spin_unlock(&pl061->lock);
+	scoped_guard(raw_spinlock, &pl061->lock)
+		regmap_clear_bits(pl061->regmap, GPIOIE, mask);
 
 	gpiochip_disable_irq(gc, d->hwirq);
 }
@@ -281,9 +275,8 @@ static void pl061_irq_unmask(struct irq_data *d)
 
 	gpiochip_enable_irq(gc, d->hwirq);
 
-	raw_spin_lock(&pl061->lock);
-	regmap_set_bits(pl061->regmap, GPIOIE, mask);
-	raw_spin_unlock(&pl061->lock);
+	scoped_guard(raw_spinlock, &pl061->lock)
+		regmap_set_bits(pl061->regmap, GPIOIE, mask);
 }
 
 /**

-- 
2.34.1


