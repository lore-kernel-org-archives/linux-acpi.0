From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI error during boot - does it need fixing ?
Date: Mon, 21 Dec 2009 15:48:50 +0800
Message-ID: <1261381730.12263.14.camel@rzhang1-desktop>
References: <20091220070223.GA8334@tangens.sinus.cz>
	 <1261357849.27291.276.camel@rzhang1-desktop>
	 <20091221041119.GA27565@tangens.sinus.cz>
	 <1261373160.12263.0.camel@rzhang1-desktop>
	 <20091221060430.GA2839@tangens.sinus.cz>
	 <1261381508.12263.11.camel@rzhang1-desktop>
	 <1261381642.12263.13.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27354 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbZLUHpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 02:45:20 -0500
In-Reply-To: <1261381642.12263.13.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-12-21 at 15:47 +0800, Zhang Rui wrote:
> On Mon, 2009-12-21 at 15:45 +0800, Zhang Rui wrote:
> > On Mon, 2009-12-21 at 14:04 +0800, Pavel Troller wrote:
> > > > On Mon, 2009-12-21 at 12:11 +0800, Pavel Troller wrote:
> > > > > > On Sun, 2009-12-20 at 15:02 +0800, Pavel Troller wrote:
> > > > > > > Hi!
> > > > > > >   On my new system with Gigabyte G41M-ES2H mobo and Intel Core Quad Q8300 CPU,
> > > > > > > there are the following errors reported on boot:
> > > > > > > 
> > > > > > > ACPI: SSDT 00000000cdcedb10 0022A (v01  PmRef  Cpu0Ist 00003000 INTL 20040311)
> > > > > > > Marking TSC unstable due to TSC halts in idle
> > > > > > > Switching to clocksource hpet
> > > > > > > processor LNXCPU:00: registered as cooling_device0
> > > > > > > ACPI: SSDT 00000000cdcedfd0 00152 (v01  PmRef  Cpu1Ist 00003000 INTL 20040311)
> > > > > > > ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff88012f815a00), AE_ALREADY_EXISTS
> > > > > > > ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
> > > > > > > processor LNXCPU:01: registered as cooling_device1
> > > > > > > ACPI: SSDT 00000000cdcee130 00152 (v01  PmRef  Cpu2Ist 00003000 INTL 20040311)
> > > > > > > ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff88012f815a80), AE_ALREADY_EXISTS
> > > > > > > ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
> > > > > > > processor LNXCPU:02: registered as cooling_device2
> > > > > > > ACPI: SSDT 00000000cdcee290 00152 (v01  PmRef  Cpu3Ist 00003000 INTL 20040311)
> > > > > > > ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU3._PDC] (Node ffff88012f815b00), AE_ALREADY_EXISTS
> > > > > > > ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
> > > > > > > processor LNXCPU:03: registered as cooling_device3
> > > > > > > 
> > > > > > >   Is this error just cosmetic, or is it worth fixing ? There is no BIOS update
> > > > > > > for this motherboard yet. Are the SSDT tables replaceable the same way as DSDT
> > > > > > > is ? 
> > > > > > > 
> > > > > > please attach the acpidump output.
> > > > > > please run "acpidump --addr 0xcdcedb10 --length 0x22a > ssdt1.dat"
> > > > > > "acpidump --addr 0xcdcedfd0 --length 0x152 > ssdt2.dat" "acpidump --addr
> > > > > > 0xcdcee130 --length -x--152 > ssdt3.dat" "acpidump --addr 0xcdcee290
> > > > > > --length -x152 > ssdt4.dat" and attach the ssdt*.dat files here.
> > > > > > 
> > > > > > thanks
> > > > > > rui.
> > > > > 
> > > > > Hi Rui,
> > > > >   the tables are here. Thank your for your reply!
> > > > 
> > > > you need to run "acpidump > acpidump.dat" and attach the acpidump.dat as
> > > > well. :)
> > > > 
> > > > thanks,
> > > > rui
> > > 
> > > Oh, sorry, I forgot this one.
> > >   Here it is.
> > 
> > please attach these tables as well,
> > "acpidump --addr 0xCDCEE580 --length 0x0000018A >cpu1cst.dat"
> > "acpidump --addr 0xCDCEE580 --length 0x0000018A >cpu1cst.dat"
> > "acpidump --addr 0xCDCEE580 --length 0x0000018A >cpu1cst.dat"
> > 
> Sorry, I mean
> "acpidump --addr 0xCDCEE3F0 --length 0x0000018A >cpu1cst.dat"
it should be
"acpidump --addr 0xCDCEE3F0 --length 0x0000018A >cpu0cst.dat"

> "acpidump --addr 0xCDCEE580 --length 0x0000018A >cpu1cst.dat"
> "acpidump --addr 0xCDCEE710 --length 0x0000018A >cpu2cst.dat"
> "acpidump --addr 0xCDCEE8A0 --length 0x0000018A >cpu3cst.dat"
> 
> thanks,
> rui
> > 
> > >      Pavel
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


