From: "CHP.Dekker" <chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org>
Subject: Re: VIA KT333 acpi DSDT bug
Date: Fri, 6 Feb 2004 13:59:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402061359.47026.chp.dekker@hsdrenthe.nl>
References: <3ACA40606221794F80A5670F0AF15F8401CBB66C@PDSMSX403.ccr.corp.intel.com> <200402031758.03901.chp.dekker@hsdrenthe.nl> <20040204095737.GG882@poupinou.org>
Reply-To: chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040204095737.GG882-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I didn't see this before (because fglrx act's like a semafore error generator 
for last 10 weeks) but it looks like my computer doesn't resolve 
\_SB.PCI0.SBRG.EC0.

This is what I found

ACPI: Subsystem revision 20031203
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.SBRG.EC0_] in namespace, 
AE_NOT_FOUND
search_node dff55c40 start_node dff55c40 return_node 00000000
    ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.SBRG.EC0_] in namespace, 
AE_NOT_FOUND
search_node dff55b40 start_node dff55b40 return_node 00000000
    ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
ACPI: Interpreter enabled

If any one cares then this is the rest of acpi stuff dmesg gives me

 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)

ACPI: RSDP (v000 AMI                                       ) @ 0x000fa980
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 INTL 0x02002024) @ 0x00000000

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255

ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using IRQ 255
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)


On Wednesday 04 February 2004 10:57, Bruno Ducrot wrote:
> On Tue, Feb 03, 2004 at 05:58:03PM +0100, CHP.Dekker wrote:
> > I couldn't help but to see that the source file is incomplete, I don't
> > know how it can be because I send the whole thing, if some one is willing
> > to fix my DSDT file than please mail me so that I can send it.
> >
> > On Tuesday 03 February 2004 08:24, Yu, Luming wrote:
> > > > I use a VIA KT333 motherboard.
> > > >
> > > > It hase some bugs in the DSDT file and I don't know how to fix them.
> > > > Once when I had xp installed on it (2 days long ;) I had S0
> > > > t/m S5 (Ofcourse
> > > > not called that way by M$cro)
> > > > No ACPI (sleep) say I only have S0 S3 S4 S5
> > > > Some time none of them work becuase "one process didn't stop"
> > > > But now it "at
> > > > least I can "use S3", all that it does is putting my computer
> > > > in 1/10000 sec
> > > > to sleep (S3) mode and can be re-awakend. The lid switch
> > > > doesn't do any
> > > > thing.
> > >
> > > Do you have any hints to let us know this kind of symptom is due
> > > to DSDT bug?
> >
> > Well the thing is compile by the micros..  compiler and it has 2 error's
> >
> >                     Name (_PCL, Package (0x01)
> >                     {
> >                         \_SB.PCI0.SBRG.EC0
> >                     })
> > It says that I doesn't know the object EC0 from the line
> > \_SB.PCI0.SBRG.EC0 The 2nd error (identical I think)
> >
> >                     Name (_PCL, Package (0x01)
> >                     {
> >                         \_SB.PCI0.SBRG.EC0
> >                     })
>
> There is good luck then that the EC0 is implemented in a SSDT table,
> not in the DSDT table.
>
> Note that system sleep states are still developpement stuff (even
> though that seems to be more and more stable), so your problem may be
> not related to DSDT.  Speaking for myself, I don't care yet for bug reports
> about hacking DSDT in order to get Sx states transition support.
>
> > and 1 warning saying that a function doesn't return something every time.
>
> Sometimes iasl report 'false positive' for that, but sometime this
> may be a real problem.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
