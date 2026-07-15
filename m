Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11973D88F5
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105736; cv=none; b=X29F38hyS3f+q40swdieoX3cCmTtJh3ZYABf8VT5YWOr+5zL4o6nzMvwr8fcL62B/AYl6x0v+zw2d5UwFllf6lV/ystDB9ONtw/f1xnaOoerhPg8qJibqU6iQQh+F+QFbjDjtNaKqP/FpG5+/PLZgolo0v6okRJA+JIbuSaI/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105736; c=relaxed/simple;
	bh=Kwdh1wsDA3PQhAJXo0c3P6asDMiUgGjPhgZiuNl33tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC/f6BArDGd6JvQcplHi897goQxzawRBiyLKTgQ2IuFErvxP8VzqNUwbI9BC0JT0Nph+6WD8krjLi/m9zQVD3hKvy/DxSafTUkUWbaTXCGY8layXcW7jDzEe84KZOOiJ4XZraaTVne/Iq7Z2BZ6wkHgX8PJXpA0TEe+wx5DT7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YD+657aR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YD+657aR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8484a0b998fso3012251b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105729; x=1784710529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3HJTWjS7+7k2AMeQ/ADfiVkN81b/TWdXvCN6CQ3PZA=;
        b=YD+657aRgzTGumB9/oj+u6hfr1yAFK+xox0LXBU5PnN3FPPpf1xaqUYUTqv4drsZf6
         pLfnBrEDEWUtFlJnyHR2sv+Ghxjn68bj404DI2u9vHanWEL56iIAkFLwKHnHD9l3f+Vv
         qHO5xy8FdjpojvO5acW/dlTCdgKSRmcLM2vF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105729; x=1784710529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3HJTWjS7+7k2AMeQ/ADfiVkN81b/TWdXvCN6CQ3PZA=;
        b=pWWkJlodjbhvh2bN4m/k7fLPWMMhUzT43iTixBwq7hmHTvYtVtDXu/L7OFMJdkwcXi
         1/c8U37iD8jIHJyYzsAbCgfCBDyWLmo6OnVZ7wZjb/uSmpnzSgj4po+2bRx4rO+ElPpD
         P7ZfJeHgYWymOaTCwq9AFT2i0qYq+WIcHtkqBgibgO1+suXlPTPXKelXUsgevW5DnJjG
         T33rWjt1EaoQoSYzQkDXmp2npT49kL7cCFeI6NB3JWtA8ZIHc9n26tsB1nFD47qOp5bh
         +pCckq+fvTzSFPBGGt4c2hNjJ7WQTLuYmdQ8S0TTz5NsBRFqPekVxuDIIs5Rqw8Mw+wN
         hAGg==
X-Forwarded-Encrypted: i=1; AHgh+RpzfeIUWmQqAklA1q5sW1YG3d2tE89/sd1ZBjqACt6HDfTB5B2cfR9tWiucmEMZI1mXCHdn8alZ2XNM@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIpltewMQ46lxoVNatQyAgKtqXbnW7bH9yThGdVYAU8fnCaAK
	/xBz9PSPztD43sZ5tL/gnK4jhZLEnQtd0bFd2q1Lm0UYpRUYGEytgdyblid7lmQWcA==
X-Gm-Gg: AfdE7cmWoUSxq83w4AE+26HYzPhke/qklhvLxXNDdxva09ipi8I0rM6MHkVPswgXcXG
	JCUO4K+JmY9l+84pUh7nYvHFGLhUeN7arWNoT0riI3Fgr7xK8IlH22/m6x5AINJ6a9RC2XVlObV
	z5tm0v5XfNIpG94GqgqGUBPEEYNOTRIYntyZTTeYGYXnYqLaxs4QI8ypW9kyrOqaKlNsgwgoOf+
	vAnCrvJdLNU2cmJtVtJ7sVkcs64SSH3/zCxONIoImmodOU0dW+dKcogZ2NHHoapGKdz3SydMz81
	Ki9S9hKbuT/QV1DZGmbSUpHHtsz6lujw+BMHSsUDckwpn7c555QeC1e3mFD0ACeOOpTZJxgEIb1
	tI8y6iKpZJ+ajIqO2KkCfj2Cl2cXT78jI5AqZ6+WwAYKFB3W+XSZRH/R8zjJoos6FA0ODBKE0sx
	78MdubhJb0IBli9wnKPe4hX3Iix11L+GsCiK1wssIxDuZbOfK7/SglJLt2MZqECmRJ+pEPo1b22
	IfZSiCJ
X-Received: by 2002:a05:6a00:23c3:b0:845:d284:9e11 with SMTP id d2e1a72fcca58-84889756a2cmr15382339b3a.56.1784105728841;
        Wed, 15 Jul 2026 01:55:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:28 -0700 (PDT)
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
Subject: [PATCH v5 15/16] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Wed, 15 Jul 2026 16:53:45 +0800
Message-ID: <20260715085348.3457359-16-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mt8195 Cherry design features an M.2 E-key slot for WiFi/BT combo
cards. Only PCIe and USB are wired from the SoC to the slot, along with
some auxiliary signals.

Add the proper representation for it, replacing the PCIe wifi node and
vpcie3v3-supply property under the PCIe controller, and the vbus-supply
property under the xhci3 node.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Drop default GPIO output state from kill pins pinconfig
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 73 +++++++++++++++++--
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index ef7afc436aef..8d4cc30d91e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -266,6 +266,47 @@ tboard_thermistor2: thermal-sensor-t2 {
 						120000 51
 						125000 44>;
 	};
+
+	wifi-bt-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_e_key_kill_pins>;
+		vpcie3v3-supply = <&pp3300_wlan>;
+		w-disable1-gpios = <&pio 61 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pio 59 GPIO_ACTIVE_LOW>;
+		/* PCIe auxiliary signals wired to controller. */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PCIe for WiFi */
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				wifi_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie1_ep>;
+				};
+			};
+
+			/* USB for Bluetooth */
+			port@2 {
+				reg = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				bt_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&usb3_ep>;
+				};
+			};
+
+			/* SDIO, UART and I2S not implemented */
+		};
+	};
 };
 
 &adsp {
@@ -791,14 +832,14 @@ pcie@0 {
 		reg = <0 0 0 0 0>;
 		device_type = "pci";
 		num-lanes = <1>;
-		vpcie3v3-supply = <&pp3300_wlan>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		wifi@0 {
-			reg = <0 0 0 0 0>;
-			wakeup-source;
+		port {
+			pcie1_ep: endpoint {
+				remote-endpoint = <&wifi_ep>;
+			};
 		};
 	};
 };
@@ -1085,6 +1126,13 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO61__FUNC_GPIO61>,
+				 <PINMUX_GPIO59__FUNC_GPIO59>;
+		};
+	};
+
 	mmc0_pins_default: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
@@ -1637,9 +1685,24 @@ &xhci2 {
 &xhci3 {
 	/* MT7921's USB Bluetooth has issues with USB2 LPM */
 	usb2-lpm-disable;
-	vbus-supply = <&pp3300_wlan>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb3_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&bt_ep>;
+			};
+		};
+	};
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.55.0.795.g602f6c329a-goog

