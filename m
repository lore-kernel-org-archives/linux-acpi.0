From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Disable Vista compatibility for Sony VGN-NS50B_L
Date: Thu, 10 Jun 2010 11:30:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006101129190.4129@localhost.localdomain>
References: <1275982120.19052.11515.camel@rzhang1-desktop>
 <alpine.LFD.2.00.1006091755080.1402@localhost.localdomain>
 <20100609222809.GA29937@srcf.ucam.org>
 <1276132054.19052.14072.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:64770 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0FJPbM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 11:31:12 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3T00IG81RL5BT5@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 10 Jun 2010 10:30:58 -0500 (CDT)
In-reply-to: <1276132054.19052.14072.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "harestomper@gmail.com" <harestomper@gmail.com>


On Thu, 10 Jun 2010, Zhang Rui wrote:

> On Thu, 2010-06-10 at 06:28 +0800, Matthew Garrett wrote:
> > On Wed, Jun 09, 2010 at 05:55:22PM -0400, Len Brown wrote:
> > > applied
> > 
> > Len, as mentioned, there's absolutely no way that this can be the 
> > correct fix. Could you make note of that in the commit?
> > 
> agree.

I put it on a branch called bugzilla-102904-workaround,
but I'll add a note that it is just a workaround to the commit message.

Of course we claim that we are compatible with the latest windows
but frankly, discovering what compatible means is an ongoing process...

thanks,
Len Brown, Intel Open Source Technology Center


