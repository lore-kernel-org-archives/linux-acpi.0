From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
 accessing PM registers
Date: Wed, 18 Sep 2013 17:28:25 +0800
Message-ID: <52397239.9080606@linaro.org>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com> <52366F91.30204@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63469 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab3IRJbk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Sep 2013 05:31:40 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so6798282pdi.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 Sep 2013 02:31:40 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

On 2013-9-17 1:26, Moore, Robert wrote:
> + #define ACPI_REDUCED_HARDWARE           TRUE
> 
> The intent of this feature is of course, to remove all code that is not needed -- specifically for hardware-reduced machines where the size of the kernel is important.

Ok, how about this patch below, is it reasonable to you?

>From b10bc1d2f9a3ff09abfb6990412aa1cf62d56937 Mon Sep 17 00:00:00 2001
From: Hanjun Guo <hanjun.guo@linaro.org>
Date: Wed, 18 Sep 2013 17:19:23 +0800
Subject: [PATCH] ACPI: Introduce CONFIG_ACPI_REDUCED_HARDWARE to enable
 reduced hardware

If we want to enable reduced hardware ACPI on some platform (such as ARM),
we need to modify the kernel code and set ACPI_REDUCED_HARDWARE to TRUE.

This is not reasonable, so introduce a kernel config to enable it, and
no need for kernel modification when we use hardware-reduced ACPI.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig    |    8 ++++++++
 include/acpi/acconfig.h |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0d7f6eb..1232a7b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -413,6 +413,14 @@ config ACPI_BGRT
          data from the firmware boot splash. It will appear under
          /sys/firmware/acpi/bgrt/ .

+config ACPI_REDUCED_HARDWARE
+       bool "Hardware-reduced ACPI support"
+       depends on ARM || ARM64
+        help
+         This config adds support for Hardware-reduced ACPI. When this option
+         is selected, will generate a specialized version of ACPICA that ONLY
+         supports the ACPI 5.0 "reduced hardware".
+
 source "drivers/acpi/apei/Kconfig"

 endif  # ACPI
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 1c16f82..15254f5 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -100,7 +100,11 @@
  *      ACPI PM timer
  *      FACS table (Waking vectors and Global Lock)
  */
+#ifdef CONFIG_ACPI_REDUCED_HARDWARE
+#define ACPI_REDUCED_HARDWARE           TRUE
+#else
 #define ACPI_REDUCED_HARDWARE           FALSE
+#endif /* CONFIG_ACPI_REDUCED_HARDWARE */

 /******************************************************************************
  *
-- 
1.7.9.5
