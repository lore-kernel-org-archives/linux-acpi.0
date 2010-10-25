From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/60] ACPICA: Add Vista SP2 to supported _OSI strings
Date: Mon, 25 Oct 2010 02:20:40 -0400
Message-ID: <23ebbf07068f84b7ed119a0bef4a3f0ebb82c894.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38306 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0JYJLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:03 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added "Windows 2006 SP2" for Vista SP2.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 ++-
 drivers/acpi/acpica/utosi.c   |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 04ce322..1bb18c0 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -908,7 +908,8 @@ struct acpi_bit_register_info {
 #define ACPI_OSI_WIN_VISTA              0x07
 #define ACPI_OSI_WINSRV_2008            0x08
 #define ACPI_OSI_WIN_VISTA_SP1          0x09
-#define ACPI_OSI_WIN_7                  0x0A
+#define ACPI_OSI_WIN_VISTA_SP2          0x0A
+#define ACPI_OSI_WIN_7                  0x0B
 
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 0a37950c..18c59a8 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -71,6 +71,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2006", NULL, 0, ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
 	{"Windows 2006.1", NULL, 0, ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
 	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 
 	/* Feature Group Strings */
-- 
1.7.3.2.90.gd4c43

