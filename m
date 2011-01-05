From: yakui.zhao@intel.com
Subject: [Patch 1/3] Pmtools: Complain the table name of dynamic SSDT table with wrong checksum
Date: Wed,  5 Jan 2011 09:35:31 +0800
Message-ID: <1294191333-7381-2-git-send-email-yakui.zhao@intel.com>
References: <1294191333-7381-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32664 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab1AEBej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jan 2011 20:34:39 -0500
In-Reply-To: <1294191333-7381-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The input parameter of acpi_dump_dynmaic_SSDT is also renamed.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 acpidump/acpidump.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: pmtools/acpidump/acpidump.c
===================================================================
--- pmtools.orig/acpidump/acpidump.c
+++ pmtools/acpidump/acpidump.c
@@ -315,7 +315,7 @@ static int acpi_dump_SDT(int fd, struct 
 
 #define DYNAMIC_SSDT	"/sys/firmware/acpi/tables/dynamic"
 
-static void acpi_dump_dynamic_SSDT(int fd)
+static void acpi_dump_dynamic_SSDT(int out_fd)
 {
 	struct stat file_stat;
 	char filename[256], *ptr;
@@ -366,8 +366,8 @@ static void acpi_dump_dynamic_SSDT(int f
 		ptable = (struct acpi_table_header *) ptr;
 		if (checksum((u8 *) ptable, ptable->length))
 			fprintf(stderr, "Wrong checksum "
-					"for dynamic SSDT table!\n");
-		write_table(fd, ptable, 0);
+				"for dynamic SSDT table of %s!\n", filename);
+		write_table(out_fd, ptable, 0);
 		free(ptr);
 	}
 	closedir(tabledir);
