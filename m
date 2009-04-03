From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 21/98] ACPICA: Check for non-zero address before being
 converted to GAS
Date: Fri, 03 Apr 2009 12:41:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904031239540.4655@localhost.localdomain>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
 <5e053e77f233342b56fda419d347fd2c958b9849.1238214618.git.len.brown@intel.com>
 <200904021359.01408.trenn@suse.de>
 <1238720972.25165.2.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:54778 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757108AbZDCQlu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2009 12:41:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHJ00551ADHI95K@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 03 Apr 2009 11:41:41 -0500 (CDT)
In-reply-to: <1238720972.25165.2.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 3 Apr 2009, Lin Ming wrote:

> On Thu, 2009-04-02 at 19:59 +0800, Thomas Renninger wrote:
> > On Saturday 28 March 2009 05:30:56 Len Brown wrote:
> > > From: Lin Ming <ming.m.lin@intel.com>
> > > 
> > > Reported-by: FreeBSD community
> > > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > > Signed-off-by: Len Brown <len.brown@intel.com>
> > Does this fix something for real?
> 
> It's a regression fix.
> see "linux-next acpi changes make vmware server unusable"
> http://marc.info/?l=linux-acpi&m=123620365021296&w=2

To clarify...
this fix is in response to a regression caused by the previous patch
in this series.  That is why it doesn't need to go to .stable.

thanks,
-Len Brown, Intel Open Source Technology Center

