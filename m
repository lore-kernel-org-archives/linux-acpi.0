From: "Brown, Len" <len.brown@intel.com>
Subject: RE: acpi slab consumption
Date: Thu, 9 Mar 2006 01:21:46 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006523B61@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:13525 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751298AbWCIGVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2006 01:21:48 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k296LmVt003683
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 06:21:48 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k296GCgL032009
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 06:16:13 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030822214701531
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 22:21:47 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


>Anybody interested in auditing ACPI slab usage?
>
>ftp.linux.org.uk/pub/people/viro/slab-leaks.patch
>
>with CONFIG_DEBUG_SLAB_LEAK
>
>creates /proc/slab_allocators

Viro updated this patch so with CONFIG_KALLSYMS=y
it does the symbols in /proc.  Format is now:

slab-name active-allocations caller

Here's what I see on my box:

# grep acpi /proc/slab_allocators
acpi_operand: 888 acpi_os_acquire_object+0xb/0x3e
size-2048: 1 acpi_ev_create_gpe_block+0x180/0x625
size-2048: 1 acpi_thermal_add+0x6c/0x6bf
size-2048: 13 pnpacpi_add_device_handler+0x94/0x2a0
size-1024: 1 acpi_ev_create_gpe_block+0x180/0x625
size-1024: 1 acpi_processor_add+0x67/0x103
size-1024: 70 acpi_add_single_object+0x80/0xa4f
size-256: 1 acpi_ev_create_gpe_block+0x10f/0x625
size-256: 1 acpi_tb_convert_table_fadt+0x8b/0x342
size-256: 1 acpi_ec_intr_add+0x6e/0x2b9
size-32: 1 acpi_os_create_lock+0x31/0xac
size-32: 11 acpi_evaluate_integer+0x8a/0x2a8
size-32: 26 acpi_ds_build_internal_buffer_obj+0x130/0x1b0
size-32: 13 acpi_ds_build_internal_package_obj+0xe9/0x1a0
size-32: 7 acpi_ev_pci_config_region_setup+0x1dd/0x2dc
size-32: 1 acpi_install_gpe_handler+0xf2/0x188
size-32: 1 acpi_ev_create_gpe_block+0x3ac/0x625
size-32: 1 acpi_ac_add+0x6b/0x2ba
size-32: 3 acpi_button_add+0x6b/0x5b6
size-32: 12 acpi_pci_bind+0xec/0x476
size-32: 1 acpi_pci_bind_root+0xf2/0x241
size-32: 1 acpi_container_add+0x94/0x16d
size-32: 4 pnpacpi_option_resource+0x9c/0x447
size-32: 16 pnpacpi_option_resource+0x1c8/0x447
size-32: 13 pnpacpi_add_device_handler+0x17b/0x2a0
size-128: 4 acpi_ds_build_internal_buffer_obj+0x130/0x1b0
size-128: 2 acpi_ds_build_internal_package_obj+0xe9/0x1a0
size-128: 2 acpi_ev_create_gpe_block+0x80/0x625
size-128: 1 acpi_ev_create_gpe_block+0x10f/0x625
size-128: 1 acpi_tb_convert_to_xsdt+0x33/0xa6
size-128: 5 acpi_tb_init_table_descriptor+0x48/0x1e8
size-128: 1 acpi_video_bus_add+0x77/0xf1d
size-64: 21 acpi_os_create_semaphore+0x32/0x102
size-64: 1 acpi_ds_build_internal_buffer_obj+0x130/0x1b0
size-64: 23 acpi_ds_build_internal_package_obj+0xe9/0x1a0
size-64: 3 acpi_ev_system_memory_region_setup+0x7b/0xe8
size-64: 662 acpi_ns_create_node+0x3d/0x9c
size-64: 1 acpi_battery_add+0x68/0x398
size-64: 1 acpi_video_bus_add+0x5b9/0xf1d
size-64: 3 acpi_video_bus_add+0x634/0xf1d
size-64: 1 acpi_pci_root_add+0x7e/0x431
size-64: 14 acpi_pci_link_add+0x68/0x313
size-64: 14 acpi_pci_irq_add_prt+0x281/0x3ef
size-64: 12 pnpacpi_option_resource+0x47/0x447
