Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A440DB3F
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882714; cv=none; b=eRl1uhqKMQXsfOCgYOCOjWoePhUrKdUbwyBdfjpf6RBHYtljdzmrBbmnm1JOKAGhYZVVGTUF4x1SpDFzQD6AwE+LT7Em8o9fQVzq9qFHMaZlWcYYVLf08fo6rMl5Bsp9nJ1cTDqV+OcZP6c0zUCQ0wGESPdPVQfYSCjfqkym4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882714; c=relaxed/simple;
	bh=v0+Tz2myQW41rIDpdJevWmH+Rji/Co2WNAU+Key/38U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0FKTvhb+d/c0IHImSTX/QRmkmIKwYEDG0fWDi1lw3tWCV/to9ZjyD4HlujJtm+5svE4qBDSJnUa6taZqEQqw8PaPZgV8vj0jQ7caUEKS/vMofB/timPg9Wxmll6Rhmy/KFdaxY0GFATtwXWHvxxX3Q4huvRsySYeHzmnqE6H3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CADUrsKG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CADUrsKG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso102265a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2026 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882711; x=1785487511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fMs6AV1DB1/anefBW7A0r/4RRc6OeCs0ioieSwLEU0=;
        b=CADUrsKGCgO71Q8af5kBQHO4Yk9G2cyaHPwuBz1/Zk/Muj3CKG/cN11ecqmp8j/PAW
         gsKBw7DIRvpYazIBIOhY+qNrDLG4BpvMnR1miel3bkrWgbmIkqixioOdKaehtH7jEMVy
         dEORI/AYZCxkcUoE7FSGZgAQ21AMdzIt9iMBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882711; x=1785487511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fMs6AV1DB1/anefBW7A0r/4RRc6OeCs0ioieSwLEU0=;
        b=nZaFrFYjqr9kYO0JKWHQk8ki/vUyLk39Hg1nu+47UBW0VNqrlgN9sB4n4PA3n4aTgj
         jlt3JWgKfqw3ztyktBFj+U4e9IyOcYaHyNPrI6LLKwEaICVnDO/um1vWMm6WOw9GdZHA
         tGJ/s/HWsRy/YwojpJuoLLdD9TgEYHkdRnWO3clqbMhHK8rMowvPyQcG6gVdwt/aO5ik
         kbOAMmikvYxZRAHqki5N4sjt66nYbyx9k+nQZEZJsA7BGluPhLJ30PFYbVozB6UCr4Dq
         BMC0ngQDYcOMfkdz04AebJsAZG3ADWD6xhBinD5IuM5FhIbnE3CPrbcPrJZcJ+6Y6zXy
         0Lqw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0wtSd2ibC/5RUgoxGhMt16VKKGa4YVNp5VYJUCGefW17uRmxLDlZMQKPQRm3wmfY+Q35aYM9RPcQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZN4j0umDCTWxHC9b5RwQOz1VSoKVT1tvbLIARQE3RV9O8iOT
	6szs1J8e5IwxgUwnAgq7BoGd62Thst/biU7VfJ5VTVe3IBByrt4jMvV6dVRRBJsIZw==
X-Gm-Gg: AR+sD11xC210jiIjvv4eNgBSpER26BIyKmxy5Gf7zeAhdiU8K3mR/p/kAguhMhEByEv
	UAM3XOJCJtzYlu0obF6k2mel3737aNmIbFKW11MgGfwYMreZeb//p4iuPSE+nWqZn8ICOPT69lJ
	vK9mQKzbNuckDN6fviR5iTlrt8XNMekginN2dChSR+2ZgL0LzhIVMBXzWFXcz6ELSV4WEeOeq9X
	UnF0g9wtY9XJ4+0jC891Zk6wfnYwZxDVYqMXjvr3EpuY6TTl15EigFK75lsGWtMrnyCh8OtJF2F
	1BgsLOYYJtHavx0cRfvW4EXu72n7FtqYBtuckTi7Z/cIeUDJC1TmCT4PBtzmrXxbo8OXBbJbtdU
	bN7yIdIdLOE8O7L9AAJxW15Q0Dloli5NQw+EJHZ17l+44/QJGQPnYkwE9naZvuHUqd2zoE87HjF
	E0UlCgb/n03KXeWrkYVVRr5QbJjEiu0VyKNZc3Z7fcPWbjEoPxjT2rEX2fvcI=
X-Received: by 2002:a17:90b:5205:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38ec6a51c9dmr7051099a91.28.1784882711529;
        Fri, 24 Jul 2026 01:45:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:45:10 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v7 13/16] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Fri, 24 Jul 2026 16:43:22 +0800
Message-ID: <20260724084328.3943997-14-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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

