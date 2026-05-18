Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A733E1682
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090857; cv=none; b=mJNsGgAZQXQmf2ZWUMxKqnBFXJWu+PXEyo8Btx5biF9VIfpiSZPn1f+fJkPK3+s+ZXiuLuQF2PFYhM+BUNQfjO1ekJgW+7OlDwgnzlPwR0yl89Ive7t0RGRLxTFrdh1GdiVatGhWzyaM7u6s6opswCV6xM0Mt45R4lXBOrAxJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090857; c=relaxed/simple;
	bh=dRrJpo/RFBlXKEJiWCWaT5Y8j+cfkW+t5EzYx2I3Jmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv/nEAaMc3NSV1v5HnGeiybkRU+PUijqYgGDWYE19Elou3p9rspj/K49ipUK/wDFOjPmp0c+WASDmE2XzsHOjzseoxhrHb/oWxvd2cbK6LIZUrEzvtHcHvaQZljSJeLVZNWzM8vL5uumvQWZPKry5tp9FdA2rwZDD2bYxMZcqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn8D4q2j; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn8D4q2j"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso26180545e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090844; x=1779695644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i+l+TnhrZLaF02FWG+gAPSZUlHwak2ucKtwF5XZOc0=;
        b=Tn8D4q2jqPgE4EZ5gygR+L6CaAbdXKFUcHGG/hysH0xJtyBuGu9t18KN0oPiRdjfal
         MIgR+fqyexVR9cEPwveWuhmvhdej/Owe8yl+iFoBxgTBZkVc83QbYvjBMuja0f+1pzcY
         VoMS+d24YKOd3By4eybhilnxofTcVdSXbv3FpsnY3ze+dbshVG5sDv3lc510SHmnSz9W
         cmi3bKvIVXI8inmmnNE6PpPansQUkOMgs9fELnS9oCXoBn2jdxq7JUGW9mCrqVundyWK
         znCe8nFQ0367Kzf98EX6m3v1kLU4lXZAbW5U89Mvi5qWZj43CbvjUR0bOQpJeEe9wmuZ
         8+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090844; x=1779695644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9i+l+TnhrZLaF02FWG+gAPSZUlHwak2ucKtwF5XZOc0=;
        b=o+KJ2Nv7Rhizt/JqGTh5m4DrAUvJ2Q5DKTIBcbufdw7n7g+EOjnrsFl3W/MWAw9xu0
         3R/1PlS5aquDcrWf6SaMf+foJJof35DqNkijYXmqwxxhzpyUBGvfpen9MaH3TBlL7K9s
         kYUtJXFPptaCs/9GMECTk3JouOuZER7dPFLoWbN+uvqox7WgVAmReyFktTAlCife0miy
         UcR9ZiLanhUCnC3PCW3gicI43odsyyK7h++K3eB/LWa5sCLaNm646/miqSz01cqCGmMw
         XJBW/ov4iiucWkZDT0n8edCbkNXUE3Q51EeMIdUfRn+AACRJNuK5/7Pua8EelxoDBlnK
         HtoA==
X-Forwarded-Encrypted: i=1; AFNElJ+MmJR/75GyE2avO1wjXdVMXNrIIrV9xWQmH77SE5rCuD+j53byFAoAtgtEISWRXE1SPiQuIcZcxsYS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ANkf3KSwS3OupHfa0dmVEjCxKCzMFtRLDgS2FBpg9sKkQdtr
	ReOohLGVoBDvL5nezyPvIgHY8nfUj5uklwKOtF3WIAAhbAM3Z9IPNdbC
X-Gm-Gg: Acq92OEgZbKA/apE81MvBpxqxu/LduGZV+DKwW+HX+xTy4LA2NZJmj8ReCANhnS6/KG
	9cWn7EjP2Oyc8PeQ5r7QU9iXqZRRJjGL/gstZ/Zzchs5UsT+NMfviOg56lXMsHcSVpbQg+szYSS
	awp6lnEwS+qzGwSBbPhxc0H0+YwyJ3kNt25YVrVmA/QnKj/oZek2NNkOPudKgRt657OhlrsqdwL
	77z3+MfbbjUkmX6tfm7v9s7jGjOSKluTjje4b8WmX0oNOYp99H3G1tJHaU//+arGKsTaN2/5ml+
	7AmQcpX6JfEK5ywmlW70ksn0Zf+iY88FrTwICZR/zg38XEBX3APopwEKIj4R1lupKO7WPqakL9U
	nhQcO2uD6SmMZqtBOio453bUTNTurxydP/Ql772NA4Ones0chARR0UoyqatiEs5RECufK+K4mPr
	cOlR++nWHJFippOwI=
X-Received: by 2002:a05:600c:4692:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-48fe6325792mr216525115e9.16.1779090844437;
        Mon, 18 May 2026 00:54:04 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:03 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 03/12] gpiolib: acpi: Add robust bounds-checking for GPIO pin resources
Date: Mon, 18 May 2026 09:53:48 +0200
Message-ID: <20260518075357.112584-4-mscardovi95@gmail.com>
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
 drivers/gpio/gpiolib-acpi-core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 64040b098e91..90bda2d7da57 100644
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
 
@@ -1111,6 +1124,11 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
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

