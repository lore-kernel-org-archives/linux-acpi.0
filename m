From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/48] ACPI / PM: Add functions for manipulating lists of power
 resources
Date: Wed, 12 Jan 2011 05:19:27 -0500
Message-ID: <d2ef555b57292cd818934636ac8e3414cc2a6762.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49185 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSAV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:21 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:20 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI device power resources should be reference counted during
device initialization, so that their reference counters are always
up to date.  It is convenient to do that with the help of a function
that will reference count and possibly turn on power resources in
a given list, so introduce that function, acpi_power_on_list().
For symmetry, introduce acpi_power_off_list() for performing the
reverse operation and use the both of them to simplify
acpi_power_transition().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |   67 ++++++++++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 9bd1b60..95fedbd 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -266,6 +266,35 @@ static int acpi_power_off_device(acpi_handle handle)
 	return result;
 }
 
+static void __acpi_power_off_list(struct acpi_handle_list *list, int num_res)
+{
+	int i;
+
+	for (i = num_res - 1; i >= 0 ; i--)
+		acpi_power_off_device(list->handles[i]);
+}
+
+static void acpi_power_off_list(struct acpi_handle_list *list)
+{
+	__acpi_power_off_list(list, list->count);
+}
+
+static int acpi_power_on_list(struct acpi_handle_list *list)
+{
+	int result = 0;
+	int i;
+
+	for (i = 0; i < list->count; i++) {
+		result = acpi_power_on(list->handles[i]);
+		if (result) {
+			__acpi_power_off_list(list, i);
+			break;
+		}
+	}
+
+	return result;
+}
+
 /**
  * acpi_device_sleep_wake - execute _DSW (Device Sleep Wake) or (deprecated in
  *                          ACPI 3.0) _PSW (Power State Wake)
@@ -458,10 +487,7 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 
 int acpi_power_transition(struct acpi_device *device, int state)
 {
-	int result = 0;
-	struct acpi_handle_list *cl = NULL;	/* Current Resources */
-	struct acpi_handle_list *tl = NULL;	/* Target Resources */
-	int i = 0;
+	int result;
 
 	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
 		return -EINVAL;
@@ -473,37 +499,20 @@ int acpi_power_transition(struct acpi_device *device, int state)
 	    || (device->power.state > ACPI_STATE_D3))
 		return -ENODEV;
 
-	cl = &device->power.states[device->power.state].resources;
-	tl = &device->power.states[state].resources;
-
 	/* TBD: Resources must be ordered. */
 
 	/*
 	 * First we reference all power resources required in the target list
-	 * (e.g. so the device doesn't lose power while transitioning).
+	 * (e.g. so the device doesn't lose power while transitioning).  Then,
+	 * we dereference all power resources used in the current list.
 	 */
-	for (i = 0; i < tl->count; i++) {
-		result = acpi_power_on(tl->handles[i]);
-		if (result)
-			goto end;
-	}
+	result = acpi_power_on_list(&device->power.states[state].resources);
+	if (!result)
+		acpi_power_off_list(
+			&device->power.states[device->power.state].resources);
 
-	/*
-	 * Then we dereference all power resources used in the current list.
-	 */
-	for (i = 0; i < cl->count; i++) {
-		result = acpi_power_off_device(cl->handles[i]);
-		if (result)
-			goto end;
-	}
-
-     end:
-	if (result)
-		device->power.state = ACPI_STATE_UNKNOWN;
-	else {
-	/* We shouldn't change the state till all above operations succeed */
-		device->power.state = state;
-	}
+	/* We shouldn't change the state unless the above operations succeed. */
+	device->power.state = result ? ACPI_STATE_UNKNOWN : state;
 
 	return result;
 }
-- 
1.7.4.rc1.7.g2cf08

