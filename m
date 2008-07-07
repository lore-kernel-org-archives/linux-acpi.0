From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Mon, 7 Jul 2008 22:17:23 +0200
Message-ID: <200807072217.24590.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <200807070319.29470.rjw@sisk.pl> <Pine.LNX.4.55.0807072054310.20615@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34596 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755513AbYGGUPj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2008 16:15:39 -0400
In-Reply-To: <Pine.LNX.4.55.0807072054310.20615@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>

On Monday, 7 of July 2008, Maciej W. Rozycki wrote:
> On Mon, 7 Jul 2008, Rafael J. Wysocki wrote:
> 
> > @@ -1714,12 +1721,14 @@ static inline void __init check_timer(vo
> >  		apic2 = apic1;
> >  	}
> >  
> > -	replace_pin_at_irq(0, 0, 0, apic1, pin1);
> > -	apic1 = 0;
> > -	pin1 = 0;
> > -	setup_timer_IRQ0_pin(apic1, pin1, cfg->vector);
> > +	if (disable_irq0_through_ioapic) {
> > +		clear_IO_APIC_pin(apic1, pin1);
> > +	} else {
> > +		replace_pin_at_irq(0, 0, 0, apic1, pin1);
> > +		apic1 = 0;
> > +		pin1 = 0;
> > +		setup_timer_IRQ0_pin(apic1, pin1, cfg->vector);
> >  
> > -	if (pin1 != -1) {
> >  		/*
> >  		 * Ok, does IRQ0 through the IOAPIC work?
> >  		 */
> 
>  This is completely broken -- you cannot blindly assume IRQ0 is wired to
> the pin #0 of the I/O APIC #0.  You have to respect routing information
> provided by the system.
> 
>  Ingo, from the sequence above, I gather this code is currently in the 
> tree:
> 
> -	replace_pin_at_irq(0, 0, 0, apic1, pin1);
> -	apic1 = 0;
> -	pin1 = 0;
> 
> Please revert the change which introduced it.  While I recall posting a
> patch which added code like this, I clearly stated it was solely for
> diagnostics of Rafael's system and not to apply to any tree.

Shouldn't the setup_timer_IRQ0_pin(apic1, pin1, cfg->vector) be removed as
well?

Rafael
