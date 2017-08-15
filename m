From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] ACPI/APEI: Add BERT data driver
Date: Tue, 15 Aug 2017 14:15:57 -0700
Message-ID: <20170815211556.nnnnbtlvorgc3ijh@intel.com>
References: <20170814165613.25561-1-tony.luck@intel.com>
 <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdHOVP6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 17:15:58 -0400
Content-Disposition: inline
In-Reply-To: <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 15, 2017 at 11:22:06AM +0100, Punit Agrawal wrote:
> There is already a bert driver which prints the error record. Would it
> make sense to integrate the character device there instead of creating a
> new driver?

Like this?  The source code is smaller. But it doesn't offer the option to unload
the driver and unmap the BERT data region after you have retrieved the error record.

Either looks plausible to me (but I'm hardly a disinterested party).

Votes?

-Tony

>From cbeabf2d83fe91eebd960cd5cc1b61faaeed1441 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Tue, 15 Aug 2017 13:48:28 -0700
Subject: [PATCH] ACPI: APEI: Extend BERT driver to provide a character device
 to access data

The BERT table simply provides the size and address of the error
record in BIOS reserved memory. Currently this driver decodes the
record to the console log. But other users of BERT may want to access
the full binary record.

In an earlier age we might have used /dev/mem to retrieve this error
record, but many systems disable /dev/mem for security reasons.

Extend this driver to provide read-only access to the data via a character
special device "/dev/bert-data".

Cc: Len Brown <lenb@kernel.org>
Cc: Boris Petkov <bp@suse.de>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>

v2: (suggested by Punit Agrawal) don't make a whole new driver, merge
    this functionality into the existing BERT driver.
---
 drivers/acpi/apei/bert.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 12771fcf0417..9bc39b1bffde 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -26,12 +26,16 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
 
 #include "apei-internal.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "BERT: " fmt
 
+static __iomem void *bert_data;
+static unsigned int region_len;
 static int bert_disable;
 
 static void __init bert_print_all(struct acpi_bert_region *region,
@@ -95,12 +99,45 @@ static int __init bert_check_table(struct acpi_table_bert *bert_tab)
 	return 0;
 }
 
+static int bert_chrdev_open(struct inode *inode, struct file *file)
+{
+	if (file->f_flags & (O_WRONLY | O_RDWR))
+		return -EPERM;
+	inode->i_size = region_len;
+	return 0;
+}
+
+static ssize_t bert_chrdev_read(struct file *filp, char __user *ubuf,
+				size_t usize, loff_t *off)
+{
+	if (*off > region_len)
+		return -EINVAL;
+	if (*off + usize > region_len)
+		usize = region_len - *off;
+	if (copy_to_user(ubuf, bert_data + *off, usize))
+		return -EFAULT;
+	*off += usize;
+	return usize;
+}
+
+static const struct file_operations bert_chrdev_ops = {
+	.open		= bert_chrdev_open,
+	.read		= bert_chrdev_read,
+	.llseek		= default_llseek,
+};
+
+static struct miscdevice bert_chrdev_device = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "bert-data",
+	.fops		= &bert_chrdev_ops,
+	.mode		= 0444,
+};
+
 static int __init bert_init(void)
 {
-	struct apei_resources bert_resources;
 	struct acpi_bert_region *boot_error_region;
+	struct apei_resources bert_resources;
 	struct acpi_table_bert *bert_tab;
-	unsigned int region_len;
 	acpi_status status;
 	int rc = 0;
 
@@ -139,7 +176,9 @@ static int __init bert_init(void)
 	boot_error_region = ioremap_cache(bert_tab->address, region_len);
 	if (boot_error_region) {
 		bert_print_all(boot_error_region, region_len);
-		iounmap(boot_error_region);
+		bert_data = boot_error_region;
+		if (misc_register(&bert_chrdev_device))
+			iounmap(boot_error_region);
 	} else {
 		rc = -ENOMEM;
 	}
-- 
2.11.0

