From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 19/19] ACPI: handle re-enumeration,
	when acpi_devices might already exist
Date: Fri, 31 Jul 2009 15:38:10 -0600
Message-ID: <20090731213810.29930.29434.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:2434 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZGaViy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:38:54 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

acpi_bus_scan() traverses the namespace to enumerate devices and uses
acpi_add_single_object() to create acpi_devices.  When the platform
notifies us of a hot-plug event, we need to traverse part of the namespace
again to figure out what appeared or disappeared.  (We don't yet call
acpi_bus_scan() during hot-plug, but I plan to do that in the future.)

This patch makes acpi_add_single_object() notice when we already have
an acpi_device, so we don't need to make a new one.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c078390..87d3df4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1354,10 +1354,10 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 				      void *context, void **return_value)
 {
 	struct acpi_bus_ops *ops = context;
-	struct acpi_device *device = NULL;
-	acpi_status status;
 	int type;
 	unsigned long long sta;
+	struct acpi_device *device;
+	acpi_status status;
 	int result;
 
 	result = acpi_bus_type_and_status(handle, &type, &sta);
@@ -1368,13 +1368,16 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 	    !(sta & ACPI_STA_DEVICE_FUNCTIONING))
 		return AE_CTRL_DEPTH;
 
-	if (ops->acpi_op_add)
-		status = acpi_add_single_object(&device, handle, type, sta,
-						ops);
-	else
-		status = acpi_bus_get_device(handle, &device);
+	/*
+	 * We may already have an acpi_device from a previous enumeration.  If
+	 * so, we needn't add it again, but we may still have to start it.
+	 */
+	device = NULL;
+	acpi_bus_get_device(handle, &device);
+	if (ops->acpi_op_add && !device)
+		acpi_add_single_object(&device, handle, type, sta, ops);
 
-	if (ACPI_FAILURE(status))
+	if (!device)
 		return AE_CTRL_DEPTH;
 
 	if (ops->acpi_op_start && !(ops->acpi_op_add)) {

