From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/23] proper prototype for acpi_processor_tstate_has_changed()
Date: Wed, 11 Jun 2008 03:59:16 -0400
Message-ID: <0d5a29f8eb48af371fe2a7427a7431d73a90be11.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53014 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbYFKH7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:35 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A003KOGV98T12@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:34 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

This patch adds a proper prototype for acpi_processor_tstate_has_changed()
in include/acpi/processor.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    1 -
 include/acpi/processor.h      |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 386e5aa..9dd0fa9 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -86,7 +86,6 @@ static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
-extern int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 
 
 static const struct acpi_device_id processor_device_ids[] = {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 06480bc..06ebb6e 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -319,6 +319,7 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_throttling.c */
+int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;
-- 
1.5.6.rc2.23.gea81e

