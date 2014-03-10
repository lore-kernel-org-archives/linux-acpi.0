From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 1/3] ACPI / battery: move definition ACPI_BATTERY_CLASS to header
Date: Mon, 10 Mar 2014 18:47:39 +0700
Message-ID: <1394452061-27777-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:55240 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbaCJLuD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 07:50:03 -0400
Received: by mail-la0-f41.google.com with SMTP id gl10so4637541lab.0
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2014 04:50:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

ACPI_BATTERY_CLASS is used in multiple places.
Create a header file for it, and replace copies with #include.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/battery.c | 3 ++-
 drivers/acpi/battery.h | 6 ++++++
 drivers/acpi/sbs.c     | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/battery.h

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 797a693..0a19c8f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -39,11 +39,12 @@
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
 
+#include "battery.h"
+
 #define PREFIX "ACPI: "
 
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
-#define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
 #define ACPI_BATTERY_NOTIFY_STATUS	0x80
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
new file mode 100644
index 0000000..785373c
--- /dev/null
+++ b/drivers/acpi/battery.h
@@ -0,0 +1,6 @@
+#ifndef __ACPI_BATTERY_H
+#define __ACPI_BATTERY_H
+
+#define ACPI_BATTERY_CLASS "battery"
+
+#endif
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index dbd4849..366ca40 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -37,12 +37,12 @@
 #include <linux/power_supply.h>
 
 #include "sbshc.h"
+#include "battery.h"
 
 #define PREFIX "ACPI: "
 
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
-#define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_SBS_FILE_INFO		"info"
 #define ACPI_SBS_FILE_STATE		"state"
-- 
1.9.0

