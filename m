From: mochel@linux.intel.com
Subject: [PATCH 9/24] Remove unneeded debugging macros in drivers/acpi/event.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233131896-git-send-email-mochel@linux.intel.com>
References: <11453233132040-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:25478 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932103AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PO6X013964
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <11453233132040-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/event.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

applies-to: 65fc0b6d7275eddc21b21841c1d3f896d5972a58
d16be8d5640de1b382b085bbd2d19678ec7619b5
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index dab09d3..ed27d8e 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -48,18 +48,16 @@ acpi_system_read_event(struct file *file
 	static int chars_remaining = 0;
 	static char *ptr;
 
-	ACPI_FUNCTION_TRACE("acpi_system_read_event");
-
 	if (!chars_remaining) {
 		memset(&event, 0, sizeof(struct acpi_bus_event));
 
 		if ((file->f_flags & O_NONBLOCK)
 		    && (list_empty(&acpi_bus_event_list)))
-			return_VALUE(-EAGAIN);
+			return -EAGAIN;
 
 		result = acpi_bus_receive_event(&event);
 		if (result)
-			return_VALUE(result);
+			return result;
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
 					  event.device_class ? event.
@@ -75,13 +73,13 @@ acpi_system_read_event(struct file *file
 	}
 
 	if (copy_to_user(buffer, ptr, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	*ppos += count;
 	chars_remaining -= count;
 	ptr += count;
 
-	return_VALUE(count);
+	return count;
 }
 
 static int acpi_system_close_event(struct inode *inode, struct file *file)
@@ -112,10 +110,8 @@ static int __init acpi_event_init(void)
 	struct proc_dir_entry *entry;
 	int error = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_event_init");
-
 	if (acpi_disabled)
-		return_VALUE(0);
+		return 0;
 
 	/* 'event' [R] */
 	entry = create_proc_entry("event", S_IRUSR, acpi_root_dir);
@@ -124,7 +120,7 @@ static int __init acpi_event_init(void)
 	else {
 		error = -ENODEV;
 	}
-	return_VALUE(error);
+	return error;
 }
 
 subsys_initcall(acpi_event_init);
---
0.99.9.GIT


