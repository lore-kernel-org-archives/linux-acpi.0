From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/60] ACPICA: Change type of _TZ from ThermalZone to Device
Date: Mon, 25 Oct 2010 02:20:38 -0400
Message-ID: <81256669aaaa8b06a617f8d0613cb7fb24f8b910.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38306 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0JYJLC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:02 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:01 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The type of ThermalZone was confusing hosts as they process the
various ThermalZone objects. ACPICA BZ 876.

http://www.acpica.org/bugzilla/show_bug.cgi?id=876

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utglobal.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 45f6334..4a5dcaa 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -154,14 +154,16 @@ ACPI_EXPORT_SYMBOL(acpi_format_exception)
  * 1) _SB_ is defined to be a device to allow \_SB_._INI to be run
  *    during the initialization sequence.
  * 2) _TZ_ is defined to be a thermal zone in order to allow ASL code to
- *    perform a Notify() operation on it.
+ *    perform a Notify() operation on it. 09/2010: Changed to type Device.
+ *    This still allows notifies, but does not confuse host code that
+ *    searches for valid thermal_zone objects.
  */
 const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
 	{"_GPE", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_PR_", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_SB_", ACPI_TYPE_DEVICE, NULL},
 	{"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
-	{"_TZ_", ACPI_TYPE_THERMAL, NULL},
+	{"_TZ_", ACPI_TYPE_DEVICE, NULL},
 	{"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
 	{"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
 	{"_GL_", ACPI_TYPE_MUTEX, (char *)1},
-- 
1.7.3.2.90.gd4c43

