From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 4/4] ACPI / ACPICA: Fail acpi_gpe_wakeup() if ACPI_GPE_CAN_WAKE is unset
Date: Thu, 8 Jul 2010 00:45:34 +0200
Message-ID: <201007080045.34877.rjw@sisk.pl>
References: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32921 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab0GGWrs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jul 2010 18:47:48 -0400
In-Reply-To: <201007080041.38627.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_gpe_wakeup() return error code for GPEs whose
ACPI_GPE_CAN_WAKE flag is not set.  This way acpi_gpe_wakeup() will
only wake for the GPEs reported by the host OS as "wakeup" ones with
the help of acpi_gpe_can_wake().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxfevnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -239,7 +239,7 @@ acpi_status acpi_gpe_wakeup(acpi_handle 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
+	if (!gpe_event_info || !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
 	}

