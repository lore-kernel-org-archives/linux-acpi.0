Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602020;
	b=068jKpDeEExt32AA+K3xk0Ts5iR/+hJwNdV3u6JCUM9lyVGLT8qOn/L3WfajuW5u2KLA
	 hd+lIHhiaj/nsASGJaabNpCcXc5t4rZko4A8xVR5SVNRcoYrgL0puR3aFV4j5TUtMjHRv
	 Ery94Xx8Ait1O2oKtaQUfv6FeSPVNwsZflCGybVPSWfIPmFjAwQZ5QW0PqDw23shAXhlY
	 Epw583DuHeKvfizLGNUSoWnGAQnZT8vD7c2U1IS9WN0LBhyxso0GzFbK+ztFKWDFvLlYi
	 I/VBTL86uEiKlIKKTtw1+cBkcygj2TQoVjiGMGgDsuaETr2ty9DwN45fG+LD+SnBYHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QW3CzfPEuKpaLa114oR22qLFgs3zc0UThhwaKSc7g18=;
	b=aFryN6LAE47UPvQ5qwQfgHFNhcL0svs8g1AnSHkJzFf6zv0nE0bBSO7st1GnGqHR5qCy
	 rQiHgodQJ8VljqGkD/G2WvstVBFhhFCtP3OcA2bcMpci0Slad7Rv/6Qfp7CU8BGHgXGVK
	 jhK5HJBh7sZKWAUxG8QUflJpe4Yz0Bh5S5Vjg5AePvmYv14BqqT4vjfJe3WpPTne1hhCn
	 3vBwtLynG0DStfjG+azOsb42kTvjmf1JESTIzuVfLZhBkkqVufbMI6dfvxcFkb3zJ7lbc
	 ZOlEjsUpNdITr6dMp6qDTD0+t1pwYsM305gzMz0lyT8IjVr9dAsez/j17yKjJWj+ZVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5OfPole;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861160A2618;
	Mon,  2 Nov 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5OfPole
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602019;
	b=GaOQ1gN+FcGQqiuQBvfixYbQr9as1oNFs391TcZSMIaUYuWwVWCqBsn5lCyDsv4FFRpo
	 YOn/asrdP/4tvHr2yqcvLx3V8a+ckb2jQ5zyXy7s9v0wENRHE0YiNpicQBEleb7mLFCLI
	 e4aTQGkvshP1a6bkPcca0FZHystM22MyAgaUPqrL5TxTEvmb2PoCveG3dc5Y6QKWV+Axs
	 PsK2lfDFWKF85DQTsxbWi+BncjsTMEMiIvBX326GSEcceL7i+qoz9uOkgkOvTsUA+US42
	 jz4ayJKDnysIfwMCeYihEDThQkjA8Eh1o6WooGn6XTnCPJTa5za5Lkdn6sCjl4h26Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QW3CzfPEuKpaLa114oR22qLFgs3zc0UThhwaKSc7g18=;
	b=TMI9MLM5qoKjty/ygV6QkOE7X94Bf4yScDGP5SLX8055zQLcW4zE3Bq2BlNyi4kagAQb
	 jq/ILW47V81SNUgYY5DguS0G7rkc3oW67RE0tncpLDZ+znm3tnARG0t+05WNJSVRenC34
	 jRJyqVMDLzoARzO2Umawpf29JO1ovPZfQIJZ/HGGdSTiSKLyyBGQfA2nRSqMs90m/654Q
	 Z+5X8jwXCZE5TCZ9lQK5TFTxi3MATLWAPdwk2fikOpziYYXZJVJUtniijaVkNCpnIvcGF
	 LwQIO7eo2bQ+cM/zy51c5KXL+rFzEhpXJMqNU50K9Me+QVkfZo86b5/o5Q4lT9FvTbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E2F071F00A21;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602019;
	bh=QW3CzfPEuKpaLa114oR22qLFgs3zc0UThhwaKSc7g18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=m5OfPolebYIrj3F75JSQY9zZBXtAiAodcBz2yn2tAXJ9mYAuW50yczSTS6eR5pkDc
	 0qfxbZTqOFhr+WXvkU8rQzhZmx7JZPJvp/eR4hf57ZfFFpfw/4dqcEv6P20mDcR3XT
	 g9G9Ex+JgdMYqgUI9QgPCT7Cms3TuzvgV7z682j2ZvSsDo3FIAY43po0HPX5d8EoyJ
	 mJoGGuPlAR1EPdp6JBMbDZyP/lM1HJR7gc0Utos6laid4Oe7VyZcmWhu4SUc0BP2Ie
	 Qim3UskAsm/4laKP0LSHaeRxStZQ8o3U+gXw+4HWJMwltudTaJkSzEkHEOjdry+5qc
	 pHFX2Ac+3TIMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D2E60463C3;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:00 +0800
Subject: [PATCH v13 07/13] gpio: pl061: keep the parent device in a local
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
Message-Id: <20261102-cv75-gpio-v13-7-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=3279;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=3w3mdV9O1WfvTa1UQD42+BMAnP/3kNlEj5RJh0P3/78=;
 b=FtyH9TzklLUUi5PO0ibyYZOJku87CgTW0+bYoDM+3wYXlSry7t3eyOwFA7FdtaD7eccF7cXku
 hwOflrOz02TBrRlRSe0QgaAiSowCAwTCRNp8tOw4dCfKgbAReDUxoT4
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

IRQ logging uses gc->parent. Keep that device in a local so the
gpio-regmap switch can change where it comes from without rewriting
every log line.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index a232b63fbc0b..27ed759486ca 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -156,6 +156,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pl061 *pl061 = gpiochip_get_data(gc);
+	struct device *parent = gc->parent;
 	int offset = irqd_to_hwirq(d);
 	unsigned int bit = BIT(offset);
 	unsigned int gpioiev = 0;
@@ -166,7 +167,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		return -EINVAL;
 
 	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {
-		dev_err(gc->parent,
+		dev_err(parent,
 			"trying to configure line %d for both level and edge "
 			"detection, choose one!\n",
 			offset);
@@ -192,7 +193,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		else
 			gpioiev &= ~bit;
 		irq_set_handler_locked(d, handle_level_irq);
-		dev_dbg(gc->parent, "line %d: IRQ on %s level\n",
+		dev_dbg(parent, "line %d: IRQ on %s level\n",
 			offset,
 			polarity ? "HIGH" : "LOW");
 	} else if ((trigger & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
@@ -201,7 +202,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		/* Select both edges, setting this makes GPIOEV be ignored */
 		gpioibe |= bit;
 		irq_set_handler_locked(d, handle_edge_irq);
-		dev_dbg(gc->parent, "line %d: IRQ on both edges\n", offset);
+		dev_dbg(parent, "line %d: IRQ on both edges\n", offset);
 	} else if ((trigger & IRQ_TYPE_EDGE_RISING) ||
 		   (trigger & IRQ_TYPE_EDGE_FALLING)) {
 		bool rising = trigger & IRQ_TYPE_EDGE_RISING;
@@ -216,7 +217,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		else
 			gpioiev &= ~bit;
 		irq_set_handler_locked(d, handle_edge_irq);
-		dev_dbg(gc->parent, "line %d: IRQ on %s edge\n",
+		dev_dbg(parent, "line %d: IRQ on %s edge\n",
 			offset,
 			rising ? "RISING" : "FALLING");
 	} else {
@@ -225,8 +226,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		gpioibe &= ~bit;
 		gpioiev &= ~bit;
 		irq_set_handler_locked(d, handle_bad_irq);
-		dev_warn(gc->parent, "no trigger selected for line %d\n",
-			 offset);
+		dev_warn(parent, "no trigger selected for line %d\n", offset);
 	}
 
 	regmap_write(pl061->regmap, GPIOIS, gpiois);
@@ -307,8 +307,9 @@ static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 static void pl061_irq_print_chip(struct irq_data *data, struct seq_file *p)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct device *parent = gc->parent;
 
-	seq_puts(p, dev_name(gc->parent));
+	seq_puts(p, dev_name(parent));
 }
 
 static const struct irq_chip pl061_irq_chip = {

-- 
2.34.1


