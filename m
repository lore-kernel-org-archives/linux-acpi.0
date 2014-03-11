From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH v2 1/3] ACPI / battery: move some ACPI_BATTERY_* definitions to header
Date: Wed, 12 Mar 2014 00:58:46 +0700
Message-ID: <1394560728-14048-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:65482 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaCKSBj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2014 14:01:39 -0400
Received: by mail-lb0-f178.google.com with SMTP id s7so5990930lbd.9
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2014 11:01:38 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

ACPI_BATTERY_CLASS is used in multiple places.
Also, I'll use ACPI_BATTERY_NOTIFY_STATUS inside AC driver in
one of following patches.

So, create a header file and move ACPI_BATTERY_CLASS and
ACPI_BATTERY_NOTIFY_* definitions into it.
Also, remove copy of ACPI_BATTERY_CLASS from sbs.c

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 v2: move ACPI_BATTERY_NOTIFY_* to header too

 drivers/acpi/battery.c |  6 ++----
 drivers/acpi/battery.h | 10 ++++++++++
 drivers/acpi/sbs.c     |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 drivers/acpi/battery.h

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 797a693..bfec70f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -39,15 +39,13 @@
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
 
+#include "battery.h"
+
 #define PREFIX "ACPI: "
 
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
 
-#define ACPI_BATTERY_CLASS		"battery"
 #define ACPI_BATTERY_DEVICE_NAME	"Battery"
-#define ACPI_BATTERY_NOTIFY_STATUS	0x80
-#define ACPI_BATTERY_NOTIFY_INFO	0x81
-#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
 
 /* Battery power unit: 0 means mW, 1 means mA */
 #define ACPI_BATTERY_POWER_UNIT_MA	1
diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
new file mode 100644
index 0000000..6c08497
--- /dev/null
+++ b/drivers/acpi/battery.h
@@ -0,0 +1,10 @@
+#ifndef __ACPI_BATTERY_H
+#define __ACPI_BATTERY_H
+
+#define ACPI_BATTERY_CLASS "battery"
+
+#define ACPI_BATTERY_NOTIFY_STATUS	0x80
+#define ACPI_BATTERY_NOTIFY_INFO	0x81
+#define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82
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

