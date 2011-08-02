From: Len Brown <lenb@kernel.org>
Subject: Re: Missing ACPI documentation
Date: Tue, 02 Aug 2011 17:14:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108021713440.25237@x980>
References: <20110704175208.15a11789@lxorguk.ukuu.org.uk>
 <20110704101135.967f73d6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:53933 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab1HBVOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:14:42 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00JCHKCB6CL3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:14:36 -0500 (CDT)
In-reply-to: <20110704101135.967f73d6.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-acpi@vger.kernel.org


> > Documentation/kernel-parametes.txt
> > 
> > Says for acpi=
> > 
> > 			See also Documentation/power/pm.txt, pci=noacpi
> > 
> > but this file does not exist
> 
> maybe Documentation/pm/basic-pm-debugging.txt:

No, I think it is just stale.  All the acpi= options
are included right there in kernel-parameters.txt.

will delete.

thanks,
-Len
