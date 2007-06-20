From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/2] acpi choose sleep state help
Date: Wed, 20 Jun 2007 14:18:00 +0800
Message-ID: <1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	 <200706191352.16913.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11146 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761191AbXFTGWn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jun 2007 02:22:43 -0400
In-Reply-To: <200706191352.16913.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>

On Tue, 2007-06-19 at 13:52 +0200, Rafael J. Wysocki wrote:
> On Tuesday, 19 June 2007 04:33, Shaohua Li wrote:
> > Based on David's patch
> > http://marc.info/?l=linux-acpi&m=117873972806360&w=2
> > I slightly changed it.
> > 
> > Add a helper routine, which gets the sleep state of a ACPI device.
> 
> Is it going to work with the recent code ordering changes?  I mean,
> acpi_pm_prepare() is now called after device_suspend() (and analogously for
> the hibernation), so the target ACPI state is not known when the drivers'
> .suspend() routines are being called.
Not. Could pm_message_t have a member indicating the suspend state?

> 
> > Index: 2.6.22-rc2/drivers/acpi/sleep/main.c
> > ===================================================================
> > --- 2.6.22-rc2.orig/drivers/acpi/sleep/main.c	2007-05-23 09:15:14.000000000 +0800
> > +++ 2.6.22-rc2/drivers/acpi/sleep/main.c	2007-06-19 09:19:09.000000000 +0800
> > @@ -34,6 +34,8 @@ static u32 acpi_suspend_states[] = {
> >  
> >  static int init_8259A_after_S1;
> >  
> > +static int acpi_target_sleep_state = ACPI_STATE_S0;
> > +
> >  /**
> >   *	acpi_pm_prepare - Do preliminary suspend work.
> >   *	@pm_state:		suspend state we're entering.
> > @@ -54,6 +56,7 @@ static int acpi_pm_prepare(suspend_state
> >  		printk("acpi_pm_prepare does not support %d \n", pm_state);
> >  		return -EPERM;
> >  	}
> > +	acpi_target_sleep_state = acpi_state;
> >  	return acpi_sleep_prepare(acpi_state);
> >  }
> >  
> > @@ -140,6 +143,7 @@ static int acpi_pm_finish(suspend_state_
> >  		printk("Broken toshiba laptop -> kicking interrupts\n");
> >  		init_8259A(0);
> >  	}
> > +	acpi_target_sleep_state = ACPI_STATE_S0;
> >  	return 0;
> >  }
> >  
> > @@ -184,6 +188,7 @@ static struct pm_ops acpi_pm_ops = {
> >  #ifdef CONFIG_SOFTWARE_SUSPEND
> >  static int acpi_hibernation_prepare(void)
> >  {
> > +	acpi_target_sleep_state = ACPI_STATE_S4;
> >  	return acpi_sleep_prepare(ACPI_STATE_S4);
> >  }
> >  
> > @@ -215,6 +220,7 @@ static void acpi_hibernation_finish(void
> >  		printk("Broken toshiba laptop -> kicking interrupts\n");
> >  		init_8259A(0);
> >  	}
> > +	acpi_target_sleep_state = ACPI_STATE_S0;
> 
> This will clash with the recent Pavel's patch that removes the Toshiba
> quirk from the hibernation code path
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc5/patches/35-ACPI-remove-S1-workaround-from-hibernation-code-path.patch
> 
> >  }
> >  
> >  static struct hibernation_ops acpi_hibernation_ops = {
> > @@ -224,6 +230,49 @@ static struct hibernation_ops acpi_hiber
> >  };
> >  #endif				/* CONFIG_SOFTWARE_SUSPEND */
> >  
> > +int acpi_pm_choose_sleep_state(acpi_handle handle, pm_message_t state)
> > +{
> 
> The second argument doesn't seem to be used.  Is that intentional and if so,
> then why?
I hope it gives the suspend state, but it appears it's not used.

> > +	char sxd[] = "_SxD";
> > +	unsigned long d_min, d_max;
> > +	struct acpi_device *dev;
> > +
> > +	/*
> > +	 * If the sleep state is S0, we will return D3, but if the device has
> > +	 * _S0W, we will use the value from _S0W
> > +	 */
> 
> Hmm, is the comment right?  Why should we return D3 for S0?
Yes. It could be runtime device suspend. In that case we return D3 by
default if acpi gives the correct _S0W, we use state from it.

> > +	d_min = ACPI_STATE_D3;
> > +	d_max = ACPI_STATE_D3;
> > +
> > +	/* If present, _SxD methods give the minimum D-state we may use
> > +	 * for each S-state ... with lowest latency state switching.
> > +	 *
> > +	 * We rely on acpi_evaluate_integer() not clobbering the integer
> > +	 * provided -- that's our fault recovery, we ignore retval.
> > +	 */
> > +	sxd[2] = '0' + acpi_target_sleep_state;
> > +	if (acpi_target_sleep_state > ACPI_STATE_S0)
> > +		acpi_evaluate_integer(handle, sxd, NULL, &d_min);
> > +
> > +	/*
> > +	 * If _PRW says we can wake from the upcoming system state, the _SxD
> > +	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
> > +	 * methods exist (ACPI 3.x), they give the lowest power D-state that
> > +	 * can also wake the system.  _S0W can be valid.
> > +	 */
> > +	if (acpi_bus_get_device(handle, &dev)) {
> > +		printk(KERN_ERR"ACPI handle hasn't context\n");
> > +		return d_max;
> > +	}
> > +	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> > +	    (dev->wakeup.state.enabled &&
> > +	     dev->wakeup.sleep_state <= acpi_target_sleep_state)) {
> > +		sxd[3] = 'W';
> 
> Looks ugly.  Why don't we call the array 'method_name' or something like this?
Will fix it.

Thanks,
Shaohua
