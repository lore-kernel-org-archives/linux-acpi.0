Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602017;
	b=1xw/ddQqTF1+huX7MF/gqiRf/+1lduxOastin7nJEGH//LrTCI0erI42Qkdc73h71trs
	 obPc41XEKlNOSDiKwBBLULLAs7skaDnYA+ApaRMEUKDxZvJEzs7Qpc4jJFw81TsekBXU6
	 ALxXa6j8SL1OMw3WvNwkUmMk6FkspIZGYaGCFXKIJa98RkuNi8TEx5qO/1nPw2e+EOA7d
	 HzlHBN4al6aXWCy/bc7UGt/nfms+Mn4wcvH2WqGL6rhvOZJ7z9Ot7w/6wEulesEqbPp2K
	 3h/R/zAZYhNXX4tMSz7H95tIh4yEtkk+jD6mNq1IyurmNlvwTGzocUSlTZIQV0e9kpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602017;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LAR7UG07ENN+2lb2kJivg6c45tgcctR261e0OwsJsJo=;
	b=lFIDMbIHIOO949/H/HNkMWy8OG+m9eLBx2AbpsgQTOyCJlZb7ZAhmhELVdqoO+oCj1Jz
	 zQwDIz+4tjLoUeV8FC+Z08LNO+ASaRm2x2t954CmJfnGQQZFBl7iTTkAo+RIcadmeba1h
	 uJ2ZR32xXWXWySbzguhE55GGOrhPV1AJbypDcqV+3Avypiue808bjd2cJS3fHaOamLkvx
	 EsnJc6Q+Dq+ZQvJdJ3UfxzRIuNptshHgeRB2oAi06xGl90PrS3cCfwz3Tv09zHUeLYtDb
	 0oXTqJZ3i4Foe3pIoJJOJNPm6tx978EGtKRaNYjpeWqfhe9wkbu9f6bsAAsSCJGCY+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+9Ym+6R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA5606A324;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+9Ym+6R
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602016;
	b=U92Tahp9gLjiwT+oMFheGzA2GtB/U0cayIaMUt8EVaxD8dXZcxR/Olu90qHE63oeiNeQ
	 2K6h7PsfdGf5r16nZ6bmUlVViB+dgS9/lcui1mBXtLRZMJ4JjNrvnOAJvfMHCagYho8w7
	 K7ZRK3vQhi9Hyrf09Hu508TJmFjsbIjNy8P6izCcYgSQLfiQP2PHkEHMXzcVOy9shdhnn
	 3ZMHaIFdJUPD5GgoQFCDnNi1/jWd3UTjevKcN6beJbg6AIJ/6mIghERXcp+m52tLto1iS
	 oEoHjeQiCpvRfq7R9u7BUSr78oEBzcjP5ihVs//WLOGmvmr89KfQraiGTpz5ojt/rlg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602016;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LAR7UG07ENN+2lb2kJivg6c45tgcctR261e0OwsJsJo=;
	b=K37vCfzCXBbXNmo6CbrH4GuG4zF6bUtkz6Ak1YZP3mH2fqOU+XBG6i3EhwI7GgivsFMB
	 7IuUDWvSOelSeBv/tozyiPLa7o1A6SZI57uKOEp2f7iGy5MLd5YjmeBIglLhYPHdX9Kkz
	 ChxQiAz9r+O6thlDhx3/GI+mSVDwyj2g5bAPDidLVJ39f1a2VY0myKxwzG/UZ7PLT3jvH
	 u9Wtj9JXb9+wFV5Vz5gco9lCMIZbKLRCT+7gY/QNnDLhzm0G5krIUYHkQ7K4oNb/r7tUT
	 op3yLKUAJkxUDzi2UCzqFFKHqca8gg/4tUB+RiSy/FYkAQRar0fFlUIcDuVuYSQ3l2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1AA811F00A15;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602016;
	bh=LAR7UG07ENN+2lb2kJivg6c45tgcctR261e0OwsJsJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=c+9Ym+6RgrXmXr+y9nb5lbuka3Y2B8RTc7MTuA7cZfYk+/+XTqxqZcCkZrmoCwFAS
	 OrfHjNmfzYQX5e4cJ0qOX2cFuTZs3jTh6fJ6mtlcFhv8/GFGTuZxEsneyK5aruv/N6
	 SpK3Sqv5vwdgWM1/ivibUEez3rv4suScWfZTGmPvl+v6DTJ/U25s+ByODlM9JGv2fT
	 T+S7zBtp6oN657A6m7MhYxIhjNidEI875ydMJ+mX3vnhc1zNvjLjOta2mh1kZal39Q
	 zGYBbyev0nNyDx5Jvu0XAXQ/UYUT9OpiP4eTeYQwoDT5nfHc5drHmLU81eXXBgkqpe
	 6xwfonBA7975A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9D081463B3;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:56 +0800
Subject: [PATCH v13 03/13] gpio: pl061: drop redundant pending check in the
 IRQ handler
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
Message-Id: <20261102-cv75-gpio-v13-3-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=1082;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=3XWHZond2pOFeGIXcPtw+mHYxFL9WC432M4BN6DutlY=;
 b=MtvfHqKcpor7HpDMtvry+1ZyrmVe4wkmU3y65JLBxYaH3XmIfvi2QpnmoWgZa4cz9OgoyWNY3
 M+bEPJM2tsVA8PbGoc0mJSuml1Tdwz984tzNupXXApJv49YQe8CaE2O
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

for_each_set_bit() does nothing when the mask is zero, so the
if (pending) wrapper around it is redundant.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 919cf86fd590..721f14cf404e 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -219,11 +219,8 @@ static void pl061_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(irqchip, desc);
 
 	pending = readb(pl061->base + GPIOMIS);
-	if (pending) {
-		for_each_set_bit(offset, &pending, PL061_GPIO_NR)
-			generic_handle_domain_irq(gc->irq.domain,
-						  offset);
-	}
+	for_each_set_bit(offset, &pending, PL061_GPIO_NR)
+		generic_handle_domain_irq(gc->irq.domain, offset);
 
 	chained_irq_exit(irqchip, desc);
 }

-- 
2.34.1


