From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test4 - lost ACPI
Date: Sat, 23 Aug 2003 18:31:43 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCCC@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Tomasz Torcz <zdzichu-YxaM2a6SwlU@public.gmane.org>
Cc: LKML <linux-kernel-IFdL7R2G4aWny3qCrzbmXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Tomasz,
I'm glad that 'acpi=force pci=noacpi' got your system up and running.


Andrew is right, needing acpi=force is intentional due to the age of the
system --
we're running away from aging broken BIOS's that vendors
refuse to update, and we need to draw the line someplace.
Some say that the 2001 should really be 2002...

But, needing pci=noacpi if you successfully ran with ACPI enabled before
would be a regression.

Thanks for sending the acpidmp output.
The DSDT shows Award's "VT86" PIRQ mapping code that we've been
struggling with recently.
Indeed, the lastest ACPI patch seems to help the modern descendents of
your machine.
But I don't see any obvious errors in the AML for the interrupt part on
your box.

Using IASL to re-build your disassembled DSDT showed some static errors
that will kill you if you hit them them at run time.  If you really want
to use ACPI for run-time features on this box you'd probably need to
modify your DSDT and over-ride it for starters.  There are a number of
web pages devoted to that hobby.

I'm more interested in the interrupt issue.  If you'd like to help us
debug it, then please file a bug at http://bugzilla.kernel.org/
Category: power management, componenet: ACPI and attach your dmidecode
and acpidmp output.  The next piece to get would be the console messages
from the failing case -- you'd need a serial console to capture them.

Thanks,
-Len

lenb@dhcppc4:/smb/tomasz.torcz> acpixtract DSDT acpidmp >DSDT
lenb@dhcppc4:/smb/tomasz.torcz> iasl -d DSDT

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

Loading Acpi table from file DSDT
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
........................................................................
...........................................................
Parsing completed
Disassembly completed, written to "DSDT.dsl"
lenb@dhcppc4:/smb/tomasz.torcz>
lenb@dhcppc4:/smb/tomasz.torcz> ls
DSDT  DSDT.dsl  acpidisasm  acpidmp  dmesg.pcinoacpi.acpioff  dsdt
lenb@dhcppc4:/smb/tomasz.torcz> iasl DSDT.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

DSDT.dsl   257:     Method (\_WAK, 1, NotSerialized)
Warning  2026 -                 ^ Reserved method must return a value
(_WAK)

DSDT.dsl   269:             Store (Local0, Local0)
Error    1013 -                         ^ Method local variable is not
initialized (Local0)

DSDT.dsl   277:             Store (Local0, Local0)
Error    1013 -                         ^ Method local variable is not
initialized (Local0)

DSDT.dsl  1761:                         Store (Local0, Local0)
Error    1013 -                                     ^ Method local
variable is not initialized (Local0)

DSDT.dsl  1995:                     Method (_STA, 0, NotSerialized)
Warning  2019 -                                ^ Not all control paths
return a value (_STA)

DSDT.dsl  1995:                     Method (_STA, 0, NotSerialized)
Warning  2026 -                                ^ Reserved method must
return a value (_STA)

ASL Input:  DSDT.dsl - 2203 lines, 75934 bytes, 987 keywords
Compilation complete. 3 Errors, 3 Warnings, 0 Remarks, 235 Optimizations
lenb@dhcppc4:/smb/tomasz.torcz>

> -----Original Message-----
> From: Tomasz Torcz [mailto:zdzichu-YxaM2a6SwlU@public.gmane.org] 
> Sent: Saturday, August 23, 2003 5:38 PM
> To: Brown, Len
> Subject: Re: 2.6.0-test4 - lost ACPI
> 
> 
> On Sat, Aug 23, 2003 at 04:58:00PM -0400, Brown, Len wrote:
> > pci=noacpi is also an option.  If it works, then it means 
> you got burnt
> > by ACPI's PCI interrupt code. 
> 
> Good shot! With 'acpi=force pci=noacpi' it booted ok and works.
> I've attached dmesg FYI.
> 
> > We've had trouble with Award/VIA in this
> > area recently, so it wouldn't be surprising to have trouble with a
> > 3-year old Award/VIA BIOS.  The puzzling thing is why ACPI enabled
> > worked for you before and doesn't work now.
> 
> I can test patches. Unfortunetely I'm not good enough programmer to 
> create them.
>  
> > I'd be interested in looking over a copy of your /proc/acpi/dsdt, or
> > even better, the output from acpidmp,
> 
> Attached (gzipped)
> 
> -- 
> Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
> zdzichu-X3HQ1c18OqI0iLA60pu2Z2ZHpeb/A1Y/@public.gmane.org     Your routes will be 
> aggreggated. -- Alex Yuriev
> 
