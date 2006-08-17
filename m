From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 12/14] ACPI: Clear GPE before disabling it
Date: Thu, 17 Aug 2006 16:36:43 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4CA7ED0@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23970 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030397AbWHQXgo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2006 19:36:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: William Morrow <William.Morrow@amd.com>
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, jordan.crouse@amd.com, "Yu, Luming" <luming.yu@intel.com>

Here is the required software behavior, from the ACPI spec version 3.0A,
page 138, section 5.6.2.2:

When OSPM receives a general-purpose event (the event is from a GPEx_BLK
STS bit), OSPM does the following:
1.	Disables the interrupt source (GPEx_BLK EN bit).
2.	If an edge event, clears the status bit.
3.	Performs one of the following:
*	Dispatches to an ACPI-aware device driver.
*	Queues the matching control method for execution.
*	Manages a wake event using device _PRW objects.
4.	If a level event, clears the status bit.
5.	Enables the interrupt source.

This is essentially what is implemented today in ACPICA. (It appears
that 1 and 2 are transposed in the code, this may or may not be a
problem.)

Note that edge GPEs are cleared before dispatch, but level GPEs are
cleared after dispatch.

Bob


> -----Original Message-----
> From: William Morrow [mailto:William.Morrow@amd.com]
> Sent: Thursday, August 17, 2006 9:39 AM
> To: Moore, Robert
> Cc: akpm@osdl.org; Brown, Len; linux-acpi@vger.kernel.org;
> jordan.crouse@amd.com; Yu, Luming
> Subject: Re: [patch 12/14] ACPI: Clear GPE before disabling it
> 
> Moore, Robert wrote:
> 
> >Worse, the GPE is already cleared in the edge case, at the start of
the
> >GPE dispatch function:
> >
> >    /*
> >     * If edge-triggered, clear the GPE status bit now.  Note that
> >     * level-triggered events are cleared after the GPE is serviced.
> >     */
> >    if ((GpeEventInfo->Flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
> >            ACPI_GPE_EDGE_TRIGGERED)
> >    {
> >        Status = AcpiHwClearGpe (GpeEventInfo);
> >        if (ACPI_FAILURE (Status))
> >        {
> >            ACPI_EXCEPTION ((AE_INFO, Status,
> >                "Unable to clear GPE[%2X]", GpeNumber));
> >            return_UINT32 (ACPI_INTERRUPT_NOT_HANDLED);
> >        }
> >    }
> >
> >
> >
> Sorry for the late reply, but I have not looked at this for some time.
> I had to re-examine this issue.
> 
> The interrupt type is tagged as level triggered in this case.
> 
> The dispatch handler is ACPI_GPE_DISPATCH_METHOD and so the
> method is queued, but the interrupt is not cleared (it is disabled
> instead).
> In this hw, that is all that happens.  It is disabled but not cleared.
> The original comment would lead me to think that the prevailing
thought
> was that disabling the gpe implied clearing the interrupt status.
That is
> not the case in this hw environment, and the result is the interrupt
> storm.
> 
> Although this handler is artfully done,  the architecture of this
> handler is unusual in that most interrupt handlers field status
> and clear the offending event at once, then process the new input.
> This handler is coded in a way that seems to indicate that interrupt
> status is possible when events are not enabled, but is not willing to
> clear them - again indicating that the hw design is required to block
> interrupts if the event has been disabled, but the interrupt status is
> not clear.  If that is true - then this code has no effect, or is
another
> case which can result in an interrupt storm.
> 
>     /* Check if there is anything active at all in this register */
> 
>     enabled_status_byte = (u8) (status_reg & enable_reg);
>     if (!enabled_status_byte) {
>       /* No active GPEs in this register, move on */
>       continue;
>     }
> 
> Additionally, any error return which prevents the interrupt
> source from being cleared will result in an interrupt storm.
> This occurs several times.
> 
> The comment:
> 
> /*
>  * Execute the method associated with the GPE
>  * NOTE: Level-triggered GPEs are cleared after the method completes.
>  */
>  Status = AcpiOsExecute (OSL_GPE_HANDLER,
>              AcpiEvAsynchExecuteGpeMethod, GpeEventInfo);
> 
> is alarming, since it documents that the interrupt is active and
> expects the OS to be able to schedule with pending interrupts.
> 
> My personal preference is that the code be modified to work in
> the more traditional way, but since that would be a large change
> and this produced the desired result - I opted for the minimum
> coding distance change.
> 
> 
> If there are any other materials you need to evaluate this change, let
> me know.
> I hope this addresses your point.  I am sort of renowned for being a
> little askew
> when trying to explain myself.
> 
> Thanks for your attention!
> morrow
> 
> >
> >
> >
> >>-----Original Message-----
> >>From: Moore, Robert
> >>Sent: Wednesday, August 16, 2006 2:50 PM
> >>To: 'akpm@osdl.org'; Brown, Len
> >>Cc: linux-acpi@vger.kernel.org; william.morrow@amd.com;
> >>jordan.crouse@amd.com; Yu, Luming
> >>Subject: RE: [patch 12/14] ACPI: Clear GPE before disabling it
> >>
> >>How does this patch relate to level-triggered GPEs, where we have
the
> >>following comment in the code just after the patch:
> >>
> >>        /*
> >>         * Execute the method associated with the GPE
> >>         * NOTE: Level-triggered GPEs are cleared after the method
> >>completes.
> >>         */
> >>        Status = AcpiOsExecute (OSL_GPE_HANDLER,
> >>                    AcpiEvAsynchExecuteGpeMethod, GpeEventInfo);
> >>
> >>
> >>
> >>>-----Original Message-----
> >>>From: akpm@osdl.org [mailto:akpm@osdl.org]
> >>>Sent: Monday, August 14, 2006 10:38 PM
> >>>To: Brown, Len
> >>>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org;
> >>>
> >>>
> >william.morrow@amd.com;
> >
> >
> >>>jordan.crouse@amd.com; Yu, Luming; Moore, Robert
> >>>Subject: [patch 12/14] ACPI: Clear GPE before disabling it
> >>>
> >>>From: William Morrow <william.morrow@amd.com>
> >>>
> >>>On some BIOSen, the GPE bit will remain set even if it is disabled,
> >>>resulting in a interrupt storm.  This patch clears the bit before
> >>>disabling
> >>>it.
> >>>
> >>>Signed-off-by: William Morrow <william.morrow@amd.com>
> >>>Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> >>>Cc: "Yu, Luming" <luming.yu@intel.com>
> >>>Cc: "Brown, Len" <len.brown@intel.com>
> >>>Cc: "Moore, Robert" <robert.moore@intel.com>
> >>>Signed-off-by: Andrew Morton <akpm@osdl.org>
> >>>---
> >>>
> >>> drivers/acpi/events/evgpe.c |   14 +++++++++++++-
> >>> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>>diff -puN
> >>>
> >>>
> >drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> >
> >
> >>>drivers/acpi/events/evgpe.c
> >>>---
a/drivers/acpi/events/evgpe.c~acpi-clear-gpe-before-disabling-it
> >>>+++ a/drivers/acpi/events/evgpe.c
> >>>@@ -677,10 +677,22 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
> >>> 	case ACPI_GPE_DISPATCH_METHOD:
> >>>
> >>> 		/*
> >>>-		 * Disable GPE, so it doesn't keep firing before the
> >>>
> >>>
> >method
> >
> >
> >>>has a
> >>>+		 * Clear GPE, so it doesn't keep firing before the
> >>>
> >>>
> >method has
> >
> >
> >>>a
> >>> 		 * chance to run.
> >>> 		 */
> >>>+		status = acpi_hw_clear_gpe(gpe_event_info);
> >>>+		if (ACPI_FAILURE(status)) {
> >>>+			ACPI_EXCEPTION((AE_INFO, status,
> >>>+					"Unable to clear GPE[%2X]",
> >>>+					gpe_number));
> >>>+			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
> >>>+		}
> >>>+		/*
> >>>+		 * Disable GPE, so it doesn't keep happen again.
> >>>+		 */
> >>>+
> >>> 		status = acpi_ev_disable_gpe(gpe_event_info);
> >>>+
> >>> 		if (ACPI_FAILURE(status)) {
> >>> 			ACPI_EXCEPTION((AE_INFO, status,
> >>> 					"Unable to disable GPE[%2X]",
> >>>_
> >>>
> >>>
> >
> >
> >
> >
