Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987758;
	b=uUddzbZECxGWkQaKotkwZUkv276it2ioPlJ4wp7ZDkx+FeJazJbPcay7x4RJANjhL0Vm
	 5Aj+2o/f4NV2I2x8+50qjl3wd+HsdjMbC+/GN74hMjkqDoqSs+KKEVoZwgT5+kbwiugye
	 ThM8iBJSo476nK4H2vlZgVXPwzz5GXF84WKcq5yPlOL/ewt1uq4qYHBk9Acj4Ahi/ymf6
	 /CrU5sVsKIJXJDcmMHPe1OczZ2Vot6cIJP2WOJpk8TRcIJaCZq4h5rfPKDGszl2X8Tg/k
	 iJ6NDe1tXybt2fmc0tq6NNWDUYDtsqVhwY5vqb5sEW/KgxHF85XkTv2Q2JqD5eYS2Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987758;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	b=S4LEqw6aXisOC6DQzAlOfwrG7DexnTcAnlzD/gFiroc9QQnQumPOmAvqVGYRz4oj70FJ
	 karwG3aTYxfhnnLDhMKVkce31l5LHBmZ4zfJMwLQgEImqnaJFPHXCuKUDagAPkSFzQOhe
	 oeUGElova+DJT1b1YajFY4bRdmsiAAZ9fVJ726xLdnsDdNgYGKfeqFNwVWLH+NI3WV++T
	 NyUf4RFcIeXjzfw+kQy+1OfeTydEG3uTHi7BRGK+quyujVZ3UZoD26rapCvG9IKY7UayO
	 6Hvaz865p11o6z2VSMrd4HlheprF4VhXVrk0bBRL6QxbySpDi+UnXyvzpSXmn1VwVQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+b4TQoT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35661606A8B2;
	Wed, 18 Nov 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+b4TQoT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794987758;
	b=hGrFxkw3xaRU0wu058cRLlrobU2oEzybFPuNdTngZsRTU1LIDFz1gUQAauoz7obvuzFl
	 6lVHeJTj8gWeLljU9syFJSt1+oWuKiwSElYdd78tleGCi92kt+pOZrD5fiZGAuGcgseM7
	 biUF+ymqsAwRiJuqVLLlqKr/stjf65HJJ8h+vSEMNJOnBEmJQbuW6C08y6mpCIrMLmNe7
	 LTP9LMj43cCOEGU5oZaZ2RKJRFdx7YrqhCvixDo12YR/iVvHTCIwA3esQlf8lgR0Yu+AW
	 1Xi3bNMzTH5UmiAkdPHRUGWbhXGrYmgHulI3LV1dJSm/rhXRC1kzJa9uOenRDoaLxKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794987758;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	b=MzMJRqVcHCU0oefkTUGfLPAAylusCuIkk1eiLecy2O58WJfzIPAUaithhJLgcPlNRuL5
	 jHEEYrlK3YetdfJ5lsIxAEzEnSKPDzc1eCTzJmcFa9Tv0zbTAoE0oljkmyPw8eoflY097
	 gONyhxePH9oFUBozZu6OXR4xVu3d8zpkKGVi4A0G4eRRNcdxSedonjVa91zFvKcgMQSey
	 /lZreS5NRf8kTlAo8lKEDJqXS3yvxS7nsnolMAJZAM857pA4Mx6iYuqMQbrVfQKjFEdU0
	 E3NnqG7hegK2+RKBqaijiQxdMfBVXmu8hbfpzI7dbJea4gGNJwh2x5VGQysNU8aJsIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F0B51F0089E;
	Wed, 18 Nov 2026 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794987757;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k+b4TQoTLL6ehMHW1qfemhFIf8AVyYbdDlaOfRqyphxlRsVdtOnuLnDvp5EytUqGr
	 6M8W12gpBGfb3NMHaNgUAkmIKKz3K9WbsYUnneF+Fl4apt2pLq2D/RzGMACQYr4mNf
	 VhCFfYlizhVBY5DY6KCQrvZmSg1LzTjRkgzV+ZcBXTH+Q4dVr8AETStWsh19w+NfpO
	 WyRd1OGX7rAtuiGsWnNmjpQtnVN5jn+fsYdJw3pePUKJWjm2HI41SNmXbr99PSQqPf
	 DEuD9AiYpY161qHpz+niQJv7BF2+zmt5Yezoall+ue7GIjIzFlONs9wI/46NbSEFB5
	 MX3qnb0M/W8Dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B0D14AC76;
	Wed, 18 Nov 2026 07:42:35 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Wed, 18 Nov 2026 15:42:26 +0800
Subject: [PATCH v15 09/14] gpiolib: request ACPI GPIO events for external
 IRQ domains
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
Message-Id: <20261118-cv75-gpio-v15-9-e3c563673fe1@ambarella.com>
References: <20261118-cv75-gpio-v15-0-e3c563673fe1@ambarella.com>
In-Reply-To: <20261118-cv75-gpio-v15-0-e3c563673fe1@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>, 
 Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794987752; l=1264;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=gVUCgjHCS9XSHiZkFjkz0b69YEv686PKlJ2HzVnAOZ8=;
 b=akOmGn9ma8Ex98AfIf12efDxh9OXpmY9hkPl+qJ11g8ewU0VoIpr621Iv1gQGFsydddAKASJh
 9ZNXBHZBydfCKUAKvXZP21Rte5mnMoB0vBU2xOzjajZFCSS6++SCna4
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

gpiochip_add_irqchip() requests GPIO-signaled ACPI events after
installing the irqchip. A gpiochip that gets its IRQ domain through
gpiochip_irqchip_add_domain() never goes through that path, so _AEI
events, such as the power button on ARM64 ACPI platforms, are not
requested.

Request them here as well. gpiochip_remove() already calls
acpi_gpiochip_free_interrupts().

Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>

---
Cc: linux-acpi@vger.kernel.org
---
 drivers/gpio/gpiolib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5fb60111151..c708d81ef243 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2353,7 +2353,14 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain)
 {
-	return gpiochip_irqchip_add_allocated_domain(gc, domain, true);
+	int ret;
+
+	ret = gpiochip_irqchip_add_allocated_domain(gc, domain, true);
+	if (ret)
+		return ret;
+
+	acpi_gpiochip_request_interrupts(gc);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
 

-- 
2.34.1


