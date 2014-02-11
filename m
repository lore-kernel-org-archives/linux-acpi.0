From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Add "Windows 2013" string to _OSI support.
Date: Tue, 11 Feb 2014 10:25:27 +0800
Message-ID: <1392085527-5789-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65398 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbaBKCZq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Feb 2014 21:25:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <Robert.Moore@intel.com>

From: Bob Moore <Robert.Moore@intel.com>

This urgent patch is cherry picked from ACPICA upstream.
It is reported that some platforms fail to boot without this new _OSI
string.

This change adds this string for Windows 8.1 and Server 2012 R2.

Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bob Moore <Robert.Moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 utosi.c |    1 +
 1 file changed, 1 insertion(+)

diff -Nurp linux.before/drivers/acpi/acpica/utosi.c linux.after/drivers/acpi/acpica/utosi.c
--- linux.before/drivers/acpi/acpica/utosi.c	2014-02-11 10:02:49.000000000 +0800
+++ linux.after/drivers/acpi/acpica/utosi.c	2014-02-11 10:02:10.000000000 +0800
@@ -74,6 +74,7 @@ static struct acpi_interface_info acpi_d
 	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 - Added 08/2012 */
+	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server 2012 R2 - Added 01/2014 */
 
 	/* Feature Group Strings */
 
