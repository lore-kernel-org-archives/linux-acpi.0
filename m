From: Mark Lord <lkml@rtr.ca>
Subject: 2.6.17-rc6 (potential) bugs:
Date: Wed, 07 Jun 2006 11:02:46 -0400
Message-ID: <4486EA96.9080502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58774 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932241AbWFGPCy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2006 11:02:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com, linux-acpi@vger.kernel.org

>From building the 2.6.17-rc6 kernel on my x86 machine:
>WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xec7) and 'acpi_processor_cst_has_changed'

This is due to processor_power_dmi_table[] (__cpuinitdata)
being accessed from acpi_processor_power_init() (a non-__init function).
If the memory for the table is ever released after bootup,
then this code may crash and burn.

>WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'

This one looks like a similar issue, but my eyes failed to spot the offending lines.

Cheers
