From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] acer-wmi patches for 2.6.30 (take 2)
Date: Sat, 04 Apr 2009 12:43:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904041242490.4821@localhost.localdomain>
References: <20090404083323.14302.40102.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:46151 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZDDQoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 12:44:23 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHL00C1J55WZHX4@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 04 Apr 2009 11:44:21 -0500 (CDT)
In-reply-to: <20090404083323.14302.40102.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Sat, 4 Apr 2009, Carlos Corbacho wrote:

> Len,
> 
> The following are the patches that really are for 2.6.30-rc0 for acer-wmi.
> 
> The first one is quite a nasty one, as it appears the Aspire One's
> non-functional ACPI-WMI interface is now causing problems for userspace.
> 
> -Carlos
> ---
> 
> Andy Whitcroft (1):
>       acer-wmi: Cleanup the failure cleanup handling
> 
> Carlos Corbacho (2):
>       acer-wmi: Update copyright notice & documentation
>       acer-wmi: Blacklist Acer Aspire One
> 
> 
>  Documentation/laptops/acer-wmi.txt |   10 +++++++---
>  drivers/platform/x86/acer-wmi.c    |   35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
