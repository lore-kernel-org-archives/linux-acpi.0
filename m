From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: print out a warning message when duplicate
 video bus devices under the same VGA controller are detected
Date: Mon, 28 Dec 2009 21:40:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912282138090.12663@localhost.localdomain>
References: <1259140608.10510.62.camel@rzhang1-desktop>
 <alpine.LFD.2.00.0911251638220.3950@localhost.localdomain>
 <1259197533.10510.76.camel@rzhang1-desktop>
 <20091126051008.GB7874@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22470 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZL2ClJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2009 21:41:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVE00DVN7G34MR5@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 28 Dec 2009 20:40:56 -0600 (CST)
In-reply-to: <20091126051008.GB7874@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

lets do this:

take this patch and modify it so that by default it fixes the bug
filed in http://bugzilla.kernel.org/show_bug.cgi?id=13577
ie. by default do what Windows 2006 seems to do and use the 1st
and ignore the duplicates.

continue to print out the warning, so we have some clue
how much we see this in the field.

and also modify the patch so that in case we are guessing wrong
about windows compatibility, we go back to current behaviour
and allow multiple devices.  say video.allow_duplicates or something

thanks,
Len Brown, Intel Open Source Technology Center

