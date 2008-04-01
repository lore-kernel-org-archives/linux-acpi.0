From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/37] PNP resource_table cleanups, v2
Date: Tue, 01 Apr 2008 09:16:34 -0600
Message-ID: <20080401151634.730901933@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:4290 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbYDAPRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 11:17:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This series of patches does some PNP housecleaning and
consolidation.

PNP currently uses a fixed-size table (pnp_resource_table)
to track the IO, MMIO, IRQ, and DMA resources used by a
device.  Some motherboard devices have many resources, so
we've been plagued by table overflows and we've had to
drastically increase the table size, which wastes a lot
of memory.

The end goal is to replace that fixed-size table with something
more dynamic.  These patches don't go that far, but they do make
pnp_resource_table private to the PNP core and centralize all
references to it in a small set of shared functions.

In addition, this series contains a number of related
cleanups, like centralized allocation of struct pnp_dev,
conversion to dev_printk when possible, removing many
PNP core internal functions from the public interface,
and alignment of the ISAPNP, PNPBIOS, and PNPACPI backends.

Changes between first post and v2:

  - export pnp_get_resource()
  - fix EISA ID conversion and make a common function for ISAPNP/PNPBIOS
  - fix typos in pnp_check_{port,mem,etc} that made resource assign fail

  - the following fixes should precede this series (they're in -mm already):
	- parport_pc: wrap PNP probe code in CONFIG_PNP
	- radio-cadet: wrap PNP probe code in CONFIG_PNP
	- smsc-ircc2: wrap PNP probe code in CONFIG_PNP
	- nsc-ircc: wrap PNP probe code in CONFIG_PNP

Thanks to Rene Herman for finding and fixing the EISA ID and resource
check bugs.

Bjorn
-- 
