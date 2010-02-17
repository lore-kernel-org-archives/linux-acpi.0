From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Wed, 17 Feb 2010 13:24:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:35091 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0BQSZZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2010 13:25:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY0000MG0HSB6O2@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 17 Feb 2010 12:25:08 -0600 (CST)
In-reply-to: <20100217143245.GA18411@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

On Wed, 17 Feb 2010, Matthew Garrett wrote:

> On Tue, Feb 16, 2010 at 09:49:03PM -0500, Len Brown wrote:
> 
> > In the future, I'll consider deleting the "acpi=ht"
> > option all together, and the blacklist with it,
> > but such changes are always harder than expected.
> 
> We seem to have no good history of where these blacklist entries came 
> from, and we know that at least one of them is actively harmful. Perhaps 
> replace them with a debug statement on affected machines telling people 
> what they need to pass to restore the blacklist behaviour, and to let us 
> know if it's necessary?

Actually, it wasn't actively harmful until we broke "acpi=ht".
Indeed, it was actively helpful in pointing out that regression:-)

Yes, I think that a warning for a release or so before deleting
some of these entries would make sense -- good idea.

Re: history...
unfortunately old-2.6-bkcvs history is nearly useless,
but bkbits still seems to work.

It shows I pulled this DMI list from Linux-2.4 to Linux-2.6
on 2003-08-09, and that it originally came from Suse:

"pull DMI blacklist from UnitedLinux via 2.4 for disabling ACPI on bad 
BIOS boxes.  This also sets ACPI_BLACKLIST_CUTOFF_YEAR = 2001"

http://linux.bkbits.net:8080/linux-2.6.11-stable/arch/i386/kernel/dmi_scan.c?PAGE=diffs&REV=3f35b565a8XFxBnmR2yf-97PQRqW3Q

I think that move was a short term good idea,
but a long term bad idea.

It looks like we have added no forc_acpi_ht entries since 2003,
but we have deleted a bunch of them.  So it may indeed be time
for the force_acpi_ht, and perhaps the "acpi=ht" option to go.

The other entries in today's acpi_dmi_table[] are less clear
and should probably be modified only with some care...

I'll spin a patch for the acpi=ht part.

thanks,
-Len Brown, Intel Open Source Technology Center


