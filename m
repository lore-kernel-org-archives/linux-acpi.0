From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch 2.6.21-git] pci_choose_state() works, does ACPI magic
Date: Mon, 14 May 2007 08:01:28 -0700
Message-ID: <200705140801.28416.david-b@pacbell.net>
References: <200705091222.29561.david-b@pacbell.net> <20070514093916.GA12074@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:37461 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754863AbXENRIb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2007 13:08:31 -0400
In-Reply-To: <20070514093916.GA12074@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Monday 14 May 2007, Pavel Machek wrote:
> > --- g26.orig/drivers/acpi/sleep/main.c	2007-05-09 08:57:37.000000000 -0700
> > +++ g26/drivers/acpi/sleep/main.c	2007-05-09 08:58:33.000000000 -0700
> > @@ -35,6 +35,20 @@ static u32 acpi_suspend_states[] = {
> >  
> >  static int init_8259A_after_S1;
> >  
> > +static u8 acpi_target_sleep_state = ACPI_STATE_S0;
> > +
> > +/**
> > + *	acpi_get_target_sleep_state - return target ACPI S-state
> > + *
> > + *	When used during suspend processing, this returns the target state
> > + *	such as ACPI_STATE_S3.  Otherwise it returns ACPI_STATE_S0.
> > + */
> > +int acpi_get_target_sleep_state(void)
> > +{
> > +	return acpi_target_sleep_state;
> > +}
> > +/* EXPORT_SYMBOL(acpi_get_target_sleep_state); ... if you need it */
> > +
> >  /**
> >   *	acpi_pm_prepare - Do preliminary suspend work.
> >   *	@pm_state:		suspend state we're entering.
> 
> This is quite an ugly hack, right? Is it really neccessary to use
> global variable for this?

It's not a global variable; observe the "static", and the way it
has an accessor.  It does expose global state however.

- Dave
