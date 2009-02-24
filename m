From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] eeepc-laptop: fix a build error
Date: Tue, 24 Feb 2009 09:53:23 +0800
Message-ID: <1235440403.32297.117.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44253 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZBXBxT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Feb 2009 20:53:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, corentincj@iksaif.net

Fix a build error of the eeepc-laptop driver.

http://bugzilla.kernel.org/show_bug.cgi?id=12501
http://lkml.org/lkml/2009/1/14/315

CC: Ingo Molnar <mingo@elte.hu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/platform/x86/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/platform/x86/Kconfig
===================================================================
--- linux-2.6.orig/drivers/platform/x86/Kconfig
+++ linux-2.6/drivers/platform/x86/Kconfig
@@ -301,6 +301,7 @@ config INTEL_MENLOW
 config EEEPC_LAPTOP
 	tristate "Eee PC Hotkey Driver (EXPERIMENTAL)"
 	depends on ACPI
+	depends on INPUT
 	depends on EXPERIMENTAL
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON


