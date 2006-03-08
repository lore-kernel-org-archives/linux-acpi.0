From: Len Brown <len.brown@intel.com>
Subject: ACPI slab stats
Date: Wed, 8 Mar 2006 04:09:40 -0500
Message-ID: <200603080409.41213.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:962 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S932528AbWCHJJp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 04:09:45 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr005.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k2899iWl029593
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 09:09:44 GMT
Received: from fmssmxvs041.fm.intel.com (fmssmxvs041.fm.intel.com [132.233.42.126])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k2899iPO026726
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 09:09:44 GMT
Received: from intel.com ([10.127.52.93])
 by fmssmxvs041.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030801094315322
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 01:09:43 -0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

FYI, ACPI slab usage on Viro's box.

1344 * 96 bytes = 129KB, which is significant.

[02:40] <viro> acpi_operand: ffffffff801d90af <acpi_os_acquire_object+b/3e> 1344
[02:40] <viro> size-2048: ffffffff802180fc <acpi_thermal_add+6b/223> 1
[02:40] <viro> size-1024: ffffffff80213331 <acpi_processor_add+65/10a> 1
[02:41] <viro> size-1024: ffffffff8021a01e <acpi_add_single_object+7b/22e> 56
[02:41] <viro> size-512: ffffffff801ff0f8 <acpi_ut_callocate+57/d3> 4
[02:41] <viro> size-192: ffffffff801ff0f8 <acpi_ut_callocate+57/d3> 5
[02:41] <viro> size-32: ffffffff801d8a0c <acpi_os_create_lock+31/c9> 1
[02:41] <viro> size-32: ffffffff801d96ad <acpi_evaluate_integer+8e/2b0> 6
[02:41] <viro> size-32: ffffffff80208071 <acpi_button_add+6b/3a3> 2
[02:41] <viro> size-32: ffffffff8020a85a <acpi_fan_add+74/18f> 1
[02:41] <viro> size-32: ffffffff80210968 <acpi_pci_bind+f1/480> 4
[02:42] <viro> size-32: ffffffff80211008 <acpi_pci_bind_root+f6/246> 1
[02:42] <viro> size-128: ffffffff801ff0f8 <acpi_ut_callocate+57/d3> 801
[02:42] <viro> size-64: ffffffff801d8b4d <acpi_os_create_semaphore+32/124> 15
[02:42] <viro> size-64: ffffffff801ff0f8 <acpi_ut_callocate+57/d3> 13
[02:42] <viro> size-64: ffffffff801ff18a <acpi_ut_create_list+16/40> 2
[02:42] <viro> size-64: ffffffff8020dcf7 <acpi_pci_root_add+80/429> 1
[02:42] <viro> size-64: ffffffff8020f2ae <acpi_pci_link_add+72/26d> 12
[02:43] <viro> size-64: ffffffff8020f8c0 <acpi_pci_irq_add_entry+75/1ae> 40
[02:43] <viro> size-64: ffffffff8021a0f3 <acpi_add_single_object+150/22e> 1
