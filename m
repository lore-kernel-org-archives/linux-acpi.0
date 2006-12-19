From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 3/22] Remove deprecated parameters
Date: Tue, 19 Dec 2006 22:18:55 +0100
Message-ID: <200612192218.55855.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50175 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933013AbWLSVZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:25:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Remove the deprecated asus_uid and asus_gid parameters.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus_acpi.c |   29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

--- a/drivers/acpi/asus_acpi.c  2006-12-15 10:36:09.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c  2006-12-15 10:37:36.000000000 +0100
@@ -76,13 +76,6 @@
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
 MODULE_LICENSE("GPL");

-static uid_t asus_uid;
-static gid_t asus_gid;
-module_param(asus_uid, uint, 0);
-MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
-module_param(asus_gid, uint, 0);
-MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
-
 /* For each model, all features implemented,
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
@@ -916,8 +909,8 @@
        proc->read_proc = readfunc;
        proc->data = acpi_driver_data(device);
        proc->owner = THIS_MODULE;
-       proc->uid = asus_uid;
-       proc->gid = asus_gid;
+       proc->uid = 0;
+       proc->gid = 0;
        return 0;
 }

@@ -926,19 +919,7 @@
        struct proc_dir_entry *proc;
        mode_t mode;

-       /*
-        * If parameter uid or gid is not changed, keep the default setting 
for
-        * our proc entries (-rw-rw-rw-) else, it means we care about 
security,
-        * and then set to -rw-rw----
-        */
-
-       if ((asus_uid == 0) && (asus_gid == 0)) {
-               mode = S_IFREG | S_IRUGO | S_IWUGO;
-       } else {
-               mode = S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP;
-               printk(KERN_WARNING "  asus_uid and asus_gid parameters are "
-                      "deprecated, use chown and chmod instead!\n");
-       }
+       mode = S_IFREG | S_IRUGO | S_IWUGO;

        acpi_device_dir(device) = asus_proc_dir;
        if (!acpi_device_dir(device))
@@ -949,8 +930,8 @@
                proc->read_proc = proc_read_info;
                proc->data = acpi_driver_data(device);
                proc->owner = THIS_MODULE;
-               proc->uid = asus_uid;
-               proc->gid = asus_gid;
+               proc->uid = 0;
+               proc->gid = 0;
        } else {
                printk(KERN_WARNING "  Unable to create " PROC_INFO
                       " fs entry\n");


-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

