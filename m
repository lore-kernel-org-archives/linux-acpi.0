From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Tue, 10 Apr 2007 16:29:18 -0700
Message-ID: <200704101629.18412.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <20070407050131.GB25511@kroah.com> <200704071308.07571.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:43429 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753671AbXDJX3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Apr 2007 19:29:37 -0400
In-Reply-To: <200704071308.07571.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Saturday 07 April 2007 1:08 pm, David Brownell wrote:

> By adding a warning over this create-links patch, I found that the
> system in the $SUBJECT patch (and likely every ACPI system) has
> two different nodes that correspond to one ACPI node:
> 
> 	/sys/devices/pci0000:00 ... pci root node
> 	/sys/devices/pnp0/00:00 ... id PNP0a03
> 	/sys/devices/acpi_system:00/device:00/PNP0A03:00 ... ditto
> 
> Arguably that's too many sysfs nodes for one device...

On a different system, I found a more interesting issue.

Specifically, pnp0/00:01 and pnp0:00/03 both have ids ... the appended
patch goes on top of the previous pnpacpi patch, and should (nyet tested!)
fix another place I saw that warning.

- Dave

=========	CUT HERE
Handle PNP devices that have the same IDs a bit more sanely ... I suspect
that pnp_dev.number should be compared with some acpi_device field to make
it hook up to a particular ACPI device, but I'll leave that to someone who
knows how that's supposed to work.  At least this will connect e.g. multiple
PNP nodes to ACPI nodes sharing the same PNP0c02 id.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/pnp/pnpacpi/core.c	2007-04-10 01:38:53.000000000 -0700
+++ g26/drivers/pnp/pnpacpi/core.c	2007-04-10 16:16:07.000000000 -0700
@@ -243,6 +243,7 @@ static int __init acpi_pnp_match(struct 
 
 	/* true means it matched */
 	return acpi->flags.hardware_id
+		&& !dev->archdata.acpi_handle
 		&& compare_pnp_id(pnp->id, acpi->pnp.hardware_id);
 }
 
