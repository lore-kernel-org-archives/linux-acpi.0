From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 12/12] acpi: fix a if-statement in setup_sys_fs_device_files()
Date: Wed, 23 Feb 2005 01:53:12 -0800
Message-ID: <200502230953.j1N9rRAo020726@shell0.pdx.osdl.net>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This fixes a if-statement in setup_sys_fs_device_files().  It seems to
assume that 'struct acpi_device_flags.ejectable' indicates whether a device
has _EJ0 or not.  But this is not a right assumption.  It indicates whether
a device has _EJ0|_EJD (See acpi_bus_get_flags() function).

setup_sys_fs_device_files() creates 'eject' file for devices that have _EJ0
control method under a corresponding directory in
/sys/firmware/acpi/namespace/ACPI/.  'eject' file is used to trigger
hot-removal function from userland.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/scan.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/scan.c~acpi-fix-a-if-statement-in-setup_sys_fs_device_files drivers/acpi/scan.c
--- 25/drivers/acpi/scan.c~acpi-fix-a-if-statement-in-setup_sys_fs_device_files	2005-02-23 01:48:12.000000000 -0800
+++ 25-akpm/drivers/acpi/scan.c	2005-02-23 01:48:12.000000000 -0800
@@ -383,7 +383,15 @@ setup_sys_fs_device_files (
 	struct acpi_device *dev,
 	acpi_device_sysfs_files *func)
 {
-	if (dev->flags.ejectable == 1)
+	acpi_status		status;
+	acpi_handle		temp = NULL;
+
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
+	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
+	if (ACPI_SUCCESS(status))
 		(*(func))(&dev->kobj,&acpi_device_attr_eject.attr);
 }
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
