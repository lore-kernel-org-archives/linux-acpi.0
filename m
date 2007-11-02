From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [ACPICA PATCH] fixed event counters
Date: Fri, 2 Nov 2007 11:29:58 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4039D10B6@orsmsx415.amr.corp.intel.com>
References: <200711021304.37251.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19135 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbXKBSad convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 2 Nov 2007 14:30:33 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200711021304.37251.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

We can roll this into the base code.

Then, I would like to see a new interface to get these things, rather
than have upper code poking around in ACPICA globals.

Like: AcpiGetStatistics

We could return event counts, gpe counts, total SCI count, # methods
executed, etc., etc.

Bob


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Friday, November 02, 2007 10:05 AM
>To: Moore, Robert
>Cc: Linux-acpi@vger.kernel.org
>Subject: [ACPICA PATCH] fixed event counters
>
>Bob,
>I'm planning to add the following counters to the ACPICA code in Linux.
>
>thanks,
>-Len
>
>diff --git a/drivers/acpi/events/evevent.c
b/drivers/acpi/events/evevent.c
>index a1f87b5..8bf4dbe 100644
>--- a/drivers/acpi/events/evevent.c
>+++ b/drivers/acpi/events/evevent.c
>@@ -261,7 +261,7 @@ u32 acpi_ev_fixed_event_detect(void)
> 			enable_bit_mask)) {
>
> 			/* Found an active (signalled) event */
>-
>+			acpi_fixed_event_count[i]++;
> 			int_status |= acpi_ev_fixed_event_dispatch((u32)
i);
> 		}
> 	}
>diff --git a/drivers/acpi/utilities/utglobal.c
>b/drivers/acpi/utilities/utglobal.c
>index af33358..fbb9bec 100644
>--- a/drivers/acpi/utilities/utglobal.c
>+++ b/drivers/acpi/utilities/utglobal.c
>@@ -673,6 +673,8 @@ void acpi_ut_init_globals(void)
> 	/* GPE support */
>
> 	acpi_gpe_count = 0;
>+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
>+		acpi_fixed_event_count[i] = 0;
> 	acpi_gbl_gpe_xrupt_list_head = NULL;
> 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
> 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
>diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
>index 24c3f05..a27ba06 100644
>--- a/include/acpi/acglobal.h
>+++ b/include/acpi/acglobal.h
>@@ -120,6 +120,7 @@ extern u32 acpi_gbl_nesting_level;
> /* Event counters */
>
> ACPI_EXTERN u32 acpi_gpe_count;
>+ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
>
> /* Support for dynamic control method tracing mechanism */
>
