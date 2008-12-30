From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA Release 20081204 linuxized patch set
Date: Tue, 30 Dec 2008 01:30:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812300126550.4331@localhost.localdomain>
References: <1229427449.19540.126.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:64657 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYL3GaS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 01:30:18 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KCO00GZCFEHKAO4@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 30 Dec 2008 00:30:17 -0600 (CST)
In-reply-to: <1229427449.19540.126.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>



On Tue, 16 Dec 2008, Lin Ming wrote:

> The attachment is ACPICA Release 20081204 linuxized patch set
> 
> It can be applied cleanly to acpica branch of Len's tree linux-acpi-2.6.git
> 
> Build & tested on x86-64 and IA64.
> 
> #git clone git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
> #git am R12_04_08.mbox
> #make & reboot ....
> 
> Lin Ming
> ---
> [PATCH 01/27] ACPICA: Restructure includes into public/private
> [PATCH 02/27] ACPICA: Fixes for various ACPI data tables
> [PATCH 03/27] ACPICA: Add ACPI_MUTEX_TYPE configuration option
> [PATCH 04/27] ACPICA: Update aclinux for ACPI_MUTEX_TYPE
> [PATCH 05/27] ACPICA: New: acpi_get_gpe_device interface
> [PATCH 06/27] ACPICA: New: Public GPE group enable/disable interfaces
> [PATCH 07/27] ACPICA: New: acpi_read and acpi_write public interfaces
> [PATCH 08/27] ACPICA: Move all public H/W interfaces to new hwxface
> [PATCH 09/27] ACPICA: Update prototypes for new public interfaces
> [PATCH 10/27] ACPICA: New: acpi_reset interface - write to reset register
> [PATCH 11/27] ACPICA: FADT parsing changes and fixes
> [PATCH 12/27] ACPICA: FADT: set acpi_gbl_use_default_register_widths to TRUE by default
> [PATCH 13/27] ACPICA: FADT: Update error msgs for consistency
> 
> below patches are linux changes due to acpica header restructure
> 
> [PATCH 14/27] acpi: remove private acpica headers from driver files
> [PATCH 15/27] acpi: drivers/acpi/osl.c
> [PATCH 16/27] acpi: drivers/acpi/reboot.c
> [PATCH 17/27] acpi: drivers/acpi/ec.c
> [PATCH 18/27] acpi: drivers/acpi/sleep/proc.c
> [PATCH 19/27] acpi: drivers/acpi/sleep/wakeup.c
> [PATCH 20/27] acpi: drivers/acpi/system.c
> [PATCH 21/27] acpi: drivers/acpi/sleep/main.c
> [PATCH 22/27] acpi: drivers/misc/sony-laptop.c
> [PATCH 23/27] acpi: drivers/acpi/power.c
> [PATCH 24/27] acpi: drivers/misc/panasonic-laptop.c
> [PATCH 25/27] acpi: arch/ia64/sn/kernel/io_acpi_init.c
> [PATCH 26/27] acpi: arch/ia64/sn/kernel/io_common.c
> 
> [PATCH 27/27] ACPICA: Update version to 20081204

The problem with this series is that it is out of order.
patches 15-26 are build fixes in response to patch 14.

This will break any bisect that happens to fall between
when the build first broke and when the last fix was fixed.

The correct order is to apply the build fixes first,
and then when patch 14 is applied, nothing breaks.

-- Len Brown, Intel Open Source Technology Center

ps. s/acpi:/ACPI:/, and need more descriptive subjects
for the build fixes...
