From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Remove obsolete comment in power.c
Date: Fri, 18 Jan 2013 13:36:44 +0100
Message-ID: <1750752.GpUDbSLOP5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The TBD comment in power.c saying that power resources must be
ordered is obsolete, because power resources acually are ordered now,
so remove it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -645,8 +645,6 @@ int acpi_power_transition(struct acpi_de
 	    || (device->power.state > ACPI_STATE_D3_COLD))
 		return -ENODEV;
 
-	/* TBD: Resources must be ordered. */
-
 	/*
 	 * First we reference all power resources required in the target list
 	 * (e.g. so the device doesn't lose power while transitioning).  Then,
