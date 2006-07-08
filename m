From: thermal@o2.pl
Subject: [PATCH] ACPI devices _HID export through sysfs
Date: Sun, 9 Jul 2006 00:24:19 +0200
Message-ID: <200607090024.19776.thermal@o2.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TCDsEXVGvAwrtu/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.go2.pl ([193.17.41.42]:50323 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751311AbWGHWYj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Jul 2006 18:24:39 -0400
Received: from newhope.mordornet (beu167.neoplus.adsl.tpnet.pl [83.28.32.167])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 70FFB748079
	for <linux-acpi@vger.kernel.org>; Sun,  9 Jul 2006 00:24:37 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_TCDsEXVGvAwrtu/
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I recently thought about using coldplug (/etc/hotplug/*.rc) scripts to 
automagically load modules responsible for ACPI-controlled devices such 
as button, battery, laptop extras. To accomplish this I wrote a trivial 
kernel patch which exports the ACPI device _HID and _CID attributes in 
the corresponding sysfs node. I also wrote a script for /etc/hotplug 
which scans the /sys tree and loads modules according to HIDs exported.

Patch is an attachment because my mail client has a maximum line length 
limit. The patch is against 2.6.17.

-- 
|   ******* Maciek Grela RV409b *********
|        JID: thermal@jabber.wroc.pl
| Linux user #319794 ++ There is no spoon ...

--Boundary-00=_TCDsEXVGvAwrtu/
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="sysfs-acpi-hid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-acpi-hid.patch"

diff -rup --exclude-from=patch.exclude linux-2.6.17/drivers/acpi/scan.c linux-2.6.17-th/drivers/acpi/scan.c
--- linux-2.6.17/drivers/acpi/scan.c	2006-06-18 01:49:35.000000000 +0000
+++ linux-2.6.17-th/drivers/acpi/scan.c	2006-07-09 00:16:05.423442000 +0000
@@ -351,11 +351,19 @@ static int acpi_bus_get_wakeup_device_fl
 static ssize_t acpi_eject_store(struct acpi_device *device,
 				const char *buf, size_t count);
 
+static ssize_t acpi_hid_show(struct acpi_device *device,
+				char *buf);
+
+static ssize_t acpi_cid_show(struct acpi_device *device,
+				char *buf);
+
 #define ACPI_DEVICE_ATTR(_name,_mode,_show,_store) \
 static struct acpi_device_attribute acpi_device_attr_##_name = \
 		__ATTR(_name, _mode, _show, _store)
 
 ACPI_DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
+ACPI_DEVICE_ATTR(hid, 0400, acpi_hid_show, NULL);
+ACPI_DEVICE_ATTR(cid, 0400, acpi_cid_show, NULL);
 
 /**
  * setup_sys_fs_device_files - sets up the device files under device namespace
@@ -376,6 +384,15 @@ setup_sys_fs_device_files(struct acpi_de
 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
 	if (ACPI_SUCCESS(status))
 		(*(func)) (&dev->kobj, &acpi_device_attr_eject.attr);
+
+	if ( dev->pnp.cid_list ) {
+		(*(func)) (&dev->kobj, &acpi_device_attr_cid.attr);
+	}
+
+	if ( dev->pnp.hardware_id[0] != 0 ) {
+		(*(func)) (&dev->kobj, &acpi_device_attr_hid.attr);
+	}
+
 }
 
 static int acpi_eject_operation(acpi_handle handle, int lockable)
@@ -456,6 +473,29 @@ acpi_eject_store(struct acpi_device *dev
 	return ret;
 }
 
+static ssize_t acpi_hid_show(struct acpi_device *device,
+				char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",device->pnp.hardware_id);
+}
+
+static ssize_t acpi_cid_show(struct acpi_device *device,
+				char *buf)
+{
+	int ret = 0;
+	int buflen = PAGE_SIZE;
+	int i,w;
+	
+	for (i = 0; i < device->pnp.cid_list->count; i++, ret+=w, buflen-=w, buf+=w ) {
+		w = snprintf(buf, buflen, "%s ", device->pnp.cid_list->id[i].value);
+	}
+
+	ret += snprintf(buf, buflen, "\n");
+	
+	return ret;
+}
+
+
 /* --------------------------------------------------------------------------
                               Performance Management
    -------------------------------------------------------------------------- */

--Boundary-00=_TCDsEXVGvAwrtu/--
