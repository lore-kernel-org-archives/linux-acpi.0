From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] WMI patches for 2.6.28 (Resend)
Date: Wed, 08 Oct 2008 17:00:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810081700390.3041@localhost.localdomain>
References: <20081008204015.1815.15275.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:61882 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYJHVA4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 17:00:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172073.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8F00L40UDI9G22@vms172073.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 16:00:55 -0500 (CDT)
In-reply-to: <20081008204015.1815.15275.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

series applied to acpi-test.

thanks,
-len

On Wed, 8 Oct 2008, Carlos Corbacho wrote:

> Len,
> 
> The following are three WMI patches for 2.6.28 (resending them again, this
> is the same series I sent out a month ago).
> 
> The first two add rfkill support to acer-wmi for wireless & bluetooth, and
> remove the old sysfs interfaces for these.
> 
> The third patch, from Matthew Garrett, adds event enabling/ disabling for
> certain events to WMI, and is required for another WMI driver he's working
> on.
> 
> -Carlos
> ---
> 
> Carlos Corbacho (2):
>       acer-wmi: Remove wireless and bluetooth sysfs entries
>       acer-wmi: Add rfkill support for wireless and bluetooth
> 
> Matthew Garrett (1):
>       ACPI: WMI: Enable event methods when registering notifiers
> 
> 
>  Documentation/laptops/acer-wmi.txt |   28 +---
>  drivers/acpi/wmi.c                 |   39 ++++++
>  drivers/misc/Kconfig               |    1 
>  drivers/misc/acer-wmi.c            |  229 +++++++++++++++++++++++-------------
>  4 files changed, 191 insertions(+), 106 deletions(-)
> 
> -- 
> E-Mail: carlos@strangeworlds.co.uk
> Web: strangeworlds.co.uk
> GPG Key ID: 0x23EE722D
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
