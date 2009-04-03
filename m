From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Fri, 03 Apr 2009 12:52:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904031250010.4655@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <6cc056bc31ea9910afb01adc0848bb6ae68e0205.1238214620.git.len.brown@intel.com>
 <200903291317.48139.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:19594 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZDCQws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 12:52:48 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHJ0018TAVQLSEB@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 11:52:39 -0500 (CDT)
In-reply-to: <200903291317.48139.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

<adding linux-acpi>

On Sun, 29 Mar 2009, Matthias Welwarsky wrote:

> On Saturday 28 March 2009 05:31:33 you wrote:
> > From: Matthew Garrett <mjg59@srcf.ucam.org>
> >
> > Newer Vaios provide a full featured rfkill implementation via their
> > platform methods. Add support for enumerating the available devices and
> > providing rfkill access to them. Support for the physical kill switch is
> > added, with the devices moving into the HARD_BLOCKED state when toggled.
> 
> Bug: If you insert the module with hardware kill switch enabled, it cannot be 
> disabled any more, i.e. despite operating the hardware kill switch, devices 
> will not become enabled.
> 
> Any hint how I could debug this?
> 
> regards,
> 	matthias

Matthew,
Should we proceed with patch 58 and fix later, or scrap patch 58?

thanks,
-Len Brown, Intel Open Source Technology Center

