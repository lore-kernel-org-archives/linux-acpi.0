From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/19] ACPI processor: introduce module parameter
 processor.ignore_tpc
Date: Sat, 16 May 2009 02:02:13 -0400
Message-ID: <56c213fa012f2bad9eff908292ff2500f840b020.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:30755 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZEPGCf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00JYI3G2SFXC@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:31 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce module parameter processor.ignore_tpc.

Some laptops are shipped with buggy _TPC,
this module parameter is used to to disable the buggy support.

http://bugzilla.kernel.org/show_bug.cgi?id=13259

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: James Ettle <theholyettlz@googlemail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d0d1f4d..5f09fb8 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -45,6 +45,14 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
+/* ignore_tpc:
+ *  0 -> acpi processor driver doesn't ignore _TPC values
+ *  1 -> acpi processor driver ignores _TPC values
+ */
+static int ignore_tpc;
+module_param(ignore_tpc, int, 0644);
+MODULE_PARM_DESC(ignore_tpc, "Disable broken BIOS _TPC throttling support");
+
 struct throttling_tstate {
 	unsigned int cpu;		/* cpu nr */
 	int target_state;		/* target T-state */
@@ -283,6 +291,10 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 	if (!pr)
 		return -EINVAL;
+
+	if (ignore_tpc)
+		goto end;
+
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
@@ -290,6 +302,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 		}
 		return -ENODEV;
 	}
+
+end:
 	pr->throttling_platform_limit = (int)tpc;
 	return 0;
 }
@@ -302,6 +316,9 @@ int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
 	struct acpi_processor_limit *limit;
 	int target_state;
 
+	if (ignore_tpc)
+		return 0;
+
 	result = acpi_processor_get_platform_limit(pr);
 	if (result) {
 		/* Throttling Limit is unsupported */
-- 
1.6.0.6

