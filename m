From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ACPI: remove __init/__exit from Asus and Sony .add()/.remove() methods
Date: Wed, 1 Mar 2006 13:51:21 -0700
Message-ID: <200603011351.21322.bjorn.helgaas@hp.com>
References: <20060226094206.GA9871@mars.ravnborg.org> <200603011215.59604.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932444AbWCAUv1@vger.kernel.org>
In-Reply-To: <200603011215.59604.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Karol Kozimor <sziwan@users.sourceforge.net>, Julien Lerouge <julien.lerouge@free.fr>, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

Even though the devices claimed by asus_acpi.c and sony_acpi.c can not
be hot-plugged, the driver registration infrastructure allows the .add()
and .remove() methods to be called at any time while the driver is
registered.  So remove __init and __exit from them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/asus_acpi.c
===================================================================
--- work-mm4.orig/drivers/acpi/asus_acpi.c	2006-02-22 09:55:50.000000000 -0700
+++ work-mm4/drivers/acpi/asus_acpi.c	2006-03-01 12:17:50.000000000 -0700
@@ -817,7 +817,7 @@
 			      unsigned long count, void *data);
 
 static int
-__init asus_proc_add(char *name, proc_writefunc * writefunc,
+asus_proc_add(char *name, proc_writefunc * writefunc,
 		     proc_readfunc * readfunc, mode_t mode,
 		     struct acpi_device *device)
 {
@@ -836,7 +836,7 @@
 	return 0;
 }
 
-static int __init asus_hotk_add_fs(struct acpi_device *device)
+static int asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
 	mode_t mode;
@@ -954,7 +954,7 @@
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
-static int __init asus_hotk_get_info(void)
+static int asus_hotk_get_info(void)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1101,7 +1101,7 @@
 	return AE_OK;
 }
 
-static int __init asus_hotk_check(void)
+static int asus_hotk_check(void)
 {
 	int result = 0;
 
@@ -1121,7 +1121,7 @@
 
 static int asus_hotk_found;
 
-static int __init asus_hotk_add(struct acpi_device *device)
+static int asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
 	int result;
Index: work-mm4/drivers/acpi/sony_acpi.c
===================================================================
--- work-mm4.orig/drivers/acpi/sony_acpi.c	2006-02-22 09:55:50.000000000 -0700
+++ work-mm4/drivers/acpi/sony_acpi.c	2006-03-01 12:18:24.000000000 -0700
@@ -258,7 +258,7 @@
 	return AE_OK;
 }
 
-static int __init sony_acpi_add(struct acpi_device *device)
+static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
 	int result;
@@ -340,7 +340,7 @@
 }
 
 
-static int __exit sony_acpi_remove(struct acpi_device *device, int type)
+static int sony_acpi_remove(struct acpi_device *device, int type)
 {
 	acpi_status status;
 	struct sony_acpi_value *item;
