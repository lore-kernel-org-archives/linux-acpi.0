From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] acpi choose sleep state help
Date: Wed, 20 Jun 2007 00:00:27 +0200
Message-ID: <200706200000.29050.rjw@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706191352.16913.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43915 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbXFSV76 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 17:59:58 -0400
In-Reply-To: <200706191352.16913.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>

On Tuesday, 19 June 2007 13:52, Rafael J. Wysocki wrote:
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

The patch has been moved to

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc5/patches/34-ACPI-remove-S1-workaround-from-hibernation-code-path.patch

Sorry for the inconvenience.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
