Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1EA3DE420
	for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090847; cv=none; b=HDwSalB7+3qOOQMXWYTZqQjlKX5PEVpA73MCmpo2vRzKQ33hOORsN/CIvPAG1CBy/TimXQDdIGYDJWvafq5qrDXCPBVIrpzCf+yqhywjKwgsAdCvORQHUUK6G5W7XKPWUQUbIr0V1VPhj9G4prWcbvnLsDDbIvugroc4vfML9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090847; c=relaxed/simple;
	bh=iTm+CAQk66ngIKIctcP1U8DkyFnXKgU8LB2KAj4Nf48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH2fFEEtGdGoEWCM6cl0PfWxaJWWx0qACtlyedRvwxm9U/WZgqbVDm8yrEC2NQrKCb1hvScopgDG3qTiGrxHgxAGl8Wrlfj20y3u6/3nrxDY/DSjU69Lzcey8WkSXlg4Uf1J2IZJ7nPqsfClF0dNU5gUip2H0sy7GQDEQzTB1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duBsM5ka; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duBsM5ka"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso8849605e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2026 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090842; x=1779695642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwWV/qMNurIkUDOKP/bbi2uYeI9zTRHL+F4n5fG2Tvg=;
        b=duBsM5kaIA9mJw5OtKtwGoa2FhM/zdp8B22IgETjl8ieFIXlIXTVbuSqRuLLhau3Bc
         ZfvJolWeIQ5DNyfG0BMOAN5hdIOZu3LdJHMLBJpxaiVTF9zO4sr/1W8w5ZuCK5YO9KHO
         VCtLA+Y7ZPKSYdL1rRjTZ1UD5mJpPouBpX3Q5rEvyZn63IUkgaRY85PyO0FulhASRz8a
         TPxQBX4mdL1Ije/XcCmGA3RvKz3nXCZyqcP+tf8aRvNNoSWwd7x9KANAGtpomT5qmDCJ
         wEazdIZsW8xKL3tkQy6noYcQxzPhKcg4lLR9Ol99YCvD57v3nZnMcblVKa6EIyXCdnYR
         49ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090842; x=1779695642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwWV/qMNurIkUDOKP/bbi2uYeI9zTRHL+F4n5fG2Tvg=;
        b=ixsRWAYIBmF3NZVKrhqgQOT/KDWUzZrixQfva6DfXFRgpHQIJRNIcGi1Wh9jhoh/M4
         IfOhTxYqHNUQgiK5ihzi5nn2izsCA44RaUR0gnH4P+9dKLs4fOxZYEQuQNzwmrJ3cvgG
         fJTzjwd93TNKRP24yDAxBHexIF7hzXgujq/s88xz50OPA+a4hgIUrS8Aw2b9P+bcI17t
         Q70zIpYHRNCfEWNqvas5lQpQM6rk5aIr8BB/UEot28qOkGO8yUfMfDgwb8ANuFRq1blB
         X/fymLnIe1fSoLat8OfJX/QEHuw7YAoJm1xojZwIrfYQi3dbAym4zAJmRUMndhjmtYIp
         UdwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jW5OIw2EVrDhNLuy7tY+Lm2J7lfPetDpN5dMMILKzQi9b4seTKWS2H+U3TWO71edupDB0AApQl4ul@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyFzfgSoQeZkj2jSbMUDSyasO9gN1lDNTgXFKDEf3905DO85K
	lj/8w4uhIpc7vyfVdxJI2R8V+NvdSh5Gwc+Z6LR7xbX16JyJb1+kUf0W
X-Gm-Gg: Acq92OFNBUo/8jawT7qvxDNNDVL32GUhnrC6KYPAW6rv5gkuuL4ZFrA+bJIbXfb+L05
	I3RyqdOvhWmrRf4bRknJkX7CvDVLKq2bfFDzDjQhhCIIzZTQ0Q+VrIQrtz7Kofp2+WFzSRrdQbN
	AFRYGBdWy1Hlr7grmEIiWnStZ3WsRDA2DSLBO06zRfYlFgNWqsti+ljBulYrig4ESlHtfVRzFpN
	1lSfLLcd9y0OF63LnDPjWW5UMJIfnCpwe9OgEQvuSE2Jy4i548yNwQiBqKbfAaewbhmFgXsQHxu
	MDraSXWK9jPFdJ8NdBX3b+USqX79ef6Bm5F4kNHoZGTMVIyoK9n1jDmT7auaQDZZtHkYGO/y5nM
	23Z4xSlmwaiy5yFx/wZX7qIt51j4al50biV8Trgeei3sGsygtIcEwcgUs8tgso4tcdoNecKgEWk
	kOMM9Slrx08d/FLNg=
X-Received: by 2002:a05:600c:49a2:b0:48f:e6de:1cbb with SMTP id 5b1f17b1804b1-48fe6de1de1mr132113575e9.28.1779090841718;
        Mon, 18 May 2026 00:54:01 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:328e:213e:a3da:580f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf14d22sm102788835e9.3.2026.05.18.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:54:00 -0700 (PDT)
From: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: [PATCH 01/12] gpiolib: acpi: Use snprintf() for ACPI event name formatting
Date: Mon, 18 May 2026 09:53:46 +0200
Message-ID: <20260518075357.112584-2-mscardovi95@gmail.com>
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

Replace sprintf() with snprintf() when formatting ACPI GPIO
event names and fix minor formatting inconsistencies.

Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..64040b098e91 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -372,9 +372,10 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 
 	if (pin <= 255) {
 		char ev_name[8];
-		sprintf(ev_name, "_%c%02X",
-			agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
-			pin);
+
+		snprintf(ev_name, sizeof(ev_name), "_%c%02X",
+			 agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
+			 pin);
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
 			handler = acpi_gpio_irq_handler;
 	}
@@ -645,7 +646,7 @@ __acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
 }
 
 static int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
-				        struct acpi_gpio_info *info)
+					struct acpi_gpio_info *info)
 {
 	struct device *dev = &info->adev->dev;
 	enum gpiod_flags old = *flags;
@@ -1206,7 +1207,7 @@ static void acpi_gpiochip_request_regions(struct acpi_gpio_chip *achip)
 						    NULL, achip);
 	if (ACPI_FAILURE(status))
 		dev_err(chip->parent,
-		        "Failed to install GPIO OpRegion handler\n");
+			"Failed to install GPIO OpRegion handler\n");
 }
 
 static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
-- 
2.54.0

