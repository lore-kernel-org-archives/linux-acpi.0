From: Joe Perches <joe@perches.com>
Subject: [PATCH] acpi: pci_slot: Use generic pr_debug utility
Date: Fri, 27 May 2016 09:13:29 -0700
Message-ID: <79c094d611a0e844263e01be80dbea3dbbbcfa20.1464365586.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Remove the dbg macro and debug module parameter and use
the generic kernel facility.

Trivially reduces defconfig object size on x86-64

$ size drivers/acpi/pci_slot.o*
   text	   data	    bss	    dec	    hex	filename
    880	    752	      4	   1636	    664	drivers/acpi/pci_slot.o.new
    935	    752	      5	   1692	    69c	drivers/acpi/pci_slot.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/acpi/pci_slot.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index aa8f4c7..1236fb0 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -35,7 +35,6 @@
 #include <linux/dmi.h>
 #include <linux/pci-acpi.h>
 
-static bool debug;
 static int check_sta_before_sun;
 
 #define DRIVER_VERSION 	"0.1"
@@ -44,18 +43,10 @@ static int check_sta_before_sun;
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(debug, bool, 0644);
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_slot");
 
-#define dbg(fmt, ...)						\
-do {								\
-	if (debug)						\
-		pr_debug(fmt, ##__VA_ARGS__);			\
-} while (0)
-
 #define SLOT_NAME_SIZE 21		/* Inspired by #define in acpiphp.h */
 
 struct acpi_pci_slot {
@@ -75,7 +66,7 @@ check_slot(acpi_handle handle, unsigned long long *sun)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	dbg("Checking slot on path: %s\n", (char *)buffer.pointer);
+	pr_debug("Checking slot on path: %s\n", (char *)buffer.pointer);
 
 	if (check_sta_before_sun) {
 		/* If SxFy doesn't have _STA, we just assume it's there */
@@ -86,14 +77,16 @@ check_slot(acpi_handle handle, unsigned long long *sun)
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	if (ACPI_FAILURE(status)) {
-		dbg("_ADR returned %d on %s\n", status, (char *)buffer.pointer);
+		pr_debug("_ADR returned %d on %s\n",
+			 status, (char *)buffer.pointer);
 		goto out;
 	}
 
 	/* No _SUN == not a slot == bail */
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, sun);
 	if (ACPI_FAILURE(status)) {
-		dbg("_SUN returned %d on %s\n", status, (char *)buffer.pointer);
+		pr_debug("_SUN returned %d on %s\n",
+			 status, (char *)buffer.pointer);
 		goto out;
 	}
 
@@ -147,8 +140,8 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	get_device(&pci_bus->dev);
 
-	dbg("%p, pci_bus: %x, device: %d, name: %s\n",
-	    pci_slot, pci_bus->number, device, name);
+	pr_debug("%p, pci_bus: %x, device: %d, name: %s\n",
+		 pci_slot, pci_bus->number, device, name);
 
 	return AE_OK;
 }
-- 
2.8.0.rc4.16.g56331f8
