Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602018;
	b=Iq1cWvAqQbHHSeLpeU36qPkYVThJ3pXO24IQwlc4WuAbniDBoQHkl/B5Zp9PsZQaLiZS
	 LLU62TjLgIvAMpig+tduYvbGKNzmcj01L6fpoPEQ0atw2l6E+swcBuEdNah4P8720aJZA
	 RXPQB4ehpTq9OgBe1FWnhagV7cRoCLVMR8o+/BSyfQbqJ+ufhk55+qQBoDeolR4InXvSV
	 aMjVk2GYMd1csRQxLWf/j6JOAfDTKZykEySDc13y2laE5Zy3CXV3GUyNUvZIR8RncWJtx
	 eahaBN2QVVIHbWJQDjJZAqKsNjp4w8SxqavB7zXf5Xomigj3AB/YGA2H14z5wuczBIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602018;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4qv9GBI/rff/ofiL+Z9pE00Rlu1w4yrYAER5h1S95vo=;
	b=GWFzOD1fjmMPeQ01ad2oDT0LSwT4IExlpZaZobH6W4n9HsmOXUuE5sWjLgRHWPbXRa0b
	 iAo2vobmGY8FqJY2H2ylrbP+XqzBe9kaQBPxJTAvyVtdtIcMvJ674oXDnPu68oVKxL+PF
	 kS6FxTqk80/Wu5LEZclal9D1hMLJqpEIYEoQsU4NbOPU5FsPD2I17CC+/5Hl2RsrQBGgo
	 PO9voi/74Hbvoq9JDaHGnCOxQqC9lYE6PC2e0z49yIgJfNnZBD4fwZC0QWztliO1A/mdB
	 azL10O0HVnZeZtfqSC0Dh+WkwVR9+ktGNwVwAhAV8g9H3RI2jHnapl8MhuS7eKo0TMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOEPvOFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B264606A339;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOEPvOFs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602018;
	b=BE0+7aO7EsGzHDcR/NsX8gLXEt8qHJGg3o+Uw4e9SCK6z4JFfWX2tA6nm5B+TMmVQ5Qs
	 aMovJgWIk9NWaBuTDY6UMaBnJjfNhlLE5wrQBk3jc8JXXfuqiIfdQznAGJVWPX1SAtrQl
	 vw3R2VlwyzIgrQogPQy11fsCTBbONo7paRufUQ4FkivAFtJufHQL8d5dBGsppNG0UxWl9
	 cg4qx1GNsSFwE7fxeph39THfeGOXEq30Rml7RI64JorFO5Kvyg6GB4uOm1vJkcpikSF6a
	 FzVuJhulAUtIIK4dCY0QUKmHQ/b3B2TB84DW72XFuHKwcCvqfrVFkHUbh6vx2HP5Ivw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602018;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4qv9GBI/rff/ofiL+Z9pE00Rlu1w4yrYAER5h1S95vo=;
	b=yxKY1dU3J+8ciiSWspBgF0bVSfXh+YW5FMMqy2KMw6R9IoNm1Ff3MxExLuxS4B7fSClr
	 ojRjoqaHud/vBj6G4zPeHqlgrLHUdtxV+wgLtMtEgeQk/72YXB5bpAIwM59wnLKD+DdoA
	 P9gD/6JvjVtkT3XtDl1epnjzpQ/sl1MjB185myz+LFAWihyf/NJsoaIuzsY0o6ZSwJDLX
	 9rAjREWJofzm2BUQCv6Tvg7kvMNWFb7Iic7iABH3ALJL2iMEw/1QS5IkIJiGAez1Z8fdN
	 E+mMjYRt+v3K53eXyH5KxsLy9INPNXgojsocDG8w1C/F6Wef3IDM0EPLOJlJYHIyMpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 39AEE1F00A17;
	Mon,  2 Nov 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602018;
	bh=4qv9GBI/rff/ofiL+Z9pE00Rlu1w4yrYAER5h1S95vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dOEPvOFsacP2DngJ+KyehB+Pdzx/l4p1oZeSjqgEBY9BAFDQeRZM3TmCPVreESegD
	 oMkgGn0edA0FdWq6QaxwZayizSkwHmxoCyzTZYwh6Agmm0gP4XkAtO+uedqz05VBR7
	 uhS4Pu5b+KTt6AJe/FAsR6mhiqkBjNuPvyGUVxPzpS1K6KGfM4qo2DxSXgzYHqPown
	 ktXZzbimx4Nf0Uj6F9Rnijsedyeh00mInszqiFCh8oRlQyTo/db7PJGgKApVvrAfA+
	 gSi3OxJRaKlYnATTrFYNzHHToKCNCdwmYPUQM76gNCyFr/ZXYuQUrH1GnhgRDM/Ytv
	 lSwaJ/MhjvGkg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B822F463BB;
	Mon,  2 Nov 2026 06:46:55 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:45:58 +0800
Subject: [PATCH v13 05/13] gpio: pl061: use IRQ_TYPE_LEVEL_MASK and
 IRQ_TYPE_EDGE_BOTH
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
Message-Id: <20261102-cv75-gpio-v13-5-4f93114ea204@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=1433;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=qYs7A+3O2UQ/LJH+vQzcUZYSnBtFDMS1HvLlsWFL8rw=;
 b=HOFWnJUFa+nGTw1RNUWuQvQYphvDTDWJaYLxAhCs3PMvTugGAYLmqIWq9cV+gUJ80RWaBPt/n
 HRGME5PGzn6AZPflBYFh4ct9fDwPJC1D1WSzDh71wKdwOU2PzxeAtPB
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Use the standard IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH helpers
instead of open-coded edge and level comparisons.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 781bef987339..e0ac8335bae4 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -167,9 +167,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	if (offset < 0 || offset >= PL061_GPIO_NR)
 		return -EINVAL;
 
-	if ((trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) &&
-	    (trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)))
-	{
+	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {
 		dev_err(gc->parent,
 			"trying to configure line %d for both level and edge "
 			"detection, choose one!\n",
@@ -184,7 +182,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	regmap_read(pl061->regmap, GPIOIS, &gpiois);
 	regmap_read(pl061->regmap, GPIOIBE, &gpioibe);
 
-	if (trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
+	if (trigger & IRQ_TYPE_LEVEL_MASK) {
 		bool polarity = trigger & IRQ_TYPE_LEVEL_HIGH;
 
 		/* Disable edge detection */

-- 
2.34.1


