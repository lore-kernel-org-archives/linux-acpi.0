From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] Fix potential oops in dock driver
Date: Wed, 18 Jul 2007 01:10:24 -0400
Message-ID: <200707180110.24792.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:35917 "EHLO
	asav05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbXGRFK1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 01:10:27 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

Possible needed for -stable as well.

-- 
Dmitry

ACPI: dock - fix an oops when _DCK evaluation fails

Data returned by acpi_get_name in acpi_buffer is not acpi_object and
therefore should not be cast to it, otherwise we'll get an nice oops
trying to print error message.

Also print name of the ACPI object corresponding to the docking station
and elevate severity of the message printed when _DCK fails to KERN_ERR.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/acpi/dock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c
+++ linux/drivers/acpi/dock.c
@@ -380,12 +380,11 @@ static void handle_dock(struct dock_stat
 	union acpi_object arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 
 	acpi_get_name(ds->handle, ACPI_FULL_PATHNAME, &name_buffer);
-	obj = name_buffer.pointer;
 
-	printk(KERN_INFO PREFIX "%s\n", dock ? "docking" : "undocking");
+	printk(KERN_INFO PREFIX "%s - %s\n",
+		(char *)name_buffer.pointer, dock ? "docking" : "undocking");
 
 	/* _DCK method has one argument */
 	arg_list.count = 1;
@@ -394,7 +393,8 @@ static void handle_dock(struct dock_stat
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
 	if (ACPI_FAILURE(status))
-		pr_debug("%s: failed to execute _DCK\n", obj->string.pointer);
+		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
+			 (char *)name_buffer.pointer);
 	kfree(buffer.pointer);
 	kfree(name_buffer.pointer);
 }
