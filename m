From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/98] ACPI: move private declarations to internal.h
Date: Sat, 28 Mar 2009 00:30:48 -0400
Message-ID: <e60cc7a6f02598fc23c68a656fe9c263d6531ca0.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbZC1Ecm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7003KF8M5TYBH@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:30 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

A number of things that shouldn't be exposed outside the ACPI core
were declared in include/acpi/acpi_drivers.h, where anybody can
see them.  This patch moves those declarations to a new "internal.h"
inside drivers/acpi.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c          |    2 ++
 drivers/acpi/internal.h     |   24 ++++++++++++++++++++++++
 drivers/acpi/scan.c         |    2 ++
 drivers/acpi/sleep.c        |    2 ++
 drivers/acpi/wakeup.c       |    2 ++
 include/acpi/acpi_drivers.h |   23 -----------------------
 6 files changed, 32 insertions(+), 23 deletions(-)
 create mode 100644 drivers/acpi/internal.h

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 765fd1c..2e90410 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -39,6 +39,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "internal.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("bus");
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
new file mode 100644
index 0000000..4aee4a2
--- /dev/null
+++ b/drivers/acpi/internal.h
@@ -0,0 +1,24 @@
+/* For use by Linux/ACPI infrastructure, not drivers */
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
index c54d7b6..2f04cd1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,8 @@
 
 #include <acpi/acpi_drivers.h>
 
+#include "internal.h"
+
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("scan");
 #define STRUCT_TO_INT(s)	(*((int*)&s))
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..0f86cf7 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -21,6 +21,8 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+
+#include "internal.h"
 #include "sleep.h"
 
 u8 sleep_states[ACPI_S_STATE_COUNT];
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 2d34806..3f29fd5 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -8,6 +8,8 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+
+#include "internal.h"
 #include "sleep.h"
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5fc1bb0..241d227 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -99,24 +99,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
 				   int bus);
 
 /* --------------------------------------------------------------------------
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
-/* --------------------------------------------------------------------------
                                     Processor
    -------------------------------------------------------------------------- */
 
@@ -165,9 +147,4 @@ static inline void unregister_hotplug_dock_device(acpi_handle handle)
 }
 #endif
 
-/*--------------------------------------------------------------------------
-                                  Suspend/Resume
-  -------------------------------------------------------------------------- */
-extern int acpi_sleep_init(void);
-
 #endif /*__ACPI_DRIVERS_H__*/
-- 
1.6.0.6

