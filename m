From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] proper prototype for
	acpi_processor_tstate_has_changed()
Date: Sat, 1 Mar 2008 18:19:13 +0200
Message-ID: <20080301161913.GP25835@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:57173 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127AbYCAQUi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Mar 2008 11:20:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds a proper prototype for acpi_processor_tstate_has_changed()
in include/acpi/processor.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/acpi/processor_core.c |    1 -
 include/acpi/processor.h      |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

fcdb74ac24c943bc290e85e2d757f82dbb065955 foobar
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a3cc8a9..d88f21e 100644
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

