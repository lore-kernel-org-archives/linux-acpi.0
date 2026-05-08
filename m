Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64C377564
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221085; cv=none; b=h7NisRGy6swQDptJ/cLeuieh0hfhprEqM/jqHhj6ELwSANG26Xprev0Ck3J1ZXd0umGgxxUzAtZkiezii7ebNiSXWvf0dBqhPdKHEg6ZA6AqPTSh95ttsVf4j7Q1RTmnD6CgQGjdsGPywHHG6uhWoMwvEQDPNZEgzqmRHpl+IkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221085; c=relaxed/simple;
	bh=fne91szarOWdIvniaI9+UEt6vpPwm2FRb2JS2VMwdb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzL9pU99QdA/G242+HCq9v+Xn4V/a4bdp0QHDXlKE5nrUPzdtSSeKykDc9FyklokAiK5gr1cTmhJBA84akdtwAFpQGm5oH2mOBb/lxKqD8SdCAZhnU4mkB+nRNbKW01GM2vdJlZiTI2DfQO8FLyLfSHW+I6pPrVNDlzwqzJoZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHGrunoM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHGrunoM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so24795855e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221074; x=1778825874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btkeAG5X+48Uo58rvevp6gJltGqFkkONHOsVscYaKek=;
        b=VHGrunoMVLtvYYt6xSKBzpp0Wi1jszQ/g6/9wSP8iLL/8CThUZwcFCId+4lQXny+tO
         R6Oap6ho7m4jTAXjKCbdOoLRWtkg1qiNiPgmnu+ziKttUKQU22TIJG9RhpQtpRVBJDQn
         Bg7CcF37vorUbz7gcJ8jZogys+vOFViKwaq/je/SCDa9DJVKBIw99U0dJd8rLnNfMhQ4
         FOh/7H7PtUJKqXXMmbXI/r8Em3p+omxnCg7J6Rhue5VDcUGJsGITBeOO0vVM1gSfwKeS
         A7Csr0PIEWK6UF7/ZBUV5jrIrV9yzHLYfwAxXy/ix21qBZ5uJBJsSaFdx1XEGN1vwIhT
         kp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221074; x=1778825874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=btkeAG5X+48Uo58rvevp6gJltGqFkkONHOsVscYaKek=;
        b=R0Ic5rHqWi/wkLkLLxQIeq7pmC8ToDgLAP5shC9djYwhSi01gGbps5qIBObrNEFIrc
         3lBQJonH7/cIKRBdNUip9P9N8iQJdT+Gh10ZVrm9NUjxA59RCcmzM/vGYCr3oMruIxj2
         MLO+ht0ei1/MweqiDI/5jBjJ3rgAoxKG3V6u31XelZJTav9PJAz2LjqLcmrSCOtmLgV4
         esHZeE30tLe+w2FWW1jks0SjhpRtr+0vT9NU3yLl9Os5AYNblTnR0zo09LCZSRQVnE8w
         NToyhOIZ4ooXGnvWqw4PFOc+CvQbV8RXx6FN5uwTbjciFWBlh376KCId2MAJL6Snf0zD
         Z2yg==
X-Gm-Message-State: AOJu0YzKPTwsy/H0NZrTcOVPWbUCi92lJnCnb1bi8Ed3clwz3BWwkU5V
	8thY8TRhBVsRUghMkOsOnEFsTCIuw0sThwy3rarhTxhi8+O0lF47ZCRJ
X-Gm-Gg: AeBDieu9canOj3n76v36623Z3Nj2eLVB5KunXi/WSHc421RLobkF2um584EV/a4njH8
	aL7bBz97+jH8kiVO6Wq1EjftnN7DV+P2S3VnOcW7AOdfWiw/6KBIsVJh/LckMO+7VDyEhwpqd3H
	jrHBMSxDSPnpILW5AqTCjjZ9vBA3PxiB5I/9xpmLKlnhlE23ubQQYMgKtsH9e5MTSWBoZ5xoe5x
	mJAeyLBQY0xtlF2xVTXhqoe/YhxnpXuGadFX/2BxxvSyMM97mjABnILebCf5ThZyGpQBBzNlwHu
	iWWO04o3PufJ555IqUVCn3f59BP3zQfmPgtnMWmtzojQfdchHaFG2X+GNjuqAeLlBpRRAyrPQ6q
	d71EuDdTuGIyDUrpOtnfLhJinNX91CZhWT5lEWcjxGCqoOvHklp6uGh0MrYnhw6FH9FvRMnw+3j
	Gr1SnDqmI820cm73U=
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48e51f4e5fdmr200842415e9.28.1778221073991;
        Thu, 07 May 2026 23:17:53 -0700 (PDT)
Received: from ROG ([2a01:e11:202b:40:68b1:8d59:e348:c16e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5d48fsm11251175e9.14.2026.05.07.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:17:52 -0700 (PDT)
From: Marco Scardovi <mscardovi95@gmail.com>
To: andriy.shevchenko@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathias.nyman@intel.com,
	mika.westerberg@intel.com,
	Marco Scardovi <mscardovi95@gmail.com>
Subject: [PATCH v4 3/6] gpio: acpi: ignore out-of-range pins in acpi_gpiochip_alloc_event()
Date: Fri,  8 May 2026 08:17:26 +0200
Message-ID: <20260508061729.9530-4-mscardovi95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508061729.9530-1-mscardovi95@gmail.com>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
 <20260508061729.9530-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check to verify that the pin index retrieved from ACPI is within
the valid range for the GPIO chip (pin < chip->ngpio). If the pin is
out of range, an error is logged and the function returns early to
avoid invalid memory access.

Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index eb8a40cfb7a9..e53d68578024 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -370,6 +370,11 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	handle = ACPI_HANDLE(chip->parent);
 	pin = agpio->pin_table[0];
 
+	if (pin >= chip->ngpio) {
+		dev_err(chip->parent, "Failed to request GPIO for pin 0x%04X, out of range\n", pin);
+		return AE_OK;
+	}
+
 	if (pin <= 255) {
 		char ev_name[8];
 		sprintf(ev_name, "_%c%02X",
-- 
2.54.0

