From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI & SMP still don't work together happily.
Date: Tue, 8 Oct 2002 14:00:23 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B82B@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Eli Stair' <eli.stair-+MseY0pMZYIAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The _PRT that is used in SMP mode is indeed bad.  Here's all of the bad
code:

DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA694", "AWRDACPI", 4096)
{
    ...
            Name (APIC, Package (0x20)
            {
                ...

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x00, 
                    0x00, 
                    \_SB.PCI0.LNKA
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x01, 
                    0x00, 
                    \_SB.PCI0.LNKB
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x02, 
                    0x00, 
                    \_SB.PCI0.LNKC
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    0x03, 
                    0x00, 
                    \_SB.PCI0.LNKD


In each case, the 4th element is a reference when it should be an integer.
I would venture a guess that the 3rd and 4th elements may have been
inadvertently swapped, but there's no way to tell for certain.

There are some other interesting compile errors that I am also looking at.

Bob


-----Original Message-----
From: Eli Stair [mailto:eli.stair-+MseY0pMZYIAvxtiuMwx3w@public.gmane.org] 
Sent: Tuesday, October 08, 2002 1:36 PM
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: Re: [ACPI] ACPI & SMP still don't work together happily.

Attached is a DMESG from the system booted with ACPI=OFF, a
serial console dump from the system with ACPI enabled, and
the DSDT dump from said system with ACPI disabled.  If there
is anything else I could provide or something I could test
I'd be happy to do so.

Cheers,

/eli


On Tue, 8 Oct 2002 08:04:14 -0700 
"Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> Please send us the raw DSDT and I will take a look at this error:
> 
> rscreate-0307 [10] Rs_create_pci_routing_: Need Integer, found Reference
>  pci_irq-0207 [07] acpi_pci_irq_add_prt  : Error evaluating _PRT
> [AE_BAD_DATA]
> 
...


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
