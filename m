From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 08/18] acpiphp: prevent duplicate slot numbers when no _SUN
Date: Tue, 27 Jun 2006 02:12:49 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D8C7C3@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53256 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030656AbWF0GOF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jun 2006 02:14:05 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, gregkh@suse.de

applied to acpi-test 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Saturday, June 24, 2006 7:37 PM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; Accardi, Kristen C
>Subject: [patch 08/18] acpiphp: prevent duplicate slot numbers 
>when no _SUN
>
>
>From: Kristen Accardi <kristen.c.accardi@intel.com>
>
>Dock bridges generally do not implement _SUN, yet show up as ejectable
>slots.  If you have more than one ejectable slot that does not 
>implement
>SUN, with the current code you will get duplicate slot numbers.  So, if
>there is no _SUN, use the current count of the number of slots found
>instead.
>
>Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/pci/hotplug/acpiphp_glue.c |    9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff -puN 
>drivers/pci/hotplug/acpiphp_glue.c~acpiphp-prevent-duplicate-sl
>ot-numbers-when-no-_sun drivers/pci/hotplug/acpiphp_glue.c
>--- 
>devel/drivers/pci/hotplug/acpiphp_glue.c~acpiphp-prevent-duplic
>ate-slot-numbers-when-no-_sun	2006-06-01 20:17:06.000000000 -0700
>+++ devel-akpm/drivers/pci/hotplug/acpiphp_glue.c	
>2006-06-01 20:17:06.000000000 -0700
>@@ -218,8 +218,13 @@ register_slot(acpi_handle handle, u32 lv
> 		newfunc->flags |= FUNC_HAS_DCK;
> 
> 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
>-	if (ACPI_FAILURE(status))
>-		sun = -1;
>+	if (ACPI_FAILURE(status)) {
>+		/*
>+		 * use the count of the number of slots we've found
>+		 * for the number of the slot
>+		 */
>+		sun = bridge->nr_slots+1;
>+	}
> 
> 	/* search for objects that share the same slot */
> 	for (slot = bridge->slots; slot; slot = slot->next)
>_
>
