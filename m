From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 81/98] thermal: support forcing support for passive cooling
Date: Fri, 03 Apr 2009 12:25:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904031224280.4655@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <03a971a2899886006f19f3495973bbd646d8bdae.1238214620.git.len.brown@intel.com>
 <200904021435.38561.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:46436 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934878AbZDCQZl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 12:25:41 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHJ00MHU9METPVR@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 11:25:27 -0500 (CDT)
In-reply-to: <200904021435.38561.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>


> > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > 
> > Due to poor thermal design or Linux driving hardware outside its thermal
> > envelope, some systems will reach critical temperature and shut down
> > under high load. This patch adds support for forcing a polling-based
> > passive trip point if the firmware doesn't provide one. The assumption
> > is made that the processor is the most practical means to reduce the
> > dynamic heat generation, so hitting the passive thermal limit will cause
> > the CPU to be throttled until the temperature stabalises around the
> > defined value.
> > 
> > UI is provided via a "passive" sysfs entry in the thermal zone
> > directory. It accepts a decimal value in millidegrees celsius, or "0" to
> > disable the functionality. Default behaviour is for this functionality
> > to be disabled.

> Isn't the last paragraph worth adding to:
> Documentation/thermal/sysfs-api.txt
> or have I missed this part?

I think you're right, Thomas.
Matthew -- can you update the doc to reflect this change?

thanks,
-Len

