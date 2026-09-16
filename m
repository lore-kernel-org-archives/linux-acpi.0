Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7644BCB4
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545573; cv=none; b=ZY2qIgNW4q0d4TTmOGvPltFbPUiAmcovW3VKy8dEjHY8wueg2HKiei2BN5DvDvNIvm0U/FtgtLMYbDHvCBRXk1dBg41II/j9+SFcEoMOMuW6dxdli3ofNKhc/B+SzRX7tQFDFLpn12OYczuswmPXEcIxYWh2wHXP5qztjL/tnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545573; c=relaxed/simple;
	bh=KzBRa+RHmHfvRkSmrTiTEZJDRCsgTkmMAnZOypFRNhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmiYPuzUM6LLOQd7y8wNvHUMQkQWx8db3wO1j7fDERexgXMiaLF26N/NC5C97DiMkfMzONBy0akFG0PIiyOQaW2SHpuTrG4Mw9AVAiXHS6NKtBHzodavBKzeZZDyqq22w9AcbnvzS4ESVW8Y0e1WuT+7twQ8HfXNamdIh/Dgepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPGm4er8; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPGm4er8"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115c1so6817755ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545566; x=1790150366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG7OvbliYWQiE77ZMzyIyMkMvjpjZCW/b60QdeLOOYM=;
        b=MPGm4er8aa5ZKi7sW70lq5LixCUx77tzPTczvaXQhr/j87gnZaw7ymIgxEq0oLQns/
         RmahgFk5Nf2BBfext2RpCNYAAL+Ra/eM0SAjijf/+BsIoGTVktuCbTCNqzBCl0HaPTeb
         5esJFe370PFwfXgtV+j+PsTzrcXkRRtOhZ6So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545566; x=1790150366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG7OvbliYWQiE77ZMzyIyMkMvjpjZCW/b60QdeLOOYM=;
        b=wq+Fzap/JRVFvxFaIdmK5jeGymdcQeNTgeakJXZZN+xvZ3X3XPvBMYi4BAUV1QWt12
         fMOwki7PT3sbim7RqdqGIllusYccyO99zzV7ngFIBvgcZyWYkMs8i3ND4CQRY0A5O6CF
         3cdXhxGK+aoGtPEbeBuCoASJtON9YsRxw6tUAcY5eePX/NsX3bYlJntf9H9fwAgeYX76
         7fhZEJSixkqPX01C/kwDTpbgNyg0ramG7tx9gwM8pvr8802eaiKeI4glHUKXy3Cpg0WK
         v3x/KGEmCQfhKZ8cjQA+9VCO3RoslZ2Imm1Hn8Jg/Q7OAvJhtTaQ6hVMXi0wsxNUJlYZ
         7yow==
X-Forwarded-Encrypted: i=1; AKwUvBwJxDm5mJEGCKyyLYP1TSCpSa0+0sO68yKx5EsOgd1VFOgfg8FRG+06n6l6E0uIohQk5L7RjlMXIZ4Y@vger.kernel.org
X-Gm-Message-State: AFuF++nxPI/go79jomPQyjgAsdq4FVt7XNpqLa0PXX4LTKrYrBaYeFBl
	IXY0K5IoLXh0dvntUAW03GtZxGdY2Q0qku+A9AFfmZ5DqJzQKQP1we9hJIn5jTRaqw==
X-Gm-Gg: AYBFou0JelsL1V/C0LmKR6BkRS0vmoJNdWX6i3FObaY3A5ajnT4dp6CrNcQHf3sr/F+
	Eggckot1bWNx20Hxi0vcCFdRkwd67MjZACypeCIJCItGiT654TjyF3GgPsy8mD9VorkIPdcHVdS
	f0/IQvg/iMAN6trIjqcbj4qSLbKGCi6E58L/thMXsCl9S7LdRfhm/Sf8XQynzbSiJ25Xqm8UHwI
	N5Fxg8rRTviHHbwH3pnHMK4+sKfLZJ6BhuA/zyV9R0+JSWRQ/fi5rJm/NjS+oVM7ag4Ffi+imEH
	0mR+kQijFwulIM0iT/aIBV/1yeOvkxDIYlGZBWXj3+8iPaq4omII/0K682JDGuAc0FshpuYC1Tr
	QXU05pxwhRZc3SynxcXpcTTrBQYKK/EWMXVOg+Lqk7/I7plRztcPCywTfvf5S8BwvHGGya6gG4z
	6NJw2vInRFDd7QZ48xOf0qWPBNjwzWXb2y8n6kV1mTrFB0Ma0eTo52GmYllyfCn2aq/fW2tH5GC
	NyTeBCT//bIvAvWvnHov80mI8UkbGOm7hswYBSD4BxXvluYhEj9jkgVceu+MunzIDSI
X-Received: by 2002:a17:90b:3b91:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39e1e380e12mr4028912a91.11.1789545566189;
        Wed, 16 Sep 2026 00:59:26 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:25 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v9 12/15] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Wed, 16 Sep 2026 15:57:38 +0800
Message-ID: <20260916075745.3549953-13-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Expand commit message
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 350a4c8831f7..499cfd291a39 100644
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
2.55.0.1032.g73a4cd73de-goog

