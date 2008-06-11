From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND] [PATCH] Fujitsu-laptop update
Date: Wed, 11 Jun 2008 04:17:20 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806110415380.4233@localhost.localdomain>
References: <200806110044.m5B0iutE015287@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62018 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbYFKIRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 04:17:43 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A00JB8HOXZXNB@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 03:17:23 -0500 (CDT)
In-reply-to: <200806110044.m5B0iutE015287@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org



On Wed, 11 Jun 2008, Jonathan Woithe wrote:

> Hi Len
> 
> > Thanks for the ping, yes, this one slipped through the cracks
> > and I can drop it intot he acpi-test tree.
> 
> Thanks.
> 
> > Should we add you to MAINTAINERS for this driver?
> 
> I'm happy for this to happen if you feel it's a good idea.  A patch doing
> this is included at the end of this email.
> 
> > this patch fails scripts/checkpatch.pl in an number of ways,
> 
> Oops, so it does.  Sorry about that.
> 
> > and it fails to apply due to a small patch that akpm sent to linus on this 
> > file.
> > please refresh and resend.
> 
> Done - see below.

applied to acpi-test
(I'm don't going to worry about the 80-column violations -- don't tell 
the style police:-)

thanks,
-Len

