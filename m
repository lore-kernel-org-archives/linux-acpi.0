From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Thu, 29 Sep 2011 23:28:45 +0200
Message-ID: <201109292328.45375.rjw@sisk.pl>
References: <20110912171003.GA7939@xanatos> <201109292139.56626.rjw@sisk.pl> <20110929204440.GA6043@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37976 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756926Ab1I2V0e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Sep 2011 17:26:34 -0400
In-Reply-To: <20110929204440.GA6043@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thursday, September 29, 2011, Sarah Sharp wrote:
> On Thu, Sep 29, 2011 at 09:39:56PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, September 29, 2011, Sarah Sharp wrote:
> > > On Thu, Sep 29, 2011 at 12:21:28AM +0200, Rafael J. Wysocki wrote:
> > Please try the appended patch and check if you see the "Notification error
> > for GPE" message (please keep your previous debug patches applied).
> 
> Do I need to have the ACPI debug_level or debug_layer set to anything in
> particular to see this message?

No, I don't think so, but just in case please try the patch below instead
of the previous one.

Thanks,
Rafael

---
 drivers/acpi/acpica/evgpe.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux.orig/drivers/acpi/acpica/evgpe.c
+++ linux/drivers/acpi/acpica/evgpe.c
@@ -521,12 +521,24 @@ static void ACPI_SYSTEM_XFACE acpi_ev_as
 		status = acpi_ev_queue_notify_request(
 				local_gpe_event_info->dispatch.device.node,
 				ACPI_NOTIFY_DEVICE_WAKE);
+		if (ACPI_FAILURE(status))
+			pr_err("Notification error for GPE 0x%X",
+				local_gpe_event_info->gpe_number);
+		else
+			pr_info("Notification queued up for GPE 0x%X",
+				local_gpe_event_info->gpe_number);
 
 		notify_object = local_gpe_event_info->dispatch.device.next;
-		while (ACPI_SUCCESS(status) && notify_object) {
+		while (notify_object) {
 			status = acpi_ev_queue_notify_request(
 					notify_object->node,
 					ACPI_NOTIFY_DEVICE_WAKE);
+			if (ACPI_FAILURE(status))
+				pr_err("Notification error for GPE 0x%X",
+					local_gpe_event_info->gpe_number);
+			else
+				pr_info("Notification queued up for GPE 0x%X",
+					local_gpe_event_info->gpe_number);
 			notify_object = notify_object->next;
 		}
 
