From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
	systems
Date: Mon, 7 Jul 2008 09:36:35 +0200
Message-ID: <20080707073635.GA22946@elte.hu>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <20080701202453.GD4896@elte.hu> <200807070102.38854.rjw@sisk.pl> <200807070319.29470.rjw@sisk.pl> <20080707071706.GA3326@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754449AbYGGHhL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080707071706.GA3326@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
List-Id: linux-acpi@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Please note two things:
> > (1) The whole acpi_dmi_table[] thing originally depended on __i386__, so it
> >     wouldn't work on x86-64 no matter what.  I removed that dependecy, but
> >     I have no idea why it was there and so I'm not sure if that's correct. 
> 
> > (2) The clear_IO_APIC_pin(apic1, pin1) done if 
> >     disable_irq0_through_ioapic is true is absolutely essential.  The 
> >     symptoms are 100% reproducible without it.
> 
> thanks, applied to tip/x86, to give this some more testing.

i know you havent submitted this for inclusion yet, but FYI it wont 
build on 32-bit with a config like:

 http://redhat.com/~mingo/misc/config-Mon_Jul__7_09_22_45_CEST_2008.bad

	Ingo
