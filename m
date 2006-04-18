From: mochel@linux.intel.com
Subject: [PATCH 23/24] Remove unneeded debugging macros in drivers/acpi/system.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233151188-git-send-email-mochel@linux.intel.com>
References: <11453233151522-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:46237 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932134AbWDRBZ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:27 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQer030541
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233151522-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/system.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

applies-to: f8fdada61595438918dc97c6bf561166cea7c47e
31a4eaa3ee9730e2af763e09d6c90bc13abfb70c
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index bcbfcb1..f705386 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -47,10 +47,8 @@ extern FADT_DESCRIPTOR acpi_fadt;
 
 static int acpi_system_read_info(struct seq_file *seq, void *offset)
 {
-	ACPI_FUNCTION_TRACE("acpi_system_read_info");
-
 	seq_printf(seq, "version:                 %x\n", ACPI_CA_VERSION);
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_system_info_open_fs(struct inode *inode, struct file *file)
@@ -80,17 +78,15 @@ acpi_system_read_dsdt(struct file *file,
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	ssize_t res;
 
-	ACPI_FUNCTION_TRACE("acpi_system_read_dsdt");
-
 	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	res = simple_read_from_buffer(buffer, count, ppos,
 				      dsdt.pointer, dsdt.length);
 	acpi_os_free(dsdt.pointer);
 
-	return_VALUE(res);
+	return res;
 }
 
 static ssize_t acpi_system_read_fadt(struct file *, char __user *, size_t,
@@ -108,17 +104,15 @@ acpi_system_read_fadt(struct file *file,
 	struct acpi_buffer fadt = { ACPI_ALLOCATE_BUFFER, NULL };
 	ssize_t res;
 
-	ACPI_FUNCTION_TRACE("acpi_system_read_fadt");
-
 	status = acpi_get_table(ACPI_TABLE_FADT, 1, &fadt);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	res = simple_read_from_buffer(buffer, count, ppos,
 				      fadt.pointer, fadt.length);
 	acpi_os_free(fadt.pointer);
 
-	return_VALUE(res);
+	return res;
 }
 
 static int __init acpi_system_init(void)
@@ -127,10 +121,8 @@ static int __init acpi_system_init(void)
 	int error = 0;
 	char *name;
 
-	ACPI_FUNCTION_TRACE("acpi_system_init");
-
 	if (acpi_disabled)
-		return_VALUE(0);
+		return 0;
 
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
@@ -158,7 +150,7 @@ static int __init acpi_system_init(void)
 		goto Error;
 
       Done:
-	return_VALUE(error);
+	return error;
 
       Error:
 	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
---
0.99.9.GIT


