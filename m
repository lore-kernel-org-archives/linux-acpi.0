Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA142A785
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616939; cv=none; b=oNoqskrxroRb1/tSbN5ECUffubWI7Vw1UtNCK1heU06kj/EOmN4XdvR+1r5tDynR4tVu+r5OeBYwL315rX3fS74m/otqHOAKdqsd+ztlu3fHkzeMjYCkzAK3NtqI/z0TC4ppsnpF724IHgRYA/kUtG4ntF9vaTPQwQ2zxY0C0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616939; c=relaxed/simple;
	bh=v0+Tz2myQW41rIDpdJevWmH+Rji/Co2WNAU+Key/38U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHJT1AeNS9qdbkmJQjy9rQSxPTW+4g8n2hzkMGyt0upZhtETn25u/jdeLSDTlVPcxvdoDTQXhN9zOgnc4EsI/2jA2iVsnd9aODF0t1OrOVT4+yBp9biZrfYSRziz1KC9/PLqQpENuj/49aehMj5M6xEobakux/p96C81VpSlOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=USn1UMH2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USn1UMH2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceab75934dso115010515ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616937; x=1785221737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fMs6AV1DB1/anefBW7A0r/4RRc6OeCs0ioieSwLEU0=;
        b=USn1UMH2ZKlJ+8zH4wfdTyyN1fVa7K7TE2HinyHBNrP3DmEbFF49Jkcl5vf5BNJHjc
         xaxv2V8O8EP2qtEBWb2DG91BbcO8rOdNN00fNidCERrJf7F9JPqvzPTovjfpTJty1f6R
         nY8fGTpOU3Agj/DvgDrvyDXgWmmJJg/bnnYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616937; x=1785221737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fMs6AV1DB1/anefBW7A0r/4RRc6OeCs0ioieSwLEU0=;
        b=VcDkdai+8YB4DRG73t+g8ZVQWsAweJo+UcvcI3G7n9rmByKEDDUZX32OXSg9X0nfAv
         /TvIaVTKj+P1FH7amHRXYDc8AHMzGRL2+vnfJP1GYh2GNnuab+MD/MzwKQ/32qtDMspW
         Z1mKDKnk+CCoFpN6jotm+/+TiLIUOaPHvLdfjctrfOL0OohqhDTPAWrQQ251A3ZDk4ur
         87go6AIQPtZ/ZVODVrEnM8BJeYgGghNo2f9n3+TZC0mAUodx7PRoFdVc1ThrbjVuVrAO
         2Wf9L6gy4lR0Thd/jzCTVEXRszH/KHbUwZgPRYFxN8zVtA5z04Zj/EK2Mpr4T1Oa/iOg
         T0bQ==
X-Forwarded-Encrypted: i=1; AHgh+RrB86LPTm8KEpaCJsyhwG6V/oy/IVOhUKxWWtP0yt0seVjUdpzHcdso33wTqaD2WnbQ7iewa0ybDM1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLlKv4MrTZkVaOsP9qiubhdAMGaKTj8n0BB6avAMRgxtCAuqF
	Aq8aJpyl9tv4eBgMMpw7u8JvXQMBh7BmvISjPAz9V5c7kuAZtZed8sGEYJ6YMnQXSA==
X-Gm-Gg: AR+sD11aEA3dCdSv2yhdaNmruWEdZrt4arSKi68c0hwL3/I1LmiOMDCxWezurQTbtOA
	tkoLVbAhcRZ7dRrB+ZnRb9Y97TCtE6dpzyhqEAK3Ddc8TlFiMGLuLN8c1AJUJzXp7AS3lZpVRyb
	Z6H2Osgg5op1M1N9EFZpe4npr2PKE8oL5HmFhsZCVate23a+Yc+KgV0fL18BlmkILgVanjK8/Tx
	jsSSck0VjNl9GMSK6eLooloqJ7uXptTf1AINNVEo4jeWAW/r0/FWSEWb6i76azt49szp6+ju8FD
	yu2ry+lmJ0WZS5F+liilslrCDNgLYHcKn77TNGfJaEr8jaOS0+eM7Pcwm83Cpl428BXLpat9mZk
	NIlow4xZEWIvqypniq48E3c8HLTvnSPjrq6DRTNi+C0xZUonKyxPG+oXsxz+gCvRlKBKBfuhh8G
	zGr2u6m0VIGDB81UwzNJ8mMiql4gWav7Nx5ZnINKVU8PNN+rD4p8pKJ4Kqt/c=
X-Received: by 2002:a17:903:2c50:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2cf47c463camr154543805ad.3.1784616937260;
        Mon, 20 Jul 2026 23:55:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:36 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 13/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Tue, 21 Jul 2026 14:54:08 +0800
Message-ID: <20260721065413.2306137-14-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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

The "unit" names are internal to the power sequencing framework, and
should be confined to a single provider. The names are only
informational. Dependencies are tracked with pointers to other units.

The "target" names are the strings that the consumer uses to acquire a
descriptor with. As these remain the same, existing users will continue
to work.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Expand commit message
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 691cad0a6dd0..693b0d33f8cf 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -69,46 +69,46 @@ static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
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
@@ -130,13 +130,24 @@ static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
 
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
 
@@ -147,7 +158,9 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 
 static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_sdio_target_data,
 	&pwrseq_pcie_m2_e_uart_target_data,
+	&pwrseq_pcie_m2_e_usb_target_data,
 	NULL
 };
 
-- 
2.55.0.229.g6434b31f56-goog

