From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.5: Hitachi HA8000/70 panic, missing devices
Date: Tue, 6 Apr 2004 13:54:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD803B1208C@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Charles Duffy <charlesduffy-doANK8/0m3qakBO8gow8eQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
For the PCI devices missing problem, it's because your DSDT has error.
All _BBN of root PCI bridge return 0. We have a track (Bug 1662) about
this issue.
For panic, I'm a little curious. Since you deselect ACPI, ACPI
interpreter should be disabled. So how can you get 'ACPI: Interpreter
enabled'

Thanks,
David
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Charles Duffy
>Sent: Tuesday, April 06, 2004 1:56 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] 2.6.5: Hitachi HA8000/70 panic, missing devices
>
>Howdy. I'm presently working with a Hitachi HA8000/70. This system has
a
>Gigabyte motherboard primarily using ServerWorks chipsets.
>
>With ACPI fully enabled, the system boots but fails to recognize some
>PCI devices. Booting with pci=3Dnoacpi, or with ACPI deselected but
>ACPI_BOOT selected, the system panics. This happens in SMP or UP as
long
>as ACPI_BOOT is enabled.
>
>I'm able to convince the system to boot correctly (and show all
devices)
>in uniprocessor mode with PCI_GODIRECT and ACPI (as well as ACPI_BOOT)
>disabled. The system was able to boot correctly running SMP in 2.4.
>
>
>
>I've included links to a wide array of potentially relevant information
>below. If there's anything I've left out, or some test I could run,
>please let me know. If you're really interested in this one and in the
>Austin area, it may be possible to loan the hardware or get together in
>person -- I'll buy lunch.
>
>---
>
>A hand-typed boot log (no null-modem cable available) showing the panic
>with pci=3Dnoacpi is at:
>http://quackerhead.com/~duff/HA8000_70/noacpi_panic.txt
>
>dmidecode output is at:
>http://quackerhead.com/~duff/HA8000_70/dmidecode.txt
>
>The original ACPI DSDT is at:
>http://quackerhead.com/~duff/HA8000_70/dsdt.orig
>
>My modified ACPI DSDT (same issue; less dead code and IASL-friendly):
>http://quackerhead.com/~duff/HA8000_70/dsdt.new
>
>Extra-verbose lspci output with a uniprocessor, non-ACPI_BOOT kernel:
>http://quackerhead.com/~duff/HA8000_70/lspci_direct_pci_config.txt
>the above shows all devices in the system.
>
>Extra-verbose lspci output with a fully ACPI kernel:
>http://quackerhead.com/~duff/HA8000_70/lspci_full_acpi_config.txt
>the above is missing the GigE and SCSI controllers.
>
>/proc/interrupts with the SMP ACPI kernel (and missing devices):
>http://quackerhead.com/~duff/HA8000_70/interrupts_full_acpi_config.txt
>this one uses IO-APIC-{edge,level} almost everywhere
>
>/proc/interrupts with the UP non-ACPI kernel:
>http://quackerhead.com/~duff/HA8000_70/interrupts_direct_pci_config.txt
>this one uses XT-PIC everywhere
>
>dmesg output with the SMP ACPI kernel (including ACPI debug info):
>http://quackerhead.com/~duff/HA8000_70/dmesg_full_acpi_config.txt
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IBM Linux Tutorials
>Free Linux tutorial presented by Daniel Robbins, President and CEO of
>GenToo technologies. Learn everything from fundamentals to system
>administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcl=
ick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
