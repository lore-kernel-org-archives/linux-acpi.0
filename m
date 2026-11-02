Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602021;
	b=LSLLMnWSIWafSbMzDiv9eSe988RgvuiaqtGjuE5cmwU0JObIAeXqYV12O0CvXLGEMGsz
	 9rlSMR/20Q+j/o+mo4jYT5v8AvC5yBoHppRD3uwCWErpe0wJup4RrSfc1FyuW+xdpbY67
	 Pxta7+eIjdjuwZO4nq+S8TdvsIH3JbeVWPYOynNI4k6o4+oWdGEaMmQppmcJL86eiYnoN
	 rQ399Tg5dldIWJsDAhKOfAb4mbEOP4qmn0+21mdLKjtkZ+4ekgmw+Bvy7YhHUYVQA68pe
	 d2eerpxh00onrtCLW1LVzyqQuG1pf8RC7OPksZT62C3gaUssZIGHhL4tPvQi3tVVj3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RT/gWemlOt99jwsyvVrs12EipOy8vqXtqn5H7FYkz/Y=;
	b=Te0P5eZ4qznOATBAPiUv4KNPOV9YD/omWB0+Db3NWzjyq+hXxfT3Myi3jhmFaSXiWULV
	 +4F3nQQhZu4uipeLrBZDBxrAEnFPfzzFS9lRxkh311UgcpJhN3c4MO+5a5q0u+8ofd8/L
	 peJx2qUmkTXjBLqiDDcYNb1w2AeRW+hqv0i1591Dofv6RWuh1LMxbpdppcYy6Xqb6/led
	 LmAB6wBw5eE6+O4m8XnO3hPbwht1+Ssd3jPiwcQLbPc2XPssyB14Ds4hYndE9+BpcqkJJ
	 OAA3HMGTd/B1g6QMhKqwQYyzIIGuqYC25GnhLbCwDYIaZvdnWsBXRTLinJg3K7bLHRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkU97Q0x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1860A2633;
	Mon,  2 Nov 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkU97Q0x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602020;
	b=c/wUbcVTMazVJ9GaZiExt9Yu4tGBnJHIGOO7BR/4S2jStj30+ic05cXPV2b2SWoRpi1W
	 hYenf+38BZteo7NW0Yiogf20MKDxwuFHTh3Vspdw3XDEhYdX//C7chcPQX7OuLBNJCqTT
	 YtvSR5UqixmDKSGeXlWjfbiev4iUmMx1xSJSa+pMUgE63mwNbftAyyq5chbLJvdKxPVTb
	 YyBJtECh2OrNWxuM72RS90pJWVJUrnoxr8VyzAVSEcT4Z7bKKWd5m4Uy0ChxwDM0+OCvv
	 T0apcgRvSuzgmLEzgg/I8YMosGHpd1LraZUhn5CkV6Y3QsZEDQgtKbesfb92oMi/WOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RT/gWemlOt99jwsyvVrs12EipOy8vqXtqn5H7FYkz/Y=;
	b=w0okE82WqU6iZqPZFQEA6AvaAh+A2S/eRnwH1Joy1+XEPwrXGGiD6FxJp7DQP//YAFi6
	 BXt0FfeIUl2grYWpOB8SOzgGA1Q6Gryvge2G40FgNmS2f5aYrgGUUE1Gk+jY8I0tQHcyi
	 odlCifDOImgdOXGg/m40JDiT6u1AAiI7SZfjc9/fgqSh2vLVf4qn9me0bdnyuAulUu8qk
	 9DkCZmISBjEGAyjEFoGSMyLlxNz94ICjtRLSezCUXuCUsaqfK69a68A6CbS82HHvCckkb
	 hIIq+plLc3V0GMoaDc7akSEZUlR1Ka8/cpym3VNytlfkrfYspIggWkzKrYeo2iW+bSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF6D21F00A02;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602020;
	bh=RT/gWemlOt99jwsyvVrs12EipOy8vqXtqn5H7FYkz/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jkU97Q0xZEzsJwhfxVUcssXu8+StmtPmJ8WTzQrw8vSqLi6V4uGEAhr9xBvL0w88I
	 nHc9+VCF+obNrPg0lprvtCsws6InoxBarMdU28BpBlKbpbZeVBkJI6NeKYiPR6WpOm
	 AXR69HU4LHs7dS7a6vaYKf2tjhHtAWyop3fbDCF5h94DwmFdXlA1NpfAjqhidjH6hc
	 RTT8HvnpXJwDE0SE/Gml7dLUiv7eRXz7apfQdAOViQCFsWxEB7/koxa3s/TNsR1CJB
	 cpJMQavXZF4MENDm0hQiNkfSgi8ETfc2z9lxoEfTyWzI+8qsdjX/X2xxSjxgI0JjjY
	 CgQS7mmdms0DQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 304AF463DB;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:06 +0800
Subject: [PATCH v13 13/13] gpio: pl061: use string_choices helpers for IRQ
 trigger logging
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
Message-Id: <20261102-cv75-gpio-v13-13-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=2144;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=fw1GrW1qb2pgL5KMumdZfjy+hm5H2+O4WJ9KZtKEf7g=;
 b=frD4NqpHtQZS0jwPoCEmr+b9K0OEZGWwSl3VTced8gZdFEqXV5fKEXDa86cHB0E0lrlPaff60
 Cr97vMzZg3PBBE9QdSVH2UY4Je5FJoHSg1kWGhe37BjZOp9qF2nA718
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Add str_rising_falling() next to the other str_* helpers and use
str_high_low() / str_rising_falling() for the level and edge debug
lines.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c      | 7 +++----
 include/linux/string_choices.h | 6 ++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 63ec5363dd5f..86c22378e759 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -26,6 +26,7 @@
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 
 #define GPIODIR 0x400
 #define GPIOIS  0x404
@@ -195,8 +196,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 			gpioiev &= ~bit;
 		irq_set_handler_locked(d, handle_level_irq);
 		dev_dbg(parent, "line %d: IRQ on %s level\n",
-			offset,
-			polarity ? "HIGH" : "LOW");
+			offset, str_high_low(polarity));
 	} else if ((trigger & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
 		/* Disable level detection */
 		gpiois &= ~bit;
@@ -219,8 +219,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 			gpioiev &= ~bit;
 		irq_set_handler_locked(d, handle_edge_irq);
 		dev_dbg(parent, "line %d: IRQ on %s edge\n",
-			offset,
-			rising ? "RISING" : "FALLING");
+			offset, str_rising_falling(rising));
 	} else {
 		/* No trigger: disable everything */
 		gpiois &= ~bit;
diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..c3a0360334d6 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -65,6 +65,12 @@ static inline const char *str_read_write(bool v)
 }
 #define str_write_read(v)		str_read_write(!(v))
 
+static inline const char *str_rising_falling(bool v)
+{
+	return v ? "rising" : "falling";
+}
+#define str_falling_rising(v)		str_rising_falling(!(v))
+
 static inline const char *str_true_false(bool v)
 {
 	return v ? "true" : "false";

-- 
2.34.1


