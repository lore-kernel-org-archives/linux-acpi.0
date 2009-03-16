From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] WMI patches for 2.6.29-rc5
Date: Sun, 15 Mar 2009 22:32:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152232200.29667@localhost.localdomain>
References: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:43521 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbZCPCdG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 22:33:06 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK005BGV2O4BL7@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 21:32:54 -0500 (CDT)
In-reply-to: <20090214095342.18550.24339.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org


> The following are a set of trivial patches for 2.6.29-rc5 for ACPI-WMI and
> acer-wmi. The last patch in this series you may already have picked up,
> but is reposted here for completeness sake.
> 
> -Carlos
> ---
> 
> Carlos Corbacho (2):
>       acer-wmi: Unmark as 'experimental'
>       ACPI: WMI: Unmark as 'experimental'
> 
> Dan Carpenter (1):
>       acer-wmi: double free in acer_rfkill_exit()
> 
> Robert Jarzmik (1):
>       acer-wmi: Fix acpi video detection
> 
> 
>  drivers/platform/x86/Kconfig    |    6 ++----
>  drivers/platform/x86/acer-wmi.c |    2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)

1-4 applied.

thanks,
Len Brown, Intel Open Source Technology Center

