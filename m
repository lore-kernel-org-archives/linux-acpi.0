From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Thu, 25 Sep 2008 16:10:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809251609120.8839@localhost.localdomain>
References: <20080925170030.15311.27823.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:33892 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYIYUKH (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 16:10:07 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K7R00DSBPCT4I99@vms042.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Thu, 25 Sep 2008 15:10:06 -0500 (CDT)
In-reply-to: <20080925170030.15311.27823.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied to acpi-test

thanks,
-Len

On Thu, 25 Sep 2008, Alexey Starikovskiy wrote:

> It is easier and faster to do transaction directly from interrupt context
> rather than waking control thread.
> Also, cleaner GPE storm avoidance is implemented.
> References: 	http://bugzilla.kernel.org/show_bug.cgi?id=9998
> 		http://bugzilla.kernel.org/show_bug.cgi?id=10724
> 		http://bugzilla.kernel.org/show_bug.cgi?id=10919
> 		http://bugzilla.kernel.org/show_bug.cgi?id=11309
> 		http://bugzilla.kernel.org/show_bug.cgi?id=11549
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |  309 ++++++++++++++++++++++++++---------------------------
>  1 files changed, 149 insertions(+), 160 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 13593f9..7f0d81c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1,7 +1,7 @@
>  /*
> - *  ec.c - ACPI Embedded Controller Driver (v2.0)
> + *  ec.c - ACPI Embedded Controller Driver (v2.1)
>   *

