From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / trivial: Remove the duplicate macro for PREFIX
Date: Thu, 13 Mar 2014 12:47:39 +0800
Message-ID: <1394686059-24392-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44019 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaCMEsZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Mar 2014 00:48:25 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so538733pbb.26
        for <linux-acpi@vger.kernel.org>; Wed, 12 Mar 2014 21:48:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

we already have a macro for PREFIX of "ACPI: " in
drivers/acpi/internal.h, so remove the duplicate ones
in ACPI drivers when internal.h is included.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_cmos_rtc.c    |    2 --
 drivers/acpi/container.c        |    2 --
 drivers/acpi/dock.c             |    2 --
 drivers/acpi/osl.c              |    2 +-
 drivers/acpi/pci_link.c         |    2 --
 drivers/acpi/pci_root.c         |    2 --
 drivers/acpi/power.c            |    2 --
 drivers/acpi/processor_core.c   |    1 -
 drivers/acpi/processor_driver.c |    2 --
 drivers/acpi/sysfs.c            |    2 --
 drivers/acpi/video.c            |    2 --
 drivers/acpi/video_detect.c     |    2 --
 12 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 84190ed..961b45d 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -18,8 +18,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 ACPI_MODULE_NAME("cmos rtc");
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index a55cccb..63119d0 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -31,8 +31,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define _COMPONENT			ACPI_CONTAINER_COMPONENT
 ACPI_MODULE_NAME("container");
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a7bd300..f0fc626 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -37,8 +37,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define ACPI_DOCK_DRIVER_DESCRIPTION "ACPI Dock Station Driver"
 
 ACPI_MODULE_NAME("dock");
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d40d6dc..f7fd72a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -52,7 +52,7 @@
 
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
-#define PREFIX		"ACPI: "
+
 struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 9418c7a..cfd7581 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -43,8 +43,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define _COMPONENT			ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_link");
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c288ff3..d388f13 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -39,8 +39,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index ad7da68..e0bcfb6 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -46,8 +46,6 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define _COMPONENT			ACPI_POWER_COMPONENT
 ACPI_MODULE_NAME("power");
 #define ACPI_POWER_CLASS		"power_resource"
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a4eea9a..57e0769 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -15,7 +15,6 @@
 
 #include "internal.h"
 
-#define PREFIX			"ACPI: "
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_core");
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index c1c3562..7f70f31 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -41,8 +41,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 91a32ce..38cb978 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -12,8 +12,6 @@
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("sysfs");
 
-#define PREFIX "ACPI: "
-
 #ifdef CONFIG_ACPI_DEBUG
 /*
  * ACPI debug sysfs I/F, including:
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index b6ba88e..48c7e8a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -45,8 +45,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 #define ACPI_VIDEO_BUS_NAME		"Video Bus"
 #define ACPI_VIDEO_DEVICE_NAME		"Video Device"
 #define ACPI_VIDEO_NOTIFY_SWITCH	0x80
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 19080c8..33e3db5 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -40,8 +40,6 @@
 
 #include "internal.h"
 
-#define PREFIX "ACPI: "
-
 ACPI_MODULE_NAME("video");
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 
-- 
1.7.9.5

