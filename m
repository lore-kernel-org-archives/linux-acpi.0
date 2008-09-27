From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch]dock: make dock driver not a module
Date: Sat, 27 Sep 2008 11:10:28 +0800
Message-ID: <1222485028.2032.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50247 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYI0DKa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 23:10:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>

To avoid dock driver is loaded after other drivers like libata, let's
make dock driver not a module.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3919d6d..7060a64 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -157,7 +157,7 @@ config ACPI_FAN
 	  applications to perform basic fan control (on, off, status).
 
 config ACPI_DOCK
-	tristate "Dock"
+	bool "Dock"
 	depends on EXPERIMENTAL
 	help
 	  This driver adds support for ACPI controlled docking stations and removable


