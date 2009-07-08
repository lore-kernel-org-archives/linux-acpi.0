From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] SFI, x86: add CONFIG_SFI
Date: Wed, 08 Jul 2009 00:13:48 -0400
Message-ID: <d5a8e3203627c313e8fdbf4fa9ac1cb1cdc6706c.1247025117.git.len.brown@intel.com>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756340AbZGHEOR@vger.kernel.org>
In-reply-to: <1247026438-20891-1-git-send-email-lenb@kernel.org>
In-reply-to: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
References: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

analogous to ACPI, drivers/sfi/Kconfig is pulled in by arch/x86/Kconfig

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/Kconfig    |    2 ++
 drivers/sfi/Kconfig |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 drivers/sfi/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f722..8e864c0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1683,6 +1683,8 @@ source "kernel/power/Kconfig"
 
 source "drivers/acpi/Kconfig"
 
+source "drivers/sfi/Kconfig"
+
 config X86_APM_BOOT
 	bool
 	default y
diff --git a/drivers/sfi/Kconfig b/drivers/sfi/Kconfig
new file mode 100644
index 0000000..b217f32
--- /dev/null
+++ b/drivers/sfi/Kconfig
@@ -0,0 +1,16 @@
+#
+# SFI Configuration
+#
+
+menuconfig SFI
+	bool "SFI (Simple Firmware Interface) Support"
+	depends on X86
+	default n
+	---help---
+	The Simple Firmware Interface (SFI) provides a lightweight method
+	for platform firmware to pass information to the Operating System
+	via static tables in memory.
+
+	For more information, see http://simplefirmware.org
+
+	Say 'Y' here to enable the kernel to boot on SFI-only platforms.
-- 
1.6.0.6
