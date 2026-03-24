Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1138BF83
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369523; cv=none; b=DWv67xui2Q5wWDoIRjegYUYfBHKxYG1iwuLA22zYk3fkIan0vv1H/jjMd0b3VPeIZdXo7eNuzFHCynvwZBeOl0yBCZPg08vktf2H8crIO5e0sGEAVMd+KVJBMQxg+6hPnADKFOkjIZR3qQiFuW44irp66NkmavbotU438qMdVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369523; c=relaxed/simple;
	bh=yhN4R1wDd/73oDNMRxk7G49xgQ9prvPPOj/+PLBITnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc5f27D9NiMkeabf3X7M0D8cvZKzUwE33MZdECVBF6kQdh9+1O4NZfLEBZQdl+Rwf0IOryXjz+x5iUrqUAIgNZfY5vVEX+6Tk5goxivyrTxpQi10xCbouGEg83Fh287XqACOkQ77oRDX44lxCmPw+/zkTKhNTDH6JAj4sfyqg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImY8d2fl; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImY8d2fl"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c11c43aca0so41864eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369520; x=1774974320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kvfrEneJK185kDtn5si+bhliaq4dUjYW/h4+n6Kuf0=;
        b=ImY8d2flLZP9dL/Jr1iTstUjvZ+wBGLdE/YaEKEX+huHGU0Elt4iksqsdLdKS/pYAj
         8HNs4iDbdAkeoFZjNhtbVVb9PopoOvb5lMbhDhfEB0rv5HcSu6p430csKnxzYBUBLbqy
         3KuCNlEqgmwOPn26gkdp7GfGMVzIaVVEqoe7bm+ca2jOgx0E6i3oOY6WodRurUUcgW5h
         0mPFiiMU+pRf7LMllMdUOuLePBZRGuXT19Amegytkk2Qet5bAaQ9NhWpVLa1rGexZM6V
         SvltN0NHD6g3NuhEWSKhwH8uRJniuCbI1J6eq1Ex8vRNTCScSqjcMj3Z67tK24IPAsqc
         gcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369520; x=1774974320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kvfrEneJK185kDtn5si+bhliaq4dUjYW/h4+n6Kuf0=;
        b=D1nUR/McYIg9P0SIh0H4RHDd6qMbGq0Q/Wm1JlFMxv8l1IYPvq8PrAnQZYdl3KN6lD
         mOSHu6R6zD6SVtsjS9yCrMag7l0ndzSjBNOYoqOTqR3op0ohLdA0x42zI/uWAbZYLlfn
         8UgwnV5PNttC97PKFXf+cuX0qxIjB1aDmjrZ4e/Q539SFTVpHEPf0p3fCUhFHZg9fSCd
         +/pgrBBpO3aKE/myXl2lwH6Xb8ULpUpAdYefRWl8u/HT/sDO7akEIxWf/w1iVgHjam/I
         aJGteSn36JSccMPDrn3sh1dDNMUdkomskxaSkHaL1BqPN1DcUMHfR3JoE2zdVwV3ljWb
         Yf9g==
X-Forwarded-Encrypted: i=1; AJvYcCWiis8MK+KanRjQP2oTij+hY2zlTE17baCO1SLFXEhkxNF2gaHa8TY40APF4gV/p4eEIeCfTrUuDI7l@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/bDVd4PSgBT9x8d6ncszMGSLUlxtVBc2AobvmPijhEcyl0jQ
	dRNXpRcx7VasZppW/s1gt3zVljvPfZzs+JBJErhvcKmZYkIwfwpZgcnD
X-Gm-Gg: ATEYQzwSsQY0V7g1opD+Tiz5in20VQqVWo2ID5ZvYhnyxU1pZBsqH9ReDS2rRuIPubp
	xAFpdll3ndR5wgBXiYDofTeeAprPU+56V53AjyqMjzQwgTTiS1twVu01+xLfzZv7I6JMcDIqJtn
	wKTgEVZw6EQoCJhMYU5ig3H/hPunquUdelCDXLHXkdAcAYSJ2sxnqUSII1grcntu3W9u9WpHE0U
	OBUFJHW4j8XN8Td425ekf5pBdMRW4eBbdfaZtT6B8dTBiI62G+8LKtGCefGzlOQ6tBEr6DYiz+f
	pTp1DVKA4HFKWA+30bRiGOiYwYYD/47nQx9eEobejDt84H3RTKKSiOAILAdAiQhoKi3PWBiZ75V
	rUaYdDt24oSmlbueiYXlTqrBmtJ7+mHUy2uda+NBzkvgX8HeJ5ggnjv2DL63ZJ7LKWQKG6tKxN4
	6kF2F+Ywaw+V8iYijqJPZYAepWxPdjTH5yVYF2DWuwJIjn1wUuBkNBcxLEkvlloP8I
X-Received: by 2002:a05:7300:dc14:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2c14b4c86d3mr1691207eec.7.1774369519720;
        Tue, 24 Mar 2026 09:25:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c299sm15553433eec.6.2026.03.24.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:25:19 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:25:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow referencing software nodes by name
Message-ID: <acK6qV1Be7Wl-Yiv@google.com>
References: <acIV6xF8mY-8wd5e@google.com>
 <2026032406-recycler-device-7660@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032406-recycler-device-7660@gregkh>

On Tue, Mar 24, 2026 at 08:59:24AM +0100, Greg Kroah-Hartman wrote:
> 
> Do you have a follow-on patch that uses this new api anywhere?
> 

It will look like this (obviously split in 2 patches):

diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
index 05189c5f7d2a..ae43ca2ba4ec 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -14,10 +14,6 @@
 
 #include "geode-common.h"
 
-static const struct software_node geode_gpiochip_node = {
-	.name = "cs5535-gpio",
-};
-
 static const struct property_entry geode_gpio_keys_props[] = {
 	PROPERTY_ENTRY_U32("poll-interval", 20),
 	{ }
@@ -42,7 +38,6 @@ static const struct software_node geode_restart_key_node = {
 };
 
 static const struct software_node *geode_gpio_keys_swnodes[] __initconst = {
-	&geode_gpiochip_node,
 	&geode_gpio_keys_node,
 	&geode_restart_key_node,
 	NULL
@@ -50,10 +45,6 @@ static const struct software_node *geode_gpio_keys_swnodes[] __initconst = {
 
 /*
  * Creates gpio-keys-polled device for the restart key.
- *
- * Note that it needs to be called first, before geode_create_leds(),
- * because it registers gpiochip software node used by both gpio-keys and
- * leds-gpio devices.
  */
 int __init geode_create_restart_key(unsigned int pin)
 {
@@ -64,8 +55,7 @@ int __init geode_create_restart_key(unsigned int pin)
 	struct platform_device *pd;
 	int err;
 
-	geode_restart_key_props[0] = PROPERTY_ENTRY_GPIO("gpios",
-							 &geode_gpiochip_node,
+	geode_restart_key_props[0] = PROPERTY_ENTRY_GPIO("gpios", "cs5535-gpio",
 							 pin, GPIO_ACTIVE_LOW);
 
 	err = software_node_register_node_group(geode_gpio_keys_swnodes);
@@ -136,7 +126,7 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 		}
 
 		props[i * 3 + 0] =
-			PROPERTY_ENTRY_GPIO("gpios", &geode_gpiochip_node,
+			PROPERTY_ENTRY_GPIO("gpios", "cs5535-gpio",
 					    leds[i].pin, GPIO_ACTIVE_LOW);
 		props[i * 3 + 1] =
 			PROPERTY_ENTRY_STRING("linux,default-trigger",
diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index d0fb2e52ee76..6941e124e87f 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <asm/olpc.h>
 
 #define DRV_NAME "cs5535-mfd"
@@ -29,6 +30,10 @@ enum cs5535_mfd_bars {
 
 static struct resource cs5535_mfd_resources[NR_BARS];
 
+static const struct software_node cs5535_gpiochip_node = {
+	.name = "cs5535-gpio",
+};
+
 static struct mfd_cell cs5535_mfd_cells[] = {
 	{
 		.name = "cs5535-smb",
@@ -39,6 +44,7 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 		.name = "cs5535-gpio",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[GPIO_BAR],
+		.swnode = &cs5535_gpiochip_node,
 	},
 	{
 		.name = "cs5535-mfgpt",

Thanks.

-- 
Dmitry
