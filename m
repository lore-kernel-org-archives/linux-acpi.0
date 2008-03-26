From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 00/37] PNP resource_table cleanups
Date: Wed, 26 Mar 2008 11:10:58 -0600
Message-ID: <20080326171058.099442579@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:29079 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYCZRI0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 13:08:26 -0400
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

Bjorn
-- 
