Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602021;
	b=IIDjZor5iwiIfc3Evr4maY+7ym70y7G9SIzPdzXl3WU6MVawEzDjq5eq5ZCVy1ctkCr5
	 onWyWQ6DvRty6JbhbIzNKX6Ohr0bIoyDivs3gZVPD4ZS0Mt0uBT15sTJ99l89XG1qY+z3
	 t9umTcnFD6lzZibBA4HzFITnsTkhJ3ZsfDKNyXKaPHom1M1lRYj5VJK+cxGaa1SBvH9y6
	 yVaNSiybYcNdUzOgJleOBsje6AmVz8Bp5P4M8d7AEJXap5eGVeScfljc7XzYG0QxXF7mg
	 gl6Flr4veY/eI44wgQtiX0Rm3aW9PprZmbKm/AQUclZdPPdWE05yJ5f6SfEJWubca8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fP4uhxWrwLj9+SVQejTRux8LxkoTj+venrMY0J0+WCA=;
	b=OB8mmVeNM+g0GNQO2mBtI+Lc+UNnEss/J0ko0PuMqkZSzwqyQc+PqBYeH/YpafHSdbkX
	 cdEnazy1HWNiUHUA8qA8Q87J1NYoKELseTFfGpK2XEZhTPnyh3cQ5uyguJROVcSrH0bPJ
	 04V+616ipr8eR2hCZs2w47UhX5nsFVJUVpnVPdf93nm8HHX0MqhcVJQwkVN7J/+kI/QsI
	 ftgDfhLhZs4cjdLaMateuJPfNwKdLCT1gv5HgoXkkGw6+Y0fjmOr0dpik8O4eKwwGfnG7
	 7OZCxGWfE/rSAMUk77QseQv1lyYPKnbw68LGG+ab8fjPPwncHv3cttMUNyV5gyRsfbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2er9BsL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60560A263C;
	Mon,  2 Nov 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2er9BsL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602020;
	b=I23GCevXIZ6qr4F7WqQA8KObsfeE85AEQNCyCQcvgltYjgJq+L44Gx1RrqkoyU0flRFL
	 XSaxg5wKw8I+YcfsVvsT41/qH+Gxg8NL/WpkwbOE90KcaZcGrVO4KHkvfnTtSrY6Rp0CQ
	 6U4m284OlnFDJ0WtlINBFusLC31t9fDlNhgN1FsZwBdvLhvh5GlsPJxx2wW+sdZ0ggapH
	 7WmNYEDSe8nOykVx9PltkT2zzYcZtSLx6IRk3SpmMNqjteTfP6ANGhFO81tcZMskmElej
	 UJ54T8qTpJy2T/KPt54q+XPa8LE6JUD+9bTJN+kj9BF56DsVIDGEgSouhHFo1K3Etrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fP4uhxWrwLj9+SVQejTRux8LxkoTj+venrMY0J0+WCA=;
	b=aKXBIq4xk1csIYkJ3brUz3GzUy9yN6dWP9QaWq1u/zfgtjWzn1e/AQoUAcCmjY5JEaSh
	 93ipbgnuo5MykW61h6P3DXShCyAGVPW7XKUjiztqnVqRB5vAe6/o8MJbzF+cPans59wFC
	 n5u+lSlVBhX5OoECb5DkHVztpnWC6wXbdt7TAqMZVz9IpJFJKFihvOAoboOYieBK6jO5G
	 7moE7o9lA3t3Gvs0lwmTU6yaHCk2pZ2MYuCgRm5xrUlOXM6GSgp5vR0vr2NWPNa2FlayZ
	 G00ECM1IJJ09EuV9LDwarJQAp47Ca922hco8b8FXwrUGXveg/ntpnSvLkukIwQRHc3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9AF081F00A15;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602020;
	bh=fP4uhxWrwLj9+SVQejTRux8LxkoTj+venrMY0J0+WCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l2er9BsLk1bqR4aIVu/pgIkgE0fp5Ko0qwPNZRCWzPn/dlma1lDbr0oJLmsaDtu/B
	 S2tFr5/7S4XUoUSRJfpCdRvd+qxkBDh8CRodUkCkM5z5ovJltI8GlZ/GKJHuXMUys5
	 5wpW8wSH64TlNNoAwh0PRnIGOuXm9699DmJxUKUPdS0K/C8Gwg0Pv0TF3ncw0nOY+g
	 Xna685VN4TX7Mn9G0GQIJJ0qfMVpw3e0cmeLMNsSD8Mr93vYrKNGWEDXntRWFhy10x
	 bTwn42XeS6PdgYajEH/TngGxFqswcqE4ObGRN3GQWKqx0ZBgAr5YatXqzleipkHoDW
	 pr55Qw8goo+1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 14F2F463D3;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:04 +0800
Subject: [PATCH v13 11/13] gpio: pl061: add Ambarella register-layout
 variant
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
Message-Id: <20261102-cv75-gpio-v13-11-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=4176;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=7PBsQ7BHt0WowwsQlVwR3GG8j78Lnd2HAGKwF7XYLks=;
 b=IThx7WXR4x138FrhiZfgU2SltHuCvWmzjIDV3T3/mBJzN6DkGGjSn2DzlqmMSVxa61F+Pvqgv
 vHtxFE9mSZMCCOjx06NguBQigtKkYA1jdvmaOdyLNncxqAIFNK7wGie
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Add a 32-bit, 32-line layout with DAT/DIR/IS/IBE/IEV/IE/MIS/IC plus
MASK and ENABLE. Probe unmasks the bank and enables the controller.
IRQ type changes also clear the pending bit. This derivative does not
need write-after-direction or system suspend save/restore.

Cache DAT (REGCACHE_FLAT_S, not volatile) so gpio_set() updates one
bit from the output shadow instead of read-modify-writing the pin
level across the bank.

Match the part with designer AMBA_VENDOR_AMBARELLA (JEP106 identity
0x68, bit 7 set) and part number 0x061.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/bus.h  |  1 +
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index cb1ef0f3774c..ff9215447bbb 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -39,6 +39,18 @@
 #define PL061_GPIO_NR	8
 #define PL061_DATA_OFFSET	2
 
+#define AMBARELLA_GPIO_NR	32
+#define AMBARELLA_DAT		0x00
+#define AMBARELLA_DIR		0x04
+#define AMBARELLA_IS		0x08
+#define AMBARELLA_IBE		0x0c
+#define AMBARELLA_IEV		0x10
+#define AMBARELLA_IE		0x14
+#define AMBARELLA_MIS		0x20
+#define AMBARELLA_IC		0x24
+#define AMBARELLA_MASK		0x28
+#define AMBARELLA_ENABLE	0x2c
+
 struct pl061_regs {
 	unsigned int dat;
 	unsigned int dir;
@@ -93,6 +105,17 @@ static bool pl061_arm_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool pl061_ambarella_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AMBARELLA_MIS:
+	case AMBARELLA_IC:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config pl061_arm_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
@@ -103,6 +126,16 @@ static const struct regmap_config pl061_arm_regmap_config = {
 	.use_raw_spinlock = true,
 };
 
+static const struct regmap_config pl061_ambarella_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = AMBARELLA_ENABLE,
+	.volatile_reg = pl061_ambarella_volatile_reg,
+	.cache_type = REGCACHE_FLAT_S,
+	.use_raw_spinlock = true,
+};
+
 static unsigned int pl061_line_mask(struct pl061 *pl061, irq_hw_number_t hwirq)
 {
 	return BIT(hwirq % pl061->data->ngpio);
@@ -336,6 +369,19 @@ static const struct pl061_regs pl061_arm_regs = {
 	.ic	= GPIOIC,
 };
 
+static const struct pl061_regs pl061_ambarella_regs = {
+	.dat	= AMBARELLA_DAT,
+	.dir	= AMBARELLA_DIR,
+	.is	= AMBARELLA_IS,
+	.ibe	= AMBARELLA_IBE,
+	.iev	= AMBARELLA_IEV,
+	.ie	= AMBARELLA_IE,
+	.mis	= AMBARELLA_MIS,
+	.ic	= AMBARELLA_IC,
+	.mask	= AMBARELLA_MASK,
+	.enable	= AMBARELLA_ENABLE,
+};
+
 static const struct pl061_drvdata pl061_arm = {
 	.regmap_config		= &pl061_arm_regmap_config,
 	.regs			= &pl061_arm_regs,
@@ -345,6 +391,13 @@ static const struct pl061_drvdata pl061_arm = {
 	.reg_mask_xlate		= pl061_arm_reg_mask_xlate,
 };
 
+static const struct pl061_drvdata pl061_ambarella = {
+	.regmap_config		= &pl061_ambarella_regmap_config,
+	.regs			= &pl061_ambarella_regs,
+	.ngpio			= AMBARELLA_GPIO_NR,
+	.clear_irq_on_type	= true,
+};
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct gpio_regmap_config config = {};
@@ -521,6 +574,11 @@ static const struct amba_id pl061_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= (void *)&pl061_arm,
 	},
+	{
+		.id	= (AMBA_VENDOR_AMBARELLA << 12) | 0x061,
+		.mask	= 0x000fffff,
+		.data	= (void *)&pl061_ambarella,
+	},
 	{ 0, 0 },
 };
 MODULE_DEVICE_TABLE(amba, pl061_ids);
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 80a74cd2da7e..411533bfa61d 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -98,6 +98,7 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 	AMBA_VENDOR_QCOM = 0x51,
 	AMBA_VENDOR_LSI = 0xb6,
+	AMBA_VENDOR_AMBARELLA = 0xe8,
 };
 
 extern const struct bus_type amba_bustype;

-- 
2.34.1


