From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: Implement acpi_get_device_handle copied from thinkpad_acpi.c
Date: Fri, 16 Dec 2011 01:26:46 +0100
Message-ID: <1323995207-54686-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43349 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409Ab1LPA1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Dec 2011 19:27:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, seth.forshee@canonical.com, Azael Avalos <coproscefalo@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The toshiba_acpi driver needs it and others might as well.
Removing the thinkpad_acpi.c implementation will follow in a separate
patch.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Matthew Garrett <mjg@redhat.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: seth.forshee@canonical.com
CC: Azael Avalos <coproscefalo@gmail.com>
CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/osl.c   |   25 +++++++++++++++++++++++++
 include/linux/acpi.h |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f31c5c5..4f9f7f5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1659,3 +1659,28 @@ acpi_status acpi_os_terminate(void)
 
 	return AE_OK;
 }
+
+static acpi_status acpi_handle_locate_callback(acpi_handle handle,
+			       u32 level, void *context, void **return_value)
+{
+	*(acpi_handle *)return_value = handle;
+	return AE_CTRL_TERMINATE;
+}
+
+int acpi_handle_locate(const char *hid, acpi_handle *handle)
+{
+	acpi_status status;
+
+	if (!hid || !handle)
+		return -EINVAL;
+
+	memset(handle, 0, sizeof(acpi_handle));
+	status = acpi_get_devices(hid, acpi_handle_locate_callback, NULL,
+				  handle);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;		
+}
+EXPORT_SYMBOL_GPL(acpi_handle_locate);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6001b4da..d09aca3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -146,6 +146,8 @@ struct acpi_pci_driver {
 int acpi_pci_register_driver(struct acpi_pci_driver *driver);
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
+extern int acpi_get_device_handle(const char *hid, acpi_handle *handle);
+
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
 extern int ec_transaction(u8 command,
-- 
1.7.6.1

