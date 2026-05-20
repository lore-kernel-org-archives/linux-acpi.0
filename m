Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897425332E
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238016; cv=none; b=punxn68wWQiE1q6R8dHYjNkJl454zQO7pMnp/wHW9t3FUwXx30aVwqHeqF/6zSPGacF/0yETr5bjMjcFP82dY+TCYN1NWrj3FUiVfCfkRDg24tSVglGpY0bTFP0DnEvKxuISE49J/f67FraLoT9gwsQ58g4HdCFy6+3AuK/8s6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238016; c=relaxed/simple;
	bh=y7Fn9YFogsp8mpT4ZBz1BT2lYDSCTlD71c6vafu4GrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D478fqksCfHzHghzIztLFJ7xJjjElLJkzSijnY3K+bGy0UamkO4CcIIM9izqeowg93G2h67RWVBpkFiIzQsItTbtL9k0GVk5hqsydIz7/2GUk48YP4CqoLCRNCAhVcPScucvo/P7fbHVKmIApLyqqAvqP9DOzC1Ztmz+Mgt/NbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi1gK6X1; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi1gK6X1"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1309f4ee97fso4798771c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779238014; x=1779842814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0ubYMzKkPwIELjCKI6Oon/usrmm5Tf+jdhwqr1a+Dg=;
        b=Oi1gK6X1wdaa1laIRBm5oaQHz3rdc+QnZbBsoPKdvwfxGp2l8ejVp1ZHpXea7gwW3V
         I3Y1u9ZY8gY2cnslCLHJ9TiYdgcTfRg4b/PHNzHKLokzIvZKj83WGrEbwEKx14dHDpPr
         /tm9sRYECBzfepI0NS37n0nluvJm58OBptAiqp+2EBtaG7dVjH9oRNc8VGXvTP8RBZWP
         ZmPTSD/3QGURGt7d8HArEtLhx0WsWJnXNSZnGriaSxas7II/3JSfZ1O4sdWujXtFUIn/
         DpyYf9Avp4sTN2LXkdE7DpevYGGjWKQlM3AKzSfNoXY/AVhyKVbp8xv4J1dbqCXmQApm
         PXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779238014; x=1779842814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ubYMzKkPwIELjCKI6Oon/usrmm5Tf+jdhwqr1a+Dg=;
        b=SJSK+CgNPf4VYIP3O8IEiq/RNlWMOjZb4zdAh+1owOCJ7QIhCkj9bZZ2TpwPQFQVQI
         dohpGYS3mfnwlH/DtU9vpjGxc6UjinmLyFwD1umNWJowGwJE2nDJQGEkbgR2HiaFosGr
         2Qe9cfyUwqbj0jsGKt583E9OJe1R44bITNoWcTLWPqn55w8ekAvYkP8p0AgUuGQrNZgp
         WckfppYjAzGeuTtlcwbqOsw5qsbRfIWkDUtGz1iilZ4emvv5NOr30s+BhQMqa80xlOeh
         JBN25KKD2zvPvjcU8lGjksyqgtGaHvljtLTXTPapHvHiRL/xBz7qSvaNPi7UrwA3P8oS
         xImA==
X-Forwarded-Encrypted: i=1; AFNElJ8Zn9gashQBP03rGDg5n+K8FGtGp75r+r//dZ5hZ8Cm+7IttwBDfXipxg9+Ga9ZyZj9ftlRwILYBF/2@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqxQnqcRwdwZEM5dw3PUAyV6PeBAIwqi9oQhtSmFEt98p0Ku8
	Q+o5/Jb7/XKgizjwpUPeX8k2YWStRuGZP8rm49bTqHfZjLkrtU10l3l3
X-Gm-Gg: Acq92OGglhEoOi+kMy6i2cSGmgle7u64zjIm9+LNAJh6dFomJNgD0KKmFv/4m5/Q1w9
	LrADN7oB/HuRp4z5zVx5tP5wWvLAz0uG3hs6EcC9r5tO/d0Cmk/jfhV9P6Tp+lxY3wl+DBBJnkg
	ETyqVWAtb+v7LtVdW6pcWxIPIUlIc8sI2Im2oN5L4DzzS887wTzn3qSHdttiJb3Pnv5DLQ6L6Xj
	xuciYLlk7Xh1lwzEIUmonm6NiCO0UwrRd9XFGeIPoUH5qGgx82aIgHKABGF8U+rs009MDZet5Ks
	kdi9st2zW1cUpKyNTG0vvgMUHUO2ohDfEF4jK8JTrAzuQQr8sHvDzJnEQenfWsbER4iLMOcAvqC
	rl0pMy9YLKqxiLao9Jr621ZHwA5FlpGSBJZPVdyIEB9Ha/7ieHGdqSsbxa+h8Hr9mjY20S7DRjf
	okzxyveUhCRjz+cw3vbROqYMhP/T4SUn6Iv7SU4na95Xzz00/UmNP3wx34VKZhDYCf
X-Received: by 2002:a05:701b:271b:b0:135:da70:c2d4 with SMTP id a92af1059eb24-135da70c454mr1271166c88.25.1779238014087;
        Tue, 19 May 2026 17:46:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7677:c3e6:c92a:e780])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm25928705c88.7.2026.05.19.17.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:46:53 -0700 (PDT)
Date: Tue, 19 May 2026 17:46:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpio: remove machine hogs
Message-ID: <ag0Dn66ZVnbTc7J2@google.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
 <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>

On Mon, Mar 09, 2026 at 01:42:41PM +0100, Bartosz Golaszewski wrote:
> With no more users, remove legacy machine hog API from the kernel.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Argh! What is the replacement for this? I have patches for rsk7203 to
use them to get rid of legacy gpio use, like this:

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index f8760a91e2f1..5bbd3b31cffb 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -12,7 +12,7 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <asm/machvec.h>
@@ -165,6 +165,19 @@ static const struct platform_device_info rsk7203_devices[] __initconst = {
 	},
 };
 
+/* The base of the function GPIOs in the flat enum */
+#define SH7203_FN_BASE GPIO_FN_PINT7_PB
+
+static struct gpiod_hog rsk7203_gpio_hogs[] = {
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_TXD0 - SH7203_FN_BASE,
+		 "TXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_RXD0 - SH7203_FN_BASE,
+		 "RXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_IRQ0_PB - SH7203_FN_BASE,
+		 "IRQ0_PB", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
+	{ }
+};
+
 static int __init rsk7203_devices_setup(void)
 {
 	struct platform_device *pd;
@@ -172,12 +185,10 @@ static int __init rsk7203_devices_setup(void)
 	int i;
 
 	/* Select pins for SCIF0 */
-	gpio_request(GPIO_FN_TXD0, NULL);
-	gpio_request(GPIO_FN_RXD0, NULL);
+	gpiod_add_hogs(rsk7203_gpio_hogs);
 
 	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
 	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
-	gpio_request(GPIO_FN_IRQ0_PB, NULL);
 
 	error = software_node_register_node_group(rsk7203_swnodes);
 	if (error) {


If there is no replacement maybe we can resurrect this? Or shoudl we
have add swnode support for hogs?

Thanks.

-- 
Dmitry
