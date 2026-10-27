Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074774;
	b=NfQsfp0CuTLCasyI+ry/h1dGbjbkHxRzIqbVMMp1QUwNcKIkfqOt0iRkiDYV+mWnlHz6
	 6sqkZC44NmM77Xbg8mPkJaxyV4xppQA+PABD/mifcneCE6HTIkclyKgVjQll53JbJlisx
	 mEBWKW5IoBYyU1UqxPp1ygRthiY8hq+yGk4xbgcipboMiWncwPYa8jQZRtzNjvtxK+/1c
	 P1UsPO7c1UsjlP5Fy7qgA52h3LZKDf7LwZWDgOc1DYb0ZDFXStqCzKATge/jM1VJx34gW
	 V7QfCOcO7iY+P3bmi13ne2U6fMcR6NJn4JNpXgQWKMHV4f2RgT4Vwef+G9fFFAIRbsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074774;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jYcNSFJWQbwV7tmw1X4E/Xs+jDT2nnzKGwLhUUyePPY=;
	b=d1uwsZkqpZO6ThK8Xf3DbujUZoMliEBumoLmCOvV60JNrbuWBk0AqhNQFNI8h6nhvLsi
	 QY8hQRSHZi8G0y//pyFmb6bqqDtBBJtwmMEC4c7Cr3GOVB5YOBYxr4kJKi02x3BI/9Edy
	 6jsYijOlJRbYV8u/4Mu71gBb+taCTbwujCIYg/r6GAI1eDVn8GaWpJ6P/ezUYXTAs1Hxf
	 4brjFmEulnnsZ3o5tpGwJA6UZO6Bv1uAkiM+c5Zygliudu+Oh0Y3QldBMYnWMUi/CwOuk
	 fG0vmaUUpAqGXZnNDOT4Z0fvjYR1Hipbko1hgbWO8Qlic9MtdJnLclH9UeLJJnXMMvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPIWvMIb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764160A2604;
	Tue, 27 Oct 2026 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPIWvMIb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793074771;
	b=JVeg7OGDbZo9O7CPmke7HtJFerB2okRXlmzTB74fat6ZYAteBDCUGYzr261w51Zif7Vo
	 wFCA1+6NBukDjPDUshC4boyEORkEVNrdeVLvedVtLFZwsQ21ozbGlq3aFP2ovC2rPTtv5
	 GuZj2tdj+kowPm6PdrB+Vi4GU1lwomaHBU+YvPKSye0p6ew3bRvAWfLPVirpEah07mlBW
	 IKkDjEkJQ9nb8B4EJR+P2uhw5Ob1tm5bM4qnVIiSmfiIE4wCMSDyoTcn2enGGgLpJR4zO
	 /5Z5YUW/Wd9OcdFTWEe6iLH+ch6Ph/i0lXaOvX+lCmF2OKAUB9U8VjA9Uz0VPdfaOxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793074771;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jYcNSFJWQbwV7tmw1X4E/Xs+jDT2nnzKGwLhUUyePPY=;
	b=vK7f1GGV2esi7wWeYt4iBJexEBJovsuX/ISRlUIA+BjFaaB2dw0l7/sNwI+U/sO5IK9p
	 /0ljRN1GKjtZxHFw+cwyHi43wlPp4MAznDS5OrvXZleGo7dPJa+sEAs+l/fbIyt/8lexQ
	 rtpb1bhN8vd5vz2F+GmxB4mAqslc6ArN0EOqg7uLRACXGEGac4yhqqccSBqEAfrsQHC6A
	 OmHObQsvS9YK+zyG2wsXhlwSEFn6sOy7wIbr1WjdO99euTGcW2YUhOcqqoRCGX4y/1FVw
	 KrFBbvcGyNqNo+PlTqviAaJqdls8W8sn/sTa9rWo6KZCZ6nfJ2xXvg99xseol32CDlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 399271F01829;
	Tue, 27 Oct 2026 04:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793074771;
	bh=jYcNSFJWQbwV7tmw1X4E/Xs+jDT2nnzKGwLhUUyePPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EPIWvMIb+alRJ1DidTrsZYyTjMjjrMVeL71ZGHeuZW1xJe0aqbRi3ggmv3pGKqesR
	 cYgkhX33HIGjSwfw2sbhaOpBKV7ltrkErQjMXQTc6dZU6uAc4NXKrgAiTPzQswUuvx
	 KPPkDvuFV5VaEp//sfrxJXEv4w5DiWbuC7c7+D2ksKZ9sqK4abauBWSfSRt60AbAAm
	 CfDWSTOrpKDXpvaIHg7vXJfxkmnFibxND2ROoly9Mk9+9rTRZdVPpffdPDrKH9VRhN
	 1l2QnSg2x80baPdzSq7rkWdH6hEmc5OJUBeYK2g08ML/IsXTTJbzIDI5s2M8wJSMkr
	 ba8Jb+Vp9xyEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EC8E744F9C;
	Tue, 27 Oct 2026 04:19:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 27 Oct 2026 12:18:55 +0800
Subject: [PATCH v12 08/11] gpiolib: request ACPI GPIO events for external
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
Message-Id: <20261027-cv75-gpio-v12-8-c22555400e18@ambarella.com>
References: <20261027-cv75-gpio-v12-0-c22555400e18@ambarella.com>
In-Reply-To: <20261027-cv75-gpio-v12-0-c22555400e18@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
 linux-acpi@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793074764; l=1248;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=nRKox4n5iPzr9D86wqfw40/IYELOR8mAjPAN763uXlM=;
 b=n8NPaJtugvlc/KLICQTtIdT1uALWO3MuMEpVE1pRqulhwW49hhmuelqnTMqNvQAZxO6nQuXyH
 KS3nVrY7uk0DNnujuKhMp7Nv9oL+MkcnKxdkvgfp3mvflRIpAa1N5rs
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
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpiolib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5fb60111151..63c51d9ee0bf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2353,7 +2353,15 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
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
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
 

-- 
2.34.1


