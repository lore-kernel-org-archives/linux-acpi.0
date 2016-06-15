From: Peter Jones <pjones@redhat.com>
Subject: [PATCH] ACPI: don't show an error when we're not in charge of PCIe hotplug.
Date: Wed, 15 Jun 2016 18:15:04 -0400
Message-ID: <1466028904-28328-1-git-send-email-pjones@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbcFOWPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 18:15:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mario_Limonciello@dell.com, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, Peter Jones <pjones@redhat.com>

Right now when booting, on many laptops the firmware manages the PCIe
bus.  As a result, when we call the _OSC ACPI method, it returns an
error code.  Unfortunately the errors are not very articulate.  As a
result, we show:

ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
\_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid UUID
_OSC request data: 1 1f 0
acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM

But we did get the capabilities mask back; the firmware is merely
managing this itself.  So we really should not be showing the user a
message that looks like the firmware is broken, since it is working just
fine.

This patch supresses the error message when we're calling _OSC with the
PCIe host bridge UUID, and replaces it with a relatively innocuous
looking message that you can find if you're looking for it.
---
 drivers/acpi/bus.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 262ca31..be8a91b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -215,6 +215,8 @@ acpi_status acpi_str_to_uuid(char *str, u8 *uuid)
 }
 EXPORT_SYMBOL_GPL(acpi_str_to_uuid);
 
+static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
+
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
 	acpi_status status;
@@ -267,9 +269,13 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 		if (errors & OSC_REQUEST_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC request failed");
-		if (errors & OSC_INVALID_UUID_ERROR)
-			acpi_print_osc_error(handle, context,
-				"_OSC invalid UUID");
+		if (errors & OSC_INVALID_UUID_ERROR) {
+			if (!strcasecmp(context->uuid_str, pci_osc_uuid_str))
+				pr_info("PCI PME managed by ACPI.\n");
+			else
+				acpi_print_osc_error(handle, context,
+						     "_OSC invalid UUID");
+		}
 		if (errors & OSC_INVALID_REVISION_ERROR)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
-- 
2.7.4

