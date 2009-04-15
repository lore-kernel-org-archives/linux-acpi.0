From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI vs. hibernate on MacBook5,1
Date: Wed, 15 Apr 2009 12:13:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904151208130.5664@localhost.localdomain>
References: <1239802480.9071.14.camel@johannes.local>
 <20090415135620.GB12481@kamineko.org> <1239810531.6981.6.camel@johannes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:33417 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZDOQNw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 12:13:52 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KI500DS7H30HZ1B@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 15 Apr 2009 11:13:49 -0500 (CDT)
In-reply-to: <1239810531.6981.6.camel@johannes.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 15 Apr 2009, Johannes Berg wrote:

> On Wed, 2009-04-15 at 22:56 +0900, Mattia Dongili wrote:
> > On Wed, Apr 15, 2009 at 03:34:39PM +0200, Johannes Berg wrote:
> > > Recently, since I upgraded to -rc1, I've been seeing this at hibernate:
> > > 
> > > [13875.384603] ACPI: Preparing to enter system sleep state S4
> > > [13875.385232] ACPI Error (hwvalid-0186): Denied AML access to port 0x0000000000000080/2 (DMA1 0x0081-0x0083) [20090320]
> > > [13875.385745] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by Handler for [SystemIO] [20090320]
> > > [13875.386244] ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
> > > [13875.386896] ACPI Error (psparse-0537): Method parse/execution failed [\_PTS] (Node ffff88007e44edd0), AE_AML_ILLEGAL_ADDRESS
> > > [13875.387584] PM: Saving platform NVS memory
> > 
> > there are patches for this here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=13036
> > This should be the final one:
> > http://bugzilla.kernel.org/attachment.cgi?id=20913
> > Does it help?
> 
> Thanks, I'll give it a try later, but it seems like it would help to get
> rid of the warnings, and the random delays I'm seeing are probably
> something else.

Agreed.
The AML is doing a 2-byte write to port 80.
Linux complains b/c we told it that port 81 is protected,
and we throw away the write.

However, port 80 is just the debug port, so I think that
this blocking and this warning will have no effect on
the function of your system.

BTW.
this message should be gone in 2.6.30-rc2, as we deleted the block
for port 81 until we could figure out the path that we took in
the bugzilla above.

commit fdbdc7fc79c02ae4ede869d514179a2c65633d28
Author: Len Brown <len.brown@intel.com>
Date:   Tue Apr 7 17:33:58 2009 -0400

    ACPICA: delete check for AML access to port 0x81-83


thanks,
Len Brown, Intel Open Source Technology Center

