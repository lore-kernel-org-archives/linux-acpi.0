From: Heiko =?ISO-8859-1?Q?Ettelbr=FCck?= <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Compaq Evo N160 hangs on boot (with fixed DSDT)
Date: 06 Sep 2002 21:16:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031339776.1044.28.camel@speedy-gonzales>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

today I managed to fix the DSDT of my Compaq Evo N160 notebook. No
errors, no warnings of iasl - so I should be quite happy...

But using a vanilla kernel 2.4.19 and the acpi patch of 2002-08-21 the
machine hangs while booting. Here are the last lines it prints:

ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming tranparent
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11 14 15, disabled)
ACPI: Embedded Controller [H8] (gpe 29)
pci_bind-0194 [22] acpi_pci_bind         : Device 00:00:1d.02 not
present in PCI namespace
PCI: Probing PCI Hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10

After having searched former postings on this mailing list, I read
something about "the old LNKG problem" and similar things, together with
the advice to hack the dsdt (clean way) or the acpi code (not that
clean) to force the machine to use another interrupt line. But how do I
do that? Searching and reading in the ACPI reference (www.acpi.info)
didn't really help me.

Any suggestions how I could procede? Or does someone have an Evo N160,
too, and also a working configuration of kernel & acpi patch?

Thanks in advance for your help and advice!

Regards,
Heiko



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
