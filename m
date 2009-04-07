From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 7/7] ACPI: WMI: use .notify method instead of installing
	handler directly
Date: Tue, 07 Apr 2009 09:37:37 -0600
Message-ID: <20090407153737.21399.57171.stgit@bob.kio>
References: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:39636 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739AbZDGPhi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:38 -0400
In-Reply-To: <20090407153532.21399.92051.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Mattia Dongili <malattia@linux.it>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Harald Welte <laforge@gnumonks.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 drivers/platform/x86/wmi.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2f269e1..043b208 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -81,6 +81,7 @@ static struct wmi_block wmi_blocks;
 
 static int acpi_wmi_remove(struct acpi_device *device, int type);
 static int acpi_wmi_add(struct acpi_device *device);
+static void acpi_wmi_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -96,6 +97,7 @@ static struct acpi_driver acpi_wmi_driver = {
 	.ops = {
 		.add = acpi_wmi_add,
 		.remove = acpi_wmi_remove,
+		.notify = acpi_wmi_notify,
 		},
 };
 
@@ -643,12 +645,11 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 	}
 }
 
-static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 {
 	struct guid_block *block;
 	struct wmi_block *wblock;
 	struct list_head *p;
-	struct acpi_device *device = data;
 
 	list_for_each(p, &wmi_blocks.list) {
 		wblock = list_entry(p, struct wmi_block, list);
@@ -669,9 +670,6 @@ static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_wmi_remove(struct acpi_device *device, int type)
 {
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-		acpi_wmi_notify);
-
 	acpi_remove_address_space_handler(device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 
@@ -683,13 +681,6 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 	acpi_status status;
 	int result = 0;
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-		acpi_wmi_notify, device);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
-		return -ENODEV;
-	}
-
 	status = acpi_install_address_space_handler(device->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_wmi_ec_space_handler,

