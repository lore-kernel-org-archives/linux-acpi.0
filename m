From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Discussion: ACPI selective IRQ blacklist
Date: Wed, 3 Sep 2003 23:16:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309032316.11076.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, I've been looking into this VIA ACPI issue some more. From various 
reports, if you disable ACPI, the standard linux PCI IRQ routing system is 
able to correctly set up the board.

Some VIA motherboards DO work correctly in ACPI APIC mode however. These 
boards have the APIC IRQ settings hardwired (i.e. they do not use link 
devices).

The problem comes when the BIOS does use link devices. These will work fine in 
PIC mode. However, in APIC mode, the AML code is wrong in several respects in 
lots of BIOSes:

1) The _SRS method can only cope with IRQs <= 15, yet the BIOS returns IRQs > 
15 in the _PRS method. 

2) The _CRS method is hardcoded to return 0 ALWAYS for link devices in APIC 
mode.

The above means we cannot use the AML code for setting APIC IRQ devices on 
many VIA motherboards.

My new patch (acpi-picmode) should mean the boards are functional... just that 
they do not take advantage of any APIC/IO-APIC present.

I looked into trying to fall back to the non-ACPI PCI IRQ routing code. Its 
not really feasible: ACPI does an awful lot of setup before setting up the 
link devices, which it is not really possible to undo without lots of pain.

My suggestion is I expand the current ACPI blacklist to have a field 
specifying whether ACPI PCI routing can be relied upon. 

Using the current blacklisting (which disables ACPI completely) on masses of 
VIA motherboards is not really an option IMO.

So:
If a motherboard is dodgy and IS in the bad-routing-blacklist, ACPI will not 
be used for PCI routing.

If a motherboard is dodgy and is NOT in the bad-routing-blacklist, the 
fallback to picmode code should catch it. If the user then wants APIC with 
ACPI, they report the issue and the board is added to the 
bad-routing-blacklist.

What do people think? This is the best solution I can come up for this problem 
that would not involve a large messy error-prone change.


I'm gonna start implementing this.. but I'd appreciate feedback on this idea.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
