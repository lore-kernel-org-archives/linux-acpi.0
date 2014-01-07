From: Feng Kan <fkan@apm.com>
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot dts node.
Date: Tue,  7 Jan 2014 14:50:36 -0800
Message-ID: <1389135041-16062-2-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-acpi@vger.kernel.org

Add X-Gene reboot device tree node documentation.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 .../devicetree/bindings/arm64/xgene/reboot.txt     |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm64/xgene/reboot.txt

diff --git a/Documentation/devicetree/bindings/arm64/xgene/reboot.txt b/Documentation/devicetree/bindings/arm64/xgene/reboot.txt
new file mode 100644
index 0000000..51d23c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm64/xgene/reboot.txt
@@ -0,0 +1,10 @@
+Reboot property to control system reboot on storm platforms:
+
+The register attribute contain the address of the reset register.
+
+Example:
+
+	reboot@0 {
+		compatible = "apm,xgene-reboot";
+		reg = <0x0 0x17000014 0x0 0x4>;
+	};
-- 
1.7.6.1
