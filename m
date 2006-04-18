From: mochel@linux.intel.com
Subject: [PATCH 7/24] Remove unneeded debugging macros in drivers/acpi/debug.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <1145323313872-git-send-email-mochel@linux.intel.com>
References: <11453233133413-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:64184 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932112AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1POlA026781
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <11453233133413-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/debug.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

applies-to: ce1874742f9967d719f89401e5c88209764ef1cd
fc3c173fd00ce05df840fad89b2344436058e4a3
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index ec7bcee..2cd66c8 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -155,13 +155,11 @@ acpi_system_write_debug(struct file *fil
 {
 	char debug_string[12] = { '\0' };
 
-	ACPI_FUNCTION_TRACE("acpi_system_write_debug");
-
 	if (count > sizeof(debug_string) - 1)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(debug_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	debug_string[count] = '\0';
 
@@ -173,10 +171,10 @@ acpi_system_write_debug(struct file *fil
 		acpi_dbg_level = simple_strtoul(debug_string, NULL, 0);
 		break;
 	default:
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
-	return_VALUE(count);
+	return count;
 }
 
 static int __init acpi_debug_init(void)
@@ -185,10 +183,8 @@ static int __init acpi_debug_init(void)
 	int error = 0;
 	char *name;
 
-	ACPI_FUNCTION_TRACE("acpi_debug_init");
-
 	if (acpi_disabled)
-		return_VALUE(0);
+		return 0;
 
 	/* 'debug_layer' [R/W] */
 	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
@@ -213,7 +209,7 @@ static int __init acpi_debug_init(void)
 		goto Error;
 
       Done:
-	return_VALUE(error);
+	return error;
 
       Error:
 	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LEVEL, acpi_root_dir);
---
0.99.9.GIT


