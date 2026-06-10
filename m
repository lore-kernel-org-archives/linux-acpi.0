Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547813DBD7F
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080952; cv=none; b=blRcovID7aqHtutLO/HsABMFkK8NPO2+Z7+bZm9J7LJZG0p0uschZTHHubl5+qNQ8ekdnqRfY9gMzhFVD3bV8EtetNVdYjkWh8xt7RVIQBGuhAV6ZCzCoOwK/5pVx2EbIPjfR4sdhCe9C5U5hccwnJZ9ch24OeaVK7NSqtEMjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080952; c=relaxed/simple;
	bh=L0k6uos52VV4wg4MHzXBUup1YCt3bqCKawBNWUGaaBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrpJMKpUX5iTO9F6xPRvfm4z53OOt/3NR0hc/CtnQgyYoOXKDa15+j2PnT6zDztxdJIlW3zyMFGqrAaM/AxuuA4rv9DvosRtCR7t7x21H2n+Qg8XNzqz4XAMORLFQHzRRtlx1pZnTjbfmuD1I0+MLYNgtAKbL65lNg9KhFkgPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qlzr6dIX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qlzr6dIX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c379e8ffso44616445ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080950; x=1781685750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIcmQ/+wBM4HApLQCMfHTTwDc3UumPbYrqxn3prOxAY=;
        b=Qlzr6dIXYLWe+J1AwJtZuVEydjBe/30Rx/JLGcFfo20Wo1t0CTykbRC69z3tMJ91V5
         4UYX5bZfWp8s1ISrLW/TXHw3uqS1oZwf64wv5UztWEGoGUaZLdTeFVRjb1aVjqXHvZsu
         llT4AsUREnI9FbCkKNcT73SRhua2vtuyrm2iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080950; x=1781685750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIcmQ/+wBM4HApLQCMfHTTwDc3UumPbYrqxn3prOxAY=;
        b=Qmf4DlYvh1imCZUCzZZVdh0C62Ohg0+9XvWBBL4tPhlpOH1mNZr1GI6b0xAwIF6itX
         Wb7TRgo6JAnDdX1Ov/gzSOLB/n49N9m4wsK0J5PhC5McY0iY6o2U06zlwogbNDicVhY5
         ZyHApzhGlRwONr8q1i2MbJZbJJ7yew1F1/6Mo7hmoV8nsYAI7i9stELJTQDTN2liaJfx
         4Hh3gPpRtcpZpyW386kV28xmkaCo9zdorbWUEUM4eW38DjraxXVxT83Kg3cSTVppq0z0
         7amXVQR8EDq1paUYlu/aUfrtLmkngWW5UQMFLti2d1NBSh8m/QYJyDWTJm765k8M+Nbv
         1lLw==
X-Forwarded-Encrypted: i=1; AFNElJ8WDVzKR/LoTKiVHIEszaaCklOe4qM9W4ic20LRKvRdGiqq+ffRosbBm6otYcCW839B4a/w7IcD49+c@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7XwwMKG8dp7Z/3dJJizXc+xqb+v2wgixJ0hrtQImL50ZiGY2
	qGVVYaWh/o/nxCmPaA7ugYgWoWbsPIQJyWQFwsHl392jt7e81AKkCI+gwlPK2HIOJA==
X-Gm-Gg: Acq92OHjvkJ8Vs3sfqZuit8JoD+LdTC9ay1aZlmIv9u6YHdWIYkTj2s9nnLvkcrKUPl
	o1Ki0tSqvL45CDzDHYrlLBgbCIWfvRXjOuuhROMqaODaMMFjqZCS2eXmNn/M4Ra8IrY3HO4SS4t
	DEliQ7mWWHzEG2iHfbSuaDdql76Tn1e5YVs+N/HSw8u1Jzj13SlDfvg/3PMf7Jr1e2gtvfxDvmk
	Hiwwbe/0rJXaJ5XsYY9VXaQnJVPCcx9B1hLClfJIXkq8UKmGGnsKk1xWINfrDQd71EzX+r8ZaBa
	0FZhiu+EDpsXEPjxJVF1HT65Prtpoq1fpKeduLsviEjlcC1wMQidvkM1rTuF8/T1p+VgZ+E9ei0
	bzBRfU9h8ZmWt6nMIslpvhVEJLJnSK49ILx1gdqs3PXuvPxXkmZ0esi0sqgOvTCLdd4LdGruuTF
	v4THE2Ot+YLQYjbR+zyV8GrTlPcShWcDVORRGIj2rKYWuokGbGDl7IDPpql0i3185dVlewB7GCG
	SzPmQCGf7It1e6vzg==
X-Received: by 2002:a17:902:fc48:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c1e78e4f0emr297124555ad.4.1781080949649;
        Wed, 10 Jun 2026 01:42:29 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:29 -0700 (PDT)
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
Subject: [PATCH v2 16/16] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot
Date: Wed, 10 Jun 2026 16:40:50 +0800
Message-ID: <20260610084053.2059858-17-wenst@chromium.org>
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

The MT8188 Geralt design features a chip-on-board WiFi/BT solution. This
is a M.2 E-key WiFi/BT board layout directly inserted into the mainboard
design. The connections to the rest of the board are almost the same as
if it were a separate M.2 card. The only addition is the PMU_EN pin on
the chip; on M.2 cards this would be tied to the primary power source.

Model the chip-on-board WiFi/BT solution as a M.2 E-key slot with PCIe,
USB and auxiliary signals. The PMU_EN pin, which enables the internal
power controls and regulators, is modeled as a regulator fed by the
pp3300_wlan regulator. Since power sequencing is now correctly modeled
using the M.2 E-key slot, drop the "regulator-always-on" property one
pp3300_wlan regulator. Also drop the comment in xhci2 saying "MT7921's
power is controlled by PCIe".

Also drop the voltage range on the pp3300_wlan regulator. This
"regulator" is just a load switch and does not provide any regulation.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 93 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index f382f90c48f5..c4cc2cff1b5b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -86,13 +86,11 @@ pp3300_z1: regulator-pp3300-z1 {
 	pp3300_wlan: regulator-pp3300-wlan {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_wlan";
-		regulator-always-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		enable-active-high;
 		gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&wlan_en>;
 		pinctrl-names = "default";
+		/* load switch */
 		vin-supply = <&pp3300_z1>;
 	};
 
@@ -159,6 +157,17 @@ ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
 		vin-supply = <&pp5000_z1>;
 	};
 
+	/* PMU_EN pin controls internal regulators and power sequence */
+	wlan_pmu: regulator-wlan-pmu {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-pmu";
+		enable-active-high;
+		gpio = <&pio 145 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&wlan_pmu_en>;
+		pinctrl-names = "default";
+		vin-supply = <&pp3300_wlan>;
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -193,6 +202,39 @@ adsp_dma_mem: memory@61000000 {
 			no-map;
 		};
 	};
+
+	wifi-bt-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_e_key_kill_pins>;
+		vpcie1v8-supply = <&mt6359_vcn18_ldo_reg>;
+		vpcie3v3-supply = <&wlan_pmu>;
+		w-disable1-gpios = <&pio 13 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PCIe for WiFi */
+			port@0 {
+				reg = <0>;
+
+				wifi_ep: endpoint {
+					remote-endpoint = <&pcie_ep>;
+				};
+			};
+
+			/* USB for Bluetooth */
+			port@2 {
+				reg = <2>;
+
+				bt_ep: endpoint {
+					remote-endpoint = <&usb2_ep>;
+				};
+			};
+		};
+	};
 };
 
 &adsp {
@@ -657,6 +699,22 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
 	status = "okay";
+
+	pcie@0 {
+		compatible = "pciclass,0604";
+		reg = <0 0 0 0 0>;
+		device_type = "pci";
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		port {
+			pcie_ep: endpoint {
+				remote-endpoint = <&wifi_ep>;
+			};
+		};
+	};
 };
 
 &pciephy {
@@ -1000,6 +1058,14 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO13__FUNC_B_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_B_GPIO14>;
+			output-high;
+		};
+	};
+
 	mipi_disp_avdd_en: mipi-disp-avdd-en-pins {
 		pins-en-ppvar-mipi-disp {
 			pinmux = <PINMUX_GPIO3__FUNC_B_GPIO3>;
@@ -1164,6 +1230,13 @@ pins-bus {
 		};
 	};
 
+	wlan_pmu_en: wlan-pmu-en-pins {
+		pins-wlan-pmu-en {
+			pinmux = <PINMUX_GPIO145__FUNC_B_GPIO145>;
+			output-low;
+		};
+	};
+
 	wlan_en: wlan-en-pins {
 		pins-en-pp3300-wlan {
 			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
@@ -1343,10 +1416,22 @@ vdosys1_ep_ext: endpoint@1 {
 };
 
 &xhci2 {
-	/* no power supply since MT7921's power is controlled by PCIe */
 	/* MT7921's USB BT has issues with USB2 LPM */
 	usb2-lpm-disable;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			usb2_ep: endpoint {
+				remote-endpoint = <&bt_ep>;
+			};
+		};
+	};
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.54.0.1099.g489fc7bff1-goog

