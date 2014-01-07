From: Feng Kan <fkan@apm.com>
Subject: [PATCH V2 2/6] arm64: add missing dts entry for X-Gene platform.
Date: Tue,  7 Jan 2014 14:50:37 -0800
Message-ID: <1389135041-16062-3-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-acpi@vger.kernel.org

Add missing dts entry for the X-Gene reboot driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index d37d736..78d29781 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -187,5 +187,10 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
+
+		reboot@17000014 {
+			compatible = "apm,xgene-reboot";
+			reg = <0x0 0x17000014 0x0 0x4>;
+		};
 	};
 };
-- 
1.7.6.1
