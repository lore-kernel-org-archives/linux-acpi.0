From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / bus: Use acpi_handle_debug() in acpi_print_osc_error()
Date: Thu, 16 Jun 2016 17:23:09 +0200
Message-ID: <4229085.1etjX1W13n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43002 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754400AbcFPPS7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jun 2016 11:18:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_print_osc_error() basically duplicates the functionalit of
acpi_handle_debug(), so use that one in there.

While at it, convert the explicit KERN_DEBUG prints to pr_debug()
(and apply it to continuation messages too).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -174,22 +174,17 @@ void acpi_bus_detach_private_data(acpi_h
 EXPORT_SYMBOL_GPL(acpi_bus_detach_private_data);
 
 static void acpi_print_osc_error(acpi_handle handle,
-	struct acpi_osc_context *context, char *error)
+				 struct acpi_osc_context *context, char *error)
 {
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER};
 	int i;
 
-	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
-		printk(KERN_DEBUG "%s: %s\n", context->uuid_str, error);
-	else {
-		printk(KERN_DEBUG "%s (%s): %s\n",
-		       (char *)buffer.pointer, context->uuid_str, error);
-		kfree(buffer.pointer);
-	}
-	printk(KERN_DEBUG "_OSC request data:");
+	acpi_handle_debug(handle, "(%s): %s\n", context->uuid_str, error);
+
+	pr_debug("_OSC request data:");
 	for (i = 0; i < context->cap.length; i += sizeof(u32))
-		printk(" %x", *((u32 *)(context->cap.pointer + i)));
-	printk("\n");
+		pr_debug(" %x", *((u32 *)(context->cap.pointer + i)));
+
+	pr_debug("\n");
 }
 
 acpi_status acpi_str_to_uuid(char *str, u8 *uuid)

