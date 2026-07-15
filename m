Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079163EB10B
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105738; cv=none; b=uWrZ3SgpMV5eEkFhgHEDAuL31yu5iK5dOmZrJ/tHalMfQ/DkIFj9Km9o1atRRhl//Di/AOjBURQ/I3wR5/sLuHyj48uA4+G4KjAMIKRlvR0WmuJZs+GTOJ/dhR8Zpu4xkdqNRhmf7hX+2/pymkqbvMIrUz09QbcPg2VWVFx15Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105738; c=relaxed/simple;
	bh=YJyU75cpPuviW3DeoVCtVsycwY35EMz4CrOCdWp2v74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZr57sX0RLM1qg/Jg6eDIfgz/rv9ka9DeaveysIDPAuXjUEz5GctYdmUWGOVAkLsHmPO8gly2Pzbqz5vymfuwe3bhq/6yKZtdrXGd+bfVevnOpLd6K8RJMQC2kULT9yvx1H74x2M9DS87LVIc5bsjJZU80GecUXAyO6rT0NAE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OVszIwLS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVszIwLS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848882fdb18so1898309b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105733; x=1784710533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzcA9TG2yqej8iZO6JRem4wjlVQiv9Z5qdYjer6rUOE=;
        b=OVszIwLS7H8jiqE+d2DA2xPOT8UD7FSvMFhYDyZYT7/CL1w2FW4FSln6Z6V63NeATU
         R/fFeOrvCXNGaIKFMIOAnuZpho1aiq2jCYiY5ZRKWQshFQv2EQUWDDKgpBCNwPI9CnD0
         F/DTNpxO9rBgMZHeVDybxLXFqlVr1VIEwVCxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105733; x=1784710533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzcA9TG2yqej8iZO6JRem4wjlVQiv9Z5qdYjer6rUOE=;
        b=OqTOwQC0Exz9QnktemTeDFTVVIGOJvkkzDJEKscyIhJQJeo+Ap6ivefVM69iywKccF
         1xODmE/zI+8AOSZHSrU6L/zY9pkCdSO8mrHMHL5ZN1NB8FfBORIpNn8TaQA3KR9qKwjC
         NdXLzQ3IueqhokcWrY2+mcJMPxUzws1akj734Vnap53YQEDgzrkI3CXGmiyyoBIaCX+c
         SEiM7tkrwDcNsDwaEZUxC8yhsC4+TBewNyDh6T5ag5CZLd+51aBhWFxKnAxITRnpqIg6
         P5Gi+v9Lwp1YfuIj00ZwEd/Dv8Y+EfP6J+4sALF3kCyJlqXvjtIKt7j6d+0Wvs6TOK9C
         /r7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrlGGDGfLc3kHr0grU+aoq/RwQpu3Vz7QjmDuQwcMG9CglvEefd5rafM8gxYamhXW3Yn6/3BhqF9NpM@vger.kernel.org
X-Gm-Message-State: AOJu0YxyjV/UGo37dofGYI+zBIjBZZhpOJR0A9RFX2md9uNxYQEwrX1M
	UQlWKrDh4ioHfG5p3XVHS6hjHzSVa/c9A4m+BGsgLxXdmMokxnMDGAcrzFramWFmjA==
X-Gm-Gg: AfdE7cm0VGF8C7V+ZoEjQBBC0fWVPnywY5xu7ZnecIxbl1XCAfnzEGBHJeggxuX3zuz
	kJacwYUUKHSTLGROVDrYlxXA5RDNX6SZukdJwuRUE1ahrEjn+VeNLzs6nXIoxLyNGJUhtQIbJj7
	i1JqMLqAKRiM5o4gDoObHkM61rfETcAO0VPstF6hgISea0DuRtU/XqqjvXpsyIggcWFzOCVIden
	Pvl8B8VtIiQLeo6mmBm5UNDC/VQacI6b+RKx9wYJAGnrJKuWCGI+8W8Qlu6f8GHIiBTwlimjljx
	8vjsIc3Qw+D/ilegMV1Sm2qW2S6VZtPCfKCqrRbxuwmy4/7SiHWjwQI7z1+M5iR6sgZyEL+2DBW
	DKt8MaLGLEabBkTrDsn/clGM8QXEh4tlsVp74IiVt3+QDoVo5ZFGpuzbuC3D3cih40Eiwbosf32
	uq42mTdFq+jCn0dfmqAE1P+Bfavc2hc5ZMo+lKBnTQ/3LFQzuqPOp7pIaYjX8xIIO9mF+rng==
X-Received: by 2002:a05:6a00:368d:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84a6723d613mr1884956b3a.8.1784105733495;
        Wed, 15 Jul 2026 01:55:33 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:55:33 -0700 (PDT)
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
Subject: [PATCH v5 16/16] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot
Date: Wed, 15 Jul 2026 16:53:46 +0800
Message-ID: <20260715085348.3457359-17-wenst@chromium.org>
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
Changes since v2:
- Drop default GPIO output state from kill pins pinconfig
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 92 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index dee946309121..73b5c0fdeae6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -88,13 +88,11 @@ pp3300_z1: regulator-pp3300-z1 {
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
 
@@ -161,6 +159,17 @@ ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
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
@@ -195,6 +204,39 @@ adsp_dma_mem: memory@61000000 {
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
@@ -659,6 +701,22 @@ &pcie {
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
@@ -1002,6 +1060,13 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO13__FUNC_B_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_B_GPIO14>;
+		};
+	};
+
 	mipi_disp_avdd_en: mipi-disp-avdd-en-pins {
 		pins-en-ppvar-mipi-disp {
 			pinmux = <PINMUX_GPIO3__FUNC_B_GPIO3>;
@@ -1174,6 +1239,13 @@ pins-bus {
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
@@ -1417,10 +1489,22 @@ vdosys1_ep_ext: endpoint@1 {
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
2.55.0.795.g602f6c329a-goog

