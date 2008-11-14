From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/4] ACPI: move internal core declaration to private header
Date: Fri, 14 Nov 2008 16:02:58 -0700
Message-ID: <20081114230258.18623.2978.stgit@bob.kio>
References: <20081114230117.18623.8172.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:26538 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbYKNXC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 18:02:59 -0500
In-Reply-To: <20081114230117.18623.8172.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

A number of things that shouldn't be exposed outside the ACPI core
were declared in include/acpi/acpi_drivers.h, where anybody can
see them.  This patch moves those declarations to a new "acpi_core.h"
inside drivers/acpi.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/acpi_core.h    |   22 ++++++++++++++++++++++
 drivers/acpi/bus.c          |    2 ++
 drivers/acpi/scan.c         |    2 ++
 drivers/acpi/sleep/main.c   |    1 +
 drivers/acpi/sleep/wakeup.c |    1 +
 include/acpi/acpi_drivers.h |   23 -----------------------
 6 files changed, 28 insertions(+), 23 deletions(-)
 create mode 100644 drivers/acpi/acpi_core.h

diff --git a/drivers/acpi/acpi_core.h b/drivers/acpi/acpi_core.h
new file mode 100644
index 0000000..1f98674
--- /dev/null
+++ b/drivers/acpi/acpi_core.h
@@ -0,0 +1,22 @@
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
+int acpi_sleep_init(void);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 765fd1c..bd2d60f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -39,6 +39,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "acpi_core.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("bus");
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd5253e..0193e9c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -12,6 +12,8 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
 
+#include "acpi_core.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("scan");
 #define STRUCT_TO_INT(s)	(*((int*)&s))
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 80c0868..58e1949 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -21,6 +21,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include "../acpi_core.h"
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
index dea4c23..2debac5 100644
--- a/drivers/acpi/sleep/wakeup.c
+++ b/drivers/acpi/sleep/wakeup.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <acpi/acevents.h>
+#include "../acpi_core.h"
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

