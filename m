From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Repost: asus strict model checking
Date: Tue, 01 Aug 2006 15:15:22 +0200
Message-ID: <1154438122.4302.354.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5iW3OYKfNlsBwOovnhRt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37782 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751293AbWHANMB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2006 09:12:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>, acpi4asus-user@lists.sourceforge.net


--=-5iW3OYKfNlsBwOovnhRt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These are some minor patches I already posted...
All are patched against 2.6.18-rc2.

Do only load asus acpi module when model is listed

Description: There are machines that have a device with HID: ATK0100
(Asus) and a device with HID SNY5001 (Sony). Bad things happen if sony
and asus driver are loaded there.

Reference: https://bugzilla.novell.org/show_bug.cgi?id=166920

Signed-off-by: Timo Hoenig <thoenig@suse.de>
Signed-off-by: Thomas Renninger<mail@renninger.de>


 drivers/acpi/asus_acpi.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/asus_acpi.c
+++ linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
@@ -77,10 +77,14 @@ MODULE_LICENSE("GPL");
 
 static uid_t asus_uid;
 static gid_t asus_gid;
+static int force;
 module_param(asus_uid, uint, 0);
 MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
+module_param(force, int, 0);
+MODULE_PARM_DESC(force, "Force loading of the module even if the laptop"
+		 "model is not listed.\n");
 
 /* For each model, all features implemented, 
  * those marked with R are relative to HOTK, A for absolute */
@@ -1171,11 +1175,22 @@ static int asus_hotk_get_info(void)
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
 		} else {
-			hotk->model = M2E;
-			printk(KERN_NOTICE "  unsupported model %s, trying "
-			       "default values\n", string);
-			printk(KERN_NOTICE
-			       "  send /proc/acpi/dsdt to the developers\n");
+			if (force){
+				hotk->model = M2E;
+				printk(KERN_NOTICE "  unsupported model"
+				       "%s, trying default values\n",
+				       string);
+				printk(KERN_NOTICE
+				       "  send /proc/acpi/dsdt"
+				       " to the developers\n");
+			}
+			else{
+				printk(KERN_NOTICE "  %s unsupported model %s,"
+				       " aborting.\nForce loading with force=1"
+				       " parameter\n",
+				       ACPI_HOTK_NAME, string);
+				return -ENODEV;
+			}
 		}
 		hotk->methods = &model_conf[hotk->model];
 		return AE_OK;


--=-5iW3OYKfNlsBwOovnhRt
Content-Disposition: attachment; filename=acpi_asus_strict_model_check.patch
Content-Type: text/x-patch; name=acpi_asus_strict_model_check.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Do only load asus acpi module when model is listed

Reference: https://bugzilla.novell.org/show_bug.cgi?id=166920

Signed-off-by: Timo Hoenig <thoenig@suse.de>
Signed-off-by: Thomas Renninger<mail@renninger.de>


 drivers/acpi/asus_acpi.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/asus_acpi.c
+++ linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
@@ -77,10 +77,14 @@ MODULE_LICENSE("GPL");
 
 static uid_t asus_uid;
 static gid_t asus_gid;
+static int force;
 module_param(asus_uid, uint, 0);
 MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
+module_param(force, int, 0);
+MODULE_PARM_DESC(force, "Force loading of the module even if the laptop"
+		 "model is not listed.\n");
 
 /* For each model, all features implemented, 
  * those marked with R are relative to HOTK, A for absolute */
@@ -1171,11 +1175,22 @@ static int asus_hotk_get_info(void)
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
 		} else {
-			hotk->model = M2E;
-			printk(KERN_NOTICE "  unsupported model %s, trying "
-			       "default values\n", string);
-			printk(KERN_NOTICE
-			       "  send /proc/acpi/dsdt to the developers\n");
+			if (force){
+				hotk->model = M2E;
+				printk(KERN_NOTICE "  unsupported model"
+				       "%s, trying default values\n",
+				       string);
+				printk(KERN_NOTICE
+				       "  send /proc/acpi/dsdt"
+				       " to the developers\n");
+			}
+			else{
+				printk(KERN_NOTICE "  %s unsupported model %s,"
+				       " aborting.\nForce loading with force=1"
+				       " parameter\n",
+				       ACPI_HOTK_NAME, string);
+				return -ENODEV;
+			}
 		}
 		hotk->methods = &model_conf[hotk->model];
 		return AE_OK;

--=-5iW3OYKfNlsBwOovnhRt--

