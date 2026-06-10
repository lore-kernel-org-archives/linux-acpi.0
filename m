Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD03CF97E
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080929; cv=none; b=QP4mOgtw4+BjYbE/RKkCfneD+HCd2btfxG7NRvdoJCoB0nidi+Bh2lz0UBw/+LRwliU8+GeXlhrYb9XIZPt9W3kp+xWi/eK/gRdBj/oVs0p344luL19AhkRhlwE/ZdYABRDcm8wao9QZ4GQHkKsEgF0tqy/Kj1QDnOGZiuoN6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080929; c=relaxed/simple;
	bh=aM1pKeD/Vxy8p9xU2vujlhCyS6zAz75iUguBLngP3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKNYZLgjtoa5kt80Oh6lP00wXIl9ZcYDi1S0MZrdT5rgdu3dRHFyt5LuOOe4lrWBaowFP0631ZGm/muIEIimpdDPSxT5WZ613qJRX/ELUKuOjGHca1YE4KP0eanKnP8CQg3u+kthPSzw60hDVcXrNfnffarV5ny3/+M66QyXROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZGtxGeTW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGtxGeTW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c132ac5ec2so64201425ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080927; x=1781685727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oapuTl40hgb4G5/aDuwYBQkElchJu8zWsaiRUCi5VkU=;
        b=ZGtxGeTWVkEhm8vRhk7ZwKL5GOx9IYSy0tZ7f5lnYaPkWbzRGH+OI52sh7yr9pCvsK
         Luy1k9lx9C1WzeOlPW+AqxWDNesdcA0vlNv4r3VxQb2omFc30ytH9g4d4ICW3VZ4qTOD
         bIcq5XXczNjACDlTfTvq/BSC7YwNR4rJex11A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080927; x=1781685727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oapuTl40hgb4G5/aDuwYBQkElchJu8zWsaiRUCi5VkU=;
        b=FVBhTZsmbQvhxVDkPfxsIGhEXbE/dhX3JZ6dYdjuKIUQjBN9cQXBh3y1ww4maB7LrL
         1fYIOIkb5XMBr+PE6IXeGQ5NVgPvxmTmrL87KYmA5M+QS0KBM092SSagJft42SzkTgVv
         WNtWITlL2f139pmYaElFQck8fLe7amqMgwdFaH4XxcwcXRUTYX1KU3MmRH3t/97+A1q+
         t6Lx+FxvCfWXKMarbrMpyJMD+vet7LgjCbWZyRw8cTyVFOl6ReOBOlaTPbdqLfi5Igvk
         qAcPjyQMrHZV/Cb9KzV/rhOlfV0fNxIFQBg6Zv4WLseV/TjK0rvWI0+KPKAhoYA0p/h/
         8Fjw==
X-Forwarded-Encrypted: i=1; AFNElJ/K2JyErPZVjBHEvngBjqelrqAJ7UHAq/C/hqHG4DG9/SeXQSbWa6K7WeqfDY3h6lAv0RYK/TbiKLcu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SkZ6xJfDvUVMaFEmaBOeQdeRC2B5tHEvx/kfbs1p4dEsCNzU
	qe6OYl6yBM1ybNvpGK6zDT1GNKMkT3C2ezEpMxsd5ZVuSpHxuMcWm0mjhZKOUhlzkw==
X-Gm-Gg: Acq92OEYnIxJUQL8WqJXMU1wTp02pFVonsMxOcBNnwqO5vs1AsKfjVxpyp7BPwjgbgP
	+usp82Z8GeuVkQm6gtShvjVSxZaWdR1Ma4INW2trK1J8XG3xYmfQrtJR/yz7G4zfUAD0UXkxTH2
	PyOnaPumgYyeRqzv5m6ElhsZhpH9oCn9HbWUylXbiQpOzsMOyVeeEZFkuTYlPe8QVyR5pDN+4J+
	e+CsvSM6KiMDYcy6MdnYoZgMdix73SD14rSDSqJAgpGSecF7X0PEfjhA4XifYc9It/G3NF3N5nd
	idXhVJueBe/dhNo8HC8WC71O8x0io6BFpW0Puc5GmFDIz/WXczQqhy5xY20jK0hLN5ug7G5jAwC
	NE+rfK0LgNtazd+r3IZlL2dCxuwcZeq4wdfFqUaUujfgamdQySha8OPOpf0sNAVAJkzbfI+pbmh
	N1THbd9l6yLKjj4IU9lCUHtFenjfLjN86gAT5BsHnN4Ti/3F7+Z5tBntcPX0w+cmbynnHR5PoVG
	OTYgVN55N0Mdam1cw==
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1e77d145fmr269724115ad.0.1781080927559;
        Wed, 10 Jun 2026 01:42:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 11/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Wed, 10 Jun 2026 16:40:45 +0800
Message-ID: <20260610084053.2059858-12-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
UART for BT. Currently the driver only supports PCIe and UART.

Add power sequencing targets for SDIO and USB. To avoid adding a
complicated dependency tree, rename the existing power sequencing units
"pcie" and "uart" to "wifi" and "bt". The existing target names are left
untouched. The new "sdio" and "usb" targets just point to the renamed
"wifi" and "bt" units.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 49293376956b..a21a3dbe8a5d 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -70,46 +70,46 @@ static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
 	NULL
 };
 
-static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_bt_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
 }
 
-static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_bt_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
-	.name = "uart-enable",
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_bt_unit_data = {
+	.name = "bt-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
-	.enable = pwrseq_pci_m2_e_uart_enable,
-	.disable = pwrseq_pci_m2_e_uart_disable,
+	.enable = pwrseq_pci_m2_e_bt_enable,
+	.disable = pwrseq_pci_m2_e_bt_disable,
 };
 
-static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_wifi_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
 }
 
-static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pci_m2_e_wifi_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
-static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
-	.name = "pcie-enable",
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_wifi_unit_data = {
+	.name = "wifi-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
-	.enable = pwrseq_pci_m2_e_pcie_enable,
-	.disable = pwrseq_pci_m2_e_pcie_disable,
+	.enable = pwrseq_pci_m2_e_wifi_enable,
+	.disable = pwrseq_pci_m2_e_wifi_disable,
 };
 
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
@@ -131,13 +131,24 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
-	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
+	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data = {
+	.name = "usb",
+	.unit = &pwrseq_pcie_m2_e_bt_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
-	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
+	.unit = &pwrseq_pcie_m2_e_wifi_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_sdio_target_data = {
+	.name = "sdio",
+	.unit = &pwrseq_pcie_m2_e_wifi_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
@@ -148,7 +159,9 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 
 static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_sdio_target_data,
 	&pwrseq_pcie_m2_e_uart_target_data,
+	&pwrseq_pcie_m2_e_usb_target_data,
 	NULL
 };
 
-- 
2.54.0.1099.g489fc7bff1-goog

