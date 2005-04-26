From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Re: Why do I have to set pci=noacpi for network card to work?
Date: Tue, 26 Apr 2005 14:03:27 -0500
Message-ID: <200504261403.27844.gkanis@cems.umn.edu>
References: <16A54BF5D6E14E4D916CE26C9AD3057501C8AD2D@pdsmsx402.ccr.corp.intel.com> <200504261132.25783.gkanis@cems.umn.edu> <200504261223.31963.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504261223.31963.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Looks to me like your _PRT references LNKA, which should
> appear in the namespace.  But apparently it doesn't.
>
> That's a bug in your firmware.  Are any BIOS upgrades available?

Unfortunately, not :(
>
> You could disassemble your DSDT to explore this further.
> In short, "cp /proc/acpi/dsdt dsdt; iasl -d dsdt;
> cat dsdt.dsl".
>
> You can get iasl here:
>     http://www.intel.com/technology/IAPC/acpi/downloads.htm

I followed the instructions found at this link  
http://forums.gentoo.org/viewtopic-t-122145-highlight-dsdt.html

and when I compiled the dsdt.dsl file I got the following errros/warning

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050309 [Apr 26 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   205:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

dsdt.dsl  1664:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1672:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1680:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1688:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1696:                             \_SB.PCI0.LPCB.LNKB,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKB)

dsdt.dsl  1704:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1712:                             \_SB.PCI0.LPCB.LNKC,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKC)

dsdt.dsl  1720:                             \_SB.PCI0.LPCB.LNKD,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKD)

dsdt.dsl  1728:                             \_SB.PCI0.LPCB.LNKH,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKH)

dsdt.dsl  1736:                             \_SB.PCI0.LPCB.LNKH,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKH)

dsdt.dsl  1744:                             \_SB.PCI0.LPCB.LNKG,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKG)

dsdt.dsl  1752:                             \_SB.PCI0.LPCB.LNKG,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKG)

dsdt.dsl  1760:                             \_SB.PCI0.LPCB.LNKF,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKF)

dsdt.dsl  1768:                             \_SB.PCI0.LPCB.LNKE,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKE)

dsdt.dsl  1776:                             \_SB.PCI0.LPCB.LNKC,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKC)

dsdt.dsl  1784:                             \_SB.PCI0.LPCB.LNKD,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKD)

dsdt.dsl  1792:                             \_SB.PCI0.LPCB.LNKA,
Error    1022 -                         Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1864:                                 \_SB.PCI0.LPCB.LNKA,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  1872:                                 \_SB.PCI0.LPCB.LNKB,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKB)

dsdt.dsl  1880:                                 \_SB.PCI0.LPCB.LNKC,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKC)

dsdt.dsl  1888:                                 \_SB.PCI0.LPCB.LNKD,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKD)

dsdt.dsl  2756:                                 \_SB.PCI0.LPCB.LNKD,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKD)

dsdt.dsl  2764:                                 \_SB.PCI0.LPCB.LNKB,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKB)

dsdt.dsl  2772:                                 \_SB.PCI0.LPCB.LNKC,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKC)

dsdt.dsl  2780:                                 \_SB.PCI0.LPCB.LNKA,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKA)

dsdt.dsl  2788:                                 \_SB.PCI0.LPCB.LNKB,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKB)

dsdt.dsl  2796:                                 \_SB.PCI0.LPCB.LNKC,
Error    1022 -                             Object does not exist ^  
(\_SB.PCI0.LPCB.LNKC)

ASL Input:  dsdt.dsl - 7057 lines, 253513 bytes, 3592 keywords
Compilation complete. 27 Errors, 1 Warnings, 0 Remarks, 957 Optimizations

I know how to fix the warning, but what I am suppose to do with the errors?

Here are the lines 1660-1670 of the dsdi.dsl file

         Return (Package (0x11)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            0x00, 
                            \_SB.PCI0.LPCB.LNKA, 
                            0x00
                        }, 

How serious this problem is? Could this be the reason for the need to use the 
command acpi=noirq?

Thank you,
Vasilis


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
