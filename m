From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: debug: Clean up acpi_aml_init()
Date: Thu, 24 Jan 2019 11:25:59 +0100
Message-ID: <2715517.7WDaClUie6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The err_exit label in acpi_aml_init() is not used any more after
commit 9ec6dbfbdc0a ("ACPI: no need to check return value of
debugfs_create functions"), but the other label in there is not
necessary too, so rearrange the code to get rid of them both.

No intentional functional impact.

Fixes: 9ec6dbfbdc0a ("ACPI: no need to check return value of debugfs_create functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_dbg.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/acpi_dbg.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_dbg.c
+++ linux-pm/drivers/acpi/acpi_dbg.c
@@ -750,29 +750,28 @@ static const struct acpi_debugger_ops ac
 
 int __init acpi_aml_init(void)
 {
-	int ret = 0;
+	int ret;
 
 	/* Initialize AML IO interface */
 	mutex_init(&acpi_aml_io.lock);
 	init_waitqueue_head(&acpi_aml_io.wait);
 	acpi_aml_io.out_crc.buf = acpi_aml_io.out_buf;
 	acpi_aml_io.in_crc.buf = acpi_aml_io.in_buf;
+
 	acpi_aml_dentry = debugfs_create_file("acpidbg",
 					      S_IFREG | S_IRUGO | S_IWUSR,
 					      acpi_debugfs_dir, NULL,
 					      &acpi_aml_operations);
-	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
-	if (ret)
-		goto err_fs;
-	acpi_aml_initialized = true;
 
-err_fs:
+	ret = acpi_register_debugger(THIS_MODULE, &acpi_aml_debugger);
 	if (ret) {
 		debugfs_remove(acpi_aml_dentry);
 		acpi_aml_dentry = NULL;
+		return ret;
 	}
-err_exit:
-	return ret;
+
+	acpi_aml_initialized = true;
+	return 0;
 }
 
 void __exit acpi_aml_exit(void)
