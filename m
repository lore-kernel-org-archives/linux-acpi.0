Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146B42A173
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511470; cv=none; b=e69+J9ctQZSL8xhaRICacshgZgDjMxqTaG8bNY4DM12X7qXYhDgUkgqLO10awqju2MBnfnESopVxtIoTBxlhAHpP2PhnDeGfGGrhHWr3tA3fkfEFzXVRnkzc4e22UBJsMVsFcFgvBPUwm7K5u6X6nqDA+/wzqDEYh6vXoP8Vl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511470; c=relaxed/simple;
	bh=u12auxpxANOpkxu9usV3zVUsre8MM64CpWgx+x9ARHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5unFUCpQFjUsQLOwBj5qZfkoMhXbhEwckqCXL9svkLUpF27glthd4CaqmUSdEu/ccJFfJB6WZemtj1jw13UcEzQ447RJMPM5OjyFUyK3G3gZM2C+4+5Qj4tHB1XGKkGzrFMk+52XvcOgriHnBhGX0Bb9V60GyP5Bns1pAmBEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DxydsGSV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DxydsGSV"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so601492a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511468; x=1789116268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXiJKGEMuTwqwy42qG7uMnjSfbdcOoA9DAqQks+0PHc=;
        b=DxydsGSV51i5/UV7fZspU9PTFi1HT8u8l/K2z/jFAIxHGIxbnN+KYRRluHQcGahpn4
         lzfgcO7KsAvSGx1KuLGnCDv0RKbF5Hdrjxvunbfw47xTxxLOCJO1EqGZZau+vkTsAccX
         2FA2pZDAlpS0Rbd9j9/CucpcuNOo1+OUUwl88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511468; x=1789116268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXiJKGEMuTwqwy42qG7uMnjSfbdcOoA9DAqQks+0PHc=;
        b=E6EOT3HuB2gI4XK+FU4XXEy8N2LKdvOucl2yIN4nOWW07SwDqLCu6Sa+nOzcWfJycO
         k3EGAYdLphD/FQsHleRct+3SYxIL9u8jzcIJ8LvsFTUHpFQwmCwFZY96X/g32wwvBvrn
         HIh3c1uPKQbyZkDVWwlT/HEzxCKLFqnvrOfsumWvfSioeX2d0MYBjZz0OKHi6BRdQ3xx
         z0v+LQNGLZpuXK+OkjqNo/Q47k54bXZzzC44YoxLps3v/6jyUJRQy+PlVOtsrhcZ8j28
         RJsg3tpWUqHQ68oAnvGHT+EURWxNkRniclBSSi3gr/bh6CJ7ibHcIHzFITq5UH7/9igv
         krtQ==
X-Forwarded-Encrypted: i=1; AKwUvByTBOWPl/ysqXAcco2Xsnp+Zo6rgAhIeytL7kXGYRYbsXsYBnHMLlBUKcEdKbCLKsgOK7oTdccvsF2V@vger.kernel.org
X-Gm-Message-State: AFuF++l+lBT5veD6/8SJsuMDmV4exRSvpbKtEkZ6UG3rzzEQWTT/U+Wf
	MdHs/xegRab4p+M8w4rQWdxGXW6HMWRIIw/po1nzlWeyENpGal0J6PEHipOhMMFg7Hrn2hBeVmg
	yAos=
X-Gm-Gg: AYBFou0/5PgHvk+XO8xmfcyHgdoSr115/Drn4bzjiXbZoiJEBRuMR2z4q1Cwiys2v68
	hUHyDghagCchzMXqk45iau0cnv/gk4TcKCH0wnf735cBD8SIjGxZqCIsTddEzSkWw3wZLU0Ma0+
	+BinjCGERgWnaorvT/WtIXl9GIQOHxEYidCk1PGVomcZtvUczyt0HMFT1Vaw6uvW0+DfzjtL0gX
	twYELJvUc7MwtbvjS8ndpMAmo07x1P89vcKgwvayQ6nybkrGGI4X8GW2uVshtduSKY4IA6mIs1R
	vGNm4cPLopijfZnVgmR6XRttCuUgsmeiiBsbCVXIJTEsUI+LZSedGsJkmJzyTJm9eP57ci/8/B4
	t3prvXyM8vD5lfj2iiDJOiTYccl7gQolofNEwSviHh0F42hsO/TN+cnB5u/AddN3A5C771JWLKh
	hjMuE0iHO5ZWWBvuIau7wBl691FdJwknuktHBISs90Aigv0ZBi30UQ45ox7TFnEWtBO8ADKLTYI
	QGlc+xbLKfQwxdmALDcBT4q4obh5qPuphu11ZibRB4R
X-Received: by 2002:a17:90b:2b8c:b0:398:9be6:f995 with SMTP id 98e67ed59e1d1-39b262aaf48mr7479557a91.20.1788511467843;
        Fri, 04 Sep 2026 01:44:27 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:27 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 13/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Fri,  4 Sep 2026 16:41:52 +0800
Message-ID: <20260904084158.1341550-14-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
index 43b2328a6661..987faa9f3b3b 100644
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
2.55.0.979.g7e5102b832-goog

