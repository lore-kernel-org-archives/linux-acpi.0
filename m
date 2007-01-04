From: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 05 Jan 2007 00:36:23 +0100
Message-ID: <1167953784.4901.5.camel@localhost.localdomain>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:1617 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965101AbXADXg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 18:36:26 -0500
In-Reply-To: <20070104125107.b82db604.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

Le jeudi 04 janvier 2007 =E0 12:51 -0800, Andrew Morton a =E9crit :

> The place to start (please) is the patches in -mm:
>=20
> 2.6-sony_acpi4.patch
> sony_apci-resume.patch
> sony_apci-resume-fix.patch
> acpi-add-backlight-support-to-the-sony_acpi.patch
> acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_regi=
ster-sony_acpi-fix.patch

In addition to those, I also have the attached patch in my local tree.

Stelian.

---

Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi su=
bsystem,
and made correspondent necessary changes for this to work.

Signed-off-by: Nilton Volpato <nilton.volpato@gmail.com>
---

 drivers/acpi/sony_acpi.c |   55 ++++++++++++++++++++++++--------------=
--------
 1 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index e23522a..0c9367f 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -33,7 +33,7 @@
=20
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.2"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
=20
 #define LOG_PFX			KERN_WARNING "sony_acpi: "
=20
@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
=20
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
+static struct acpi_device *sony_acpi_acpi_device =3D NULL;
=20
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
@@ -245,7 +246,9 @@ static int sony_acpi_write(struct file *
=20
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data=
)
 {
-	printk(LOG_PFX "sony_acpi_notify\n");
+	if (debug)
+		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
+	acpi_bus_generate_event(sony_acpi_acpi_device, 1, event);
 }
=20
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
@@ -269,6 +272,8 @@ static int sony_acpi_add(struct acpi_dev
 	int result;
 	struct sony_acpi_value *item;
=20
+	sony_acpi_acpi_device =3D device;
+
 	sony_acpi_handle =3D device->handle;
=20
 	acpi_driver_data(device) =3D NULL;
@@ -282,16 +287,16 @@ static int sony_acpi_add(struct acpi_dev
 			result =3D -ENODEV;
 			goto outwalk;
 		}
+	}
=20
-		status =3D acpi_install_notify_handler(sony_acpi_handle,
-						     ACPI_DEVICE_NOTIFY,
-						     sony_acpi_notify,
-						     NULL);
-		if (ACPI_FAILURE(status)) {
-			printk(LOG_PFX "unable to install notify handler\n");
-			result =3D -ENODEV;
-			goto outnotify;
-		}
+	status =3D acpi_install_notify_handler(sony_acpi_handle,
+					     ACPI_DEVICE_NOTIFY,
+					     sony_acpi_notify,
+					     NULL);
+	if (ACPI_FAILURE(status)) {
+		printk(LOG_PFX "unable to install notify handler\n");
+		result =3D -ENODEV;
+		goto outnotify;
 	}
=20
 	for (item =3D sony_acpi_values; item->name; ++item) {
@@ -310,7 +315,7 @@ static int sony_acpi_add(struct acpi_dev
 		    		 item->acpiset, &handle)))
 		    	continue;
=20
-		item->proc =3D create_proc_entry(item->name, 0600,
+		item->proc =3D create_proc_entry(item->name, 0666,
 					       acpi_device_dir(device));
 		if (!item->proc) {
 			printk(LOG_PFX "unable to create proc entry\n");
@@ -329,13 +334,11 @@ static int sony_acpi_add(struct acpi_dev
 	return 0;
=20
 outproc:
-	if (debug) {
-		status =3D acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	status =3D acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
 outnotify:
 	for (item =3D sony_acpi_values; item->name; ++item)
 		if (item->proc)
@@ -350,13 +353,13 @@ static int sony_acpi_remove(struct acpi_
 	acpi_status status;
 	struct sony_acpi_value *item;
=20
-	if (debug) {
-		status =3D acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	sony_acpi_acpi_device =3D NULL;
+
+	status =3D acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
=20
 	for (item =3D sony_acpi_values; item->name; ++item)
 		if (item->proc)

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
