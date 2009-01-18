From: Len Brown <lenb@kernel.org>
Subject: Re: works better
Date: Sat, 17 Jan 2009 20:18:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901172018290.20606@localhost.localdomain>
References: <49720E9B.1080408@med.unc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:43380 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbZARBS7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 20:18:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KDN004YR7N6FWV6@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 17 Jan 2009 19:18:48 -0600 (CST)
In-reply-to: <49720E9B.1080408@med.unc.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tamas Hegedus <hegedus@med.unc.edu>
Cc: linux-acpi@vger.kernel.org


what works better?

thanks,
--
Len Brown, Intel Open Source Technology Center

On Sat, 17 Jan 2009, Tamas Hegedus wrote:

> Hi,
> 
> 
> [    0.280017] ACPI: EC: Look up EC in DSDT
> [    0.305045] ACPI: BIOS _OSI(Linux) query ignored
> [    0.305049] ACPI: DMI System Vendor: Dell Inc.
> [    0.305052] ACPI: DMI Product Name: Precision WorkStation 370
> [    0.305054] ACPI: DMI Product Version:
> [    0.305057] ACPI: DMI Board Name: 0M3849
> [    0.305059] ACPI: DMI BIOS Vendor: Dell Inc.
> [    0.305061] ACPI: DMI BIOS Date: 07/07/2006
> [    0.305063] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> [    0.305066] ACPI: If "acpi_osi=Linux" works better, please notify
> linux-acpi@vger.kernel.org
> 
> *********************************
> AFTER ADDING ACPI_OSI=LINUX:
> 
> 
> [    0.000000] ACPI: RSDP 000FEBF0, 0014 (r0 DELL  )
> [    0.000000] ACPI: RSDT 000FCC29, 0040 (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: FACP 000FCC69, 0074 (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: DSDT FFFC8EAC, 2E37 (r1   DELL    dt_ex     1000 MSFT
> 100000D)
> [    0.000000] ACPI: FACS BFE8AC00, 0040
> [    0.000000] ACPI: SSDT FFFCBCE3, 00A7 (r1   DELL    st_ex     1000 MSFT
> 100000D)
> [    0.000000] ACPI: APIC 000FCCDD, 0092 (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: BOOT 000FCD6F, 0028 (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: ASF! 000FCD97, 0067 (r16 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: MCFG 000FCDFE, 003E (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: HPET 000FCE3C, 0038 (r1 DELL    WS 370         7 ASL
> 61)
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] Allocating PCI resources starting at c2000000 (gap:
> c0000000:20000000)
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 -
> 00000000000f0000
> [    0.000000] PM: Registered nosave memory: 00000000000f0000 -
> 0000000000100000
> [    0.000000] SMP: Allowing 8 CPUs, 6 hotplug CPUs
> [    0.000000] PERCPU: Allocating 37960 bytes of per cpu data
> [    0.000000] NR_CPUS: 8, nr_cpu_ids: 8
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total
> pages: 779916
> [    0.000000] Kernel command line: acpi_osi=Linux
> root=/dev/mapper/violin-root ro quiet
> [    0.000000] ACPI: Added _OSI(Linux)
> 
> -- 
> Tamas Hegedus, PhD          | phone: (1) 919-966 0329
> UNC - Biochem & Biophys     | fax:   (1) 919-966 5178
> 6107 Thurston-Bowles Bldg   | mailto:hegedus@med.unc.edu
> Chapel Hill, NC, 27599-7248 | http://biohegedus.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
