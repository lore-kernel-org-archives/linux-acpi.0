From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: Re: Acpica problem?
Date: Mon, 30 Jun 2003 14:16:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306301416.08433.hrvoje.habjanic@zg.htnet.hr>
References: <Pine.LNX.4.33.0306301311190.1064-100000@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306301311190.1064-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


It seems that osunixxf.c is missing something?

<quote>
ACPI_STATUS
AcpiOsGetRootPointer (
    UINT32                  Flags,
    ACPI_POINTER           *Address)
{

    return (AE_OK);
}
</quote>


[root@xxx compiler]# gdb ./iasl   
GNU gdb Red Hat Linux (5.3post-0.20021129.18rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...
(gdb) set args -g
(gdb) run
Starting program: /tmp/acpi/acpica-unix-20030619/compiler/iasl -g

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b


Program received signal SIGSEGV, Segmentation fault.
0x0806dee5 in AdGetLocalTables (Filename=0x0, GetAllTables=1 '\001') at ../common/adisasm.c:877
877             if (!ACPI_STRNCMP (NewTable->Signature, "RSDT", 4))
(gdb) backtrace
#0  0x0806dee5 in AdGetLocalTables (Filename=0x0, GetAllTables=1 '\001') at ../common/adisasm.c:877
#1  0x0806d9fa in AdAmlDisassemble (OutToFile=1 '\001', Filename=0x0, Prefix=0x0, OutFilename=0x80a0f14, 
    GetAllTables=0 '\0') at ../common/adisasm.c:492
#2  0x0805295a in main (argc=2, argv=0xbfffe174) at aslmain.c:735
#3  0x4003e5cd in __libc_start_main () from /lib/libc.so.6


On Monday 30 June 2003 13:11, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Salut Hrvoje,
>
> On Mon, 30 Jun 2003, Hrvoje Habjanic wrote:
> > [root@xxx acpi]# ./acpica-unix-20030619/compiler/iasl -g
> >
> > Intel ACPI Component Architecture
> > ASL Optimizing Compiler / AML Disassembler version 20030619 [Jun 30 2003]
> > Copyright (C) 2000 - 2003 Intel Corporation
> > Supports ACPI Specification Revision 2.0b
> >
> > Core dump
> >
> > I'm dooing something wrong?
>
> Did you build it from source?
>
> cheers
>   hartwig felger
>
> Hartwig Felger informatics
>
> - --
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>
> iD8DBQE/ABsD9bBoTzOf1pMRAsgWAJ40y8pmLoTgrpn+H+wrN0Szr4M2qQCgzTVL
> t3yWu5IzYV+sixQuDzWMM6g=
> =xK2h
> -----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
