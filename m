From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 6/8] PNP: replace pnp_resource_table with dynamically allocated resources
Date: Wed, 14 May 2008 17:18:34 -0600
Message-ID: <200805141718.35158.bjorn.helgaas@hp.com>
References: <20080505223630.682082986@ldl.fc.hp.com> <20080505224000.013817328@ldl.fc.hp.com> <20080513194241.d11664df.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:31503 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYENXSe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 19:18:34 -0400
In-Reply-To: <20080513194241.d11664df.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>

On Tuesday 13 May 2008 08:42:41 pm Andrew Morton wrote:
> On Mon, 05 May 2008 16:36:36 -0600 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > PNP used to have a fixed-size pnp_resource_table for tracking the
> > resources used by a device.  This table often overflowed, so we've
> > had to increase the table size, which wastes memory because most
> > devices have very few resources.
> > 
> > This patch replaces the table with a linked list of resources where
> > the entries are allocated on demand.
> > 
> > This removes messages like these:
> > 
> >     pnpacpi: exceeded the max number of IO resources
> >     00:01: too many I/O port resources
> > 
> > References:
> > 
> >     http://bugzilla.kernel.org/show_bug.cgi?id=9535
> >     http://bugzilla.kernel.org/show_bug.cgi?id=9740
> >     http://lkml.org/lkml/2007/11/30/110
> > 
> > This patch also changes the way PNP uses the IORESOURCE_UNSET,
> > IORESOURCE_AUTO, and IORESOURCE_DISABLED flags.
> 
> This patch kills my prehistoric dual PIII.
> 
> http://userweb.kernel.org/~akpm/p5135912.jpg
> http://userweb.kernel.org/~akpm/config-vmm.txt
> http://userweb.kernel.org/~akpm/dmesg-vmm.txt

Thanks for the report.  I think I've fixed the problem.  You had
to remove the following three patches:

  pnp-replace-pnp_resource_table-with-dynamically-allocated-resources.patch
  pnp-remove-ratelimit-on-add-resource-failures.patch
  pnp-dont-sort-by-type-in-sys-resources.patch

I'll post a new set of four patches (I added one patch to fix this
problem) to replace those.  They should go at the same point in the
series as the three you removed.

Bjorn
