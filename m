From: Len Brown <len.brown@intel.com>
Subject: [PATCH 32/77] ACPICA: Update _OSI string list
Date: Sun, 22 Jul 2007 05:14:17 -0400
Message-ID: <11850957362476-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53139 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762981AbXGVJPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:38 -0400
In-Reply-To: <11850957342584-git-send-email-len.brown@intel.com>
Message-Id: <3c6394c5bd04e31d40d007af8b6c2484a08838d0.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Latest update for the Windows strings, with comments. Removed
unused strings.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/uteval.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 8ec6f8e..f112af4 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -62,16 +62,13 @@ acpi_ut_translate_one_cid(union acpi_operand_object *obj_desc,
 static char *acpi_interfaces_supported[] = {
 	/* Operating System Vendor Strings */
 
-	"Windows 2000",
-	"Windows 2001",
-	"Windows 2001 SP0",
-	"Windows 2001 SP1",
-	"Windows 2001 SP2",
-	"Windows 2001 SP3",
-	"Windows 2001 SP4",
-	"Windows 2001.1",
-	"Windows 2001.1 SP1",	/* Added 03/2006 */
-	"Windows 2006",		/* Added 03/2006 */
+	"Windows 2000",		/* Windows 2000 */
+	"Windows 2001",		/* Windows XP */
+	"Windows 2001 SP1",	/* Windows XP SP1 */
+	"Windows 2001 SP2",	/* Windows XP SP2 */
+	"Windows 2001.1",	/* Windows Server 2003 */
+	"Windows 2001.1 SP1",	/* Windows Server 2003 SP1 - Added 03/2006 */
+	"Windows 2006",		/* Windows Vista - Added 03/2006 */
 
 	/* Feature Group Strings */
 
-- 
1.5.3.rc2.22.g69a9b
