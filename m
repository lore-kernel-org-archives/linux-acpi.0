From: al.stone@linaro.org
Subject: [PATCH v3 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Wed,  4 Dec 2013 14:22:03 -0700
Message-ID: <1386192127-28564-2-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37870 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab3LDVWV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 16:22:21 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so27730091ief.38
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 13:22:21 -0800 (PST)
In-Reply-To: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

From: Al Stone <al.stone@linaro.org>

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

Support for X86 in hardware reduced mode is also provided to make it
simpler to debug this mode, and to provide for probable use in such
products.  Hardware reduced mode, despite the name, exists primarily
to allow newer platforms to use a much simpler form of ACPI that does
not require supporting the legacy of previous versions of the specification,
and is likely to be used more often in the near future as a result.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 8 ++++++++
 include/acpi/platform/aclinux.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d92485..66e6bb2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -343,6 +343,14 @@ config ACPI_BGRT
 	  data from the firmware boot splash. It will appear under
 	  /sys/firmware/acpi/bgrt/ .
 
+config ACPI_REDUCED_HARDWARE
+	bool "Hardware-reduced ACPI support"
+	depends on X86 || ARM || ARM64
+	help
+	This config adds support for Hardware-reduced ACPI. When this option
+	is selected, will generate a specialized version of ACPICA that ONLY
+	supports the ACPI "reduced hardware".
+
 source "drivers/acpi/apei/Kconfig"
 
 config ACPI_EXTLOG
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 28f4f4d..a33f502 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -52,6 +52,12 @@
 
 #ifdef __KERNEL__
 
+/* Compile for reduced hardware mode if requested for this kernel config */
+
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+#define ACPI_REDUCED_HARDWARE 1
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.8.3.1

