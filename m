From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPI: Remove useless initializers
Date: Mon, 03 Jun 2013 12:20:24 -0600
Message-ID: <20130603182024.16039.34089.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43437 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544Ab3FCSU1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2013 14:20:27 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so11351161iea.37
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jun 2013 11:20:26 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These local variables are all initialized at their first use, so there's
no point in initializing them earlier.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/bus.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 292de3c..a5bb33b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -91,8 +91,7 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 
 int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
 {
-	acpi_status status = AE_OK;
-
+	acpi_status status;
 
 	if (!device)
 		return -EINVAL;
@@ -162,7 +161,7 @@ EXPORT_SYMBOL(acpi_bus_private_data_handler);
 
 int acpi_bus_get_private_data(acpi_handle handle, void **data)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 
 	if (!*data)
 		return -EINVAL;
@@ -361,7 +360,7 @@ extern int event_is_open;
 int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id, u8 type, int data)
 {
 	struct acpi_bus_event *event;
-	unsigned long flags = 0;
+	unsigned long flags;
 
 	/* drop event on the floor if no one's listening */
 	if (!event_is_open)
@@ -400,7 +399,7 @@ EXPORT_SYMBOL(acpi_bus_generate_proc_event);
 
 int acpi_bus_receive_event(struct acpi_bus_event *event)
 {
-	unsigned long flags = 0;
+	unsigned long flags;
 	struct acpi_bus_event *entry = NULL;
 
 	DECLARE_WAITQUEUE(wait, current);
@@ -593,7 +592,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 
 static int __init acpi_bus_init_irq(void)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 	union acpi_object arg = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list arg_list = { 1, &arg };
 	char *message = NULL;
@@ -640,7 +639,7 @@ u8 acpi_gbl_permanent_mmap;
 
 void __init acpi_early_init(void)
 {
-	acpi_status status = AE_OK;
+	acpi_status status;
 
 	if (acpi_disabled)
 		return;
@@ -714,8 +713,8 @@ void __init acpi_early_init(void)
 
 static int __init acpi_bus_init(void)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
+	int result;
+	acpi_status status;
 	extern acpi_status acpi_os_initialize1(void);
 
 	acpi_os_initialize1();

