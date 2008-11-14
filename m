From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/4] ACPI: processor: make new processor.h header local to
	driver
Date: Fri, 14 Nov 2008 16:02:53 -0700
Message-ID: <20081114230253.18623.45714.stgit@bob.kio>
References: <20081114230117.18623.8172.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:18445 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbYKNXCy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 18:02:54 -0500
In-Reply-To: <20081114230117.18623.8172.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

The processor-related declarations in acpi_drivers.h are used
only by the processor driver, which happens to be split across
several files.  The usual way to do this is to have a per-driver
header, so I created such a header and moved these declarations
to it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/processor.h         |    5 +++++
 drivers/acpi/processor_core.c    |    2 ++
 drivers/acpi/processor_thermal.c |    2 ++
 drivers/acpi/thermal.c           |    2 ++
 include/acpi/acpi_drivers.h      |   10 ----------
 5 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/processor.h

diff --git a/drivers/acpi/processor.h b/drivers/acpi/processor.h
new file mode 100644
index 0000000..51df8cb
--- /dev/null
+++ b/drivers/acpi/processor.h
@@ -0,0 +1,5 @@
+#define ACPI_PROCESSOR_LIMIT_NONE	0x00
+#define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
+#define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
+
+int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 3494836..e4a5956 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -59,6 +59,8 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
 
+#include "processor.h"
+
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
 #define ACPI_PROCESSOR_FILE_INFO	"info"
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b1eb376..a778ac2 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -40,6 +40,8 @@
 #include <acpi/processor.h>
 #include <acpi/acpi_drivers.h>
 
+#include "processor.h"
+
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_thermal");
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 073ff09..6baaa09 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -47,6 +47,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "processor.h"
+
 #define ACPI_THERMAL_CLASS		"thermal_zone"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_FILE_STATE		"state"
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 9ea2684..4358917 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -103,16 +103,6 @@ extern int acpi_power_nocheck;
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
 
-/* --------------------------------------------------------------------------
-                                    Processor
-   -------------------------------------------------------------------------- */
-
-#define ACPI_PROCESSOR_LIMIT_NONE	0x00
-#define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
-#define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
-
-int acpi_processor_set_thermal_limit(acpi_handle handle, int type);
-
 /*--------------------------------------------------------------------------
                                   Dock Station
   -------------------------------------------------------------------------- */

