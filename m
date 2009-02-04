From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Tue, 03 Feb 2009 23:09:26 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902032304060.5607@localhost.localdomain>
References: <1233545621.3715.42.camel@localhost.localdomain>
 <200902031456.39680.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:24688 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbZBDEJ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 23:09:28 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEI00M2GWVRJZU2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Feb 2009 22:09:27 -0600 (CST)
In-reply-to: <200902031456.39680.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: yakui_zhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com

> I remember that Rui pointed me to a brightness level list, which included
> a value in AC/battery values which was not in the rest of the list.

if that is true, then I like your idea better.
we should make sure that the ac and dc values appear on the list.

> I expect simply ignoring battery/AC values is not right.
> I posted a patch a while ago which did:
>   - Go through the brightness values and extract from all (including
>     AC and battery) unique values
>   - Sort them
>   - Create a with the data a new list.
> Not sure whether this would have worked, but something is still
> missing. Currently we do not use battery/AC values, but what if we want
> do that, e.g. exporting them to userspace?

I should think that it would be prudent to expose the
ac and dc defaults to user-space -- allowing user-space
to over-ride them, and then on ac events doing the
brightness switch in the kernel.  That way it will work
even w/o teaching user-space new tricks.

thanks,
-Len

> > http://bugzilla.kernel.org/show_bug.cgi?id=12450
