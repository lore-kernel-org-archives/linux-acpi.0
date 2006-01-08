From: akpm-3NddpPZAyC0@public.gmane.org
Subject: - git-acpi-memhotplug-build-fix.patch removed from -mm tree
Date: Sat, 07 Jan 2006 23:02:59 -0800
Message-ID: <200601080703.k0873Awg011231@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     git-acpi: memhotplug build fix

has been removed from the -mm tree.  Its filename is

     git-acpi-memhotplug-build-fix.patch

This patch was probably dropped from -mm because
it has already been merged into a subsystem tree
or into Linus's tree


From: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

drivers/acpi/acpi_memhotplug.c: In function `acpi_memory_get_device_resources':
drivers/acpi/acpi_memhotplug.c:101: error: structure has no member named `attribute'
drivers/acpi/acpi_memhotplug.c:103: error: structure has no member named `attribute'
drivers/acpi/acpi_memhotplug.c: In function `acpi_memory_disable_device':
drivers/acpi/acpi_memhotplug.c:253: warning: unused variable `attr'

Cc: <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/acpi/acpi_memhotplug.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN drivers/acpi/acpi_memhotplug.c~git-acpi-memhotplug-build-fix drivers/acpi/acpi_memhotplug.c
--- devel/drivers/acpi/acpi_memhotplug.c~git-acpi-memhotplug-build-fix	2006-01-05 22:28:02.000000000 -0800
+++ devel-akpm/drivers/acpi/acpi_memhotplug.c	2006-01-05 22:28:02.000000000 -0800
@@ -71,8 +71,8 @@ static struct acpi_driver acpi_memory_de
 struct acpi_memory_device {
 	acpi_handle handle;
 	unsigned int state;	/* State of the memory device */
-	unsigned short cache_attribute;	/* memory cache attribute */
-	unsigned short read_write_attribute;	/* memory read/write attribute */
+	unsigned short caching;	/* memory cache attribute */
+	unsigned short write_protect;	/* memory read/write attribute */
 	u64 start_addr;		/* Memory Range start physical addr */
 	u64 end_addr;		/* Memory Range end physical addr */
 };
@@ -97,10 +97,10 @@ acpi_memory_get_device_resources(struct 
 	if (ACPI_SUCCESS(status)) {
 		if (address64.resource_type == ACPI_MEMORY_RANGE) {
 			/* Populate the structure */
-			mem_device->cache_attribute =
-			    address64.attribute.memory.cache_attribute;
-			mem_device->read_write_attribute =
-			    address64.attribute.memory.read_write_attribute;
+			mem_device->caching =
+			    address64.info.mem.caching;
+			mem_device->write_protect =
+			    address64.info.mem.write_protect;
 			mem_device->start_addr = address64.minimum;
 			mem_device->end_addr = address64.maximum;
 		}
@@ -250,7 +250,6 @@ static int acpi_memory_disable_device(st
 	int result;
 	u64 start = mem_device->start_addr;
 	u64 len = mem_device->end_addr - start + 1;
-	unsigned long attr = mem_device->read_write_attribute;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
 
_

Patches currently in -mm which might be from kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

git-acpi.patch
swap-migration-v5-mpol_mf_move-interface.patch
page-owner-tracking-leak-detector-fix.patch

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
