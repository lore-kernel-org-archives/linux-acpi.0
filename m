Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2123391E6B
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837680; cv=none; b=t44eSaQJOh4JAXi88fj1wTHGWQkZ3fAobR9e5MvieY9u1+Vf5bLN9KxZOq1E3iBjIZXL8QRQS3CJH5+lJnwFSR6dK+LGMEeWNgkft9WUfIwOg3Qw2frEMcN8B11MnP1eV+FapB7h/IIOaDTTJr7NqAin9cCVXIbdPIs8iWOQiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837680; c=relaxed/simple;
	bh=QDf16Y7vyxJr6CaPRWRkq0hvjTb2t+Mwk/4kS11e5G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swiY7vkNd6Th30mf62n2d1eM1qt/qUaS4/yH73x6W1NqZOgEwDPv+glwUBnQBdXSTvmPV8UgyrZ80Sij3VyqnBr6jB0dc60HTDInbUZYG8dij4kNrhC06PzGSCOpBHl6JVcipFBVnbXqaz7Wd3D90ISRGuo6yGUo50oiB16FLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M24Nnnng; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M24Nnnng"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c1632faeb9so7149554eec.0
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837678; x=1775442478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=M24NnnngCdbbWFRJIAXGs9rOMgU9vpwJHy6eKIx7wetLpAmVu97WfCeBGQSj0oiOwa
         VRlu2L8M/6hZRgOyWxjhFPdH3LLfi5wNZjUSJU1v7mCckHdUv+cuQyg16u8ebFKavgyv
         4zFRKIlsTE/BdWm3XtfnrtwyUo+KCj+00hAstxj6+OjrqOYUCw8cAudl3YNmqY2OgL14
         UscTACGTOijvzFvKpPkQyVbXa8PP0COB1V1Rzi9JzloLlA1EpAw5qLxNNGtTe5b5xbEj
         1ngpbViPsQRal7NbA+dJub6KUFsDN5SPM8AKCXLsEa+2gLtH4Q44In8Gm4DLh+TaXsJC
         eN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837678; x=1775442478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=RPXOb/QeiLK1OTIbZLpSWFmySgikXsGSsU9WAeTYjCT6Zbc2Xej0+gCmaWcXcahZCg
         i71O37dv1DmWj+3oXZsSMQDvPVs1/Y3wOZjRtF20SU9QdbNl1E9NFG8v6oDYYs0HmKE8
         2s14JMa4G2nllOBhYvGlYwGYozuZrk9ixyuP2zXrnhAVvHM0KAZ9dTv5kTJoeLKQGMqO
         gA7A58LEyyAfdPJZwzi8piZu/mRZPVmPmig0KPViSMXqOECsh71rU/7W5JV4C2W5Z/79
         xjShYZXjDgmA6rw4gdFa/8c/0JQw3b1je5DFjgWbd1larkI8UmLgwrCK00huV4kRpgzm
         e69g==
X-Forwarded-Encrypted: i=1; AJvYcCUbgpvkrvFEqtognmR3wkf5i0s9RJHP28FmVHHfMSwsZcN9FUknkw0fk0+El21MCeQrZ7lq6VTD/ngN@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVb0M0XNMfJqp+pgPbcxVr5x8YXyJf4zJM2SSJD4GLlFP5z+G
	rY9Ucg1BzCEDaxTgWKHn8dOVXP1MnjSlvXdt0hxgbvhdX0mJE+5uDyHH
X-Gm-Gg: ATEYQzxJDZqMJVKNiIwn7jSHul5jhpu04pStJ7C+hwxLKoRGScoLjLlSoMJGj6bvlcg
	OiTQi2GG+4xotJx0O4J+sG0CtSaYJpaf96zXnc/AiBHIMFMxTiBjfTx7GDYEP6u1fsZJjnZNE94
	wMEQyn2MXGGmOnl5c65TWqvPpmqwjLU9fUvzOU+QjjocYb6m1jLWGMJ8LfDkFoKncjEw+TppNA7
	3lpKRGFsIACRUL9eCfmNJiUrfkzHfJlrADkXsTwccPXpK/Zg0HfnkRWJZK9AGdQ0YK8jxsvC56v
	kFxrwJ6B2FsVlKbbw9tE3ji+H9CMUbT9y77LbZjOym1VGpqcD4TpL2b1AVQDdzIcgCJtQJECsmf
	5HpxfJCEKWqMl5FgcTaPzHvANbCet26GJ8WAKFmrqDhJTiKPyxw3j08tkT07ByY48dPPnXMNlm+
	M6pvE8XjjfFTz7T+G5kJ7n/JRBn4vo890DI1QesdNg0KpoLylCdcHYQ568IjmJJOSbXeJAWlzqX
	qCehbPDI4pJQeQ=
X-Received: by 2002:a05:7300:3b1a:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2c5b23e4f48mr1555198eec.23.1774837677943;
        Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 19:27:48 -0700
Subject: [PATCH v2 1/4] x86/geode: fix on-stack property data usage
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
In-Reply-To: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6826

The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
creates a temporary software_node_ref_args structure on the stack
when used in a runtime assignment. This results in the property
pointing to data that is invalid once the function returns.

Fix this by ensuring the GPIO reference data is not stored on stack and
using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
reference data.

Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to software properties")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
index 05189c5f7d2a..1843ae385e2d 100644
--- a/arch/x86/platform/geode/geode-common.c
+++ b/arch/x86/platform/geode/geode-common.c
@@ -28,8 +28,10 @@ static const struct software_node geode_gpio_keys_node = {
 	.properties = geode_gpio_keys_props,
 };
 
-static struct property_entry geode_restart_key_props[] = {
-	{ /* Placeholder for GPIO property */ },
+static struct software_node_ref_args geode_restart_gpio_ref;
+
+static const struct property_entry geode_restart_key_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &geode_restart_gpio_ref, 1),
 	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
 	PROPERTY_ENTRY_STRING("label", "Reset button"),
 	PROPERTY_ENTRY_U32("debounce-interval", 100),
@@ -64,8 +66,7 @@ int __init geode_create_restart_key(unsigned int pin)
 	struct platform_device *pd;
 	int err;
 
-	geode_restart_key_props[0] = PROPERTY_ENTRY_GPIO("gpios",
-							 &geode_gpiochip_node,
+	geode_restart_gpio_ref = SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
 							 pin, GPIO_ACTIVE_LOW);
 
 	err = software_node_register_node_group(geode_gpio_keys_swnodes);
@@ -99,6 +100,7 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 	const struct software_node *group[MAX_LEDS + 2] = { 0 };
 	struct software_node *swnodes;
 	struct property_entry *props;
+	struct software_node_ref_args *gpio_refs;
 	struct platform_device_info led_info = {
 		.name	= "leds-gpio",
 		.id	= PLATFORM_DEVID_NONE,
@@ -127,6 +129,12 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 		goto err_free_swnodes;
 	}
 
+	gpio_refs = kzalloc_objs(*gpio_refs, n_leds);
+	if (!gpio_refs) {
+		err = -ENOMEM;
+		goto err_free_props;
+	}
+
 	group[0] = &geode_gpio_leds_node;
 	for (i = 0; i < n_leds; i++) {
 		node_name = kasprintf(GFP_KERNEL, "%s:%d", label, i);
@@ -135,9 +143,11 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 			goto err_free_names;
 		}
 
+		gpio_refs[i] = SOFTWARE_NODE_REFERENCE(&geode_gpiochip_node,
+						       leds[i].pin,
+						       GPIO_ACTIVE_LOW);
 		props[i * 3 + 0] =
-			PROPERTY_ENTRY_GPIO("gpios", &geode_gpiochip_node,
-					    leds[i].pin, GPIO_ACTIVE_LOW);
+			PROPERTY_ENTRY_REF_ARRAY_LEN("gpios", &gpio_refs[i], 1);
 		props[i * 3 + 1] =
 			PROPERTY_ENTRY_STRING("linux,default-trigger",
 					      leds[i].default_on ?
@@ -171,6 +181,8 @@ int __init geode_create_leds(const char *label, const struct geode_led *leds,
 err_free_names:
 	while (--i >= 0)
 		kfree(swnodes[i].name);
+	kfree(gpio_refs);
+err_free_props:
 	kfree(props);
 err_free_swnodes:
 	kfree(swnodes);

-- 
2.53.0.1018.g2bb0e51243-goog

