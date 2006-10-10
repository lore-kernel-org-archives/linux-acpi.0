From: akpm@osdl.org
Subject: [patch 07/12] acpi: check if parent is on dock
Date: Tue, 10 Oct 2006 14:20:38 -0700
Message-ID: <200610102120.k9ALKcF3024284@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030540AbWJJVus (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:50:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kristen.c.accardi@intel.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Ever since I put out the docking station patches people have been asking me if
I could get removable drive bays to work as well.  These are devices such as
the IBM/Lenovo Ultrabay, or the Dell Module Bay - basically removable disk
drives.  There is an IBM platform specific solution that works with some IBM
laptops, but nothing generic.  In addition, the ibm_acpi driver had the
limitation that it would not correctly identify ultrabay devices that had been
inserted after the OS booted.  This driver implements bay handling using ACPI
to safely power off the drive.  It works similarly to the ibm_acpi driver, in
that it will simply generate an acpi event which can then be used by udev to
unmount or rescan depending on the event.  It will create a proc entry under
/proc/acpi/bay for "eject" and for "status".  Writing a 1 to the eject call
will cause the drive bays acpi eject method to be called, and should be done
prior to removing the device.  Reading the "status" entry will tell you either
"present" or "removed" depending on the state of the device.  User space
scripts can use the status entry to determine if a device has been either
inserted or removed in the case of some laptops who generate the exact same
event for either insertion or removal (i.e.  the Dell M65 for example).  Same
scripts for using these events and udev can be found on the thinkwiki website:

http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#When_using_the_ata
_piix_driver

Note that due to the lack of hotplug PATA, this driver will only work with
SATA devices, or with ata_piix driver.  Hopefully if/when hotplug PATA support
gets into libata, we can support that as well.

Note that this driver does not have the same limitations that the ibm_acpi
driver had with regard to device insertion after booting.  i.e.  - if you boot
the laptop without a drive bay inserted, and then insert the drive bay later
on, this driver will still detect the insertion and send an event to user
space.  The bay driver will also register with the dock station driver so that
if the removeable drive bay is on a dock station, an event will be sent to
userspace upon dock/undock that will allow any udev scripts specifically for
bay handling to still be executed.

The driver still needs more testing, and I still have a little bit of
funkiness to sort out with the Lenovo X60 with the SATA controller in
compatibility mode - but I think it is ready for you to experiment with if you
like and I hope that you will give it a try and send me any feedback you have.

patch 1 is just a bug fix to the dock driver that will allow devices who's
parents are listed as being on the dock to also be recognized as being on a
dock station.  patch 2 is the driver.


This patch:

When determining if a device is on a dock station, we should
check the parent of the device as well.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/dock.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/dock.c~acpi-check-if-parent-is-on-dock drivers/acpi/dock.c
--- a/drivers/acpi/dock.c~acpi-check-if-parent-is-on-dock
+++ a/drivers/acpi/dock.c
@@ -586,20 +586,28 @@ static acpi_status
 find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	acpi_handle tmp;
+	acpi_handle tmp, parent;
 	struct dock_station *ds = context;
 	struct dock_dependent_device *dd;
 
 	status = acpi_bus_get_ejd(handle, &tmp);
-	if (ACPI_FAILURE(status))
-		return AE_OK;
+	if (ACPI_FAILURE(status)) {
+		/* try the parent device as well */
+		status = acpi_get_parent(handle, &parent);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+		/* see if parent is dependent on dock */
+		status = acpi_bus_get_ejd(parent, &tmp);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+	}
 
 	if (tmp == ds->handle) {
 		dd = alloc_dock_dependent_device(handle);
 		if (dd)
 			add_dock_dependent_device(ds, dd);
 	}
-
+ fdd_out:
 	return AE_OK;
 }
 
_
