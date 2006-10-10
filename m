From: akpm@osdl.org
Subject: [patch 06/12] asus_acpi: don't printk on writing garbage to proc files
Date: Tue, 10 Oct 2006 14:20:36 -0700
Message-ID: <200610102120.k9ALKa9G024281@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030542AbWJJVup (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:50:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, adobriyan@gmail.com

From: Alexey Dobriyan <adobriyan@gmail.com>

* This reporting is useless (you get errno anyway).
* This reporting is already inconsistent in driver.
* Looks like created files in proc are rw-rw-rw- by default.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   10 +---------
 1 files changed, 1 insertion(+), 9 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-dont-printk-on-writing-garbage-to-proc-files drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-dont-printk-on-writing-garbage-to-proc-files
+++ a/drivers/acpi/asus_acpi.c
@@ -629,9 +629,7 @@ proc_write_ledd(struct file *file, const
 			       "Asus ACPI: LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
-	} else if (rv < 0)
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
-
+	}
 	return rv;
 }
 
@@ -849,10 +847,7 @@ proc_write_brn(struct file *file, const 
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 		/* 0 <= value <= 15 */
 		set_brightness(value);
-	} else if (rv < 0) {
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
-
 	return rv;
 }
 
@@ -897,9 +892,6 @@ proc_write_disp(struct file *file, const
 	rv = parse_arg(buffer, count, &value);
 	if (rv > 0)
 		set_display(value);
-	else if (rv < 0)
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
-
 	return rv;
 }
 
_
