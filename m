From: Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 08:28:32 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D8B1470.5020507@optonline.net>
Reply-To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_CpfoAL1P/j0slfoWt9PEiA)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_CpfoAL1P/j0slfoWt9PEiA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

kernel: 2.4.20-pre7, with patch acpi20020918, configured with ACPI
platform: intel server SRMK2S with AMIBIOS and dual 1GHz PIII/256k 
cache, 1GB memory, adaptec 7899 SCSI

DOES NOT BOOT

Even after some patching of the DSDT, I get this:

ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
    ACPI-0273: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LN00] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN01] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN02] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN03] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN04] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN05] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN06] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN07] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN08] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN09] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN10] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN11] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN12] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN13] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN14] enabled at IRQ 0
ACPI: PCI Interrupt Link [LN15] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
PCI: No IRQ known for interrupt pin A of device 00:0f.2 - using IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'


The interrupt assignment seems to be out of whack, the SCSI disks cannot 
be accessed, and the kernel panics.


Next, I pass  pci=noacpi to the kernel, with the following result:

ACPI: Subsystem revision 20020918
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
    ACPI-0273: *** Info: Table [DSDT] replaced by host OS
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Link [LN00] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN01] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN02] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN03] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN04] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN05] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN06] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN07] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN08] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN09] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN10] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN11] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN12] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN13] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN14] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LN15] (IRQs 3 4 5 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNUS] (IRQs 10, disabled)
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 1!


With pic=noacpi it finally boots after 10mins and tons of scsi error 
messages. The system is barely functional, the network cards don't work etc.


I have attached the unpatched dsdt. To get rid of acpi error messages, I 
removed offending "Name()" lines. Please let me know if this is the 
appropriate fix. As I said, it doesn't boot with the original dsdt either.

Your help is greatly appreciated!

Bernd



--Boundary_(ID_CpfoAL1P/j0slfoWt9PEiA)
Content-type: application/octet-stream; name=dsdt.asl.gz
Content-transfer-encoding: base64
Content-disposition: attachment; filename=dsdt.asl.gz

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
Hz+9/v/PPhJ757IBAA==

--Boundary_(ID_CpfoAL1P/j0slfoWt9PEiA)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
