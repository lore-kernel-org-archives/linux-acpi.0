Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE953B2FEB
	for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174049; cv=none; b=Bai36qQnwvlU1/hQ08Gw0NW1Qts8ayrIpGqwYJEcnWzHT/pig+MvosgYD5AtbVYgfueo4uJZb2QG6pqJ2QSsFDlhKyqFWFwclshvoJ7QqJFIhsEFBatCoRX4iVtl9bCUue/MQEC/fl2aRn70+7i9EQ8gd+EPBiJNZW7DJATyN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174049; c=relaxed/simple;
	bh=ZSp/z1Tj1Jrmgu4eL15wfq9HJ2Umx5HE6Vy5deEwP90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9tlhV2DamLBXrE7dRI43v+Cd7+4AD5bkArEuL7+Vb4mqcxNPgbUW5eebADFqyBj4U8USoWb1ve2wthvif9LdK/cFm945Yjn9+S6Bu21cU5mrKIqNt+wSK4HKtl6UhFaZckYuqA4v/YjCgbRJG+7KGkXL07d4OmVUQX7+CMetfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZACryWA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZACryWA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44a5174670eso1728484f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174046; x=1779778846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jiHQAOvHLYgdNNqQrTT3RCJkY+Y4TVhMjJVagFdqfs=;
        b=QZACryWAEj13f+h5914xQ/BU5TFOZzht+7a9UIk0Fu/m51/KPbipQlUqNPm9c9xo5Z
         oa7RUwgsJuIAqjqX6cZPBCSrQb6GFDfX5XbgY9oUc3V6e1qP2ZYrKpTzxtKj/6DfNy6R
         M9cKdCXsL/BJ5GWj9u6u0tMF1B3vFtoTOyrj04jhLjmrt+ok2Ek+1TK/xHKjnxBRYbt8
         4sMEymqH0FE+Eo4wsWZKubwIGZ31IGj54w5KG2XLm6+LsmFIaabhcc4X9bVUbe0P4qKU
         KeBhASqhX3BsBcz730Dl7o4hmrwM/BNXBNAALvLoCng3ruL7cxtwcqqVareF2yNv6RdA
         zpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174046; x=1779778846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jiHQAOvHLYgdNNqQrTT3RCJkY+Y4TVhMjJVagFdqfs=;
        b=TwI1TeF0aoWJBeKaLrHBFFlB1OgisNZ0HGCnHSoL32gdYLHHKSetHHyEjkFZXWU1Xu
         3/7qe4JSB7I3/ALCAAGHNDSJbJM/xU4mmqjp09eYEWUSBkomLYaRwLXSQsO27/2oIXOP
         OFo4A6ehTfSvupcmmPr/thGyuUXF1DytZ8IXFOjrrvdPahImzBf3K79SYHHyOinaRHgg
         c5cx2j6djICAvSTb+OceqM5QeLcisI1u8YlZSdbvdBR3tv8SByMuWJAQ/tcvvfVwLXKv
         6sAY+g1exTtiupG+Nq75JsJDvJ/B1LjXovK2jcf6LbszMRp904beSZW7yKGzdeuA/T25
         1vkQ==
X-Forwarded-Encrypted: i=1; AFNElJ++OVIR6bQ1AmpDZDeZ5uf9W+HD4lz8jGkXgY7buHg6jdw4M3ALQWEliOtTG6OY/Enoqyp2kPHRRAfn@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQ8wh/fvF5R2FxF5BKwh0/fH7STOX5p6WGFPLw/iCYQCt8pw1
	L4WaB5HZC5W7M8OUdKU+2cJp669r66Fmupq2sd4Ge2Dt0C0tGhwxVphz
X-Gm-Gg: Acq92OEDBavNrKywLK9Utukjg3U3n5CiI4UObuJ/i71bslyaK9QhHC9lbbEtv9sK45x
	2n1vnpdlBwEJ33kOwM2bPLLvSvpdVApl3+CscjseA6ol0iX6WyGKCd3dAGy+uSKX2nW5vQutdsi
	udp3D/w18PT+qlVxWaI4DQotUO9+chhXIP5FzqWgfdi1OhO/w/TpWJC3YQjAehcCmKSsr3i4569
	/IQjbcY63t/tKSLbowI0gjFHolSnm04sDTlhSBcLBRjjBVNlJ8QVIe9WAjV2PXW+GobNerie736
	Us87vbZaVDMOTu9uRvXyGEGkD5ZQgtWsyfuJEYOULR1lBIcRfqlfQq+yAsn5b+9hALQ2HdtfuyK
	Y8ONC3vvVhDFwT5255J7qxYLbfOLFOwkfGq8TSyAoVBqhV3bOliZWmEycLIr06LgCHov5R6j6ks
	EpvgukcdsrU9d4SHmh7UEBuQrZBDrKTA==
X-Received: by 2002:a05:600c:4692:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-48fe63253e0mr289793925e9.20.1779174045400;
        Tue, 19 May 2026 00:00:45 -0700 (PDT)
Received: from G614PR ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm149177055e9.4.2026.05.19.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:00:44 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mscardovi95@gmail.com,
	westeri@kernel.org
Subject: [PATCH 1/2] gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
Date: Tue, 19 May 2026 09:00:30 +0200
Message-ID: <20260519070039.9280-2-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070039.9280-1-mscardovi95@gmail.com>
References: <20260518103302.GO84797@black.igk.intel.com>
 <20260519070039.9280-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the GPIO pin resource arrays are safely bounded before
accessing indices. Add bounds checking in acpi_request_own_gpiod(),
acpi_gpio_irq_is_wake(), acpi_gpiochip_alloc_event(), and
acpi_gpio_adr_space_handler() to prevent out-of-bounds array reads if
the ACPI namespace provides malformed or empty pin tables.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..d381631ba6f0 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -322,9 +322,14 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 {
 	int polarity = GPIO_ACTIVE_HIGH;
 	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
-	unsigned int pin = agpio->pin_table[index];
+	unsigned int pin;
 	struct gpio_desc *desc;
 
+	if (index >= agpio->pin_table_length)
+		return ERR_PTR(-EINVAL);
+
+	pin = agpio->pin_table[index];
+
 	desc = gpiochip_request_own_desc(chip, pin, label, polarity, flags);
 	if (IS_ERR(desc))
 		return desc;
@@ -337,7 +342,12 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 static bool acpi_gpio_irq_is_wake(struct device *parent,
 				  const struct acpi_resource_gpio *agpio)
 {
-	unsigned int pin = agpio->pin_table[0];
+	unsigned int pin;
+
+	if (agpio->pin_table_length == 0)
+		return false;
+
+	pin = agpio->pin_table[0];
 
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
@@ -367,6 +377,9 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	if (!acpi_gpio_get_irq_resource(ares, &agpio))
 		return AE_OK;
 
+	if (agpio->pin_table_length == 0)
+		return AE_OK;
+
 	handle = ACPI_HANDLE(chip->parent);
 	pin = agpio->pin_table[0];
 
@@ -1110,6 +1123,11 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		return AE_BAD_PARAMETER;
 	}
 
+	if (pin_index >= agpio->pin_table_length) {
+		ACPI_FREE(ares);
+		return AE_BAD_PARAMETER;
+	}
+
 	length = min(agpio->pin_table_length, pin_index + bits);
 	for (i = pin_index; i < length; ++i) {
 		unsigned int pin = agpio->pin_table[i];
-- 
2.54.0

