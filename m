From: akpm@osdl.org
Subject: [patch 18/23] ACPI: remove __init/__exit from Asus .add()/.remove() methods
Date: Tue, 21 Mar 2006 22:30:42 -0800
Message-ID: <200603220633.k2M6Xtmj019580@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:22460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750851AbWCVGd6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:33:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Even though the devices claimed by asus_acpi.c can not be hot-plugged, the
driver registration infrastructure allows the .add() and .remove() methods to
be called at any time while the driver is registered.  So remove __init and
__exit from them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~acpi-remove-__init-__exit-from-asus-add-remove-methods drivers/acpi/asus_acpi.c
--- devel/drivers/acpi/asus_acpi.c~acpi-remove-__init-__exit-from-asus-add-remove-methods	2006-03-21 22:30:06.000000000 -0800
+++ devel-akpm/drivers/acpi/asus_acpi.c	2006-03-21 22:30:06.000000000 -0800
@@ -817,7 +817,7 @@ typedef int (proc_writefunc) (struct fil
 			      unsigned long count, void *data);
 
 static int
-__init asus_proc_add(char *name, proc_writefunc * writefunc,
+asus_proc_add(char *name, proc_writefunc * writefunc,
 		     proc_readfunc * readfunc, mode_t mode,
 		     struct acpi_device *device)
 {
@@ -836,7 +836,7 @@ __init asus_proc_add(char *name, proc_wr
 	return 0;
 }
 
-static int __init asus_hotk_add_fs(struct acpi_device *device)
+static int asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
 	mode_t mode;
@@ -954,7 +954,7 @@ static void asus_hotk_notify(acpi_handle
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
-static int __init asus_hotk_get_info(void)
+static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1101,7 +1101,7 @@ static int __init asus_hotk_get_info(voi
 	return AE_OK;
 }
 
-static int __init asus_hotk_check(void)
+static int asus_hotk_check(void)
 {
 	int result = 0;
 
@@ -1121,7 +1121,7 @@ static int __init asus_hotk_check(void)
 
 static int asus_hotk_found;
 
-static int __init asus_hotk_add(struct acpi_device *device)
+static int asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
 	int result;
_
