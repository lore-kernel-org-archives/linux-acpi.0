From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/3] ACPI: move internal core declarations to private header
Date: Thu, 19 Feb 2009 12:51:53 -0700
Message-ID: <20090219195153.20619.89309.stgit@bob.kio>
References: <20090219195009.20619.20334.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:12539 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZBSTvz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 14:51:55 -0500
In-Reply-To: <20090219195009.20619.20334.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

A number of things that shouldn't be exposed outside the ACPI core
were declared in include/acpi/acpi_drivers.h, where anybody can
see them.  This patch moves those declarations to a new "ospm.h"
inside drivers/acpi.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/bus.c          |    2 ++
 drivers/acpi/ospm.h         |   23 +++++++++++++++++++++++
 drivers/acpi/scan.c         |    2 ++
 drivers/acpi/sleep.c        |    1 +
 drivers/acpi/wakeup.c       |    1 +
 include/acpi/acpi_drivers.h |   23 -----------------------
 6 files changed, 29 insertions(+), 23 deletions(-)
 create mode 100644 drivers/acpi/ospm.h

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 765fd1c..0286607 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -39,6 +39,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "ospm.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("bus");
 
diff --git a/drivers/acpi/ospm.h b/drivers/acpi/ospm.h
new file mode 100644
index 0000000..8e54c90
--- /dev/null
+++ b/drivers/acpi/ospm.h
@@ -0,0 +1,23 @@
+
+/* --------------------------------------------------------------------------
+                                  Power Resource
+   -------------------------------------------------------------------------- */
+
+int acpi_device_sleep_wake(struct acpi_device *dev,
+                           int enable, int sleep_state, int dev_state);
+int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
+int acpi_disable_wakeup_device_power(struct acpi_device *dev);
+int acpi_power_get_inferred_state(struct acpi_device *device);
+int acpi_power_transition(struct acpi_device *device, int state);
+extern int acpi_power_nocheck;
+
+/* --------------------------------------------------------------------------
+                                  Embedded Controller
+   -------------------------------------------------------------------------- */
+int acpi_ec_ecdt_probe(void);
+int acpi_boot_ec_enable(void);
+
+/*--------------------------------------------------------------------------
+                                  Suspend/Resume
+  -------------------------------------------------------------------------- */
+extern int acpi_sleep_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c54d7b6..2e00298 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,8 @@
 
 #include <acpi/acpi_drivers.h>
 
+#include "ospm.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("scan");
 #define STRUCT_TO_INT(s)	(*((int*)&s))
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..e841938 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -21,6 +21,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include "ospm.h"
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 2d34806..58c1f91 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -8,6 +8,7 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include "ospm.h"
 #include "sleep.h"
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 4358917..f237ec2 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -85,24 +85,6 @@ acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
 struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
 				   int bus);
 
-/* --------------------------------------------------------------------------
-                                  Power Resource
-   -------------------------------------------------------------------------- */
-
-int acpi_device_sleep_wake(struct acpi_device *dev,
-                           int enable, int sleep_state, int dev_state);
-int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
-int acpi_disable_wakeup_device_power(struct acpi_device *dev);
-int acpi_power_get_inferred_state(struct acpi_device *device);
-int acpi_power_transition(struct acpi_device *device, int state);
-extern int acpi_power_nocheck;
-
-/* --------------------------------------------------------------------------
-                                  Embedded Controller
-   -------------------------------------------------------------------------- */
-int acpi_ec_ecdt_probe(void);
-int acpi_boot_ec_enable(void);
-
 /*--------------------------------------------------------------------------
                                   Dock Station
   -------------------------------------------------------------------------- */
@@ -142,9 +124,4 @@ static inline void unregister_hotplug_dock_device(acpi_handle handle)
 }
 #endif
 
-/*--------------------------------------------------------------------------
-                                  Suspend/Resume
-  -------------------------------------------------------------------------- */
-extern int acpi_sleep_init(void);
-
 #endif /*__ACPI_DRIVERS_H__*/

