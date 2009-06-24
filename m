From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] io_start uses unsigned int instead of int
Date: Tue, 23 Jun 2009 23:47:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906232346450.32742@localhost.localdomain>
References: <1243926700.9076.1.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57081 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZFXDrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 23:47:25 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLQ00F2356T48J5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 23 Jun 2009 22:47:19 -0500 (CDT)
In-reply-to: <1243926700.9076.1.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Rui,
Please send this to akpm cc: lkml

thanks,
Len Brown, Intel Open Source Technology Center

On Tue, 2 Jun 2009, Zhang Rui wrote:

> Not sure which mail list I should send to.
> 
> io_start uses unsigned int instead of int
> http://bugzilla.kernel.org/show_bug.cgi?id=13253
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/resource.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/resource.c
> ===================================================================
> --- linux-2.6.orig/kernel/resource.c
> +++ linux-2.6/kernel/resource.c
> @@ -787,7 +787,7 @@ static int __init reserve_setup(char *st
>  	static struct resource reserve[MAXRESERVE];
>  
>  	for (;;) {
> -		int io_start, io_num;
> +		unsigned int io_start, io_num;
>  		int x = reserved;
>  
>  		if (get_option (&str, &io_start) != 2)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
