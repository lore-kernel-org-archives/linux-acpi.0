From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: 07 Jan 2003 14:28:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <871y3p6qd7.fsf@lapper.ihatent.com>
References: <200210081115.21667.mark.pritchard-acpi@modus.com.au>
	<20030102113459.GA2974@zaurus> <87hecqiryo.fsf@lapper.ihatent.com>
	<200301031111.21645.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200301031111.21645.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What messages do you get during bootup, I get these ones with the
somewhat working DSDT:

.
.
.
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
    ACPI-0274: *** Info: Table [DSDT] replaced by host OS
    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for C03C, AE_ALREADY_EXISTS
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [C03C] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
ACPI: Embedded Controller [C0D0] (gpe 29)
schedule_task(): keventd has not started
ACPI: Power Resource [C141] (off)
ACPI: Power Resource [C155] (off)
ACPI: Power Resource [C159] (off)
.
.
.

The errors from the ACPI subsystem, and a schduling problem towards
the bottom there.

mvh,
A

Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org> writes:

> Alexander
> 
> On my 800c running 2.4.19 SUSE 8.1 with 0918 patch and my modified DSDT I get 
> the following:
> 
> present:                 yes
> design capacity:         4114 mAh
> last full capacity:      4114 mAh
> battery technology:      rechargeable
> design voltage:          14800 mV
> design capacity warning: 411 mAh
> design capacity low:     0 mAh
> capacity granularity 1:  100 mAh
> capacity granularity 2:  100 mAh
> model number:            Primary
> serial number:           3
> battery type:            4E4F494C
> OEM info:                 COMPAQ
> 
> with AC plugged in a full battery
> 
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            0 mA
> remaining capacity:      4114 mAh
> present voltage:         16633 mV
> 
> with AC removed and a near full battery
> 
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            1105 mA
> remaining capacity:      4074 mAh
> present voltage:         16227 mV
> 
> I get 3+ hours out of a full battery.
> 
> I use my laptop similar to you as a portable desk machine, ie it spends most 
> of its time plugged into AC.
> 
> I also have klaptopdaemon working, edited the current acpi proc tree into 
> portable.cpp in the source.
> 
> I have not gone down the 2.4.20 route, but will have to shortly as I need the 
> updated usb support.  I was waiting until it appeared stable, but I guess i 
> will have to bit the bullet and try it.  Since working through the various 
> issues a while back I have a stable acpi install.  About the only area I 
> don't have working is the speedstep switching from P0 to P1; it always 
> reports P0.
> 
> I concur, beefy is a good description, but a lot less weight than a number of 
> the alternatives, and you forgot the 1600x1200 screen - very nice;)
> 
> Hope this helps
> 
> Bob
> 
> On Friday 03 January 2003 07:59, Alexander Hoogerhuis wrote:
> > Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
> > > Hi!
> > >
> > > > present:                 yes
> > > > design capacity:         1918 mAh
> > > > last full capacity:      1918 mAh
> > > > battery technology:      rechargeable
> > > > design voltage:          14800 mV
> > > > design capacity warning: 192 mAh
> > >
> > > 2Ah seems quite low, but as you have 15V
> > > battery its 30Wh, which might be okay for
> > > *small* notebook.
> >
> > Evo n800c is not a *small* notebook, its a pretty beefy thing and the
> > biggest beast Compaq could conjure up this summer :) P4-1.7GHz, 768Mb
> > RAM and a 30Gb disk and a nice ATI Radeon 7500 to boot :)
> >
> > > > And it's been a long time since I've had much physics, but the design
> > > > capacity doesn't seem right to me. I'm able to run about 13-14 mins on
> > > > battery, before the machine dies, from a fully charged battery.
> > >
> > > Perhaps your battery is too old these days?
> >
> > Not even six months, and not many cycles as its used mainly as a
> > portable desktop.
> >
> > > --
> > > 				Pavel
> > > Written on sharp zaurus, because my Velo1 broke. If you have Velo you
> > > don't need...
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
