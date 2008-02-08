From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/8] ACPI: WMI: Improve Kconfig description
Date: Fri,  8 Feb 2008 01:29:23 -0500
Message-ID: <20b4514799ebcfb04b45537e90e421cb73fd0cc9.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:37463 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933510AbYBHG3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:37 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Pavel Machek <pavel@ucw.cz>, Ray Lee <ray-lk@madrabbit.org>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

As Pavel Machek has pointed out, the Kconfig entry for WMI is pretty
non-descriptive.

Rewrite it so that it explains what ACPI-WMI is, and why anyone
would want to enable it.

Many thanks to Ray Lee for ideas on this.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Pavel Machek <pavel@ucw.cz>
CC: Ray Lee <ray-lk@madrabbit.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 65da19b..f688c21 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -207,11 +207,22 @@ config ACPI_WMI
 	depends on X86
 	depends on EXPERIMENTAL
 	help
-	  This driver adds support for the ACPI-WMI mapper device (PNP0C14)
-	  found on some systems.
+	  This driver adds support for the ACPI-WMI (Windows Management
+	  Instrumentation) mapper device (PNP0C14) found on some systems.
 
-	  NOTE: You will need another driver or userspace application on top of
-	  this to actually use anything defined in the ACPI-WMI mapper.
+	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
+	  ACPI firmware to userspace - this is done through various vendor
+	  defined methods and data blocks in a PNP0C14 device, which are then
+	  made available for userspace to call.
+
+	  The implementation of this in Linux currently only exposes this to
+	  other kernel space drivers.
+
+	  This driver is a required dependency to build the firmware specific
+	  drivers needed on many machines, including Acer and HP laptops.
+
+	  It is safe to enable this driver even if your DSDT doesn't define
+	  any ACPI-WMI devices.
 
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
-- 
1.5.4.34.g053d9

