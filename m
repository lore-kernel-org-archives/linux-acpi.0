From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/55] PNP cleanup, v5
Date: Mon, 28 Apr 2008 16:33:47 -0600
Message-ID: <20080428223347.233593713@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:42983 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934483AbYD1WgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Apr 2008 18:36:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

I'm trying to stabilize something so we can get it into -mm, 
so this only addresses Rene's comments on v4. 

As a reminder, if anybody tests this and sees problems, the
dmesg log with CONFIG_PNP_DEBUG enabled would be a great help
to me.

Changes between v4 and v5:

  - moved #ifdef DEBUG inside dbg_pnp_show_resources()
  - removed cast of flags to int; print the long directly
  - changed printk "0x%x" to "%#x"
  - set "type" in pnp_clean_resource_table()
  - fix return type of pnp_{port,mem,irq,dma}_flags()
  - new patch converts pnp_assign_*() and /sys interfaces to pnp_get_resource()
  - added Rene's acks

Changes between v3 and v4:

  - changed pnp_check_port(), etc., to take resource instead of index
  - added some decoder/encoder/assign debug output (under CONFIG_PNP_DEBUG)
  - fixed some ISAPNP register index bisectability problems
  - removed the list-based resource management (will work on that separately)

Changes between v2 and v3:

  - several updates from Rene Herman's review:
	- tweak EISA ID conversion and keep high-order bit for ISAPNP
	- fix pnp_add_card_id() so bisection works better
	- fix some "x <= 0" tests when x is unsigned
	- make resource accessors inlines, not #defines
	- fix pnp_{port,mem,irq,dma}_valid() return int, not resource_size_t
	- fold isapnp_read_resources() back into isapnp_get_resources()
  - factored out pnp_init_resource() from pnp_{init,clean}_resource_table()
  - initialize generic pnp_dev fields earlier, to help dev_printk
  - add pnp_resource to hold ISAPNP register index
  - convert to resource management from table to list (finally)
  - remove pnp_dev->regs (only set by ISAPNP, never used)
  - in /sys/.../resources, don't sort resources by type

Changes between first post and v2:

  - export pnp_get_resource()
  - fix EISA ID conversion and make a common function for ISAPNP/PNPBIOS
  - fix typos in pnp_check_{port,mem,etc} that made resource assign fail

  - the following fixes should precede this series (they're in -mm already):
	- parport_pc: wrap PNP probe code in CONFIG_PNP
	- radio-cadet: wrap PNP probe code in CONFIG_PNP
	- smsc-ircc2: wrap PNP probe code in CONFIG_PNP
	- nsc-ircc: wrap PNP probe code in CONFIG_PNP

Bjorn

-- 
