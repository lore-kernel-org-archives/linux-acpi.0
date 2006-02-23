From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/3] acpi: export acpi_bus_trim
Date: Thu, 23 Feb 2006 11:56:14 -0800
Message-ID: <1140724574.11750.16.camel@whizzy>
References: <20060223195022.747891000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:11485 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751771AbWBWTvD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2006 14:51:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Export the acpi_bus_trim function so that the pci hotplug driver can 
use it.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/acpi/scan.c     |    5 +++--
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-dock-mm.orig/drivers/acpi/scan.c
+++ linux-dock-mm/drivers/acpi/scan.c
@@ -24,7 +24,6 @@ static LIST_HEAD(acpi_device_list);
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
-static int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 
 static void acpi_device_release(struct kobject *kobj)
 {
@@ -1268,7 +1267,7 @@ int acpi_bus_start(struct acpi_device *d
 
 EXPORT_SYMBOL(acpi_bus_start);
 
-static int acpi_bus_trim(struct acpi_device *start, int rmdevice)
+int acpi_bus_trim(struct acpi_device *start, int rmdevice)
 {
 	acpi_status status;
 	struct acpi_device *parent, *child;
@@ -1321,6 +1320,8 @@ static int acpi_bus_trim(struct acpi_dev
 	}
 	return err;
 }
+EXPORT_SYMBOL_GPL(acpi_bus_trim);
+
 
 static int acpi_bus_scan_fixed(struct acpi_device *root)
 {
--- linux-dock-mm.orig/include/acpi/acpi_bus.h
+++ linux-dock-mm/include/acpi/acpi_bus.h
@@ -330,6 +330,7 @@ int acpi_bus_register_driver(struct acpi
 int acpi_bus_unregister_driver(struct acpi_driver *driver);
 int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
 		 acpi_handle handle, int type);
+int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_start(struct acpi_device *device);
 
 int acpi_match_ids(struct acpi_device *device, char *ids);

--
