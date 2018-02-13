From: Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] ACPICA: Recognize the Windows 10 RS3 OSI string
Date: Tue, 13 Feb 2018 12:00:19 -0600
Message-ID: <1518544819-1173-1-git-send-email-mario.limonciello@dell.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:12653 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965158AbeBMSAw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Feb 2018 13:00:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>

Dell uses this string to activate Thunderbolt native mode on supported
machines.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
Thunderbolt Native mode requires other patches to be applied otherwise
this patch will cause problems.

This patch should only be applied with:
1) Acpiphp platches from
   https://marc.info/?l=linux-acpi&m=151853954129169&w=2
and

2) Thunderbolt patches from
   https://lkml.org/lkml/2018/2/13/685

This has also been submited into ACPICA:
https://github.com/acpica/acpica/pull/359

 drivers/acpi/acpica/utosi.c | 1 +
 include/acpi/actypes.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index f6b8dd2..aed77c3 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -103,6 +103,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added 03/2015 */
 	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10 version 1607 - Added 12/2017 */
 	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10 version 1703 - Added 12/2017 */
+	{"Windows 2017.2", NULL, 0, ACPI_OSI_WIN_10_RS3}, /* Windows 10 version 1709 - Added 02/2018 */
 
 	/* Feature Group Strings */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 31f1be7..3f829cc 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1303,6 +1303,7 @@ typedef enum {
 #define ACPI_OSI_WIN_10                 0x0D
 #define ACPI_OSI_WIN_10_RS1             0x0E
 #define ACPI_OSI_WIN_10_RS2             0x0F
+#define ACPI_OSI_WIN_10_RS3             0x10
 
 /* Definitions of getopt */
 
-- 
2.7.4

