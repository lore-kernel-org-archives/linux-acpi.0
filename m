From: akpm@linux-foundation.org
Subject: [patch 08/11] proper prototype for acpi_processor_tstate_has_changed()
Date: Mon, 09 Jun 2008 16:22:24 -0700
Message-ID: <200806092322.m59NMOkc013976@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49464 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755168AbYFIXXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:23:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bunk@kernel.org

From: Adrian Bunk <bunk@kernel.org>

This patch adds a proper prototype for acpi_processor_tstate_has_changed()
in include/acpi/processor.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_core.c |    1 -
 include/acpi/processor.h      |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/processor_core.c~proper-prototype-for-acpi_processor_tstate_has_changed drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~proper-prototype-for-acpi_processor_tstate_has_changed
+++ a/drivers/acpi/processor_core.c
@@ -86,7 +86,6 @@ static int acpi_processor_info_open_fs(s
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
-extern int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 
 
 static const struct acpi_device_id processor_device_ids[] = {
diff -puN include/acpi/processor.h~proper-prototype-for-acpi_processor_tstate_has_changed include/acpi/processor.h
--- a/include/acpi/processor.h~proper-prototype-for-acpi_processor_tstate_has_changed
+++ a/include/acpi/processor.h
@@ -319,6 +319,7 @@ static inline int acpi_processor_ppc_has
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_throttling.c */
+int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;
_
