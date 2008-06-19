From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Thu, 19 Jun 2008 11:35:41 +0200
Message-ID: <20080619093541.GC15228@elte.hu>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806180053.40044.rjw@sisk.pl> <Pine.LNX.4.55.0806180400070.28110@cliff.in.clinika.pl> <200806190011.38548.rjw@sisk.pl> <Pine.LNX.4.55.0806182345380.7802@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0806182345380.7802@cliff.in.clinika.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Maciej W. Rozycki <macro@linux-mips.org> wrote:

> --- a/arch/x86/kernel/io_apic_64.c	2008-06-18 22:53:34.000000000 +0000
> +++ b/arch/x86/kernel/io_apic_64.c	2008-06-18 22:58:45.000000000 +0000
> @@ -1714,6 +1714,7 @@ static inline void __init check_timer(vo
>  		/* replace_pin_at_irq(0, apic1, pin1, apic2, pin2); */
>  		setup_timer_IRQ0_pin(apic2, pin2, cfg->vector);
>  		unmask_IO_APIC_irq(0);
> +		clear_IO_APIC_pin(apic2, pin2);
>  		enable_8259A_irq(0);
>  		if (timer_irq_works()) {
>  			apic_printk(APIC_VERBOSE," works.\n");

would it be fine with you if we applied this to tip/x86, as it unbreaks 
Rafael's box?

does PIT programming matter? One detail which might matter and which 
touches IRQ0 generation is the clockevent driver on nohz/highres. See 
arch/x86/kernel/i8253.c:init_pit_timer():

        case CLOCK_EVT_MODE_SHUTDOWN:
        case CLOCK_EVT_MODE_UNUSED:
                if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
                    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
                        outb_pit(0x30, PIT_MODE);
                        outb_pit(0, PIT_CH0);
                        outb_pit(0, PIT_CH0);
                }
                pit_disable_clocksource();
                break;

        case CLOCK_EVT_MODE_ONESHOT:
                /* One shot setup */
                pit_disable_clocksource();
                outb_pit(0x38, PIT_MODE);
                break;

	Ingo
