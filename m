From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] ACPI / PM: Fix error messages in drivers/acpi/bus.c
Date: Fri, 18 May 2012 23:00:22 +0200
Message-ID: <201205182300.23142.rjw@sisk.pl>
References: <201205142253.57023.rjw@sisk.pl> <201205182258.56497.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201205182258.56497.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After recent changes of the ACPI device low-power states definitions
kernel messages in drivers/acpi/bus.c need to be updated so that they
include the correct names of the states in question (currently that
is "D3" for D3hot and "D4" for D3cold, which is incorrect).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

Index: linux/drivers/acpi/bus.c
===================================================================
--- linux.orig/drivers/acpi/bus.c
+++ linux/drivers/acpi/bus.c
@@ -182,6 +182,24 @@ EXPORT_SYMBOL(acpi_bus_get_private_data)
                                  Power Management
    -------------------------------------------------------------------------- */
 
+static char *state_string(int state)
+{
+	switch (state) {
+	case ACPI_STATE_D0:
+		return "D0";
+	case ACPI_STATE_D1:
+		return "D1";
+	case ACPI_STATE_D2:
+		return "D2";
+	case ACPI_STATE_D3_HOT:
+		return "D3hot";
+	case ACPI_STATE_D3_COLD:
+		return "D3";
+	default:
+		return "(unknown)";
+	}
+}
+
 static int __acpi_bus_get_power(struct acpi_device *device, int *state)
 {
 	int result = 0;
@@ -215,8 +233,8 @@ static int __acpi_bus_get_power(struct a
 			device->parent->power.state : ACPI_STATE_D0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is D%d\n",
-			  device->pnp.bus_id, *state));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is %s\n",
+			  device->pnp.bus_id, state_string(*state)));
 
 	return 0;
 }
@@ -234,13 +252,14 @@ static int __acpi_bus_set_power(struct a
 	/* Make sure this is a valid target state */
 
 	if (state == device->power.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
-				  state));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at %s\n",
+				  state_string(state)));
 		return 0;
 	}
 
 	if (!device->power.states[state].flags.valid) {
-		printk(KERN_WARNING PREFIX "Device does not support D%d\n", state);
+		printk(KERN_WARNING PREFIX "Device does not support %s\n",
+		       state_string(state));
 		return -ENODEV;
 	}
 	if (device->parent && (state < device->parent->power.state)) {
@@ -294,13 +313,13 @@ static int __acpi_bus_set_power(struct a
       end:
 	if (result)
 		printk(KERN_WARNING PREFIX
-			      "Device [%s] failed to transition to D%d\n",
-			      device->pnp.bus_id, state);
+			      "Device [%s] failed to transition to %s\n",
+			      device->pnp.bus_id, state_string(state));
 	else {
 		device->power.state = state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Device [%s] transitioned to D%d\n",
-				  device->pnp.bus_id, state));
+				  "Device [%s] transitioned to %s\n",
+				  device->pnp.bus_id, state_string(state)));
 	}
 
 	return result;
