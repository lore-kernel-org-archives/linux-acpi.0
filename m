From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] ACPI / ACPICA: Simplify acpi_ev_initialize_gpe_block()
Date: Mon, 5 Jul 2010 01:00:49 +0200
Message-ID: <201007050100.49823.rjw@sisk.pl>
References: <201007050056.22705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50851 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab0GDXDu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jul 2010 19:03:50 -0400
In-Reply-To: <201007050056.22705.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lin Ming <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Linux PM <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Simplify the main loop in acpi_ev_initialize_gpe_block() by
rearranging code and removing the "enabled" label that is not
necessary any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evgpeblk.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -472,26 +472,21 @@ acpi_ev_initialize_gpe_block(struct acpi
 			gpe_event_info = &gpe_block->event_info[gpe_index];
 			gpe_number = gpe_index + gpe_block->block_base_number;
 
-			/*
-			 * If the GPE has already been enabled for runtime
-			 * signaling, make sure it remains enabled, but do not
-			 * increment its reference counter.
-			 */
-			if (gpe_event_info->runtime_count) {
-				status = acpi_ev_enable_gpe(gpe_event_info);
-				goto enabled;
-			}
-
 			/* Ignore GPEs that have no corresponding _Lxx/_Exx method */
 
 			if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)) {
 				continue;
 			}
 
-			/* Enable this GPE */
+			/*
+			 * If the GPE has already been enabled for runtime
+			 * signaling, make sure it remains enabled, but do not
+			 * increment its reference counter.
+			 */
+			status = gpe_event_info->runtime_count ?
+				acpi_ev_enable_gpe(gpe_event_info) :
+				acpi_enable_gpe(gpe_device, gpe_number);
 
-			status = acpi_enable_gpe(gpe_device, gpe_number);
- enabled:
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",

