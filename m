From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: RFC: Output ACPI info via sysfs
Date: Thu, 11 May 2006 09:45:17 -0600
Message-ID: <200605110945.17187.bjorn.helgaas@hp.com>
References: <446350DE.9010900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:58020 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030285AbWEKPpU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 11:45:20 -0400
In-Reply-To: <446350DE.9010900@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Thursday 11 May 2006 08:57, Prarit Bhargava wrote:
> Currently, after booting a system there is no way to tell what hardware 
> is currently in the system.  The current output from sysfs only 
> indicates what knowledge the kernel has of the system (ie, is limited by 
> NR_CPUS, etc.).  However, during ACPI initialization a lot of data is 
> output to the console about the precise number of CPUs, lapics, etc.
> 
> Having this information is useful to anyone (or any application) 
> interested in querying the real system information.

Some of this we should get via "lspnp".  (But you need PNPACPI and
somebody (/me looks around innocently) should fix lspnp to look in
/sys/bus/pnp/devices.)

But I see your point about things that are often described in static
tables, like CPUs and APICs, because those don't show up in the
namespace.  Len's pmtools package[1] can already extract and decode
most of the static tables.

Does this (from a 4-CPU Intel Tiger) have some of the information
you need?

# ./acpidump -b -t APIC | ../madt/madt 
ACPI: APIC (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x(nil)
ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0xc6] lsapic_eid[0x18] enabled)
ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0xc2] lsapic_eid[0x18] enabled)
ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0xc4] lsapic_eid[0x18] enabled)
ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0xc0] lsapic_eid[0x18] enabled)
ACPI: IOSAPIC (id[0x0] global_irq_base[0x0] address[0xfec00000])
ACPI: IOSAPIC (id[0x1] global_irq_base[0x18] address[0xfec10000])
ACPI: IOSAPIC (id[0x2] global_irq_base[0x30] address[0xfec20000])
ACPI: IOSAPIC (id[0x3] global_irq_base[0x48] address[0xfec30000])
ACPI: IOSAPIC (id[0x4] global_irq_base[0x60] address[0xfec40000])
ACPI: IOSAPIC (id[0x5] global_irq_base[0x78] address[0xfec50000])
ACPI: IOSAPIC (id[0x6] global_irq_base[0x90] address[0xfec60000])
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: PLAT_INT_SRC (low level type[0x3] id[0x00c6] eid[0x18] iosapic_vector[0x1e] global_irq[0x16]
Length 230 OK
Checksum OK


[1] ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools-20051111.tar.bz2
