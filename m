From: Len Brown <lenb@kernel.org>
Subject: [PATCH 008/103] ACPI: add const to acpi_check_resource_conflict()
Date: Wed, 16 Dec 2009 03:35:19 -0500
Message-ID: <876fba43cc810e3c37ce26995933f9547b83cb0e.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:46620 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZLPIhT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:19 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00AXFL9RFOR2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:04 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

acpi_check_resource_conflict() doesn't change the resource
it operates on, so the res parameter can be marked const.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c   |    2 +-
 include/linux/acpi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7c1c59e..02e8464 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1118,7 +1118,7 @@ __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
 
 /* Check for resource conflicts between ACPI OperationRegions and native
  * drivers */
-int acpi_check_resource_conflict(struct resource *res)
+int acpi_check_resource_conflict(const struct resource *res)
 {
 	struct acpi_res_list *res_list_elem;
 	int ioport;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dfcd920..c920d2d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -240,7 +240,7 @@ extern int pnpacpi_disabled;
 #define PXM_INVAL	(-1)
 #define NID_INVAL	(-1)
 
-int acpi_check_resource_conflict(struct resource *res);
+int acpi_check_resource_conflict(const struct resource *res);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
-- 
1.6.0.6

