From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception
 code: 0xFFFFFFEA [20060707]
Date: Sun, 27 Aug 2006 00:14:37 -0700
Message-ID: <20060827001437.ec4f7a7a.akpm@osdl.org>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:27862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751277AbWH0HOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Aug 2006 03:14:41 -0400
In-Reply-To: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Sat, 26 Aug 2006 23:56:09 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
>  [dump_trace+100/418] dump_trace+0x64/0x1a2
>  [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
>  [show_trace+13/16] show_trace+0xd/0x10
>  [dump_stack+23/25] dump_stack+0x17/0x19
>  [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
>  [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
>  [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
>  [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
>  [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
>  [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
>  [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
>  [init+136/512] init+0x88/0x200
>  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> 
> Leftover inexact backtrace:
> 
>  [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
>  [show_trace+13/16] show_trace+0xd/0x10
>  [dump_stack+23/25] dump_stack+0x17/0x19
>  [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
>  [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
>  [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
>  [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
>  [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
>  [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
>  [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
>  [init+136/512] init+0x88/0x200
>  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
>  =======================

cc's added.
