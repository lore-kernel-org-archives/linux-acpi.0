From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/54] PNP cleanup, v4
Date: Fri, 25 Apr 2008 12:38:07 -0600
Message-ID: <20080425183807.366134771@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:18906 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbYDYSj1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 14:39:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

I'm still working through some issues with removing the
fixed pnp_resource_table.  But I'd like to get some of
the earlier patches off my plate, so here they are.  These
should be relatively safe because they don't really change
any fundamental behavior.  I'd like to get them in -mm
for some test time.

I'll start a new series for converting from a table to
a list.

I added some debug code for resource handling, so if you test
this and see problems, it would help me investigate them if you
collect the dmesg log with CONFIG_PNP_DEBUG turned on.

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
