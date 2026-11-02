Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602020;
	b=3b+NvQ+9u22o4UrMoVOL8dAuqqa/0spe8Yy0M+FbBK3F2bvXIswN5KNaxQMjg060avEP
	 UkIDbJ+mnXk0wHc2MQz9+tx9OlUOkHPpzlZqOaqlfNqjl94wEBLxdlEso4l5hrdnhaRBY
	 Ad3y0IjG5lw6skM19rbveEMFFeVFErIwYreqLlX2SpQxihNBsyb+T1KujNK1lx5Q3iYDe
	 pPMvzcYHnT9MF/AbfrSqVJD+j92lznvgD064KF9L30lYHClVwn39ZxMZ4sEi7QxWcbk9+
	 HZ7+ISm7VhIxgUaaN72fmR9GE2MiD1YV2hqBvXxihhwDYIun2TcL48zr6QBVbcxBCVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cjxdJTdu9iRc9WKSGl7wU7e5PLo0KrF88nKZOIp3wPo=;
	b=KVYYy1jKQHT16makGNX/6+U6T67JdzTnsQYnTfWrC/w36ZkcsTm4yfODceslQdbfEXUP
	 FsXIZsDEXAFswdYx8sXmdYGr6O9aPkuUFxtHxV8J1ZB+aQ+35e2a8dim2i5XAn9ZUmEVo
	 hr3HS4anrqfOM6+cRteackKWwN6YEEdrPsx3JBkDErfxB4zet2UI91jN/rZ61VNRTHjNb
	 Mrr0AD4QgRRQunPTMqLJkLKWvTIWh2GOOgXCyzgvW0Tiv0VzOFvl8atPsjpaVVgJ7CkU/
	 ZawU5GnbJtDXclVnka2XKAWJXYRg3hrc5+t0rPlSNTwzYug591nm/YeR2yUpVysdEqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9E3ECrP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1660A2620;
	Mon,  2 Nov 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9E3ECrP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602020;
	b=MjmgYkWi5BURWxCYH9b9KCoonkp0knafhFhuTyl7cYMABpwGkNhkpmGgkfCyqgPS4/Dl
	 Nf2lptei20Dr8NLrOVcq5wF1F8mWTfduTlA7I7F3U+dK5CsCb+7bisvdZKcZ0sxG55Bbn
	 PM9gQr8o1P1HVcajAR5n/0/82XKKzY1uExoYLY+aHD7BEaiV8QfcWPjK9r7M/gdIzFC2j
	 JAsFXZU34ETk73ReqFno+RuRhnHhykp6SIaoXgWL46EZ9I9PN2ZhYEp5D14/5hesUKWQu
	 nT1IYgiVD0gWFp2rTJ4qT/YniNXkiBqrRy/FUgUsHVQpGVsJ38egSvOBvL4z8Y92WMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cjxdJTdu9iRc9WKSGl7wU7e5PLo0KrF88nKZOIp3wPo=;
	b=xmW+xp2jnicXuwkFjM4/Op9DM/I2ZjTdwaxNU4ukEYEilrFWOWXWILU1tfOGAIbMapuw
	 14X8Ud+dRXqDA8EESC4ydDmrJU/eV0ZMq/sdEncjWnwjnX3ri98xQSncaZ4AbJNPbNSn4
	 ZHj8jj7lNFrBzQwMOzywtlT6umUognn4JKJZpE1Gy8knVjz/Z3/ulNoUA8hX2FO5pnRb3
	 RqKnsbWsoqrNBbmlSlzLfnrElMH2WHkzCsAk/nK0vpVT1o/uj31UFCu+7S/VZ3X4Uczuy
	 cYKGCQXCXWDjLAKaggjy4uDKGTBFTvf2tRo4Vb1LGH0dx5HqBqUbTJs39oW84msj3Lw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EA1BF1F00A1A;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602019;
	bh=cjxdJTdu9iRc9WKSGl7wU7e5PLo0KrF88nKZOIp3wPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U9E3ECrP9N8q4STZLNx9qoHLAb1ZvGdEdr9n+krLaDvtwNVYfTXmCT//Bk62BLqeU
	 5BOrfJcm1N7ijux7LmUMjep/DLg2v2U3UeG3vAubpGjdTA43j8H1A+QgS0tunkWQI7
	 R70QNgAxE7UA8eMO+msxkGin9YNi2BqAoinitDhdSr7Y+YV/hv2uMzENVOSgcmiVxd
	 oVhDeo7LHJpIEey2dcaEgW/K4Z1qF3xWqlP7fdwwMQ+Lx/5gllu9qI3mJH0DT5oAwG
	 7v+Ua+KKIh6iQVq9WoIrtxtlBeMELxxEqltC/kKPwEHNuhugNqmLWaZ/wojUQBrmvo
	 Ag3ghmePlDb3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E00C0463C7;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:01 +0800
Subject: [PATCH v13 08/13] gpio: regmap: remove gpiochip before tearing
 down irqchip
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
Message-Id: <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=1791;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=OaUzJvxSKHvAu1q9Z7cujbZIxtxmQOv3Dz1Q60lLuSg=;
 b=/f7+d+2PUAkbck+adNb2ioj2juP3k0EZTnjzDEa6JLN9dXJtNl1WrCrBkZ7H5RNiz0qvaJKLM
 QM7pidA8KgFAbIuR5bnERDt0UfU+g19Id6AWwHIWTq4uLqkC3O1xZtw
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

gpio_regmap_unregister() currently calls regmap_del_irq_chip() before
gpiochip_remove(). That disposes the mapped virtual IRQs and frees the
irq_domain while ACPI GPIO-signaled events may still be requested and
while gpiod_free_irqs() still needs gc->irq.domain.

Remove the gpio_chip first so ACPI teardown and USED_AS_IRQ cleanup run
against a live domain, then delete the regmap irqchip. Use the same
order on the registration error path, which previously leaked the
irqchip when gpiochip_irqchip_add_domain() failed after
regmap_add_irq_chip_fwnode().

Cc: Michael Walle <mwalle@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-regmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 0a44deae3d01..6b520bd80834 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -429,6 +429,11 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 err_remove_gpiochip:
 	gpiochip_remove(chip);
+
+#ifdef CONFIG_REGMAP_IRQ
+	if (gpio->irq_chip_data)
+		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
+#endif
 err_free_bitmap_output:
 	bitmap_free(gpio->fixed_direction_output);
 err_free_bitmap_dirmask:
@@ -445,12 +450,13 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
  */
 void gpio_regmap_unregister(struct gpio_regmap *gpio)
 {
+	gpiochip_remove(&gpio->gpio_chip);
+
 #ifdef CONFIG_REGMAP_IRQ
 	if (gpio->irq_chip_data)
 		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
 #endif
 
-	gpiochip_remove(&gpio->gpio_chip);
 	bitmap_free(gpio->fixed_direction_output);
 	bitmap_free(gpio->fixed_direction_mask);
 	kfree(gpio);

-- 
2.34.1


