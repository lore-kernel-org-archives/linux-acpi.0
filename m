From: al.stone@linaro.org
Subject: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Sat,  9 Nov 2013 18:36:11 -0700
Message-ID: <1384047382-20623-2-git-send-email-al.stone@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46092 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576Ab3KJBgd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Nov 2013 20:36:33 -0500
Received: by mail-ie0-f175.google.com with SMTP id u16so2485674iet.34
        for <linux-acpi@vger.kernel.org>; Sat, 09 Nov 2013 17:36:32 -0800 (PST)
In-Reply-To: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>

From: Al Stone <ahs3@redhat.com>

To enable the hardware reduced mode of ACPI on some platforms (such as
ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWARE
to TRUE in the ACPICA source.

This can be done more resonably by introducing a kernel config item
to enable/disable ACPI_REDUCED_HARDWARE.  We can then change the kernel
config instead of having to modify the kernel source directly to enable
the reduced hardware mode of ACPI.

Lv Zheng suggested that this configuration item does not belong in ACPICA,
the upstream source for much of the ACPI internals, but rather to the
Linux kernel itself.  Hence, we introduce this flag so that we can make
ACPI_REDUCED_HARDWARE configurable.  For the details of the discussion,
please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.html

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 8 ++++++++
 include/acpi/platform/aclinux.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 589da05..7bbd3b0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -354,6 +354,14 @@ config ACPI_BGRT
 	  data from the firmware boot splash. It will appear under
 	  /sys/firmware/acpi/bgrt/ .
 
+config ACPI_REDUCED_HARDWARE
+	bool "Hardware-reduced ACPI support"
+	depends on !(IA64 || X86)
+	help
+	This config adds support for Hardware-reduced ACPI. When this option
+	is selected, will generate a specialized version of ACPICA that ONLY
+	supports the ACPI "reduced hardware".
+
 source "drivers/acpi/apei/Kconfig"
 
 endif	# ACPI
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 28f4f4d..ae93a91 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -67,6 +67,10 @@
 
 /* Host-dependent types and defines for in-kernel ACPICA */
 
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+#define ACPI_REDUCED_HARDWARE TRUE
+#endif
+
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
-- 
1.8.3.1

