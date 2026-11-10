Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794285170;
	b=lIEWO/gQBQc3Cjo/SMAGrq9WwsSKJyesq3B0WqQSWal3awiV8aQiZH7EaYrnDhg78PA6
	 7p7X5Bz0F/invfZfbVL1vc6/SC1e42AhmUy90TcNCVwBRD3GWoklzImGuo05P0xp1w1ZX
	 1oGy5pNVoEB67sxrp3NtOtpduqFBXOVyDKVwP/QUqMAdS2YKdVpoSMR3iX73RCYx1y10m
	 aJzzRtBhKYWJkswtTRvwS5kwqtIAxDmQDX5K+cyLQ/xvaqLlF+gG+k2V3UnMvB9uwGjzz
	 vk2qfJqH+o6aHeyBx3JzGMfN5TxZ1aTINMg6QQ/7L3NjB69LgwqVQbHLLfynMFt4YRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285170;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	b=KnTx6SHtVUwxuz9QLS08le5EyCvh7e5L1z2nCAaIqLI/AVz7WsT0S+MmzB37w24HAfIB
	 gCTX7deETPJ1qyO9xCMtldie+S+p9tKs6KVNjSFSYwnW+LtDKHi8fKHgfyWyKmdRxsE3n
	 ja6iVJq8sAHd2RGLG0Q8JEy0pZLRRZq0RfaFTcXAtF7tDETcbUtHqCqmMGs8YAmYnWxKQ
	 sYt2IFFO+UUDFIAg4vXRloyrzXNAAF+XsCPFqbBvxXX998Td0od+gjDkWCdc0t6e0R4Zq
	 2jCm+F/7gQbgOM0t6pc9GyN3RMF0RMCjUf1nhDNV1orKy2BKeZ8Pn7cb84mc18EcafQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEFYHxAO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1960A2633;
	Tue, 10 Nov 2026 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEFYHxAO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794285169;
	b=qxs8GlZvpuUe1JmoN93IULoNJlPKHnflfXWO0z0xNABvBl6mfeN2NuBIfdY9rJ/83dly
	 Nk1P0ZIpm/6XMaOljpYrvdL7uXhPrqp6ylieMicR6S5HTwRzQmqx9GOwL9AbiZAbUxqft
	 CIL7MG+moy/nlDUdOimba3PDrd57EDVGF36ck5DE0B0a1T+eCOkgS813gGf91pemOxMdL
	 2pthDW69gLurDrPZFegut60rMELV30T6P9tig8NmpJlJHVR9pB7FmLYaRhfU5LiixA57D
	 n+H1BXLPh2XJwGzbDbH4ffqa5CIQ750yIVO9vKooguY8sj80uIlk9lO1WQF7MqiaiRw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794285169;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	b=T+KkusY8pQ5tdw+Zvd9+pnSyIIBHj0su4rEgxY9jfxzz6pK8ASkCUmXTTT5AwgEBNNbg
	 Zwmb9o0lM6Qy7fm1eXF/FBtJ5xdje9eRvPuCxgglKQus9s02vJJd0SEwoD1W/0q8mlZIk
	 SivnQW6akSuepqAVwTzTCofAHdHY6w4k9MQmNxw5xz+kzjv9XPTTOteKd00wwmGE4N+vr
	 R8n2taUEzGsW1wzZpgNNi8lv9DhHClHbiScZoQlOqN+ma0elGZ4iiYWzVmB0h4v1B0tdh
	 Fj1rtb4cbhJQjtO6Xmom1DqWoAajAhLeTBla5YEpMEGvHo+rGQzovqhZM7cy2Uqj7yQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11A2B1F008AB;
	Tue, 10 Nov 2026 04:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285169;
	bh=lpMIYvYM4e1N5ncXBt5rAZ4BpSgX8FAu5IJ/N7zbfqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aEFYHxAO5cOwOrIR6IeTh7O925BVrDY0r8rvDiRqc8ObTO+GNqfwFeOU/dhIo8wx4
	 yMJcQ9e1fH07OpZyuCLg9Xg8RCwH9JOuBYxe1Q6xv1jWmUPbeNZl5iX8p7vRn0isOF
	 4KKIeZyYg5mCUWRYbg7bbAnvIeuQSEKgHFQ+/dAztt34ZT7rnjf7VrzBKaLhLGHK6z
	 alg4kECcYtHaQTTKf+QtEK7aBaaLd/rUz0cVaWjiCvrgYqm/1ROQuHe568/Hxs+pQ7
	 Kmq1OQ2V5a7qfCUpnn/KhI8R3aVp+g7+lTzPTTH1w4CBr1wPzbu4PQj+0HeAQC5AxV
	 6OS5cdPWDt3hQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2A86F48871;
	Tue, 10 Nov 2026 04:32:45 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 10 Nov 2026 12:32:34 +0800
Subject: [PATCH v14 09/14] gpiolib: request ACPI GPIO events for external
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
Message-Id: <20261110-cv75-gpio-v14-9-e586aad0467a@ambarella.com>
References: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
In-Reply-To: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794285162; l=1264;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=gVUCgjHCS9XSHiZkFjkz0b69YEv686PKlJ2HzVnAOZ8=;
 b=EjnEQ7Yq459Wok73+IUHDlSh2Q9ZdqLbv1+aWGH0JAYWUzg/OICQIvAuzW19xwsfpvw8Z5H0H
 dBA28Iy6tHZCnsVBaE5Bew4i4T+EN/6Vi4i+/KzKeWnhriKGuHz7V4s
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


