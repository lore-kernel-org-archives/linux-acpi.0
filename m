Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A4435508
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616949; cv=none; b=KlnBOv67nIeYv93g1+PBKIStI2BMzuiXc1Sxy09q66ZulC4GvxsdEZ7i1ivRnCesLz4eXBkbUX8YgPgnGOFzDpX0wktecCQhO03XOW0RIQEde0cFIn3nzj3wC+BebrkINdtshMYKn9qA34prB/wfOjGZeuZun0sjvUCJ82Hol4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616949; c=relaxed/simple;
	bh=cD7gxZbnksnsRmt5xlVgCnW9fn8tFZE5tdqpS/YKQq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orZ68cY2vKEmp+L3dr3RRkpm/djrXXSn/sUmo12nfrVbnngq4ZeAsNmx4iFjUq1WIryglPhC9uvja9oytKwScwow4HXVWYEBbjBNpPEGxn05K4Xc1YFguljBh0gH0geBrcfnRxW84AnyCF98FYYe1d+nlfNgaI/m12sJH3iLLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FPc/sQCw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPc/sQCw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so70230365ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616946; x=1785221746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpPVT8Dc4rsd7+Cy/PRWiKisx//FM/DZEFs1R+jF/Vo=;
        b=FPc/sQCwgDyJXu6s/HKhVc9SbB55Bwmdq3QrqdzvD0xUj6DxB8Bt3Sq29ZvXfFYCOf
         iEMfnd751mIi/cQ0R4QAd4Ioj2uUa7NG77xoT1kCzkD69xYRWI21l6wTOcs7A2lNX6qe
         y+U8woy7XAtQYiFCE3ZDuarexqZGq3KiCP8xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616946; x=1785221746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpPVT8Dc4rsd7+Cy/PRWiKisx//FM/DZEFs1R+jF/Vo=;
        b=O0YLj0Mycmpu0huBmsk+Tr8xtN1gHW+OU1TcXF8S1vbL4mxRZsXjVoZPF15BpUz8nQ
         xrfCCymMzEobPv2CYRtrn5tNvM5zBX5gVXnhkoFMYjE5cpDoZyGnFloIY3tNG7Ry/P8J
         pSHESP3xry3nL322O2Lhox1IaZsmGpQpk78tTIuNo+yvr4lz+DHLAsAwT8Hos3I9SFxh
         9zUiM/N0imhm75r+iM3aA6+0+5fykEbSrNO9RNmjkAwhBQ1J7l348iuJcanCJXi5/wJ5
         eeIllrtzBT4pTBPoy2zFizgLGlmQW6HQ/0nErchMcqCifLdq7Gdrt5EylDnqKmTM+ZnE
         hiew==
X-Forwarded-Encrypted: i=1; AHgh+Rq8kQghMjVBlg1AZZo82DSO+dFc10GwCkKq8TbTKSjZ4oNdOMyd0lWLLtvqC66Q7slcfzVMQfX6ql+J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qwKuMpaV2VO1wZpuI/jhWwU5SWh4o87DLUtcqwvHz6sQgwv+
	I6i9wPS+gQcHVlKU8B0fU8JHcoMsdEsEuIeG1SN6uU9i7bGuPI9KNsb7OzFJU1ef2w==
X-Gm-Gg: AR+sD13l0Suu3iQAZIhTJC0y8Ux0x5NeVuW6TkXP/Z9kfueuxbpZCfzd/Q2IsNKaZkL
	qgwR7yxNfJ6OPL0sFlg74Gi2wWc9UjJRp9p3VaHbkCe1nS1d5rMwgew/i4b/3f2yimQkrpWNwGN
	gX2yoYQlcxaGXp1UB/v+NAnRRUvmN/Al5A/AU3YBeoE0dhzYUOPfBkBubX+OrAZzwqjFd4CcAJE
	aQqEj+kpR8z6SjUd7pc1hj29qkk8m0Z4pSPgvA9GZjsJzrLnz7WFSYXBpBSRSuAHkr8499OdURz
	04CyL43tyZ3itfX07R2fVin21OfXCvfytTvE8IRu4Csk/T2/rPvyCFQ3pDNg7zTPCdVyV6XuCAV
	mIPlib8U2k+fYjxDu+wGYk5yMPHeVXM9PdOSXknHSN9Fkfl9uxubxmSRrkLDa50V2Ops5asBFGk
	5PxkYTYFbMWT0t9+mWQ9TgOM54dJcFw5oISmQvDZuoWTdu5f2epn/L4DPZi70mLnvGns1J1Q==
X-Received: by 2002:a17:902:d581:b0:2ce:d34a:5963 with SMTP id d9443c01a7336-2cf3496c380mr178033695ad.24.1784616946307;
        Mon, 20 Jul 2026 23:55:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:45 -0700 (PDT)
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
Subject: [PATCH v6 15/16] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Tue, 21 Jul 2026 14:54:10 +0800
Message-ID: <20260721065413.2306137-16-wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

