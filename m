From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/8] acpi: check for pxm_to_node_map overflow
Date: Sun, 15 Mar 2009 23:47:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152347050.30317@localhost.localdomain>
References: <200903041955.n24JtUTS028013@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:59250 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZCPDrP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:47:15 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK00KAPYIPX22N@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:47:14 -0500 (CDT)
In-reply-to: <200903041955.n24JtUTS028013@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, gorcunov@gmail.com, gorcunov@openvz.org

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

> From: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> It is hardly (if ever) possible but in case of broken _PXM entry we could
> reach out of pxm_to_node_map array bounds in acpi_map_pxm_to_node() call.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/numa.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/numa.c~acpi-check-for-pxm_to_node_map-overflow drivers/acpi/numa.c
> --- a/drivers/acpi/numa.c~acpi-check-for-pxm_to_node_map-overflow
> +++ a/drivers/acpi/numa.c
> @@ -277,7 +277,7 @@ int acpi_get_node(acpi_handle *handle)
>  	int pxm, node = -1;
>  
>  	pxm = acpi_get_pxm(handle);
> -	if (pxm >= 0)
> +	if (pxm >= 0 && pxm < MAX_PXM_DOMAINS)
>  		node = acpi_map_pxm_to_node(pxm);
>  
>  	return node;
> _
> 
