From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: iasl
Date: Fri, 9 May 2003 10:55:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3C61@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> dsdt.dsl  1902:                 Field (PIUC, DWordAcc, Lock, Preserve)
> Error    1047 -                           ^ Access width is greater
than
> region size
>                  OperationRegion (PIUC, PCI_Config, 0x74, 0x01)


The problem is that the region is defined as 0x01 byte, and the field
specifies a minimum access width of Dword (4 bytes).


> -----Original Message-----
> From: sjb [mailto:ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org]
> Sent: Friday, May 09, 2003 10:56 AM
> To: Ducrot Bruno
> Cc: ACPI List
> Subject: Re: [ACPI] iasl
> 
> Ducrot Bruno wrote:
> 
> > It should be
> >
> > 	If(\_OSI("Windows 2001")) {
> >
> > and you may have to add:
> > extern (\_OSI)
> > (but I am not sure if it is OK with latest iasl).
> >
> > BTW, could you try 'iasl -d mydsdt' in order to disassemble your
DSDT,
> and
> > check if 'If (\_OSI ("Windows 2001"))' is correct ?
> 
> I did and it appears to produce better output than acpidump ...
> 
> It decompiled that "Windows 2001" line correctly as
> 
>                  If (\_OSI ("Windows 2001"))
>                  {
>                      Store (0x04, OSTP)
>                  }
> 
> I fixed the "AnyAcc" error, and now all I see is ..
> 
> ottaky@vaio:~/acpi> ./iasl -tc dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030424 [May  7
2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt.dsl  1902:                 Field (PIUC, DWordAcc, Lock, Preserve)
> Error    1047 -                           ^ Access width is greater
than
> region size
> 
> ASL Input:  dsdt.dsl - 3047 lines, 101035 bytes, 1552 keywords
> 
> The OperationRegion line reads ..
> 
>                  OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
> 
> Does that provide enough info?
> 
> Thanks for helping out BTW *8-)
> 
> sjb
> 
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise
solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
