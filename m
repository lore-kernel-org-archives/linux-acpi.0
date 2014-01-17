From: al.stone@linaro.org
Subject: [PATCH v3] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to enable this ACPI mode
Date: Fri, 17 Jan 2014 11:51:30 -0700
Message-ID: <1389984690-24251-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43434 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaAQSvl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 13:51:41 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so2372499pbb.15
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jan 2014 10:51:41 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

From: Al Stone <al.stone@linaro.org>

ACPI hardware reduced mode exists to allow newer platforms to use a
simpler form of ACPI that does not require supporting legacy versions
of the specification and their associated hardware.  This mode was
introduced in the ACPI 5.0 specification.

To enable the hardware reduced mode of ACPI, we need to set the flag
ACPI_REDUCED_HARDWARE to TRUE in the ACPICA source.  In order to do
that, we introduce a kernel configuration item to enable or disable
ACPI_REDUCED_HARDWARE.  We can then change the kernel configuration
instead of having to modify the kernel source.

Introducing this configuration item is based on suggestions from Lv
Zheng saying that this does not belong in ACPICA, but rather to the
Linux kernel itself.  Hence, we introduce this configuration item so
that we can make ACPI_REDUCED_HARDWARE configurable.  For the details
of the discussion, please refer to:

   http://www.spinics.net/lists/linux-acpi/msg46369.html

Changes for v3:
   -- Minimize the changelog.

Changes for v2:
   -- Changed test for EXPERT to avoid reported Kconfig warning

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 13 +++++++++++++
 include/acpi/platform/aclinux.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4770de5..9fd6a7a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -343,6 +343,19 @@ config ACPI_BGRT
 	  data from the firmware boot splash. It will appear under
 	  /sys/firmware/acpi/bgrt/ .
 
+config ACPI_REDUCED_HARDWARE_ONLY
+	bool "Hardware-reduced ACPI support only" if EXPERT
+	def_bool n
+	depends on ACPI
+	help
+	This config item changes the way the ACPI code is built.  When this
+	option is selected, the kernel will use a specialized version of
+	ACPICA that ONLY supports the ACPI "reduced hardware" mode.  The
+	resulting kernel will be smaller but it will also be restricted to
+	running in ACPI reduced hardware mode ONLY.
+
+	If you are unsure what to do, do not enable this option.
+
 source "drivers/acpi/apei/Kconfig"
 
 config ACPI_EXTLOG
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 28f4f4d..7d71f08 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -52,6 +52,12 @@
 
 #ifdef __KERNEL__
 
+/* Compile for reduced hardware mode only with this kernel config */
+
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE_ONLY
+#define ACPI_REDUCED_HARDWARE 1
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.8.4.2

