Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357240DFC7
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591130; cv=none; b=iVbFzRvpVAvyERqdRAimWAlT9vZxAAMWy5tl6g8QY+oyz23IMuu6WxWgKx1sr1O538vMLgmQFfPzM4RG2iO3L6u2Qtpf6crhCNGjT5cr5iIH098nYuHRil4r/3h4pq5h8Ca8LwnRkOGuikk1uzfNs75MDY5//7DdZXxZV7RqEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591130; c=relaxed/simple;
	bh=Kwdh1wsDA3PQhAJXo0c3P6asDMiUgGjPhgZiuNl33tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfSvfZDouuqwclLTN3SIUfLKMl3VPBJvTjSr+GjUa8nduYf6eE6t0pWtAWcrWIkOY/m303F/Vl6qooeT1A+7mFIbg0LiV6imZ1vOSCnFuSR5+ntz0Xw49pceWTyIKhgRzxOOEwKEmeRte5OwElknfTqtqNm4kkEdJX0GNdYYHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WTgjieAf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTgjieAf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so7496695ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591128; x=1784195928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3HJTWjS7+7k2AMeQ/ADfiVkN81b/TWdXvCN6CQ3PZA=;
        b=WTgjieAfs+UJDdeyn04913Pv6VWXPWClSQy45+aEABhhZsnmdf0obtmcHrxdA3cP1a
         JWQJHu5lNqr+EJKzJR1djDi/OOc7kCHshleopyPVAo7aXrlL0kViJlZkggwlprWrHyxz
         mAnu0Uh5fXa4bFfGtOIyX4CeNfu5lhvmeEi7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591128; x=1784195928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3HJTWjS7+7k2AMeQ/ADfiVkN81b/TWdXvCN6CQ3PZA=;
        b=cW4ir5NL0IM9IOrQHJUQBlPK2+sGtyJ4Ky1eGCAbX/7T2+nkb2w0dlOU4Biqqp7Bl3
         g8EaCqvs8rWFAbOcS8zWpzB/U5G1nauogBGl6Zb538vB5tOBSacQU/lsNMhzqI/PUw2W
         mqWVJbbfunRXsgth3iKKDW3frKFnYgEg+cOWnX2IkdxCBlJ+ZbcNCDguQg3EpX8DB6hf
         z5oW9iJIDIiVa2GeB2FRB6V/Cm3vvJ8nV/2LvyY46k7m3QnD+KXhXfAQjF0hORWAQp2e
         YanAb2Z88ZYEtdlIzsOFjtQbveUstX3eHE5xJD08lEORriosLYtgKX81iCcmDxDAHh40
         SZdA==
X-Forwarded-Encrypted: i=1; AHgh+Rqp0fqOfTWOtFENAqyrWRzdYl8VEDGovMarEvi8rTQ2UV3E7Rrm+F4IYp9k1KKpNbmAnlIr2M0MgdWd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+V4euDGIUwurVGk5B17Z722RqWJGseOJNicSMPEymz6GPtxK
	qTNFkX5yTolF0zYqVNBSDEndwv1xa7lHzONqDdXKTTIcK0nkwBWkKmqt/1j9FGca8w==
X-Gm-Gg: AfdE7ck3htUYdNiUwRObtgcOAAA+IIbhBWGdT9eiJW3DBFrCrCmQsG4nK/V9D32QERR
	AM7yG0d5Cj27RfxsibWU7ZcNT3/Mp4IhqxpZtRD5ZE3d+QvYUM1NNSQryV+Syyu2FJ5m/hBPrvN
	vk1XB/7lOEqmCo752QOLg1pVCfAsE2tian1zNGRQyjxw4WjDOYow4dp1joE4ix1In0hdF3wqToY
	XM/zFoscp/DvGOlsKiMaMuBK2NOHBHUHmyD+XCjJ79qTLGvPNNA8aQa0nQt2uBmpEHdNGZdMLt5
	QxqD1e4I4Mrhww7Y8JLkcPVefWaDKgly08MbTCHcgBX9/sVu+rRYZuIN53RiPYa8AEF5Em9G4vR
	+Coc9D1EFsOCaok1+NBC2oSBfEBCPatourQdsrDJot3vt0B46wD2nZFv8snYV/lPH8fbVs7uvdD
	uCy+6EpBXXRH7Zhzje70Sd7gA1I8QLFKuFuVthnSyZQ/NdqvlKB8w7IssJoX6SLVE1o7d2SQ==
X-Received: by 2002:a17:903:17c6:b0:2cc:7e4a:bcc5 with SMTP id d9443c01a7336-2ccea480bdfmr74905205ad.32.1783591128101;
        Thu, 09 Jul 2026 02:58:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:47 -0700 (PDT)
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
Subject: [PATCH v4 13/14] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Thu,  9 Jul 2026 17:57:18 +0800
Message-ID: <20260709095726.704448-14-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
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

