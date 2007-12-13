From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] clear GPE earily in resume
Date: Thu, 13 Dec 2007 17:26:00 -0500
Message-ID: <200712131726.00601.lenb@kernel.org>
References: <1181785011.19274.6.camel@sli10-conroe.sh.intel.com> <1182302278.29466.1.camel@sli10-conroe.sh.intel.com> <200706201335.24754.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59150 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbXLMW0e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 17:26:34 -0500
In-Reply-To: <200706201335.24754.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, "robert.moore" <robert.moore@intel.com>

Applied to 2.6.25 queue

thanks,
-Len

On Wednesday 20 June 2007 07:35, Rafael J. Wysocki wrote:
> On Wednesday, 20 June 2007 03:17, Shaohua Li wrote:
> > On Wed, 2007-06-20 at 00:06 +0200, Rafael J. Wysocki wrote:
> > > On Thursday, 14 June 2007 03:36, Shaohua Li wrote:
> > > > Wakeup GPE hasn't a handler. If system is waked up by such GPE like a
> > > > USB hotplug, I saw a lot of error reporting the GPE hasn't handler.
> > > > acpi_leave_sleep_state will clear the GPE but it's too late, we should
> > > > doe it before interrupt is re-enabled. 
> > > > 
> > > > Maybe we should just clear wakeup GPE here, but clear all GPEs sounds
> > > > not harmful in my test. Not sure other systems.
> > > 
> > > I think that the clearing all of the GPEs is the right thing to do here.
> > > 
> > > > Index: 2.6.22-rc/drivers/acpi/sleep/main.c
> > > > ===================================================================
> > > > --- 2.6.22-rc.orig/drivers/acpi/sleep/main.c	2007-06-11 15:31:03.000000000 +0800
> > > > +++ 2.6.22-rc/drivers/acpi/sleep/main.c	2007-06-14 09:31:54.000000000 +0800
> > > > @@ -104,6 +104,8 @@
> > > >  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
> > > >  		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> > > >  
> > > 
> > > I'd add a comment saying why we're clearing the GPEs at this point.
> > added.
> 
> Thanks.
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>  
> > Wakeup GPE hasn't a handler. If system is waked up by such GPE like a
> > USB hotplug, I saw a lot of error reporting the GPE hasn't handler.
> > acpi_leave_sleep_state will clear the GPE but it's too late, we should
> > do it before interrupt is re-enabled. 
> > 
> > diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> > index bc7e16e..9f36859 100644
> > --- a/drivers/acpi/sleep/main.c
> > +++ b/drivers/acpi/sleep/main.c
> > @@ -104,6 +104,13 @@ static int acpi_pm_enter(suspend_state_t pm_state)
> >  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
> >  		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> >  
> > +	/*
> > +	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
> > +	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
> > +	 * acpi_leave_sleep_state will reenable specific GPEs later
> > +	 */
> > +	acpi_hw_disable_all_gpes();
> > +
> >  	local_irq_restore(flags);
> >  	printk(KERN_DEBUG "Back to C!\n");
> >  
> > 
> > 
> 
