Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602020;
	b=ZEVqLLCmxYq+2TgZ7QIhwuNXpOHfqzZQmMKdtIzublDD0Pnaog3GF4XINJ8hyQbA53zA
	 LSF5KbE1l8btkCRwZvib8oIvVoCgZqMrko3kPk84mJPnkTojEpIEhAQX9dX3eE1dUbSwe
	 dRo17KrBH9zqtiLu9EzGLVu1F/ZKoXVZR1fdHimws5/ZAU5nL9f6PPrxTIGupqvYqn3T3
	 xZuxtX7Wc4k9VH7g+MEYWhn/e7RO/JCs/PqijCqf466xWnV8KazhfQj3G8Oe409koAOA7
	 rJQAAdi2+zqnbhUgXVpnDHPwQSVficvsNeVcIPVCVWrvwoJeMYDxRDQ/ezQ4+4bxW4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602020;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pEndLz4GqYmkPUkp+03fPyPtIwQ/zDtAgVJtXhEv8k0=;
	b=43tHRo3UJmMwUaI/ylrDwUyhK8aLfkmEP1hMUr+p7gIREtNaRUmMgSRErZTLt6L0d5Bh
	 M4GZSzQLHuovx/ggC+fWm709euy4ZCC6JZhZgbguf3pdM2yPkHlMLg4UDgg0PD8jSOMe+
	 GaKM7/vgELCiDJ4YvYpLp396xO5BUlLbFPZIPwNos6+OI3e/yq+JI9Ze+kpJiqcCNWu4V
	 tF6Eue9BZFUTB9M6fYWVEOtJLxJ33liRE+TvUjf6Lo499QfqhLARpKtSTlAqJ/TvWKYPH
	 XpJnjdDCO6scHvIBWP5cQUPCB8P5Bi1DdMavtBdJn8PtJDVXJqkQGh3hzIgbzqgz3vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTqKV4cb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44560A2623;
	Mon,  2 Nov 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTqKV4cb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602020;
	b=gsHA6TgYYMQkogb3WWc7ktGCZ9lueycUaUd90WeWczOXLT5YgPhIwnirwDgSKx2hBShK
	 O6Oecrj0BRoTk/1QgriAYbzZc/sY3O8BvDIrlzaX+4nmjp2pON8b2jGSi8ciWSnMkngCP
	 cZRdjnD/WS6GK/nVhTSgguKaTgYq6R/bMvIBxjyTPLCgmadMX4m30kS/iKBRXHeZbt2iK
	 Cpj+ctG2VgZLlb6KNjjZAuaP0ccZDrm3Pas8opcslN2/p7fGzLsAh/B07XHzZYQT5RMnw
	 /ImsUjb4eQwTms2nrXQ7QB+vDB/d+j4nQiMKhnAqJXOEDY60fXqMCr/eCYKkLWDAQjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602020;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pEndLz4GqYmkPUkp+03fPyPtIwQ/zDtAgVJtXhEv8k0=;
	b=qxRSq/Ub5S1PkXROPGymyVXCH70ebXThHcbq/58fNOrzLs0pidgERjzcdFwGtFgEuY97
	 bl5G0y8kDS2NdZBy1/aGFrZLSOyyuF0xySGjnJId9srSWHpxV/rV7he6leO46yj47bEiI
	 nWiijhg9oVZYxGc+8XSq4IcGo1DZLLsXxt6Y+0o88RmRVRCODIoPtE2ezjZ/N+snrs3bU
	 JRxiNw5IrmsmH3i+yOJyyChjpyEO77U/EdPQmxDW1k85Ri0bA7DVzHnvZneXOA5Ues2Hb
	 S/IHl6nGzRofAyzDe/eiJEgnSjA/Hu4L1UiRaHqWmbmvFdbYecaJlGXWaAbbjrCwnbA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52E541F0093A;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602020;
	bh=pEndLz4GqYmkPUkp+03fPyPtIwQ/zDtAgVJtXhEv8k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jTqKV4cbTKihuSmNkz/+JDp2+XHAs6cmhAqvl6gQb2yqaeriLG2AlglkUE4ynEV83
	 18D7aRpz2aTu5V2+FN0SrxTgV6jkbSqNyBQzHNuDIdZocc+8syDLG4Iv53s8mt6M9k
	 H02UUagFEoIfvghVPCvejyZDDQ8+QvmIkNQTcIhpSA3Ordxv+XoZ0LxAKuGrbVTNRB
	 RvkIdtjONWyUXWEVq8TLAIh/zk9+jS7SkI8zMYICu9yM+VOAtelIgCTBFZBc2QOUU1
	 Ff0sMdD9WrSn6yLOKVhu7avRqAA5JRVcu7k2vUZ2CLhHhDk2Rh3IA0Ee+JZCF9/N/2
	 KDM06u5gHk8Ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ED16D463CB;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:02 +0800
Subject: [PATCH v13 09/13] gpiolib: request ACPI GPIO events for external
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
Message-Id: <20261102-cv75-gpio-v13-9-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=1299;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=iX8Xb0+PinHVdTfUGv4kYZvwdiGV19SDmTbEVrsx8Kw=;
 b=SgVZg3oLNdgX7Cwul3GCiom5Nd2FLLWQUZtdfemMVC86x/tqx2ettJYHDNfcEDD5HvA67QgRE
 NOdjEnKtKmUAGj3TzRH0sYekOeMxcp7QKp1DYw/WwFn5ccbebJSkOTW
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

Cc: Mika Westerberg <westeri@kernel.org>
Cc: linux-acpi@vger.kernel.org
Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
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


