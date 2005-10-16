From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] acpi: fix kernel-doc
Date: Sun, 16 Oct 2005 11:53:24 -0700
Message-ID: <20051016115324.6deb06d7.rdunlap@xenotime.net>
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
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>

Convert function descriptions to kernel-doc format.
Eliminate all kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
---

 Documentation/DocBook/kernel-api.tmpl |    1 
 drivers/acpi/scan.c                   |   27 +++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff -Naurp linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl~doc_acpi_kdoc linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl
--- linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl~doc_acpi_kdoc	2005-10-16 10:54:12.000000000 -0700
+++ linux-2614-rc4/Documentation/DocBook/kernel-api.tmpl	2005-10-16 10:54:44.000000000 -0700
@@ -367,6 +367,7 @@ X!Edrivers/acpi/motherboard.c
 X!Edrivers/acpi/bus.c
 -->
 !Edrivers/acpi/scan.c
+!Idrivers/acpi/scan.c
 <!-- No correct structured comments
 X!Edrivers/acpi/pci_bind.c
 -->
diff -Naurp linux-2614-rc4/drivers/acpi/scan.c~doc_acpi_kdoc linux-2614-rc4/drivers/acpi/scan.c
--- linux-2614-rc4/drivers/acpi/scan.c~doc_acpi_kdoc	2005-10-14 17:31:23.000000000 -0700
+++ linux-2614-rc4/drivers/acpi/scan.c	2005-10-16 10:41:24.000000000 -0700
@@ -476,8 +476,10 @@ static LIST_HEAD(acpi_bus_drivers);
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
@@ -490,8 +492,10 @@ acpi_bus_match(struct acpi_device *devic
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
@@ -604,8 +608,9 @@ static int acpi_driver_detach(struct acp
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
@@ -634,8 +639,9 @@ int acpi_bus_register_driver(struct acpi
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
@@ -661,8 +667,9 @@ int acpi_bus_unregister_driver(struct ac
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
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
