Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1313E0253
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090860; cv=none; b=mWU1XUN8GhkbtGBoV32nE46tAy1VWJm2slomlH25Um8A6ga3tfSJAZHtM4U5M6oRVC/A14LwzrADvR5XAskI/QMHyz3Aiqo8GAIvFY+Aa4e70i2ooMI0O67FDN0KkFwc7IcKm9a59ZJJk7spIVQfxvdXQTQecSEx5D0a2xzIaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090860; c=relaxed/simple;
	bh=MSoorrxg8uzper7S6y38HW3VXpbkdEo9+GwAwliU7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URxXD8gumwcU8j/CnKf2nVSpg6pxgY3YvdbO2VuQ1TcL+bJzXUC4b+E17gxJ7gauqfFq1iE+M/2U63FCMdsNKz+tpTIqGPiw1AsKstDb8NtjhKeBbC3cbDbd5iZJAEz6XUpdph+IsziGj1f1h5u2TJV1focLn194VDnJGmb9O40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0m7rbk9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0m7rbk9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so1851641f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090849; x=1779695649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN7GTrvsqw+xYYoyO+iJ1HbUPl2cSRua7bHIZ6rl0Bw=;
        b=n0m7rbk9USHwhdkt4AyqCT7X0V8CpLwysC7v6bqFg9lqnMKusqUpqdZOfi7RHoYUxU
         sOmjb1/BGbANeFWSI7IhTltQ8n7NbYXPeIBzsfu+1YxCHXjI/y/g84BFCQeeuWx7EV/4
         5lfJ3cB6HYh6t0s0gRJTZep7+FYNouf3P/SeZ3XzEwFhAXehAdT8QJdilt8M9PO5dC/n
         s/8R5bIpbTua/w60Nj5ylw8Uz/pB4rn5LgvPJD2u8UI4MUHFXpPLL1ILeuPgbMfuPjxm
         sD5XD3iWI0Euo6fdICQDOzeYOaQm7DWYfyeRtbTdT+px6mnNcSKy1+YMy/K+oalY3HXs
         R52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090849; x=1779695649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QN7GTrvsqw+xYYoyO+iJ1HbUPl2cSRua7bHIZ6rl0Bw=;
        b=iNaYefxZ+tEVs5mIxxa77A9XchYaIe0ehpNDAgg+zlPeSJDX+zFA9RRmjJeS+h0VWl
         6LG27o0OtmMDyxrVPs7HhMy0ga6kCBPQzIpKV38Lca6iLc/rwVspdoSPsdkY4jcT3nmG
         ulK3O0YEUYYM0CNF7H0LbHryRkvD7LtIYu3a160zccDLaz4TmWYLlrehoCiWhYspLcMn
         o6qg26OeFRP+fP8Az7y2UlN1BpUau5ut54MpTpcDHVirfMnzXVr7Q7xw7GBBsSoyJogz
         SmRfF93KOruFUOFwyCukZhUX6F+fglEowOmMOdpFb+4OO9KLMhiUGwdfJUID4BPHnBn1
         HOOA==
X-Forwarded-Encrypted: i=1; AFNElJ8zVbG7+5scZ7oZ1pyeioAwh/7JNynykr4xaj3oT5EKQsJGaQiyD/yf0yln7AyKFqpEIv4IuYpLaLpY@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFN8qOaqyCH7Zm6TEd67C8aIGHORNa3dqKi5eXjF1mE5XM9HE
	rmUFqFCFhdjeWZCaw6kiyeQkTGf5hlpvZh+280ykTuIV1MynbGESiCUh
X-Gm-Gg: Acq92OGOiQtpyvKFsgGojaLzSzxbCaB0W5Z0vNZKmioRnzpltOvyoJcgbdj91hN+GE4
	6/+Xp66Do/FeajcU6OKIO4qr5cK3QNfsH8ymv/vcS8DugEtCiE8m0E8HpsTXeSYWeN9Q+bzGnUm
	xqC1F0P5oApCywqCvLOVQSYpJLs0H4TVKAw5wprhN7x539yDcuMbL4dhzWY7OX3z2OUrqB/UqhG
	Hh72P0GOb8TVUIdRnhp+BTUdSjHuh7AqYYY9YHLWXca3vtUnWwXdJKmSNgWpIHoDVIWFBG6YvV3
	91qFPqVrgsRuIyGgoreyySiJq8igRDvvYFV2F9SKXi0NWHtoOU/ArpWQiBBWnDVJ90apRbRYRRW
	glpI2Sns1QdjDHthTrEtgcetJiWV15w2CKnWlwVW3PxmJPN22To4ENVyiyb6JZeQ8Ccp5M2VNVg
	2A0JVWYyssTLHf1+Y=
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe539198fmr198503155e9.13.1779090848818;
        Mon, 18 May 2026 00:54:08 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:08 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 06/12] gpiolib: acpi: Expose core GPIO resource and OpRegion helpers
Date: Mon, 18 May 2026 09:53:51 +0200
Message-ID: <20260518075357.112584-7-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518075357.112584-1-mscardovi95@gmail.com>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assisted-by: Antigravity:gemini-3-flash

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 12 ++++++------
 drivers/gpio/gpiolib-acpi.h      |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 7217ec5c7fae..afd76301c41f 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -272,10 +272,10 @@ static void acpi_gpio_set_debounce_timeout(struct gpio_desc *desc,
 			   acpi_debounce, ret);
 }
 
-static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
-						struct acpi_resource_gpio *agpio,
-						unsigned int index,
-						const char *label)
+struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
+					 struct acpi_resource_gpio *agpio,
+					 unsigned int index,
+					 const char *label)
 {
 	int polarity = GPIO_ACTIVE_HIGH;
 	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
@@ -1169,7 +1169,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	return status;
 }
 
-static void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
+void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
 {
 	struct gpio_chip *chip = achip->chip;
 	acpi_handle handle = ACPI_HANDLE(chip->parent);
@@ -1185,7 +1185,7 @@ static void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
 			"Failed to install GPIO OpRegion handler\n");
 }
 
-static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
+void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
 {
 	struct gpio_chip *chip = achip->chip;
 	acpi_handle handle = ACPI_HANDLE(chip->parent);
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index bd857ead9dcc..6729da5a6fb7 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -55,6 +55,14 @@ struct acpi_gpio_chip {
 	struct list_head deferred_req_irqs_list_entry;
 };
 
+struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
+					 struct acpi_resource_gpio *agpio,
+					 unsigned int index,
+					 const char *label);
+
+void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip);
+void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip);
+
 #ifdef CONFIG_ACPI
 void acpi_gpiochip_add(struct gpio_chip *chip);
 void acpi_gpiochip_remove(struct gpio_chip *chip);
-- 
2.54.0

