From: jbarnes-sJ/iWh9BUns@public.gmane.org
Subject: [PATCH] don't use alloc_bootmem in ACPI table initialization
Date: Mon, 8 Sep 2003 11:47:40 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030908184740.GA758@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Already talked with Andy about this one, is it ok to push to Linus?

Thanks,
Jesse


diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Wed Jul 30 11:45:27 2003
+++ b/drivers/acpi/tables.c	Wed Jul 30 11:45:27 2003
@@ -69,7 +69,8 @@
 
 static unsigned long		sdt_pa;		/* Physical Address */
 static unsigned long		sdt_count;	/* Table count */
-static struct acpi_table_sdt	*sdt_entry;
+
+static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
 
 void
 acpi_table_print (
@@ -413,12 +414,6 @@
 			sdt_count = ACPI_MAX_TABLES;
 		}
 
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
-		}
-
 		for (i = 0; i < sdt_count; i++)
 			sdt_entry[i].pa = (unsigned long) mapped_xsdt->entry[i];
 	}
@@ -463,12 +458,6 @@
 			printk(KERN_WARNING PREFIX "Truncated %lu RSDT entries\n",
 				(sdt_count - ACPI_MAX_TABLES));
 			sdt_count = ACPI_MAX_TABLES;
-		}
-
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
 		}
 
 		for (i = 0; i < sdt_count; i++)
