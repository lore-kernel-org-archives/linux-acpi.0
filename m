From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] ACPICA: Clear power button status before enabling
	event
Date: Thu, 18 Jun 2009 15:00:21 +0800
Message-ID: <1245308421.7697.73.camel@localhost.localdomain>
References: <20090615164907.10901.73210.stgit@bob.kio>
	 <200906171308.58783.bjorn.helgaas@hp.com>
	 <1245291266.7697.11.camel@localhost.localdomain>
	 <200906172138.04877.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55379 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311AbZFRG7Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2009 02:59:16 -0400
In-Reply-To: <200906172138.04877.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thu, 2009-06-18 at 11:38 +0800, Bjorn Helgaas wrote:
> On Wednesday 17 June 2009 8:14:26 pm yakui_zhao wrote:
> > On Thu, 2009-06-18 at 03:08 +0800, Bjorn Helgaas wrote:
> > > What's your opinion of the following patch?  This drops the clear
> > > from acpi_suspend_enter().  In the ACPI CA acpi_leave_sleep_state(),
> > > it clears first, then enables, and moves both before the _WAK
> > > execution.
> > > 
> > >   button press A causes wakeup
> > >   <possible button press (or BIOS sets event) B>
> > >   acpi_leave_sleep_state() clears all GPEs
> > >   acpi_leave_sleep_state() enables runtime GPEs
> > >   acpi_leave_sleep_state() clears power button event
> > >   <possible button press C>
> > >   acpi_leave_sleep_state() enables power button event
> > >   <possible button press D>
> > >   acpi_leave_sleep_state() runs _WAK
> > >   <possible button "press" E from _WAK>
> > >   <possible button press F>
> > >   
> > > This should work the same as the current code -- we drop event B
> > > as desired, and we handle all others.
> > > 
> > > It has the advantages that we remove a bit of code from Linux/ACPI,
> > > we only touch the power button events in one place, and we follow
> > > the same pattern (clear, then enable) as the GPEs.
> > > 
> > > I'm not sure why acpi_suspend_enter() only clears the event when
> > > the acpi_target_sleep_state == ACPI_STATE_S3.  Sec. 4.7.2.2.1.1
> > > doesn't mention that.
> > We had better not delete the code that clears the power button event in
> > course of acpi_suspend_enter. 
> > This is to avoid that the power button wake event hits the user space.
> > 
> > Maybe the BIOS will set the power button event enable/status bit. And
> > after the interrupt is enabled, the power button event will hit the
> > userland. So it is appropriate to clear the power button event as early
> > as possible.
> 
> OK, I think I see now.  I didn't think through the "should not reach
> userspace" language.  I think we just want to clear the event so we
> don't take another interrupt when we re-enable interrupts near the
> end of acpi_suspend_enter().
What you said is partially right.
   The power button wakeup event had better not hit the userland. If the
acpid receives the power button wakeup event, then the system will be
shutdown. This is not what we wanted.
   So it will be better that the power button event is cleared as early
as possible(At least it is cleared before the interrupt is re-enabled).
> 
> >     Of course it can be cleared in the function of
> > "acpi_leave_sleep_state_prep".
> 
> The interrupt path (acpi_ev_sci_xrupt_handler() ->
> acpi_ev_fixed_event_detect() -> acpi_ev_fixed_event_dispatch())
> is mostly in the ACPI CA, so I like your idea of clearing the
> power button event in acpi_leave_sleep_state_prep() because
> that's also in the CA, and it seems more robust if the CA
> clears it rather than assuming that the host OS will clear it.
> 
> I would probably suggest moving the acpi_disable_all_gpes() into
> acpi_leave_sleep_state_prep() for the same reason.
It is ok for me. 
> 
> It's still asymmetric because we disable & clear *all* GPEs,
> but only the power button fixed event.

> 
> And I still don't understand the ACPI_STATE_S3 test around the
> power button event clear.  Do you think that's necessary?
For the S3 test it is necessary to clear the power button event before
the interrupt is re-enabled.
Now the power button event is cleared at two places in course of resume.
One is  in the acpi_suspend_enter and another is in the function of
acpi_leave_sleep_state. As the acpi_leave_sleep_state is called with
interrupt enabled, it will be too late. Maybe when the interrupt is
enabled, the power button event is fired and then hit the userland.

If the power button event is cleared in the function of
acpi_leave_sleep_state_prep, it is unnecessary to clear it explicitly in
the acpi_suspend_enter.

Thanks.
> 
> Thanks for your patience in explaining all this to me.
> 
> Bjorn
> 
> > > diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
> > > index db307a3..c3252ee 100644
> > > --- a/drivers/acpi/acpica/hwsleep.c
> > > +++ b/drivers/acpi/acpica/hwsleep.c
> > > @@ -592,6 +592,18 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
> > >  		return_ACPI_STATUS(status);
> > >  	}
> > >  
> > > +	/* Enable power button */
> > > +
> > > +	(void)
> > > +	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > > +			      [ACPI_EVENT_POWER_BUTTON].
> > > +			      status_register_id, ACPI_CLEAR_STATUS);
> > > +
> > > +	(void)
> > > +	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > > +			      [ACPI_EVENT_POWER_BUTTON].
> > > +			      enable_register_id, ACPI_ENABLE_EVENT);
> > > +
> > >  	arg.integer.value = sleep_state;
> > >  	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
> > >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > > @@ -608,18 +620,6 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
> > >  
> > >  	acpi_gbl_system_awake_and_running = TRUE;
> > >  
> > > -	/* Enable power button */
> > > -
> > > -	(void)
> > > -	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > > -			      [ACPI_EVENT_POWER_BUTTON].
> > > -			      enable_register_id, ACPI_ENABLE_EVENT);
> > > -
> > > -	(void)
> > > -	    acpi_write_bit_register(acpi_gbl_fixed_event_info
> > > -			      [ACPI_EVENT_POWER_BUTTON].
> > > -			      status_register_id, ACPI_CLEAR_STATUS);
> > > -
> > >  	arg.integer.value = ACPI_SST_WORKING;
> > >  	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
> > >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index 01574a0..b63c525 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -257,13 +257,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
> > >  	/* Reprogram control registers and execute _BFS */
> > >  	acpi_leave_sleep_state_prep(acpi_state);
> > >  
> > > -	/* ACPI 3.0 specs (P62) says that it's the responsibility
> > > -	 * of the OSPM to clear the status bit [ implying that the
> > > -	 * POWER_BUTTON event should not reach userspace ]
> > > -	 */
> > > -	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
> > > -		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> > > -
> > >  	/*
> > >  	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
> > >  	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 

