From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 04/12] ACPI: HW reduced mode does not allow use of the FADT sci_interrupt field
Date: Thu, 21 Nov 2013 22:36:30 +0100
Message-ID: <11851356.OfxTKMH3Jy@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <6632063.kaWI72d4Ef@vostro.rjw.lan> <528E60C3.7080706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62927 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753318Ab3KUVXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 16:23:49 -0500
In-Reply-To: <528E60C3.7080706@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Thursday, November 21, 2013 12:36:35 PM Al Stone wrote:
> On 11/20/2013 05:27 PM, Rafael J. Wysocki wrote:
> > On Wednesday, November 20, 2013 02:24:29 PM Al Stone wrote:
> >> On 11/17/2013 03:06 PM, Rafael J. Wysocki wrote:
> >>> On Saturday, November 09, 2013 06:36:14 PM al.stone@linaro.org wrote:
> >>>> From: Al Stone <ahs3@redhat.com>
> >>>
> >>> -ENOCHANGELOG
> >>
> >> Yup.  Will be added.
> >>
> >>>> Signed-off-by: Al Stone <al.stone@linaro.org>
> >>>> ---
> >>>>    drivers/acpi/bus.c      |  3 ++-
> >>>>    drivers/acpi/osl.c      | 10 ++++++----
> >>>>    drivers/acpi/pci_link.c | 14 ++++++++------
> >>>>    3 files changed, 16 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >>>> index b587ec8..6a54dd5 100644
> >>>> --- a/drivers/acpi/bus.c
> >>>> +++ b/drivers/acpi/bus.c
> >>>> @@ -540,7 +540,8 @@ void __init acpi_early_init(void)
> >>>>    		goto error0;
> >>>>    	}
> >>>>
> >>>> -#ifdef CONFIG_X86
> >>>> +#if (!CONFIG_ACPI_REDUCED_HARDWARE)
> >>>
> >>> Why don't you use #ifndef here?
> >>
> >> No particular reason; I'll change it.
> >>
> >>>> +	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
> >>>
> >>> I'm not sure what the "NB" stands for, but it looks like that's what "NOTE:" is
> >>> used for elsewhere.
> >>
> >> Ah.  Whups.  "NB" == "Nota Bene" -- Latin for "note well" and a
> >> personal habit when writing.  Yes, it should be "NOTE:".
> >>
> >>>>    	if (!acpi_ioapic) {
> >>>>    		/* compatible (0) means level (3) */
> >>>>    		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
> >>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >>>> index 54a20ff..017b85c 100644
> >>>> --- a/drivers/acpi/osl.c
> >>>> +++ b/drivers/acpi/osl.c
> >>>> @@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
> >>>>
> >>>>    static acpi_osd_handler acpi_irq_handler;
> >>>>    static void *acpi_irq_context;
> >>>> +static u32 acpi_irq_number;
> >>>>    static struct workqueue_struct *kacpid_wq;
> >>>>    static struct workqueue_struct *kacpi_notify_wq;
> >>>>    static struct workqueue_struct *kacpi_hotplug_wq;
> >>>> @@ -797,9 +798,9 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
> >>>>
> >>>>    	/*
> >>>>    	 * ACPI interrupts different from the SCI in our copy of the FADT are
> >>>> -	 * not supported.
> >>>> +	 * not supported, except in HW reduced mode.
> >>>>    	 */
> >>>> -	if (gsi != acpi_gbl_FADT.sci_interrupt)
> >>>> +	if (!acpi_gbl_reduced_hardware && (gsi != acpi_gbl_FADT.sci_interrupt))
> >>>
> >>> The inner parens are not necessary.
> >>
> >> Ack.
> >>
> >>> Also it seems that we may need to support gsi != acpi_gbl_FADT.sci_interrupt
> >>> generically, because there may be GPE device objects with interrupts different
> >>> from the SCI.
> >>
> >> In reduced HW mode, there are no GPE blocks defined; all
> >> interrupts of that nature are required to use GPIO interrupts
> >> instead, afaict.
> >
> > Well, I'm not sure about that.  The GPE0/1 blocks in FADT are not supposed to
> > be present, but does that apply to GPE block devices (Section 9.10 of ACPI 5.0)?
> >
> >> The spec unfortunately has this info scattered
> >> through out -- the earlier parts of the spec discussing the
> >> reduced HW mode and the discussion around the FADT go into
> >> some of the details.
> >
> > Any more precise pointers?
> >
> > Anyway, the point was that we may need to support interrupts different from
> > acpi_gbl_FADT.sci_interrupt even if the HW reduced mode is *not* used, so
> > making that depend on acpi_gbl_reduced_hardware doesn't seem quite right.
> 
> Yeah, sorry, I should have included the pointers earlier.  I'm basing
> my thinking on my understanding of these sections:
> 
>     -- Section 4.1 which defines HW reduced ACPI, and specifically
>        on 4.1.1, Hardware-Reduced Events.
> 
>     -- Section 5.2.9 defining the FADT and the HW reduced restrictions
> 
>     -- Section 5.6.5, GPIO-signaled ACPI events
> 
>     -- Section 9.10, GPE block device
> 
> The way I read 9.10 in particular is why I'm thinking that any use of
> acpi_gbl_FADT.sci_interrupt needs to go away in HW reduced mode.  The
> first sentence says:
> 
>     The GPE Block device is an optional device that allows a system
>     designer to describe GPE blocks beyond the two that are described
>     in the FADT.

Well, precisely.  It doesn't say anything like "GPE block devices may
only be used if the GPE blocks described in the FADT are present."

> The way I am interpreting that is that a GPE block device only makes
> sense as an extension of the GPE0/1 blocks, not as an independent
> device.

It is an independent device and it may use a *different* interrupt (see
the example in Section 9.10).  [The paragraph right before that example
even says: "To represent the GPE block associated with the FADT ..."
and describes that in detail.]

So to my eyes the spec doesn't actually explicitly say anywhere that
using GPE block devices in the HW reduced mode is invalid.

> Since using the GPE0/1 blocks is not allowed in reduced HW
> mode (see 5.2.9), we cannot extend them with a GPE block device.
> 
> That being said, I agree we should be able to install interrupt
> handlers other than acpi_gbl_FADT.sci_interrupt regardless of whether
> we are in legacy or reduced HW mode.  So, I'm thinking that this
> block:
> 
> 	if (gsi != acpi_gbl_FADT.sci_interrupt)
> 		return AE_BAD_PARAMETER;
> 
> should just be removed from acpi_os_install_interrupt_handler().
> 
> Does that make sense?

I think so.  At least I don't recall any specific situation in which it will
lead to problems.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
