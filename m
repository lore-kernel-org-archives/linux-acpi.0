From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
 systems
Date: Mon, 7 Jul 2008 20:59:47 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807072054310.20615@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl>
 <20080701202453.GD4896@elte.hu> <200807070102.38854.rjw@sisk.pl>
 <200807070319.29470.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200807070319.29470.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 7 Jul 2008, Rafael J. Wysocki wrote:

> @@ -1714,12 +1721,14 @@ static inline void __init check_timer(vo
>  		apic2 = apic1;
>  	}
>  
> -	replace_pin_at_irq(0, 0, 0, apic1, pin1);
> -	apic1 = 0;
> -	pin1 = 0;
> -	setup_timer_IRQ0_pin(apic1, pin1, cfg->vector);
> +	if (disable_irq0_through_ioapic) {
> +		clear_IO_APIC_pin(apic1, pin1);
> +	} else {
> +		replace_pin_at_irq(0, 0, 0, apic1, pin1);
> +		apic1 = 0;
> +		pin1 = 0;
> +		setup_timer_IRQ0_pin(apic1, pin1, cfg->vector);
>  
> -	if (pin1 != -1) {
>  		/*
>  		 * Ok, does IRQ0 through the IOAPIC work?
>  		 */

 This is completely broken -- you cannot blindly assume IRQ0 is wired to
the pin #0 of the I/O APIC #0.  You have to respect routing information
provided by the system.

 Ingo, from the sequence above, I gather this code is currently in the 
tree:

-	replace_pin_at_irq(0, 0, 0, apic1, pin1);
-	apic1 = 0;
-	pin1 = 0;

Please revert the change which introduced it.  While I recall posting a
patch which added code like this, I clearly stated it was solely for
diagnostics of Rafael's system and not to apply to any tree.

  Maciej
