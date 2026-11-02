Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602020;
	b=ab/+vqYLJQuVvE6yLaGMy0eGDBGz+CUoowFgEXgMkb/XJe0N2jCYHtkavkObRBQHTz6N
	 GKZVj90LAgrzLZIenvQjuPoxSjyrToVLKG17U5NrGmrP89xr83YZzKUIJrXpAYk6h5ct1
	 vuy+tvikWqZaj3tC/Sogaqd1ZfoRRr0uAUCJuGXhb5IWSrBN7ZrlcJvCxUcs7a4HZh6bg
	 DU7MHXEKZ9hy3YxVT4VMa45wF1B6onMPGOe8BLJJF8CPfYblG0WZwfA4XKAxe083/moG1
	 dVUKvhYO0D3vDB2ZBk+YCSmUJhwlNCZ0QFxlj43XB/o5xffiqDWL95wNbGtajkpPGSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KSuvzuDS+Q2G7GKYSoWi/SBDgthEqC97t7ChpZKJHPA=;
	b=UeP3ExEAzn+VU+Fz6AXWFjMB/Iw5J4KyDncY0cRtAt6p2yt16a6sWFBFFU/QpyGAAFT7
	 CfY2cw0f8sN9VcV5pVgiBf5OtNM9ZAmOdtf+/lsO/wMBZpjSggqJ+XDeOFtjqCCnSM6LK
	 kXxDvprf1v1yagk4llUSYeNMeodBD1KDQfuTEJzGEak6pqcNfzIEY15BHfSIMWFV3ynLv
	 Pg2pYGjsAETxJuqEPBkkGm2BRi8ATEQvnnEhTjdix6IU9ZjTxusA2nIZzOl6qHwvD/xUn
	 3sq5TEA6M5QICIY3Eq7E6z3FFr3kTZ+1kMlh2REwSw/BLlaO7UqRGSLHhLwjpIeI9hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqaSH5Ta;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01C60A2617;
	Mon,  2 Nov 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqaSH5Ta
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602019;
	b=oBbSksdhnLAd35iCHSrasskRA/kbUa8ScO5+20JdbYibs9a1LW+ZSsgjk0alykmX/iAS
	 XvR8YPmPReIc87iG1yrDovmA14rPfZupqvahnV5bH8b2uOGtg5W4R508zejUSAHB3bSJK
	 jtSf9/NGzgTT5tylIFwOSidDc8mSSDd+RShJUBsYohhAc/O1mWYPQJsb/DR1aZA4TeEUr
	 YYUSWtqTUcr3Zc2rtGxvV5Hf7rblpubvlOBqn0/4X+QQNZeqxjo6GEMv3XnaX+7a2HTrl
	 7sCdKU+IjhB0szTjYdPruHriVSLJUTyVIxWtvGX9zjL3vTXYFi03qML8xaAAnZrvEOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KSuvzuDS+Q2G7GKYSoWi/SBDgthEqC97t7ChpZKJHPA=;
	b=DXkUAGwIUzhu3EMe2zV4LjPS4TEqSOD4H4nKroKltR9BGIfHp9SBrnwhQtMKUysM2n9r
	 a75AeMFo7u0fNFRl3ljzQKQtNV/RWIScXZzXb1CzjlaRdNMDLXIZ8+HF1yQHo8cPpi57m
	 3XHpkbWO0PO6OoZ5G1dR5y6LuTvWnBcU5OEZIjIWkcxXoXGdebrVktJ4QfaSgkxfdY9Ub
	 jhAbVai7rcNGLJ0JUYxRv7QIYGnPMuVwCGWDG7+c6eUekhCLXI61DEWz6Ro0KY5ckkHJM
	 fE4YDnYah3Tek9X024EOaZU5fpz2aThplmHy43rMdahO5HT+7FiiPmqS0I1RxdB4aPg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 278F11F000C1;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602019;
	bh=KSuvzuDS+Q2G7GKYSoWi/SBDgthEqC97t7ChpZKJHPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MqaSH5TaTmUID/MnD3/iOJB1lhxn8TizvZYfC3ue1h+HRmvFi7XO+oZWy/jWVbR0C
	 QtmVEMQNhg63UCK53fjgJyVe6yuSDxrLBN+tSHqMn12op8yj02qv9B3dYFdwhvDLCF
	 VQNfY4rrmxDz9AJ2KahVeT+gGb3zkgwL/0+H2MpRXJkoIl3bUvUePRmXVa0ep4uTHr
	 szNX5U3MtSVc7C5FYLCc0f9rmLouEedtVZjMeYRnvaO+eh08p5pT53BJtJTwGl2sWF
	 egw9C8XQSXszI2nb4c2DKvPzEQxtXyNBqZgamEoHHNxbS9xjzgkT1LOpihnJJtybQU
	 9ShpXHkU71nIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AAE9D463B7;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:57 +0800
Subject: [PATCH v13 04/13] gpio: pl061: convert register access to regmap
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
Message-Id: <20261102-cv75-gpio-v13-4-4f93114ea204@ambarella.com>
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
 linux-kernel@vger.kernel.org, Chanho Min <chanho.min@lge.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=11651;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=TNw3YIgJikWzzNq+gClJHLW8lzpyMmMDydkXhdo5rRs=;
 b=z9VzlgcWYHfzHW5q3tJAp5WTwUFjMn6+u8E5YTQPAAiMgkXqhVx05HGqcceb4zZ42lWm8XuVs
 xJfWvK8Qi77Bgv8OmE/GU7zxMCBkqY9C5T4tE0klVf4YPLGivs+f4SX
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Replace readb()/writeb() with a MMIO regmap while keeping the existing
gpio_chip and girq irqchip. Use a raw spinlock so irq_ack() can run
under the irq descriptor lock.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/Kconfig      |   1 +
 drivers/gpio/gpio-pl061.c | 144 ++++++++++++++++++++++++++++++----------------
 2 files changed, 94 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f03c05288376..2a1487bd1a94 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -583,6 +583,7 @@ config GPIO_PL061
 	depends on ARM_AMBA || COMPILE_TEST
 	select IRQ_DOMAIN
 	select GPIOLIB_IRQCHIP
+	select REGMAP_MMIO
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device.
 
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 721f14cf404e..781bef987339 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -19,9 +19,11 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -36,6 +38,7 @@
 #define GPIOIC  0x41C
 
 #define PL061_GPIO_NR	8
+#define PL061_DATA_OFFSET	2
 
 struct pl061_context_save_regs {
 	u8 gpio_data;
@@ -49,18 +52,51 @@ struct pl061_context_save_regs {
 struct pl061 {
 	raw_spinlock_t		lock;
 
-	void __iomem		*base;
+	struct regmap		*regmap;
 	struct gpio_chip	gc;
 	int			parent_irq;
 
 	struct pl061_context_save_regs csave_regs;
 };
 
+static bool pl061_arm_is_data_reg(unsigned int reg)
+{
+	return reg >= BIT(PL061_DATA_OFFSET) &&
+	       reg <= BIT(PL061_DATA_OFFSET + PL061_GPIO_NR - 1) &&
+	       is_power_of_2(reg);
+}
+
+static bool pl061_arm_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case GPIOMIS:
+	case GPIOIC:
+		return true;
+	default:
+		return pl061_arm_is_data_reg(reg);
+	}
+}
+
+static const struct regmap_config pl061_arm_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.reg_stride = 4,
+	.max_register = GPIOIC,
+	.volatile_reg = pl061_arm_volatile_reg,
+	.cache_type = REGCACHE_FLAT_S,
+	.use_raw_spinlock = true,
+};
+
 static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
+	int ret;
+
+	ret = regmap_test_bits(pl061->regmap, GPIODIR, BIT(offset));
+	if (ret < 0)
+		return ret;
 
-	if (readb(pl061->base + GPIODIR) & BIT(offset))
+	if (ret)
 		return GPIO_LINE_DIRECTION_OUT;
 
 	return GPIO_LINE_DIRECTION_IN;
@@ -70,12 +106,9 @@ static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	unsigned long flags;
-	unsigned char gpiodir;
 
 	raw_spin_lock_irqsave(&pl061->lock, flags);
-	gpiodir = readb(pl061->base + GPIODIR);
-	gpiodir &= ~(BIT(offset));
-	writeb(gpiodir, pl061->base + GPIODIR);
+	regmap_clear_bits(pl061->regmap, GPIODIR, BIT(offset));
 	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
@@ -85,20 +118,20 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 		int value)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
+	unsigned int mask = BIT(offset);
 	unsigned long flags;
-	unsigned char gpiodir;
 
 	raw_spin_lock_irqsave(&pl061->lock, flags);
-	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
-	gpiodir = readb(pl061->base + GPIODIR);
-	gpiodir |= BIT(offset);
-	writeb(gpiodir, pl061->base + GPIODIR);
+	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
+			   BIT(offset), value);
+	regmap_set_bits(pl061->regmap, GPIODIR, mask);
 
 	/*
 	 * gpio value is set again, because pl061 doesn't allow to set value of
 	 * a gpio pin before configuring it in OUT mode.
 	 */
-	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
+	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
+			   BIT(offset), value);
 	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
 	return 0;
@@ -108,16 +141,16 @@ static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	return !!readb(pl061->base + (BIT(offset + 2)));
+	return regmap_test_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
+				BIT(offset));
 }
 
 static int pl061_set_value(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 
-	writeb(!!value << offset, pl061->base + (BIT(offset + 2)));
-
-	return 0;
+	return regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
+				  BIT(offset), value);
 }
 
 static int pl061_irq_type(struct irq_data *d, unsigned trigger)
@@ -125,9 +158,11 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	int offset = irqd_to_hwirq(d);
+	unsigned int bit = BIT(offset);
+	unsigned int gpioiev = 0;
+	unsigned int gpioibe = 0;
+	unsigned int gpiois = 0;
 	unsigned long flags;
-	u8 gpiois, gpioibe, gpioiev;
-	u8 bit = BIT(offset);
 
 	if (offset < 0 || offset >= PL061_GPIO_NR)
 		return -EINVAL;
@@ -145,9 +180,9 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 
 	raw_spin_lock_irqsave(&pl061->lock, flags);
 
-	gpioiev = readb(pl061->base + GPIOIEV);
-	gpiois = readb(pl061->base + GPIOIS);
-	gpioibe = readb(pl061->base + GPIOIBE);
+	regmap_read(pl061->regmap, GPIOIEV, &gpioiev);
+	regmap_read(pl061->regmap, GPIOIS, &gpiois);
+	regmap_read(pl061->regmap, GPIOIBE, &gpioibe);
 
 	if (trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
 		bool polarity = trigger & IRQ_TYPE_LEVEL_HIGH;
@@ -199,9 +234,9 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 			 offset);
 	}
 
-	writeb(gpiois, pl061->base + GPIOIS);
-	writeb(gpioibe, pl061->base + GPIOIBE);
-	writeb(gpioiev, pl061->base + GPIOIEV);
+	regmap_write(pl061->regmap, GPIOIS, gpiois);
+	regmap_write(pl061->regmap, GPIOIBE, gpioibe);
+	regmap_write(pl061->regmap, GPIOIEV, gpioiev);
 
 	raw_spin_unlock_irqrestore(&pl061->lock, flags);
 
@@ -210,15 +245,17 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 
 static void pl061_irq_handler(struct irq_desc *desc)
 {
-	unsigned long pending;
-	int offset;
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	struct pl061 *pl061 = gpiochip_get_data(gc);
+	unsigned long pending;
+	unsigned int mis = 0;
+	int offset;
 
 	chained_irq_enter(irqchip, desc);
 
-	pending = readb(pl061->base + GPIOMIS);
+	regmap_read(pl061->regmap, GPIOMIS, &mis);
+	pending = mis;
 	for_each_set_bit(offset, &pending, PL061_GPIO_NR)
 		generic_handle_domain_irq(gc->irq.domain, offset);
 
@@ -230,11 +267,9 @@ static void pl061_irq_mask(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
-	u8 gpioie;
 
 	raw_spin_lock(&pl061->lock);
-	gpioie = readb(pl061->base + GPIOIE) & ~mask;
-	writeb(gpioie, pl061->base + GPIOIE);
+	regmap_clear_bits(pl061->regmap, GPIOIE, mask);
 	raw_spin_unlock(&pl061->lock);
 
 	gpiochip_disable_irq(gc, d->hwirq);
@@ -245,13 +280,11 @@ static void pl061_irq_unmask(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
-	u8 gpioie;
 
 	gpiochip_enable_irq(gc, d->hwirq);
 
 	raw_spin_lock(&pl061->lock);
-	gpioie = readb(pl061->base + GPIOIE) | mask;
-	writeb(gpioie, pl061->base + GPIOIE);
+	regmap_set_bits(pl061->regmap, GPIOIE, mask);
 	raw_spin_unlock(&pl061->lock);
 }
 
@@ -269,9 +302,7 @@ static void pl061_irq_ack(struct irq_data *d)
 	struct pl061 *pl061 = gpiochip_get_data(gc);
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 
-	raw_spin_lock(&pl061->lock);
-	writeb(mask, pl061->base + GPIOIC);
-	raw_spin_unlock(&pl061->lock);
+	regmap_write(pl061->regmap, GPIOIC, mask);
 }
 
 static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
@@ -303,17 +334,22 @@ static const struct irq_chip pl061_irq_chip = {
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
-	struct pl061 *pl061;
 	struct gpio_irq_chip *girq;
+	struct pl061 *pl061;
+	void __iomem *base;
 	int ret, irq;
 
 	pl061 = devm_kzalloc(dev, sizeof(*pl061), GFP_KERNEL);
 	if (pl061 == NULL)
 		return -ENOMEM;
 
-	pl061->base = devm_ioremap_resource(dev, &adev->res);
-	if (IS_ERR(pl061->base))
-		return PTR_ERR(pl061->base);
+	base = devm_ioremap_resource(dev, &adev->res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pl061->regmap = devm_regmap_init_mmio(dev, base, &pl061_arm_regmap_config);
+	if (IS_ERR(pl061->regmap))
+		return PTR_ERR(pl061->regmap);
 
 	raw_spin_lock_init(&pl061->lock);
 	pl061->gc.request = gpiochip_generic_request;
@@ -332,7 +368,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	/*
 	 * irq_chip support
 	 */
-	writeb(0, pl061->base + GPIOIE); /* disable irqs */
+	regmap_write(pl061->regmap, GPIOIE, 0); /* disable irqs */
 	irq = adev->irq[0];
 	if (!irq)
 		dev_warn(&adev->dev, "IRQ support disabled\n");
@@ -363,14 +399,20 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 static int pl061_suspend(struct device *dev)
 {
 	struct pl061 *pl061 = dev_get_drvdata(dev);
+	unsigned int val = 0;
 	int offset;
 
 	pl061->csave_regs.gpio_data = 0;
-	pl061->csave_regs.gpio_dir = readb(pl061->base + GPIODIR);
-	pl061->csave_regs.gpio_is = readb(pl061->base + GPIOIS);
-	pl061->csave_regs.gpio_ibe = readb(pl061->base + GPIOIBE);
-	pl061->csave_regs.gpio_iev = readb(pl061->base + GPIOIEV);
-	pl061->csave_regs.gpio_ie = readb(pl061->base + GPIOIE);
+	regmap_read(pl061->regmap, GPIODIR, &val);
+	pl061->csave_regs.gpio_dir = val;
+	regmap_read(pl061->regmap, GPIOIS, &val);
+	pl061->csave_regs.gpio_is = val;
+	regmap_read(pl061->regmap, GPIOIBE, &val);
+	pl061->csave_regs.gpio_ibe = val;
+	regmap_read(pl061->regmap, GPIOIEV, &val);
+	pl061->csave_regs.gpio_iev = val;
+	regmap_read(pl061->regmap, GPIOIE, &val);
+	pl061->csave_regs.gpio_ie = val;
 
 	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
 		if (pl061->csave_regs.gpio_dir & (BIT(offset)))
@@ -395,10 +437,10 @@ static int pl061_resume(struct device *dev)
 			pl061_direction_input(&pl061->gc, offset);
 	}
 
-	writeb(pl061->csave_regs.gpio_is, pl061->base + GPIOIS);
-	writeb(pl061->csave_regs.gpio_ibe, pl061->base + GPIOIBE);
-	writeb(pl061->csave_regs.gpio_iev, pl061->base + GPIOIEV);
-	writeb(pl061->csave_regs.gpio_ie, pl061->base + GPIOIE);
+	regmap_write(pl061->regmap, GPIOIS, pl061->csave_regs.gpio_is);
+	regmap_write(pl061->regmap, GPIOIBE, pl061->csave_regs.gpio_ibe);
+	regmap_write(pl061->regmap, GPIOIEV, pl061->csave_regs.gpio_iev);
+	regmap_write(pl061->regmap, GPIOIE, pl061->csave_regs.gpio_ie);
 
 	return 0;
 }

-- 
2.34.1


