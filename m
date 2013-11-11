From: Brandon Anderson <brandon.anderson@amd.com>
Subject: [PATCH 4/4] ACPI/ARM: Remove sections of DTS definition
Date: Mon, 11 Nov 2013 11:16:10 -0600
Message-ID: <1384190170-8707-5-git-send-email-brandon.anderson@amd.com>
References: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:14373
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753784Ab3KKRSO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 12:18:14 -0500
In-Reply-To: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ssg.sos.patches@amd.com, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: Brandon Anderson <brandon.anderson@amd.com>

Use ACPI definition instead of DTS definition for devices that are supported
by AMBA bus ACPI module. The replacement ACPI definition was provided in the
related '0/4' email.

Note that MMCI is compatible with AMBA bus ACPI module, but is not ported
due to complex relations with sysreg and voltage regulator.


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +++++++---
 arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 ++++
 arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 ++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/foundation-v8-acpi.dts b/arch/arm64/boot/dts/foundation-v8-acpi.dts
index 7f57c53..f0671eb 100644
--- a/arch/arm64/boot/dts/foundation-v8-acpi.dts
+++ b/arch/arm64/boot/dts/foundation-v8-acpi.dts
@@ -15,12 +15,16 @@
 
 	chosen { };
 
+	/*
+	 * Removed for ACPI
+	 *
 	aliases {
 		serial0 = &v2m_serial0;
 		serial1 = &v2m_serial1;
 		serial2 = &v2m_serial2;
 		serial3 = &v2m_serial3;
 	};
+	*/
 
 	cpus {
 		#address-cells = <2>;
@@ -196,6 +200,9 @@
 				reg = <0x010000 0x1000>;
 			};
 
+			/*
+			 * Removed for ACPI
+			 *
 			v2m_serial0: uart@090000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
@@ -227,9 +234,6 @@
 				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
 				clock-names = "uartclk", "apb_pclk";
 			};
-			/*
-			 * Removed for ACPI
-			 *
 			virtio_block@0130000 {
 				compatible = "virtio,mmio";
 				reg = <0x130000 0x1000>;
diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts
index 7f348eb..0953fd0 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts
@@ -20,12 +20,16 @@
 
 	chosen { };
 
+	/*
+	 * Removed for ACPI
+	 *
 	aliases {
 		serial0 = &v2m_serial0;
 		serial1 = &v2m_serial1;
 		serial2 = &v2m_serial2;
 		serial3 = &v2m_serial3;
 	};
+	*/
 
 	cpus {
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi b/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi
index bbaaa8e..f20af14 100644
--- a/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi
+++ b/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi
@@ -71,6 +71,9 @@
 				#gpio-cells = <2>;
 			};
 
+			/*
+			 * Removed for ACPI
+			 *
 			v2m_sysctl: sysctl@020000 {
 				compatible = "arm,sp810", "arm,primecell";
 				reg = <0x020000 0x1000>;
@@ -87,6 +90,7 @@
 				clocks = <&v2m_clk24mhz>;
 				clock-names = "apb_pclk";
 			};
+			*/
 
 			mmci@050000 {
 				compatible = "arm,pl180", "arm,primecell";
@@ -100,6 +104,9 @@
 				clock-names = "mclk", "apb_pclk";
 			};
 
+			/*
+			 * Removed for ACPI
+			 *
 			kmi@060000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x060000 0x1000>;
@@ -179,6 +186,7 @@
 				clocks = <&v2m_clk24mhz>;
 				clock-names = "apb_pclk";
 			};
+			*/
 
 			clcd@1f0000 {
 				compatible = "arm,pl111", "arm,primecell";
-- 
1.7.9.5


