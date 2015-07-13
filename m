From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Update the copyright notice and description of power.c
Date: Tue, 14 Jul 2015 01:10:46 +0200
Message-ID: <27649054.dqKQ91UE5a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The description and copyright notice of drivers/acpi/power.c is out
of date, so update it as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -1,8 +1,10 @@
 /*
- *  acpi_power.c - ACPI Bus Power Management ($Revision: 39 $)
+ * drivers/acpi/power.c - ACPI Power Resources management.
  *
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ * Copyright (C) 2001 - 2015 Intel Corp.
+ * Author: Andy Grover <andrew.grover@intel.com>
+ * Author: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -23,10 +25,11 @@
  * ACPI power-managed devices may be controlled in two ways:
  * 1. via "Device Specific (D-State) Control"
  * 2. via "Power Resource Control".
- * This module is used to manage devices relying on Power Resource Control.
+ * The code below deals with ACPI Power Resources control.
  * 
- * An ACPI "power resource object" describes a software controllable power
- * plane, clock plane, or other resource used by a power managed device.
+ * An ACPI "power resource object" represents a software controllable power
+ * plane, clock plane, or other resource depended on by a device.
+ *
  * A device may rely on multiple power resources, and a power resource
  * may be shared by multiple devices.
  */

