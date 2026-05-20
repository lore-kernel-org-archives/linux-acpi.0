Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AC391512
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263404; cv=none; b=Un3ikoNGDEpRHDTAnQnbaCTVWPG2WPgskudZ+cv4QiPBU9Vpo4j3iRLGUQVSF5DoOraXdLkZaPdwSx4uIwjTC6Ae1Faps1fF5p/+5VwpuPpbrcBAl75lbZxfjdaL3vFFDi7fbt5YAGpJdIDuoTEptRYgTXlR6nzmPbx4uqatlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263404; c=relaxed/simple;
	bh=v8QO5wIg8fMTR7uQ8ckLfU5/0hxPkOwG5s8qbIzOad8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1i9MGmxaBhjq8F9lLvnyp+L0pEXAdbB4g/KNIPDZMRqrqFP8oX3/BxYITNYWteglMafWJF/y27L2c9Q5w9Rz0B/u14/+AMa4Efy/gCTdC21zeyiGq+6yRl87C2sH/ibeb8miCguAo5XIoYM9I2kV8mLgl9WLS7GPPB+9eAy6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM/YiFnH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/YiFnH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso47869855e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779263401; x=1779868201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thg0qkEsY0JjFZeY1AfIvrImoT1KU/tjOzYFDJJSqYU=;
        b=MM/YiFnHIBWAfXqauOYaU6lKNLzl7ah3KqyUBCiksDawFWQoIpv5anAvXv6w/RIZzk
         MGqxLq4ITMXP4dVbc3bO9Pim/NLPkFoFXP5Ei7C4L5wJWYfvJeAlyNeyk8gA845yIq6u
         OehCc0WzW0okoCl25J1LDgIr956hEipd7GhUlR3ektEcJUsrCfgoIPAqbanfEkVSdMfv
         P94GJNwaDuGDW3eg6LqYAnXHpUu+guAmxvf7rha40QeG6zdy9s7V04oOCsxbgdG7hX6j
         xxGB5w8kcle50Qk6g//NO6tb97KokLfH+6Vn7+CQfG3+hXdSOkqEyb6Lg8jelQMWYohM
         jUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263401; x=1779868201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Thg0qkEsY0JjFZeY1AfIvrImoT1KU/tjOzYFDJJSqYU=;
        b=qOvPNjFdP4cmDjyiIvKrban1wUDNP1It6k9ZzGrTTXqT+srZS6PJ67ym+jw3+OwVWz
         px9oV+MpH8lL7Gunj43zX0yuVDCtNNY+HRhwSrroX9qpZfnTFqerbn/QWMues3oAr6YR
         CzIj4z4eyc3XTuZhNEzeWdxNxVICIHZzw+47q1y91jFqrbWnjic2QqbYUSFKBO5t4sx6
         lRYmnyTTEKzl5gNs1NYLqEvci9MK7GJ6uAeo2HWt662XxRTmeZ6cIP4QwhdO2fnBajVh
         JbVgFdCIMwFB1ElEpkavy/F/NnVYXSS5yMkCpzx9NrqeB5rpVIHPZEbDkiLXYosBojHr
         YflQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NMxYoLqLc0PTYxTnY2pa/731MZuSjSvvIhGRJirJLrfcRcUsLeSfensQW500FsCvx3UzUcjKCYoN/@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTAIsOlt9G9YTL751RWJPQoysdhCtSwLsbu7Cchzko87VkpxX
	IxG/WBAY/EnGwZ+7yUdCxpYlSgirWQjaJdiuu18UKUZrlSz/qzTpJfFH
X-Gm-Gg: Acq92OFyQWXs2RVVHtSaDg2T6e4GZ/n1mVETErMOYrzZxMICBi4+EvQtrx8SXbBkn6j
	go0MBunawmjzaHk3zsaWixli7e9wY/vSL9CXeH8QdmweQa6auWRbjD3TYaGxVTJYrlC+uW+fcIY
	FPuVrubo3O79jkKzO63eIbnhDAWlBF5XQXraK0nSPKRHE8woyVu80JzQn8leeD87OOHYygeWoKJ
	2j7nnQSeGSy/VH7vbf58GanHiFbxDPCK8as2YFxUbmq4rOzgXhK+CCkSxUweDJMTJU3WhO8tKPv
	vQPqVD/0bbLrpb2XPAp5tgzN90QsEiNItPjIMYyQLNrVJlfNoUT913nK23NuTRXDt6VqT4Bx6AP
	cwzuJslT7diirc0BaRE/vvF4aA0xcf21RLsNqtDrBhMaIiE1PsYIBI5ffiuDOS01Xn/ccmd9XZb
	6I06vr0CGolpS3xKDzOMy5iBTRGpQCLw==
X-Received: by 2002:a05:600c:2ad3:b0:490:f32:3a07 with SMTP id 5b1f17b1804b1-4900f323a11mr124130385e9.30.1779263400772;
        Wed, 20 May 2026 00:50:00 -0700 (PDT)
Received: from G614PR ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm496536215e9.9.2026.05.20.00.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:50:00 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	mscardovi95@gmail.com,
	westeri@kernel.org
Subject: [PATCH v3 1/2] gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
Date: Wed, 20 May 2026 09:45:46 +0200
Message-ID: <20260520074955.55443-2-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074955.55443-1-mscardovi95@gmail.com>
References: <agwfEMtEctXYC1oc@ashevche-desk.local>
 <20260520074955.55443-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the GPIO pin resource arrays are safely bounded before
accessing indices. Add bounds checking in acpi_request_own_gpiod(),
acpi_gpio_irq_is_wake(), and acpi_gpiochip_alloc_event() to prevent
out-of-bounds array reads if the ACPI namespace provides malformed or
empty pin tables.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..a6d78dad299e 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -320,10 +320,18 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 						unsigned int index,
 						const char *label)
 {
-	int polarity = GPIO_ACTIVE_HIGH;
-	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
-	unsigned int pin = agpio->pin_table[index];
 	struct gpio_desc *desc;
+	enum gpiod_flags flags;
+	unsigned int pin;
+	int polarity;
+
+	polarity = GPIO_ACTIVE_HIGH;
+	flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
+
+	if (index >= agpio->pin_table_length)
+		return ERR_PTR(-EINVAL);
+
+	pin = agpio->pin_table[index];
 
 	desc = gpiochip_request_own_desc(chip, pin, label, polarity, flags);
 	if (IS_ERR(desc))
@@ -337,11 +345,16 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 static bool acpi_gpio_irq_is_wake(struct device *parent,
 				  const struct acpi_resource_gpio *agpio)
 {
-	unsigned int pin = agpio->pin_table[0];
+	unsigned int pin;
 
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
+	if (agpio->pin_table_length == 0)
+		return false;
+
+	pin = agpio->pin_table[0];
+
 	if (acpi_gpio_in_ignore_list(ACPI_GPIO_IGNORE_WAKE, dev_name(parent), pin)) {
 		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
 		return false;
@@ -368,6 +381,9 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 		return AE_OK;
 
 	handle = ACPI_HANDLE(chip->parent);
+	if (agpio->pin_table_length == 0)
+		return AE_OK;
+
 	pin = agpio->pin_table[0];
 
 	if (pin <= 255) {
-- 
2.54.0

