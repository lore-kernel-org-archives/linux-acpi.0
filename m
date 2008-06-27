From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH 1/2] ACPI: allow enable/disable/clear ACPI interrupts
 in user space
Date: Thu, 26 Jun 2008 22:49:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806262246410.2988@localhost.localdomain>
References: <1213926167.3001.9.camel@rzhang-dt.sh.intel.com>
 <alpine.LFD.1.10.0806200132080.22284@localhost.localdomain>
 <alpine.LFD.1.10.0806200252290.22284@localhost.localdomain>
 <1214276318.3001.58.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:50110 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYF0Ctd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 22:49:33 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K330031DP5XVHI8@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 26 Jun 2008 21:49:11 -0500 (CDT)
In-reply-to: <1214276318.3001.58.camel@rzhang-dt.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>


> Re-based the patch on top of linux-acpi test branch.
> No functional change, just fixed some conflicts introduced by
> 4fe0a2f25ed36949330dbda0154a4a701f310462

I'm an idiot.
The problem was that Lindent commit that I should not have 
checked in before your patch.  Sorry i created work for you.

I reverted the Lindent patch, applied your original,
and will then Lindent the result -- assuming I can
tame Lindent to be more deterinistic...

thanks,
-Len


