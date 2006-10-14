From: Len Brown <len.brown@intel.com>
Subject: [PATCH 26/28] ACPI: asus_acpi: don't printk on writing garbage to proc files
Date: Sat, 14 Oct 2006 04:06:07 -0400
Message-ID: <11608132023186-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15632 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752130AbWJNIDW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:22 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <6df05702f97f99e038ab817f4466386f6255f58d.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 10 Oct 2006 14:20:36 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Alexey Dobriyan <adobriyan@gmail.com>

This reporting is useless (we errno anyway).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 33eaca1..c7ac929 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
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
 
-- 
1.4.3.rc2.g23bed-dirty
