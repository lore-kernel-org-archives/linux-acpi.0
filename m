From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: [PATCH] Fix container's notify handler to handle proper cases properly
Date: Mon, 07 Feb 2005 22:28:47 +0900
Message-ID: <20050207222847.5a32d68c.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Anil Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This is to fix container's ACPI notify handler to handle
proper cases properly.

  Previously, the handler tried to make a container device
be offline if an ACPI_NOTIFY_BUS/DEVICE_CHECK notification
is performed on the device was present and has its acpi_device.
But, the condition is weird.  Whenever the notification is
performed, there should be only the following two conditions:

  1. the device is present, but does not have its acpi_device.
  2. the device is not present, but has its acpi_device.

#1 is a hot-addition case, which was handled properly also
in previous handler.  #2 is a surprising hot-removal case,
which was not handled in previous handler.

Hope it makes sense,
Keiichiro Tokunaga


Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
---

 linux-2.6.11-rc3-kei/drivers/acpi/container.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/container.c~container_bug_fix drivers/acpi/container.c
--- linux-2.6.11-rc3/drivers/acpi/container.c~container_bug_fix	2005-02-07 22:15:44.000000000 +0900
+++ linux-2.6.11-rc3-kei/drivers/acpi/container.c	2005-02-07 22:15:44.000000000 +0900
@@ -177,13 +177,18 @@ container_notify_cb(acpi_handle handle, 
 		printk("Container driver received %s event\n",
 			(type == ACPI_NOTIFY_BUS_CHECK)?
 			"ACPI_NOTIFY_BUS_CHECK":"ACPI_NOTIFY_DEVICE_CHECK");
+		status = acpi_bus_get_device(handle, &device);
 		if (present) {
-			status = acpi_bus_get_device(handle, &device);
 			if (ACPI_FAILURE(status) || !device) {
 				result = container_device_add(&device, handle);
 				if (!result)
-					kobject_hotplug(&device->kobj, KOBJ_ONLINE);
-			} else {
+					kobject_hotplug(&device->kobj,
+							KOBJ_ONLINE);
+				else
+					printk("Failed to add container\n");
+			}
+		} else {
+			if (ACPI_SUCCESS(status)) {
 				/* device exist and this is a remove request */
 				kobject_hotplug(&device->kobj, KOBJ_OFFLINE);
 			}

_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
