From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: Tarting up my ACER 1703 ACPI spec
Date: Fri, 9 Jan 2004 15:40:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040109154007.7c6e4abc.greg@morningdave.org>
References: <1073487455.3051.17.camel@dirkl.int.tobit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1073487455.3051.17.camel-TZn3W1BCDhcZRZVKWRWvQyp2UmYkHbXO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dirk Koopman <djk-ovDUel0N34n10XsdtD+oqA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Dirk,

   I found a couple of HOWTOs about this. They are:

http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt
http://home.fhtw-berlin.de/~s0502837/r31/

   They suggest that the solution to both of your warnings is to add the following line at the end of the offending methods:

   Return(Package(0x02){0x00, 0x00})

   I can confirm that adding that line to my _WAK method did indeed get rid of the Warning on recompile. I don't know why that is the proper statement, which makes me a little uneasy, so if anyone could explain that (or point me to something that does), I'd appreciate it.

   Hope that helps.
   Greg


On Wed, 07 Jan 2004 14:57:36 +0000
Dirk Koopman <djk-ovDUel0N34n10XsdtD+oqA@public.gmane.org> wrote:

> I have an Acer 1703SC and I have had several months of no battery
> indication and megabytes of error messages. Having finally discovered
> how to fiddle with the various tools, I have fixed this. Does nobody
> test their DSDTs before they stick them in? 
> 
> Anyway, before I submit it I would like to get the rest of the warnings
> out and then write a little paper on what I did.
> 
> I enclose the various bits of info as attachments. 
> 
> My original problem seems to have been caused by the battery code
> calling Method Z009 which (by a process of deduction) must have been
> renamed Z00A. Viz:
> 
> "Jan  6 04:02:38 dhcppc0 kernel: search_node c1b2ea00 start_node c1b2ea00 return_node 00000000
> Jan  6 04:02:38 dhcppc0 kernel:     ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
> Jan  6 04:02:38 dhcppc0 kernel:     ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c1b2eac0), AE_NOT_FOUND
> Jan  6 04:02:38 dhcppc0 kernel:     ACPI-0352: *** Error: Looking up [Z009] in namespace, AE_NOT_FOUND"
> 
> That is now fixed. However, when compiling the DSDT I get these warnings:-
> 
> [root-0jNJT1+6+ws@public.gmane.org iasl-linux-20030918]# iasl dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt.dsl   816:                     Method (DRUL, 1, NotSerialized)
> Warning  2019 -                                ^ Not all control paths return a value (DRUL)
> 
> dsdt.dsl  3577:             Method (Z00A, 0, NotSerialized)
> Warning  2019 -                        ^ Not all control paths return a value (Z00A)
> 
> dsdt.dsl  3701:     Method (_WAK, 1, NotSerialized)
> Warning  2026 -                ^ Reserved method must return a value (_WAK)
> 
> ASL Input:  dsdt.dsl - 3766 lines, 136715 bytes, 1973 keywords
> AML Output: DSDT.aml - 15831 bytes 485 named objects 1488 executable opcodes
> 
> Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 645 Optimizations
> 
> Also in the dmesg I have:-
> 
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKA._CRS] (Node c1
> b33ee0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3)
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKC._CRS] (Node c1
> b322c0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKD._CRS] (Node c1
> b323c0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKD] (IRQs 10)
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKE._CRS] (Node c1
> b324c0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKE] (IRQs 10)
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKF._CRS] (Node c1
> b325c0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKF] (IRQs 10)
>     ACPI-0145: *** Error: Return object type is incorrect [\_SB_.PCI0.LPCB.LNKG._CRS] (Node c1
> b326c0), AE_TYPE
> ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 10)
> ACPI: Embedded Controller [EC0] (gpe 25)
> 
> At least on initial boot up before I make the replacement of the DSDT
> using the initrd patch (included in Mandrake 9.2).
> 
> Firstly: is this anything to worry about?
> Secondly: before I try to work out what is going on, can anyone that
> knows what they are doing look at it a fix it quicker, else give me some
> pointers?
> 
> Ta
> 
> Dirk 
> 




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
