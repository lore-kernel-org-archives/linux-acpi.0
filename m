From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] acer-wmi, tc1100-wmi: select ACPI_WMI
Date: Fri,  8 Feb 2008 01:29:24 -0500
Message-ID: <4a507d93fac78ecd37d18343c57c564f6a126f01.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:37463 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933512AbYBHG3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:37 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

It is safe for these Kconfig entries to use select because
they select ACPI_WMI, which already has its dependencies
satisfied.  This makes Kconfig more user friendly, since
the user selects the driver they want and the dependency
is met for them.  Otherwise, the user would have to find
and enable ACPI_WMI to make enabling these drivers possible.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 218c65a..e19343e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -97,9 +97,9 @@ config ACER_WMI
 	depends on X86
 	depends on EXPERIMENTAL
 	depends on ACPI
-	depends on ACPI_WMI
 	depends on LEDS_CLASS
 	depends on BACKLIGHT_CLASS_DEVICE
+	select ACPI_WMI
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
@@ -146,7 +146,7 @@ config TC1100_WMI
 	tristate "HP Compaq TC1100 Tablet WMI Extras"
 	depends on X86 && !X86_64
 	depends on ACPI
-	depends on ACPI_WMI
+	select ACPI_WMI
 	---help---
 	  This is a driver for the WMI extensions (wireless and bluetooth power
 	  control) of the HP Compaq TC1100 tablet.
-- 
1.5.4.34.g053d9

