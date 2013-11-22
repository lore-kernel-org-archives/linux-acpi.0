From: al.stone@linaro.org
Subject: [PATCH v2 1/6] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Thu, 21 Nov 2013 17:41:50 -0700
Message-ID: <1385080915-23430-2-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:65194 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab3KVAmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:11 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so523446pbc.25
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:10 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
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

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 8 ++++++++
 include/acpi/platform/aclinux.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d92485..53f0f16 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -343,6 +343,14 @@ config ACPI_BGRT
 	  data from the firmware boot splash. It will appear under
 	  /sys/firmware/acpi/bgrt/ .
 
+config ACPI_REDUCED_HARDWARE
+	bool "Hardware-reduced ACPI support"
+	depends on ARM || ARM64
+	help
+	This config adds support for Hardware-reduced ACPI. When this option
+	is selected, will generate a specialized version of ACPICA that ONLY
+	supports the ACPI "reduced hardware".
+
 source "drivers/acpi/apei/Kconfig"
 
 config ACPI_EXTLOG
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

