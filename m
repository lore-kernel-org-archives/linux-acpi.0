From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] ACPICA: Clear power button status before enabling
	event
Date: Wed, 17 Jun 2009 15:34:38 +0800
Message-ID: <1245224078.3614.21.camel@localhost.localdomain>
References: <20090615164907.10901.73210.stgit@bob.kio>
	 <1245208900.3583.190.camel@localhost.localdomain>
	 <200906162226.27783.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17991 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbZFQHdb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 03:33:31 -0400
In-Reply-To: <200906162226.27783.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Wed, 2009-06-17 at 12:26 +0800, Bjorn Helgaas wrote:
> On Tuesday 16 June 2009 9:21:40 pm yakui_zhao wrote:
> > On Tue, 2009-06-16 at 00:49 +0800, Bjorn Helgaas wrote:
> > > Clear power button status before enabling event.
> > > 
> > > It's unusual to enable an event, then immediately clear it, so this
> > > looks like a possible bug.  If it was intentional, perhaps a comment
> > > would be in order.
> > IMO this patch is unnecessary.
> 
> > It seems that we will clear the power button event immediately after it
> > is resumed from OS. (This is done in the function of
> > acpi_suspend_enter).
> 
> A comment in acpi_suspend_enter() refers to ACPI 3.0b sec. 4.7.2.2.1.1,
> which says "OSPM responds [to a button press after the button press that
> transitioned the system into a sleeping state] by clearing the power button
> status bit and waking the system."
If the power button event is not cleared after finishing the resume, the
acpid will receive the power button event and then power off the system.
So OSPM had better clear the power button event in course of resuming to
avoid that the box is poweroff.
> 
> So *somebody* has to clear the status bit, but I'm not sure that it has
> to be done in the Linux-specific code, e.g,. acpi_suspend_enter().  The
> term "OSPM" seems broad enough to include both the ACPI CA and the Linux-
> specific code, and it may be more robust to clear it in the CA.
> 
> > Maybe the power event status bit is set before we re-enable the event
> > bit. And after we re-enable the power button event, OS can handle the
> > power button event (the acpi_leave_sleep_state is called with interrupts
> > enabled). 
> > 
> > If the patch is applied, the power button event will be lost.
> 
> I think this is the scenario you refer to:
> 
>   button press A causes wakeup
>   <possible button press B>
>   acpi_suspend_enter() clears event
>   <possible button press C>
>   acpi_leave_sleep_state() clears event
>   acpi_leave_sleep_state() enables event
>   <possible button press D>
> 
> Even without this patch, we would lose button event B.  With this patch,
> we would also lose button event C.  This whole sequence should take very
> little time, so I'm dubious that there is any value in keeping either
> B or C -- it seems they'd most likely be unintentional.
Without this patch, the power button event C can be handled.

If the power button event bit will be set in the _WAK object, then this
event can't be handled after applying your patch.
> 
> Actually, it seems like it would make the most sense to apply this patch
> *and* stop clearing the event in acpi_suspend_enter().  Then the code is
> simpler and easier to analyze, because we only touch the button status in
> one place.
IMO it will be better to clear the power button event in the function of
acpi_suspend_enter.
If we don't do that, maybe the BIOS will set the power button event
status/enable bit. And after the interrupt is enabled, the power button
event handler will send the event. In such case the acpid will receive
the event. Maybe the box will be powered off after resuming. This is not
what we wanted.
Thanks.
> 
> But I admit I know very little about suspend/resume, so maybe I just
> need more convincing :-)
> 
> Bjorn
> 
> > > This patch may be used under either the GPL v2 or the BSD-style license
> > > used for the Intel ACPICA.
> > > 
> > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > CC: Bob Moore <robert.moore@intel.com>
> > > ---
> > >  drivers/acpi/acpica/hwsleep.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> > > index db307a3..3558c53 100644
> > > --- a/drivers/acpi/acpica/hwsleep.c
> > > +++ b/drivers/acpi/acpica/hwsleep.c
> > > @@ -613,12 +613,12 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
> > >  	(void)
> > >  	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > >  			      [ACPI_EVENT_POWER_BUTTON].
> > > -			      enable_register_id, ACPI_ENABLE_EVENT);
> > > +			      status_register_id, ACPI_CLEAR_STATUS);
> > >  
> > >  	(void)
> > >  	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > >  			      [ACPI_EVENT_POWER_BUTTON].
> > > -			      status_register_id, ACPI_CLEAR_STATUS);
> > > +			      enable_register_id, ACPI_ENABLE_EVENT);
> > >  
> > >  	arg.integer.value = ACPI_SST_WORKING;
> > >  	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 

