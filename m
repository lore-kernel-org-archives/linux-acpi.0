From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v4] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Tue, 30 Oct 2007 13:47:01 +0000
Message-ID: <20071030134701.GA11877@srcf.ucam.org>
References: <200710300336.43696.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:47704 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbXJ3NrQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 09:47:16 -0400
Content-Disposition: inline
In-Reply-To: <200710300336.43696.cathectic@slackadelic.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <cathectic@slackadelic.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, Oct 30, 2007 at 03:36:43AM +0000, Carlos Corbacho wrote:

> Event handling - allow a WMI based driver to register a notifier handler
> with WMI. When a notification is sent to WMI, WMI will execute _WED and
> then pass the results and the event to the external handler (since WMI
> does not know the meaning of an event, it is left to the external drivers
> to deal with, rather than WMI exporting the event to userspace).

I suspect that for a lot of cases, exporting this to userspace would be 
helpful - it's often easier for us to do this mapping in hal and just 
push out an updated fdi file than it would be to push out an updated 
kernel driver.

> Userspace - the WMI mapper disregards the WMI-ACPI spec on this point, and
> does _not_ try to export to userspace, since WMI does not exist on Linux.
> All callers of the WMI mapper are assumed to be kernel space drivers.

And for similar reasons, I think it would be helpful to provide 
userspace with the ability to trigger WMI calls. It's going to be easier 
for people to add GUIDs to a userspace file than to extend a kernel 
driver, even if there are some cases that are better handled by having a 
full in-kernel driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
