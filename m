From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Fix compile warning CONFIG_I7300_IDLE_IOAT_CHANNEL not
 defined
Date: Fri, 24 Oct 2008 13:02:18 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810241302130.3056@localhost.localdomain>
References: <20081023223906.GA26918@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:58425 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYJXRC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 13:02:26 -0400
In-reply-to: <20081023223906.GA26918@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

applied.

thanks,
-len

On Thu, 23 Oct 2008, Venki Pallipadi wrote:

> 
> When I7300_idle driver is not configured, there is a compile time
> warning about IDLE_IOAT_CHANNEL not defined. Fix it.
> 
> Reported-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  drivers/dma/ioat_dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/dma/ioat_dma.c
> ===================================================================
> --- linux-2.6.orig/drivers/dma/ioat_dma.c	2008-10-23 15:27:43.000000000 -0700
> +++ linux-2.6/drivers/dma/ioat_dma.c	2008-10-23 15:28:03.000000000 -0700
> @@ -171,7 +171,7 @@ static int ioat_dma_enumerate_channels(s
>  	xfercap_scale = readb(device->reg_base + IOAT_XFERCAP_OFFSET);
>  	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
>  
> -#if CONFIG_I7300_IDLE_IOAT_CHANNEL
> +#ifdef CONFIG_I7300_IDLE_IOAT_CHANNEL
>  	device->common.chancnt--;
>  #endif
>  	for (i = 0; i < device->common.chancnt; i++) {
> 
