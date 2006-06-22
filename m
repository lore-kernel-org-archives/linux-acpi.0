From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 16:01:25 +0900
Message-ID: <20060622160125.35f7df54.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
	<20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	<1150940220.10001.11.camel@keithlap>
	<20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	<1150942799.10001.30.camel@keithlap>
	<20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
	<1150948503.10001.60.camel@keithlap>
	<20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40879 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932287AbWFVG7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 02:59:02 -0400
In-Reply-To: <20060622142038.86ec6472.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, lhms-devel@lists.sourceforge.net, darnok@us.ibm.com, robert.moore@intel.com

On Thu, 22 Jun 2006 14:20:38 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> I'll try to write a patch.
> 

This is a patch. (against 2.6.17-mm1 but maybe okay to other kernels.)
Could you try this ?
But I'm not sure this is sane way or not..

Regards,
-Kame
=====
Index: linux-2.6.17-mm1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.17-mm1.orig/drivers/acpi/scan.c
+++ linux-2.6.17-mm1/drivers/acpi/scan.c
@@ -231,6 +231,14 @@ static int acpi_bus_get_power_flags(stru
 	return_VALUE(0);
 }
 
+static int acpi_match_hid(struct acpi_device *device, char *id)
+{
+	if (device->flags.hardware_id)
+		if (strstr(id, device->pnp.hardware_id))
+			return 0;
+	return -ENOENT;
+}
+
 int acpi_match_ids(struct acpi_device *device, char *ids)
 {
 	if (device->flags.hardware_id)
@@ -476,6 +484,14 @@ acpi_bus_match(struct acpi_device *devic
 	return acpi_match_ids(device, driver->ids);
 }
 
+static int
+acpi_bus_hid_match(struct acpi_device *device, struct acpi_driver *driver)
+{
+	if (driver && driver->ops.match)
+		return driver->ops.match(device, driver);
+	return acpi_match_hid(device, driver->ids);
+}
+
 /**
  * acpi_bus_driver_init - add a device to a driver
  * @device: the device to add and initialize
@@ -647,8 +663,24 @@ static int acpi_bus_find_driver(struct a
 	struct list_head *node, *next;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_find_driver");
-
 	spin_lock(&acpi_device_lock);
+
+	/* At first, find driver for HID */
+	list_for_each_safe(node, next, &acpi_bus_drivers) {
+		struct acpi_driver *driver =
+		    container_of(node, struct acpi_driver, node);
+
+		atomic_inc(&driver->references);
+		spin_unlock(&acpi_device_lock);
+		if (!acpi_bus_hid_match(device, driver)) {
+			result = acpi_bus_driver_init(device, driver);
+			if (!result)
+				goto Done;
+		}
+		atomic_dec(&driver->references);
+		spin_lock(&acpi_device_lock);
+	}
+	/* find driver for all IDs */
 	list_for_each_safe(node, next, &acpi_bus_drivers) {
 		struct acpi_driver *driver =
 		    container_of(node, struct acpi_driver, node);

