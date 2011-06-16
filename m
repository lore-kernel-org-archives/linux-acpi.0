From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Wakeup and S states
Date: Thu, 16 Jun 2011 15:37:04 +0100
Message-ID: <20110616143703.GA15841@srcf.ucam.org>
References: <4DF8CBC3.5070801@cfl.rr.com>
 <20110615154457.GA13863@srcf.ucam.org>
 <4DFA09CB.9040909@iradimed.com>
 <20110616141517.GB15242@srcf.ucam.org>
 <4DFA13FD.6020304@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56073 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab1FPOhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 10:37:09 -0400
Content-Disposition: inline
In-Reply-To: <4DFA13FD.6020304@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Jun 16, 2011 at 10:32:29AM -0400, Phillip Susi wrote:
> On 6/16/2011 10:15 AM, Matthew Garrett wrote:
> >Yes. How would the kernel know that you don't want WoL in that case?
> 
> That was my original point; the kernel architecture seems lacking
> since it does not consider what S state you are talking about wrt
> wakeup capability and policy.  I can see the argument that policy
> should be dynamically changed in user space, but it seems that the
> kernel really needs to track the capability as it relates to S state
> so you don't try to enable wakeup in states where it is not
> possible.

But you're complaining about the case where wakeup is enabled in a case 
where it *is* possible. Userspace needs to take care of that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
