From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 06/98] acpi: fix of pmtimer overflow that make Cx states
 time incorrect
Date: Fri, 03 Apr 2009 12:22:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904031215240.4655@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <ff69f2bba67bd45514923aaedbf40fe351787c59.1238214617.git.len.brown@intel.com>
 <200904021426.41828.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44457 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936771AbZDCQWr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 12:22:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHJ00BHN9HHE8T0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 11:22:30 -0500 (CDT)
In-reply-to: <200904021426.41828.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: stable@kernel.org, linux-acpi@vger.kernel.org, "alex.shi" <alex.shi@intel.com>, "Yakui.zhao" <yakui.zhao@intel.com>, Andrew Morton <akpm@linux-foundation.org>


> Is this worth adding:
> CC: stable@kernel.org
> but wait until 2.6.30 is finished and no regressions have been reported?
> Then backport things to .29/.28 and eventually others?

possibly -- lets re-visit, say at rc3.

What happens when this is not applied is that the accounting gets screwed 
up, powertop looks wrong, and in rare cases -- non-optimal 
c-state selection decisions could be made.

So the actual symptom is mostly cosmetic -- but the possibility of 
puzzled or even alarmed users may be justification to backport.

But as this will not happen on most machines, and the failure is not 
severe, I don't hink a crusade to backport to every possible old release 
would make sense.

thanks,
-Len Brown, Intel Open Source Technology Center

