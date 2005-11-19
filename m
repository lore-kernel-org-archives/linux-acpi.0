From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH/RESEND] ACPI: kernel-doc fixes for scan.c
Date: Fri, 18 Nov 2005 23:10:23 -0800
Message-ID: <20051118231023.4eaf23b7.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>

Fix kernel-doc warnings in acpi/scan.c.

Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
---

 Documentation/DocBook/kernel-api.tmpl |    1 
 drivers/acpi/scan.c                   |   27 +++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff -Naurp linux-2615-rc1-g6/Documentation/DocBook/kernel-api.tmpl~kdoc_acpi_scan linux-2615-rc1-g6/Documentation/DocBook/kernel-api.tmpl
--- linux-2615-rc1-g6/Documentation/DocBook/kernel-api.tmpl~kdoc_acpi_scan	2005-11-18 22:25:21.000000000 -0800
+++ linux-2615-rc1-g6/Documentation/DocBook/kernel-api.tmpl	2005-11-18 22:28:41.000000000 -0800
@@ -369,6 +369,7 @@ X!Edrivers/acpi/motherboard.c
 X!Edrivers/acpi/bus.c
 -->
 !Edrivers/acpi/scan.c
+!Idrivers/acpi/scan.c
 <!-- No correct structured comments
 X!Edrivers/acpi/pci_bind.c
 -->
diff -Naurp linux-2615-rc1-g6/drivers/acpi/scan.c~kdoc_acpi_scan linux-2615-rc1-g6/drivers/acpi/scan.c
--- linux-2615-rc1-g6/drivers/acpi/scan.c~kdoc_acpi_scan	2005-11-18 21:24:10.000000000 -0800
+++ linux-2615-rc1-g6/drivers/acpi/scan.c	2005-11-18 22:28:41.000000000 -0800
@@ -475,8 +475,10 @@ static LIST_HEAD(acpi_bus_drivers);
 static DECLARE_MUTEX(acpi_bus_drivers_lock);
 
 /**
- * acpi_bus_match 
- * --------------
+ * acpi_bus_match - match device IDs to driver's supported IDs
+ * @device: the device that we are trying to match to a driver
+ * @driver: driver whose device id table is being checked
+ *
  * Checks the device's hardware (_HID) or compatible (_CID) ids to see if it
  * matches the specified driver's criteria.
  */
@@ -489,8 +491,10 @@ acpi_bus_match(struct acpi_device *devic
 }
 
 /**
- * acpi_bus_driver_init 
- * --------------------
+ * acpi_bus_driver_init - add a device to a driver
+ * @device: the device to add and initialize
+ * @driver: driver for the device
+ *
  * Used to initialize a device via its device driver.  Called whenever a 
  * driver is bound to a device.  Invokes the driver's add() and start() ops.
  */
@@ -603,8 +607,9 @@ static int acpi_driver_detach(struct acp
 }
 
 /**
- * acpi_bus_register_driver 
- * ------------------------ 
+ * acpi_bus_register_driver - register a driver with the ACPI bus
+ * @driver: driver being registered
+ *
  * Registers a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and binds.  Returns the
  * number of devices that were claimed by the driver, or a negative
@@ -633,8 +638,9 @@ int acpi_bus_register_driver(struct acpi
 EXPORT_SYMBOL(acpi_bus_register_driver);
 
 /**
- * acpi_bus_unregister_driver 
- * --------------------------
+ * acpi_bus_unregister_driver - unregisters a driver with the APIC bus
+ * @driver: driver to unregister
+ *
  * Unregisters a driver with the ACPI bus.  Searches the namespace for all
  * devices that match the driver's criteria and unbinds.
  */
@@ -660,8 +666,9 @@ int acpi_bus_unregister_driver(struct ac
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
 /**
- * acpi_bus_find_driver 
- * --------------------
+ * acpi_bus_find_driver - check if there is a driver installed for the device
+ * @device: device that we are trying to find a supporting driver for
+ *
  * Parses the list of registered drivers looking for a driver applicable for
  * the specified device.
  */


---



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
