From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Wed, 25 Sep 2002 12:57:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020925125753.59a0ef6f.dongili@supereva.it>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Sony vaio GR7/k

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6cd0
ACPI: RSDT (v001 SONY   C0       08193.02057) @ 0x07efa88f
ACPI: FADT (v001   SONY       C0 08193.02057) @ 0x07efef64
ACPI: BOOT (v001   SONY       C0 08193.02057) @ 0x07efefd8
ACPI: DSDT (v001   SONY       C0 08193.02057) @ 0x00000000


> - DOES IT BOOT?

Yes

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Yes

I still have a couple of errors during the boot process but they have been here since 20020404 (not really sure about this date).

PCI: Using configuration type 1
    ACPI-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
    ACPI-0243: *** Error: Could not install Pci_config handler for PCI0, AE_ALREADY_EXISTS
[...]
PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

from lspci:

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)

and it seems it doesn't need an irq...

bye,
--
Mattia


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
