From: Dave Bauer <dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Subject: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Mon, 02 Feb 2004 21:12:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401F0395.1090407@thedesignexperience.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

My ACPI stopped working when I added an additional 256mb RAM to my vpr 
Matricx 174b4 laptop. It has 256mb already, I added 256mb to make it 
512mb and I got a bunch of AE_NO_MEMORY errors in the ACPI code.

I took the extra RAM out, and the ACPI support works.

I am using kernel 2.6.1 with acpi patches. I had the same problem on 
2.6.0. On 2.4.20 with acpi patches the machine would not even boot with 
the extra memory.

I have a custom DSDT file that I fixed errors in. When it was working on 
2.4.20 It looked like all the ACPI features were active and functional.

Any ideas on what to look for?

Here is a sample of the boot log:

Feb  2 20:35:54 einstein kernel: ACPI: Subsystem revision 20040116
Feb  2 20:35:54 einstein kernel:    tbget-0291: *** Info: Table [DSDT] 
replaced by host OS
Feb  2 20:35:54 einstein kernel:  tbxface-0117 [03] 
acpi_load_tables      : ACPI Tables successfully acquired
Feb  2 20:35:54 einstein kernel: Parsing all Control 
Methods:..........................................................................................................................................................................
Feb  2 20:35:54 einstein kernel: Table [DSDT](id F005) - 554 Objects 
with 49 Devices 170 Methods 17 Regions
Feb  2 20:35:54 einstein kernel: Parsing all Control Methods:
Feb  2 20:35:54 einstein kernel: Table [SSDT](id F003) - 3 Objects with 
0 Devices 0 Methods 0 Regions
Feb  2 20:35:54 einstein kernel: ACPI Namespace successfully loaded at 
root c039ba9c
Feb  2 20:35:54 einstein kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Feb  2 20:35:54 einstein kernel: evxfevnt-0093 [04] 
acpi_enable           : Transition to ACPI mode successful
Feb  2 20:35:54 einstein kernel: evgpeblk-0747 [06] 
ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000001028 
on int 9
Feb  2 20:35:54 einstein kernel: evgpeblk-0747 [06] 
ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000102C 
on int 9
Feb  2 20:35:54 einstein kernel: Completing Region/Field/Buffer/Package 
initialization:.............................................................
Feb  2 20:35:54 einstein kernel: Initialized 17/17 Regions 0/0 Fields 
24/24 Buffers 20/20 Packages (565 nodes)
Feb  2 20:35:54 einstein kernel: Executing all Device _STA and_INI 
methods:....exregion-0164 [25] ex_system_memory_space: Could not map 
memory at 000000000FF7FDBD, size 190
Feb  2 20:35:54 einstein kernel: evregion-0347: *** Error: Handler for 
[SystemMemory] returned AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.PHS1] (Node c15d9428), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.BAT1._STA] (Node c15d8328), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:   uteval-0098: *** Error: Method 
execution failed [\_SB_.BAT1._STA] (Node c15d8328), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel: ....exregion-0164 [23] 
ex_system_memory_space: Could not map memory at 000000000FF7FD9D, size 20
Feb  2 20:35:54 einstein kernel: evregion-0347: *** Error: Handler for 
[SystemMemory] returned AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution fail:
Feb  2 20:35:54 einstein kernel:   nsinit-0408 [06] 
ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel: ...........................................
Feb  2 20:35:54 einstein kernel: 51 Devices found containing: 50 _STA, 1 
_INI methods
Feb  2 20:35:54 einstein kernel: ACPI: Interpreter enabled
Feb  2 20:35:54 einstein kernel: ACPI: Using PIC for interrupt routing
Feb  2 20:35:54 einstein kernel: exregion-0164 [23] 
ex_system_memory_space: Could not map memory at 000000000FF7FDBD, size 190
Feb  2 20:35:54 einstein kernel: evregion-0347: *** Error: Handler for 
[SystemMemory] returned AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.PHS1] (Node c15d9428), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.BAT1._STA] (Node c15d8328), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb  2 20:35:54 einstein kernel: PCI: Probing PCI hardware (bus 00)
Feb  2 20:35:54 einstein kernel: Transparent bridge - 0000:00:1e.0
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.AGPB._PRT]
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.PCIB._PRT]
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 
10 *11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 
*10 11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 
*10 11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 
10 *11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 
*10 11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 
10 11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 
10 11)
Feb  2 20:35:54 einstein kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 
10 11)
Feb  2 20:35:54 einstein kernel: ACPI: Embedded Controller [H_EC] (gpe 24)
Feb  2 20:35:54 einstein kernel: exregion-0164 [38] 
ex_system_memory_space: Could not map memory at 000000000FF7FDBD, size 190
Feb  2 20:35:54 einstein kernel: evregion-0347: *** Error: Handler for 
[SystemMemory] returned AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.PHS1] (Node c15d9428), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel:  psparse-1120: *** Error: Method 
execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node c15cf9a8), AE_NO_MEMORY
Feb  2 20:35:54 einstein kernel: ACPI: Power Resource [PFAN] (on)
Feb  2 20:35:54 einstein kernel: PCI: Probing PCI hardware

Thanks
Dave



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
