From: "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to support shared
 GPEs
Date: Fri, 19 Feb 2010 13:23:40 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45377 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab0BSVXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 16:23:42 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>


Here's some comments and questions on the GPE changes in ACPICA.
Overall, looks good.
Bob



Acpi_set_gpe - looks ok

Acpi_enable_gpe

+	if (type & ACPI_GPE_TYPE_RUNTIME) {
+		if (++gpe_event_info->runtime_count == 1)
+			status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
 
+		if (ACPI_FAILURE(status))
+			gpe_event_info->runtime_count--;
+	}

I would think the status check should be grouped like this:

+	if (type & ACPI_GPE_TYPE_RUNTIME) {
+		if (++gpe_event_info->runtime_count == 1) {
+			status = acpi_ev_enable_gpe(gpe_event_info, TRUE);
 
+		      if (ACPI_FAILURE(status))
+			      gpe_event_info->runtime_count--;
+           }
+	}


Acpi_disable_gpe

+			acpi_ev_disable_gpe(gpe_event_info);

There is a status returned by this function, should get it.

Should do a switch(type) and handle the bad type case.


+++ linux-2.6/drivers/acpi/ec.c
+		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
+		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);

Think you should have some comments here as to why exactly the code is
Forcing a H/W disable/enable (in all places these functions are used)


acpi_ev_update_gpe_enable_masks.

My understanding is that this function changes to update the masks based upon the reference counters, instead of an input parameter.



acpi_ev_enable_gpe:

1) I think we may not need the "write_to_hardware" parameter anymore. The calls to ev_enable_gpe that use FALSE for this parameter look like they could be simply replaced with a call to acpi_ev_update_gpe_enable_masks.

2) The GPE is only enabled if the runtime_count is non-zero. Would there ever be a situation where we might want to enable a GPE when the runtime_count is zero?


acpi_ev_disable_gpe: OK, just removing the obsolete flags


acpi_ev_save_method_info:

Default is still "runtime" gpe, unless _PRW is found later and then ACPI_GPE_CAN_WAKE is set, correct?


acpi_ev_initialize_gpe_block:

Probably should still get the status from WalkNamespace and emit an ACPI_ERROR if this fails, since this would probably be a serious error if we could not get the _PRW methods.


acpi_ev_initialize_gpe_block:

I wonder if we still need Boolean acpi_gbl_leave_wake_gpes_disabled.

Why remove call to acpi_hw_enable_runtime_gpe_block? It is much more efficient to do entire registers at once instead of repeatedly calling ev_enable_gpe.



+++ linux-2.6/include/acpi/actypes.h

#define ACPI_GPE_TYPE_WAKE_RUN          (u8) 0x06
 #define ACPI_GPE_TYPE_WAKE              (u8) 0x02
 #define ACPI_GPE_TYPE_RUNTIME           (u8) 0x04	/* Default */

These are obsolete and can be removed, yes?


