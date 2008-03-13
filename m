From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent
 asus boards
Date: Thu, 13 Mar 2008 22:15:28 +0100
Message-ID: <47D99970.4010906@freemail.hu>
References: <1205280392.8194.46.camel@linux-2bdv.site>	 <200803120010.41373.lenb@kernel.org>  <200803120140.14243.lenb@kernel.org>	 <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>	 <1205305945.2240.56.camel@acpi-hp-zz.sh.intel.com> <1205391787.2240.71.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000070401090300030109"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:56457 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYCMVYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Mar 2008 17:24:14 -0400
In-Reply-To: <1205391787.2240.71.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070000070401090300030109
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Zhang, Rui wrote:
> On Wed, 2008-03-12 at 15:12 +0800, Zhang, Rui wrote:
>> On Wed, 2008-03-12 at 13:44 +0800, Zhang, Rui wrote:
>>> On Wed, 2008-03-12 at 13:40 +0800, Len Brown wrote:
>>>> Actually,
>>>> This case (and others)
>>>> seems to be taken care of by Rui's recent patch for 8544, yes?
>>>>
>>>>  [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip
>>>> points
>>> Hah, it doesn't cover the active trip point.
>>>
>>> Please review this patch. :)
>> After reading the ACPI spec again, 
>> "If _PSV is defined then either _PSL or _TZD must be defined. _PSL and
>> _TZD may both be defined".
>> "_TZD is optional outside of the _PSV requirement".
>> which means that we should not throw out an error without checking the
>> _TZD method.
>> I think the patch still doesn't make sense, please ignore this patch and
>> wait for the refreshed patch.. :)
>>
> Marton, please try this patch and attach the full dmesg output. :)
> 
> According to the ACPI spec, 
> "If _PSV is defined then either _PSL or _TZD must be defined.
> _PSL and _TZD may both be defined." and
> "_TZD is optional outside of the _PSV requirement outlined above".
> which means that the passive trip point without _PSL is valid if _TZD exists.
> 
> This patch fixes the violation of ACPI spec.
> 
> It also fixes a broken BIOS issue which has invalid trip points.
> http://bugzilla.kernel.org/show_bug.cgi?id=8544
> In this case, the active[0] is set to invalid at boot time
> and it will not be re-evaluated again.
> We can still get a warning message at boot time.
> 
> http://marc.info/?l=linux-kernel&m=120496222629983&w=2
> 
> Signed-off-by: Zhang Rui<rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |   76 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 47 insertions(+), 29 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -400,9 +400,32 @@ static int acpi_thermal_trips_update(str
>  		}
>  	}
>  
> +	/* Evaluate _TZD */
> +	if (flag & ACPI_TRIPS_DEVICES) {
> +		memset(&devices, 0, sizeof(struct acpi_handle_list));
> +		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
> +						NULL, &devices);
> +		if (ACPI_SUCCESS(status)) {
> +			tz->flags.devices = 1;
> +			if (memcmp(&tz->devices, &devices,
> +					sizeof(struct acpi_handle_list))) {
> +				memcpy(&tz->devices, &devices,
> +					sizeof(struct acpi_handle_list));
> +				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			}
> +		} else if (tz->flags.devices) {
> +			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			tz->flags.devices = 0;
> +		}
> +	}
> +
>  	/* Passive (optional) */
> -	if (flag & ACPI_TRIPS_PASSIVE) {
> +	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES))
>  		valid = tz->trips.passive.flags.valid;
> +		
> +	if (((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) &&
> +		(tz->trips.passive.flags.valid || (flag == ACPI_TRIPS_INIT)))
> +	{
>  		if (psv == -1) {
>  			status = AE_SUPPORT;
>  		} else if (psv > 0) {
> @@ -440,16 +463,20 @@ static int acpi_thermal_trips_update(str
>  		memset(&devices, 0, sizeof(struct acpi_handle_list));
>  		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
>  							NULL, &devices);
> -		if (ACPI_FAILURE(status))
> +		if (ACPI_FAILURE(status) &&
> +			((status != AE_NOT_FOUND) || !tz->flags.devices)) {
> +			printk(KERN_WARNING PREFIX
> +				"Invalid passive threshold\n");
>  			tz->trips.passive.flags.valid = 0;
> -		else
> +		} else {
>  			tz->trips.passive.flags.valid = 1;
>  
> -		if (memcmp(&tz->trips.passive.devices, &devices,
> -				sizeof(struct acpi_handle_list))) {
> -			memcpy(&tz->trips.passive.devices, &devices,
> -				sizeof(struct acpi_handle_list));
> -			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			if (memcmp(&tz->trips.passive.devices, &devices,
> +					sizeof(struct acpi_handle_list))) {
> +				memcpy(&tz->trips.passive.devices, &devices,
> +					sizeof(struct acpi_handle_list));
> +				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			}
>  		}
>  	}
>  	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
> @@ -465,7 +492,8 @@ static int acpi_thermal_trips_update(str
>  		if (act == -1)
>  			break; /* disable all active trip points */
>  
> -		if (flag & ACPI_TRIPS_ACTIVE) {
> +		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
> +			tz->trips.active[i].flags.valid)) {
>  			status = acpi_evaluate_integer(tz->device->handle,
>  				name, NULL, &tz->trips.active[i].temperature);
>  			if (ACPI_FAILURE(status)) {
> @@ -497,16 +525,18 @@ static int acpi_thermal_trips_update(str
>  			memset(&devices, 0, sizeof(struct acpi_handle_list));
>  			status = acpi_evaluate_reference(tz->device->handle,
>  						name, NULL, &devices);
> -			if (ACPI_FAILURE(status))
> +			if (ACPI_FAILURE(status)) {
> +				printk(KERN_WARNING PREFIX
> +					"Invalid active%d threshold\n", i);
>  				tz->trips.active[i].flags.valid = 0;
> -			else
> +			} else {
>  				tz->trips.active[i].flags.valid = 1;
> -
> -			if (memcmp(&tz->trips.active[i].devices, &devices,
> -					sizeof(struct acpi_handle_list))) {
> -				memcpy(&tz->trips.active[i].devices, &devices,
> -					sizeof(struct acpi_handle_list));
> -				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +				if (memcmp(&tz->trips.active[i].devices, &devices,
> +						sizeof(struct acpi_handle_list))) {
> +					memcpy(&tz->trips.active[i].devices, &devices,
> +						sizeof(struct acpi_handle_list));
> +					ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +				}
>  			}
>  		}
>  		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
> @@ -517,18 +547,6 @@ static int acpi_thermal_trips_update(str
>  			break;
>  	}
>  
> -	if (flag & ACPI_TRIPS_DEVICES) {
> -		memset(&devices, 0, sizeof(struct acpi_handle_list));
> -		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
> -						NULL, &devices);
> -		if (memcmp(&tz->devices, &devices,
> -				sizeof(struct acpi_handle_list))) {
> -			memcpy(&tz->devices, &devices,
> -				sizeof(struct acpi_handle_list));
> -			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> -		}
> -	}
> -
>  	return 0;
>  }

I applied this patch to 2.6.25-rc5 and booted the kernel on Clevo D410J.
The dmesg is attached.

	Márton Németh

--------------070000070401090300030109
Content-Type: text/plain;
 name="dmesg-2.6.25-rc5-Clevo-D410J-2008-03-13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.25-rc5-Clevo-D410J-2008-03-13.txt"

[    0.000000] Linux version 2.6.25-rc5 (nmarci@europa) (gcc version 4.2.3 20080114 (prerelease) (Debian 4.2.2-7)) #1 PREEMPT Thu Mar 13 20:47:49 CET 2008
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003bf70000 (usable)
[    0.000000]  BIOS-e820: 000000003bf70000 - 000000003bf7a000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003bf7a000 - 000000003bf80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003bf80000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
[    0.000000] 63MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] Scan SMP from c0000000 for 1024 bytes.
[    0.000000] Scan SMP from c009fc00 for 1024 bytes.
[    0.000000] Scan SMP from c00f0000 for 65536 bytes.
[    0.000000] found SMP MP-table at [c00f6870] 000f6870
[    0.000000] Entering add_active_range(0, 0, 245616) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   245616
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   245616
[    0.000000] On node 0 totalpages: 245616
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 126 pages used for memmap
[    0.000000]   HighMem zone: 16114 pages, LIFO batch:3
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP 000F68D0, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 3BF7600B, 0030 (r1 PTLTD    RSDT    6040000  LTP        0)
[    0.000000] ACPI: FACP 3BF79E87, 0074 (r1 AMDK8  PTLTW     6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 3BF7603B, 3E4C (r1  VIA   PTL_ACPI  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS 3BF7AFC0, 0040
[    0.000000] ACPI: SSDT 3BF79EFB, 00B5 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: APIC 3BF79FB0, 0050 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:12 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bffe0000)
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000d8000
[    0.000000] PM: Registered nosave memory: 00000000000d8000 - 0000000000100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 243698
[    0.000000] Kernel command line: root=/dev/hda3 ro log_buf_len=1M
[    0.000000] log_buf_len: 1048576
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1603.652 MHz processor.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000999] ... MAX_LOCKDEP_SUBCLASSES:    8
[    0.000999] ... MAX_LOCK_DEPTH:          48
[    0.000999] ... MAX_LOCKDEP_KEYS:        2048
[    0.000999] ... CLASSHASH_SIZE:           1024
[    0.000999] ... MAX_LOCKDEP_ENTRIES:     8192
[    0.000999] ... MAX_LOCKDEP_CHAINS:      16384
[    0.000999] ... CHAINHASH_SIZE:          8192
[    0.000999]  memory used by lock dependency info: 992 kB
[    0.000999]  per task-struct memory footprint: 1920 bytes
[    0.000999] ------------------------
[    0.000999] | Locking API testsuite:
[    0.000999] ----------------------------------------------------------------------------
[    0.000999]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]               recursive read-lock:             |  ok  |             |  ok  |
[    0.000999]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.000999]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.000999]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.000999]   --------------------------------------------------------------------------
[    0.000999]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.000999]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.000999]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.000999]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.000999]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.000999]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.000999]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.000999]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.000999]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.000999]       hard-irq read-recursion/123:  ok  |
[    0.000999]       soft-irq read-recursion/123:  ok  |
[    0.000999]       hard-irq read-recursion/132:  ok  |
[    0.000999]       soft-irq read-recursion/132:  ok  |
[    0.000999]       hard-irq read-recursion/213:  ok  |
[    0.000999]       soft-irq read-recursion/213:  ok  |
[    0.000999]       hard-irq read-recursion/231:  ok  |
[    0.000999]       soft-irq read-recursion/231:  ok  |
[    0.000999]       hard-irq read-recursion/312:  ok  |
[    0.000999]       soft-irq read-recursion/312:  ok  |
[    0.000999]       hard-irq read-recursion/321:  ok  |
[    0.000999]       soft-irq read-recursion/321:  ok  |
[    0.000999] -------------------------------------------------------
[    0.000999] Good, all 218 testcases passed! |
[    0.000999] ---------------------------------
[    0.000999] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000999] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000999] Memory: 966924k/982464k available (2106k kernel code, 15024k reserved, 892k data, 188k init, 64960k highmem)
[    0.000999] virtual kernel memory layout:
[    0.000999]     fixmap  : 0xfffa8000 - 0xfffff000   ( 348 kB)
[    0.000999]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000999]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000999]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000999]       .init : 0xc03f0000 - 0xc041f000   ( 188 kB)
[    0.000999]       .data : 0xc030e9d1 - 0xc03edc18   ( 892 kB)
[    0.000999]       .text : 0xc0100000 - 0xc030e9d1   (2106 kB)
[    0.000999] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000999] CPA: page pool initialized 1 of 1 pages preallocated
[    0.060995] Calibrating delay using timer specific routine.. 3210.74 BogoMIPS (lpj=1605374)
[    0.061253] Mount-cache hash table entries: 512
[    0.062192] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.062254] CPU: L2 Cache: 128K (64 bytes/line)
[    0.062310] Intel machine check architecture supported.
[    0.062996] Intel machine check reporting enabled on CPU#0.
[    0.063058] Compat vDSO mapped to ffffe000.
[    0.063116] CPU: AMD Mobile AMD Sempron(tm) Processor 2600+ stepping 00
[    0.063292] Checking 'hlt' instruction... OK.
[    0.067334] Freeing SMP alternatives: 0k freed
[    0.067390] ACPI: Core revision 20070126
[    0.077860] Parsing all Control Methods:
[    0.078036] Table [DSDT](id 0001) - 480 Objects with 49 Devices 147 Methods 13 Regions
[    0.078259] Parsing all Control Methods:
[    0.078389] Table [SSDT](id 0002) - 3 Objects with 0 Devices 0 Methods 0 Regions
[    0.078505]  tbxface-0598 [02] tb_load_namespace     : ACPI Tables successfully acquired
[    0.079049] evxfevnt-0091 [02] enable                : Transition to ACPI mode successful
[    0.079987] ENABLING IO-APIC IRQs
[    0.079987] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[    0.089986] net_namespace: 604 bytes
[    0.090546] NET: Registered protocol family 16
[    0.091360] ACPI: bus type pci registered
[    0.098931] PCI: PCI BIOS revision 2.10 entry at 0xfd88c, last bus=1
[    0.099040] PCI: Using configuration type 1
[    0.099094] Setting up standard PCI resources
[    0.103310] evgpeblk-0956 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0xA
[    0.104259] evgpeblk-1052 [03] ev_initialize_gpe_bloc: Found 4 Wake, Enabled 0 Runtime GPEs in this block
[    0.104414] ACPI: EC: Look up EC in DSDT
[    0.107538] Completing Region/Field/Buffer/Package initialization:.....................................................
[    0.115314] Initialized 11/13 Regions 1/1 Fields 23/24 Buffers 18/26 Packages (492 nodes)
[    0.115431] Initializing Device/Processor/Thermal objects by executing _INI methods:.
[    0.115880] Executed 1 _INI methods requiring 1 _STA executions (examined 53 objects)
[    0.116055] ACPI: Interpreter enabled
[    0.116111] ACPI: (supports S0 S3 S4 S5)
[    0.116384] ACPI: Using IOAPIC for interrupt routing
[    0.130591] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.630930] ACPI: EC: missing write data confirmation, don't expect it any longer.
[    0.631725] ACPI: EC: GPE = 0xb, I/O: command/status = 0x66, data = 0x62
[    0.631788] ACPI: EC: driver started in interrupt mode
[    0.632066] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.633339] pci 0000:00:11.0: quirk: region 4000-407f claimed by vt8235 PM
[    0.633401] pci 0000:00:11.0: quirk: region 8100-810f claimed by vt8235 SMB
[    0.633968] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.659880] ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
[    0.660644] ACPI: PCI Interrupt Link [ALKB] (IRQs 16 17 18 19 20 21 22 23) *11, disabled.
[    0.661419] ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *10, disabled.
[    0.661900] ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *5, disabled.
[    0.662482] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
[    0.663263] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 12 14 15) *11
[    0.664119] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 11 12 14 15) *10
[    0.664952] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[    0.665945] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.666128] pnp: PnP ACPI init
[    0.666226] ACPI: bus type pnp registered
[    0.669211] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.670237] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.670508] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.670834] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.671198] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.671372]  00:05: calling quirk 0xc0264160: quirk_supermicro_h8dce_system+0x0/0x110()
[    0.671560] pnp 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.671983]  00:06: calling quirk 0xc0264160: quirk_supermicro_h8dce_system+0x0/0x110()
[    0.672184] pnp 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.672460] pnp 00:07: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.672724] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.674275] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.676008] pnp 00:0a: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.676881] pnp: PnP ACPI: found 11 devices
[    0.676929] ACPI: ACPI bus type pnp unregistered
[    0.677809] PCI: Using ACPI for IRQ routing
[    0.677869] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.682460] pnp: the driver 'system' has been registered
[    0.682499] system 00:05: iomem range 0x0-0x9ffff could not be reserved
[    0.682562] system 00:05: iomem range 0xe0000-0xfffff could not be reserved
[    0.682624] system 00:05: iomem range 0xfff00000-0xffffffff could not be reserved
[    0.682693] system 00:05: iomem range 0xffee0000-0xffefffff has been reserved
[    0.682753] system 00:05: iomem range 0xfec00000-0xfec00fff has been reserved
[    0.682813] system 00:05: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.682871] system 00:05: driver attached
[    0.682885] system 00:06: ioport range 0x4d0-0x4d1 has been reserved
[    0.682922] Time: tsc clocksource has been installed.
[    0.682932] system 00:06: ioport range 0xfe10-0xfe11 has been reserved
[    0.683003] system 00:06: ioport range 0xfe00-0xfe00 has been reserved
[    0.683062] system 00:06: ioport range 0x4000-0x407f has been reserved
[    0.683122] system 00:06: ioport range 0x8100-0x811f could not be reserved
[    0.683181] system 00:06: driver attached
[    0.715156] PCI: Bridge: 0000:00:01.0
[    0.715214]   IO window: disabled.
[    0.715271]   MEM window: 0xd1000000-0xd1ffffff
[    0.715329]   PREFETCH window: 0x00000000f0000000-0x00000000f3ffffff
[    0.715391] PCI: Bus 2, cardbus bridge: 0000:00:0c.0
[    0.715446]   IO window: 0x00002000-0x000020ff
[    0.715503]   IO window: 0x00002400-0x000024ff
[    0.715560]   PREFETCH window: 0x50000000-0x53ffffff
[    0.715618]   MEM window: 0x54000000-0x57ffffff
[    0.715705] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.715719] PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)
[    0.715787] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
[    0.715902] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[    0.715985] NET: Registered protocol family 2
[    0.716311] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.717068] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.718251] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[    0.724447] TCP: Hash tables configured (established 131072 bind 65536)
[    0.724550] TCP reno registered
[    0.727488] audit: initializing netlink socket (disabled)
[    0.727600] type=2000 audit(1205445677.726:1): initialized
[    0.728088] highmem bounce pool size: 64 pages
[    0.728872] io scheduler noop registered
[    0.728939] io scheduler cfq registered (default)
[    0.729018] PCI: VIA PCI bridge detected. Disabling DAC.
[    0.729153] pci 0000:01:00.0: Boot video device
[    0.817147] Uniform Multi-Platform E-IDE driver
[    0.817212] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.817450] VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:11.1
[    0.817831] ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
[    0.818156] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 23
[    0.818217] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 23
[    0.818282] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 23 (level, low) -> IRQ 23
[    0.818444] VP_IDE: not 100% native mode: will probe irqs later
[    0.818515] VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
[    0.818592]     ide0: BM-DMA at 0x1c60-0x1c67, BIOS settings: hda:DMA, hdb:PIO
[    0.818710]     ide1: BM-DMA at 0x1c68-0x1c6f, BIOS settings: hdc:DMA, hdd:PIO
[    0.818821] Probing IDE interface ide0...
[    1.215896] Switched to high resolution mode on CPU 0
[    1.358091] hdb: IRQ probe failed (0xfffffbfe)
[    1.632221] hdb: IRQ probe failed (0xfffffbfe)
[    2.059257] hda: SAMSUNG MP0804H, ATA DISK drive
[    2.059257] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.059257] hda: UDMA/100 mode selected
[    2.059257] Probing IDE interface ide1...
[    3.463642] hdc: Optiarc DVD RW AD-7543A, ATAPI CD/DVD-ROM drive
[    3.463642] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    3.465415] hdc: UDMA/33 mode selected
[    3.468117] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.565068] ide1 at 0x170-0x177,0x376 on irq 15
[    3.568070] pnp: the driver 'ide' has been registered
[    3.568281] hda: max request size: 512KiB
[    3.568447] hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63
[    3.569206] hda: cache flushes supported
[    3.569206]  hda: hda1 hda2 hda3
[    3.572228] TCP cubic registered
[    3.572310] NET: Registered protocol family 1
[    3.572399] NET: Registered protocol family 17
[    3.572479] Using IPI Shortcut mode
[    3.596423] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[    3.596476] ReiserFS: hda3: using ordered data mode
[    3.605919] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[    3.606409] ReiserFS: hda3: checking transaction log (hda3)
[    3.686079] ReiserFS: hda3: Using r5 hash to sort names
[    3.686079] VFS: Mounted root (reiserfs filesystem) readonly.
[    3.686079] Freeing unused kernel memory: 188k freed
[    3.686079] Write protecting the kernel read-only data: 736k
[    3.686079] Testing CPA: undo c030f000-c03c7000
[    3.686079] Testing CPA: write protecting again
[    8.886978] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    8.887365] ACPI: ACPI0007:00 is registered as cooling_device0
[    8.896459] input: Power Button (FF) as /class/input/input0
[    8.898931] ACPI: Power Button (FF) [PWRF]
[    8.899194] input: Power Button (CM) as /class/input/input1
[    8.902897] ACPI: Power Button (CM) [PWB]
[    8.903116] input: Sleep Button (CM) as /class/input/input2
[    8.905860] ACPI: Sleep Button (CM) [SLPB]
[    8.906101] input: Lid Switch as /class/input/input3
[    8.906454] ACPI: Lid Switch [LID]
[    8.914503] ACPI: Invalid active0 threshold
[    8.915060] ACPI: LNXTHERM:01 is registered as thermal_zone0
[    8.915596] ACPI: Thermal Zone [THRM] (58 C)
[    8.927894] ACPI: AC Adapter [AC] (on-line)
[    8.944847] ACPI: Battery Slot [BAT0] (battery present)
[    9.368874] Yenta: CardBus bridge found at 0000:00:0c.0 [1558:4702]
[    9.368960] Yenta: Using CSCINT to route CSC interrupts to PCI
[    9.369017] Yenta: Routing CardBus interrupts to PCI
[    9.369076] Yenta TI: socket 0000:00:0c.0, mfunc 0x00001002, devctl 0x44
[    9.494079] 8139too Fast Ethernet driver 0.9.28
[    9.592688] Yenta: ISA IRQ mask 0x08a0, PCI irq 16
[    9.592730] Socket status: 30000006
[    9.605348] ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
[    9.606511] eth0: RealTek RTL8139 at 0xf88ee000, 00:90:f5:3e:5a:ca, IRQ 19
[    9.606725] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[    9.679710] Marking TSC unstable due to: possible TSC halt in C2.
[    9.680807] Time: acpi_pm clocksource has been installed.
[    9.725311] usbcore: registered new interface driver usbfs
[    9.725530] usbcore: registered new interface driver hub
[    9.727694] usbcore: registered new device driver usb
[    9.889776] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[    9.890072] Uniform CD-ROM driver Revision: 3.20
[   10.031356] Real Time Clock Driver v1.12ac
[   10.051646] input: PC Speaker as /class/input/input4
[   10.294366] pnp: the driver 'parport_pc' has been registered
[   10.294410] parport_pc 00:0a: reported by Plug and Play ACPI
[   10.294741] parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   10.339049] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   10.340059] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   10.349620] pnp: the driver 'serial' has been registered
[   10.376833] parport_pc 00:0a: driver attached
[   10.380733] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   10.380936] serial 00:09: driver attached
[   10.413043] USB Universal Host Controller Interface driver v3.0
[   10.413453] ACPI: PCI Interrupt Link [ALKD] disabled and referenced, BIOS bug
[   10.413890] ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 21
[   10.413950] ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 21
[   10.414014] ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 21
[   10.414210] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   10.422569] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   10.422698] uhci_hcd 0000:00:10.0: irq 21, io base 0x00001c00
[   10.425486] usb usb1: configuration #1 chosen from 1 choice
[   10.426802] hub 1-0:1.0: USB hub found
[   10.427608] hub 1-0:1.0: 2 ports detected
[   10.529156] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 21
[   10.529325] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   10.529469] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   10.529573] uhci_hcd 0000:00:10.1: irq 21, io base 0x00001c20
[   10.529975] usb usb2: configuration #1 chosen from 1 choice
[   10.530105] hub 2-0:1.0: USB hub found
[   10.530178] hub 2-0:1.0: 2 ports detected
[   10.626962] ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 21
[   10.627134] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   10.627275] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   10.627389] uhci_hcd 0000:00:10.2: irq 21, io base 0x00001c40
[   10.627834] usb usb3: configuration #1 chosen from 1 choice
[   10.627964] hub 3-0:1.0: USB hub found
[   10.628048] hub 3-0:1.0: 2 ports detected
[   10.722849] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [ALKD] -> GSI 21 (level, low) -> IRQ 21
[   10.723034] ehci_hcd 0000:00:10.3: EHCI Host Controller
[   10.723202] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   10.723399] ehci_hcd 0000:00:10.3: irq 21, io mem 0xd0004400
[   10.729327] ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   10.729738] usb usb4: configuration #1 chosen from 1 choice
[   10.729871] hub 4-0:1.0: USB hub found
[   10.730338] hub 4-0:1.0: 6 ports detected
[   11.461350] ACPI: PCI Interrupt Link [ALKC] disabled and referenced, BIOS bug
[   11.461566] ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
[   11.461627] ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
[   11.461691] ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 22
[   11.464042] PCI: Setting latency timer of device 0000:00:11.6 to 64
[   11.974971] ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 22
[   11.975271] PCI: Setting latency timer of device 0000:00:11.5 to 64
[   14.070541] Adding 1951888k swap on /dev/hda2.  Priority:-1 extents:1 across:1951888k
[   24.202386] pnp: the driver 'i8042 kbd' has been registered
[   24.202431] i8042 kbd 00:08: driver attached
[   24.202472] pnp: the driver 'i8042 aux' has been registered
[   24.202522] i8042 aux 00:07: driver attached
[   24.202559] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   24.205758] i8042.c: Detected active multiplexing controller, rev 1.1.
[   24.207407] serio: i8042 KBD port at 0x60,0x64 irq 1
[   24.215946] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   24.216006] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   24.216064] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   24.216122] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   24.241504] input: AT Translated Set 2 keyboard as /class/input/input5
[   24.580903] powernow-k8: Found 1 Mobile AMD Sempron(tm) Processor 2600+ processors (1 cpu cores) (version 2.20.00)
[   24.589902] powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x6
[   24.589967] powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x18
[   24.603857] powernow-k8: ph2 null fid transition 0x8
[   24.723799] input: PS/2 Mouse as /class/input/input6
[   24.747437] input: AlpsPS/2 ALPS GlidePoint as /class/input/input7
[   24.771139] mice: PS/2 mouse device common for all mice
[   24.812961] Linux agpgart interface v0.103
[   24.898725] [drm] Initialized drm 1.1.0 20060810
[   25.037202] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   25.038070] [drm] Initialized via 2.11.1 20070202 on minor 0
[   25.089343] leds_clevo_mail: 'Clevo D410J' found
[   25.090211] Registered led device: clevo::mail
[   30.036395] CPA self-test:
[   30.036518]  4k 1024 large 223 gb 0 x 1247[c0000000-f7c00000] miss 0
[   30.043539]  4k 195584 large 33 gb 0 x 195617[c0000000-f7fff000] miss 0
[   30.047759]  4k 195584 large 33 gb 0 x 195617[c0000000-f7fff000] miss 0
[   30.047817] ok.
[   35.127535] ReiserFS: hda1: found reiserfs format "3.6" with standard journal
[   35.127628] ReiserFS: hda1: using ordered data mode
[   35.131242] ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   35.134194] ReiserFS: hda1: checking transaction log (hda1)
[   35.197946] ReiserFS: hda1: Using r5 hash to sort names
[   36.669138] ip_tables: (C) 2000-2006 Netfilter Core Team
[   36.922838] eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
[   38.597469] NET: Registered protocol family 10
[   44.717876] lp0: using parport0 (interrupt-driven).
[   44.769635] Clocksource tsc unstable (delta = -115004499 ns)
[   44.785732] ppdev: user-space parallel port driver
[   48.902610] eth0: no IPv6 routers present
[   52.770926] warning: `avahi-daemon' uses 32-bit capabilities (legacy support in use)
[   86.320860] irq 16: nobody cared (try booting with the "irqpoll" option)
[   86.320860] Pid: 0, comm: swapper Not tainted 2.6.25-rc5 #1
[   86.320860]  [<c01578f7>] __report_bad_irq+0x27/0x90
[   86.320860]  [<c0157b96>] note_interrupt+0x236/0x270
[   86.320860]  [<c0156fa3>] ? handle_IRQ_event+0x53/0x60
[   86.320860]  [<c015823a>] handle_fasteoi_irq+0x7a/0xd0
[   86.320860]  [<c0106174>] do_IRQ+0x44/0xa0
[   86.320860]  [<c0104c66>] common_interrupt+0x2e/0x34
[   86.320860]  [<c0119039>] ? finish_task_switch+0x59/0xc0
[   86.320860]  [<c0118fe0>] ? finish_task_switch+0x0/0xc0
[   86.320860]  [<c03080d6>] schedule+0x2b6/0x470
[   86.320860]  [<f892fdae>] ? acpi_processor_idle+0x0/0x436 [processor]
[   86.320860]  [<c0102b65>] cpu_idle+0xb5/0xd0
[   86.320860]  [<c030343c>] rest_init+0x5c/0x60
[   86.320860]  =======================
[   86.320860] handlers:
[   86.320860] [<f8915830>] (yenta_interrupt+0x0/0xe0 [yenta_socket])
[   86.320860] [<f8afd3f0>] (via_driver_irq_handler+0x0/0x1c0 [via])
[   86.320860] Disabling IRQ #16

--------------070000070401090300030109--
