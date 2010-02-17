From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 17 Feb 2010 16:23:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
 <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
 <20100217183108.GA23189@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:43786 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab0BQVYY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2010 16:24:24 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY000BI08QUI613@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 17 Feb 2010 15:23:24 -0600 (CST)
In-reply-to: <20100217183108.GA23189@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Wed, 17 Feb 2010, Matthew Garrett wrote:

> On Wed, Feb 17, 2010 at 01:24:58PM -0500, Len Brown wrote:
> > On Wed, 17 Feb 2010, Matthew Garrett wrote:
> > > We seem to have no good history of where these blacklist entries came 
> > > from, and we know that at least one of them is actively harmful. Perhaps 
> > > replace them with a debug statement on affected machines telling people 
> > > what they need to pass to restore the blacklist behaviour, and to let us 
> > > know if it's necessary?
> > 
> > Actually, it wasn't actively harmful until we broke "acpi=ht".
> > Indeed, it was actively helpful in pointing out that regression:-)
> 
> The machines in question are falling back to apm, so probably losing 
> some level of powersaving support. I'd say that's harmful :)

The system at hand is the Asus P2B-DS, a Dual Pentium III.
APM is not SMP safe, and was not deployed on SMP motherboards.
My expectation is that it is perfectly fine running in MPS
mode rather than ACPI mode, as it has been running that way
since 2003.  My expectation is that when running in ACPI mode,
the only thing the user will notice is that the power button
is software controlled.

> > The other entries in today's acpi_dmi_table[] are less clear
> > and should probably be modified only with some care...
> 
> At least one of them covers a single submodel in a range, despite them 
> all running the same BIOS. I'd really lean towards them being bogus at 
> this stage of the game.

While I too vote for consistency and less cruft is better,
I'd like to keep the acpi_ht issue at hand apart from the
inconsistency in old thinkpad BIOS DMI list issue; as they
are logically independent.

thanks,
Len Brown, Intel Open Source Technology Center

