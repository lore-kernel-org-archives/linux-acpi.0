From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Tue, 10 Apr 2007 17:10:50 -0700
Message-ID: <200704101710.50936.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <200704071308.07571.david-b@pacbell.net> <200704101629.18412.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:30264 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161104AbXDKAK4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Apr 2007 20:10:56 -0400
In-Reply-To: <200704101629.18412.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tuesday 10 April 2007 4:29 pm, David Brownell wrote:
> 	... the appended
> patch goes on top of the previous pnpacpi patch, and should (nyet tested!)
> fix another place I saw that warning.

And here's a tested version.  Curiouser and curiouser.  I think the mapping
of ACPI tables to sysfs nodes still needs a bunch of work...

- Dave

==========	CUT HERE
Handle PNP devices that have the same IDs a bit more sanely ... this at least
arranges multiple one-to-one mappings between PNP nodes and ACPI nodes that
all share the same PNP0c02 id.  (Maybe mapped to the wrong node though...)

This remains a hack, since it masks failures where PNP0a03 (a PCI root bridge)
is handled by ACPI special case code (/sys/devices/pci0000:00 on my systems
instead of /sys/devices/pnp0/pnp00:0/pci0000:00!) not pure PNPACPI logic.

I suspect that pnp_dev.number and some acpi_device field need to be compared,
(so the right PNP0c02 nodes hook up to each other, PNP0a03 likewise) but I'll
leave that to someone who knows how those ACPI table lookups "should" work.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/pnp/pnpacpi/core.c	2007-04-10 01:38:53.000000000 -0700
+++ g26/drivers/pnp/pnpacpi/core.c	2007-04-10 16:35:13.000000000 -0700
@@ -243,6 +243,7 @@ static int __init acpi_pnp_match(struct 
 
 	/* true means it matched */
 	return acpi->flags.hardware_id
+		&& !acpi_get_physical_device(acpi->handle)
 		&& compare_pnp_id(pnp->id, acpi->pnp.hardware_id);
 }
 
