From: akpm@linux-foundation.org
Subject: [patch 7/8] thermal: add missing Kconfig dependency
Date: Fri, 18 Sep 2009 12:41:10 -0700
Message-ID: <200909181941.n8IJfAj8002565@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57290 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbZIRTmu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 15:42:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, JBeulich@novell.com, jbeulich@novell.com, mjg@redhat.com, rui.zhang@intel.com

From: "Jan Beulich" <JBeulich@novell.com>

Otherwise THERMAL_HWMON can be selected when HWMON=n and THERMAL=n, which
fails to build.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/thermal/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/thermal/Kconfig~thermal-add-missing-kconfig-dependency drivers/thermal/Kconfig
--- a/drivers/thermal/Kconfig~thermal-add-missing-kconfig-dependency
+++ a/drivers/thermal/Kconfig
@@ -15,6 +15,7 @@ menuconfig THERMAL
 
 config THERMAL_HWMON
 	bool "Hardware monitoring support"
+	depends on THERMAL
 	depends on HWMON=y || HWMON=THERMAL
 	help
 	  The generic thermal sysfs driver's hardware monitoring support
_
