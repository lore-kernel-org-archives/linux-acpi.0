Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36D34DB4F
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312801; cv=none; b=CrLbotEeWoxgfiSY8yWOF8zSu3iKWNSIyxc6YIeu/+aty60P8E3YPiZ5qURgohuqi4fmbgZHWv42zimowtdXYX+PsFWH5xcLK0PyBtBrypFzLVnK0jCOdU/V6TiSH9A1Y0KaxHc6NaPhIdL/dys+8K0ty3t4K2WZxsCoRsmj934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312801; c=relaxed/simple;
	bh=QDf16Y7vyxJr6CaPRWRkq0hvjTb2t+Mwk/4kS11e5G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxX1h1opAHR2xcGAwNNJg21G/rYz6O5DzZk8y+HukUlaTxBAktsVEx7F/jzHwSnZko7jVoBlHelT9Y/WsC+d2YeHW2E+1mG7PMKvu3MVndOvC728aHEegk2t6e7I2PY0qXVSIwWm9d7HDqu9FFkmdTkxrfSUvBpVlmPkrClgiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJKdgaCm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJKdgaCm"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c0d36f3888so3358171eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774312800; x=1774917600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=JJKdgaCmh2s260EVCN00MexkNid7OCeyZXQxq7BUR77qFHvKBlnHtmvKuEk87TWoB1
         J9sEoOeUeaa2EOh87mP4J+ku40nB8oZ3EN3MIbk4org8u9BjfWw4bDoTj8OpKAiIXKi2
         o1Tcby68VQNSm7DTJTJ6AbGQMPh3j1MXnppHY996biQXlVzlLnhTD+NMQHBBBIKv7lfS
         k6j+FlwwS2pHAQePYdGOG551ykEEFLfZ6g0Y0gagRjDaBwgsQVzQR8zo6KGP5XA+Yvho
         v/Oq5dc9KRxdKEjnuuwGBCtuc7ImDSn90l6bz7VVufzWpvfpUQNOCTD8zJlV+ij1bivQ
         yUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312800; x=1774917600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gq4MIC18tzOF8Y9yYjqLKcBworY2R0LEwLR/J/vdJqc=;
        b=IGTtQfvNHhABDujwWN1b6zW40myWAiWA7E28BffIoE0UPeYFHIrzmfQuEcLi/MNKbf
         7hG427mzk3Jg/js50vh+TuSxT21kDcuBk99QgGpQyjCGy/aWlZMNjYGad8cfZBA4rw7b
         gznLxnEhsxQGwp/XzcJ36xjI2k/tQ2DUedmQvelTEQpNOt8ODggSoplcFw5SJpJRX++N
         zW9R2axw/RZOwsCtor07pKz/YYvPrqSXxHITTWjfD5hUB5JzWlf9VN40G5dI7bg6iGyr
         zJFLjXNuDSFZTrhrwRGmqeaEoedHNvtzU0Lmp2Y/Po8ekvq33MgdMazKDpnjcQ7CNmPL
         DMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVhu5hSAHagnisUejyHS6Filhln3uc5d9MLwR3oG9h+da+OEiPKudculQRMRJVlN57GhqZbNdCB7/Wc@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJAEDdBxns7GRIhnfV6IoLlQIhE5z4RgU039KiHFdvIAF3EFc
	5N+I5Vz/qu1wzxpgU3QhRCIxbp9Dc2kNUyh5KlrW9Pa+xiihz6bs+IW4
X-Gm-Gg: ATEYQzw37ItmWSIH0U/o4Q+3IW0TWs3t6VmagZS9+sB5d9bSYPqwWcTIUf36cQc9NLv
	b/HXtHL8umFV1+9hu1JPzy7i2b60uCXsH+oA4ek6fW1swrd0KKSR8asM5B9Hu9PyBMZ/MoQV0O9
	6NPgHJnj9IHl7Go6Ao6X1S1rFQbTrwFGyBC9mqbRwEhYKs8p7yev9BWiwUYfSmSA2F2R6f9MoVB
	CH0enBgvI+jX0pJLKm893oopai6DTYD+lZymNBYgzLDV+CuYGlJg3k9uY5mzd52axTkNfxLhEMl
	A8S4F/nA3T37YEMJNMbadYwLvmc7zCevjcFcFXA6f0AXAhUOy++j3C2bQ22EdO+Nwgv24ALRbgJ
	hFpCAFSGcliltvna/3MuLsQcoyxscAv8DNOwWF4c6gISDVO3sIIuxHOCN7/Ung+HyZDjDPaqszJ
	w0j1mgr7PjWu6hmMCeUJIawweXDgfOKmNr109qMk3t1wZ8u/FmBS2tVW+10iWOzodiEikOXhcae
	nHq2HEREOeSjFk=
X-Received: by 2002:a05:7300:dc94:b0:2c0:dc7e:ed0f with SMTP id 5a478bee46e88-2c1095a4f1cmr6259533eec.3.1774312799561;
        Mon, 23 Mar 2026 17:39:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm17543148eec.10.2026.03.23.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:39:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 23 Mar 2026 17:39:37 -0700
Subject: [PATCH 1/4] x86/geode: fix on-stack property data usage
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-property-gpio-fix-v1-1-9cb46e5fe7df@gmail.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
In-Reply-To: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
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

