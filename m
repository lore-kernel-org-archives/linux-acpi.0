From: <brandon.anderson@amd.com>
Subject: [RFC PATCH 1/3] ACPI: Remove UART and KMI entries from DTS file
Date: Mon, 21 Oct 2013 19:33:47 -0500
Message-ID: <1382402029-13381-2-git-send-email-brandon.anderson@amd.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:4845
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab3JVAeq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Oct 2013 20:34:46 -0400
In-Reply-To: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, hanjun.guo@linaro.org, graeme.gregory@linaro.org, Suravee.Suthikulpanit@amd.com, Brandon Anderson <brandon.anderson@amd.com>

From: Brandon Anderson <brandon.anderson@amd.com>

Remove DTS definition of UART and KMI so that ACPI definition in DSDT can take care of driver probing for these devices.


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +++++++---
 arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 ++++
 arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

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
index bbaaa8e..ba4e364 100644
--- a/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi
+++ b/arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi
@@ -100,6 +100,9 @@
 				clock-names = "mclk", "apb_pclk";
 			};
 
+			/*
+			 * Removed for ACPI
+			 *
 			kmi@060000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x060000 0x1000>;
@@ -147,6 +150,7 @@
 				clocks = <&v2m_clk24mhz>, <&v2m_clk24mhz>;
 				clock-names = "uartclk", "apb_pclk";
 			};
+			*/
 
 			wdt@0f0000 {
 				compatible = "arm,sp805", "arm,primecell";
-- 
1.7.9.5


