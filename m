From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between ACPI
 video driver and i915 driver
Date: Thu, 23 Apr 2009 15:56:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904231552550.15830@localhost.localdomain>
References: <1239678275.5564.66.camel@localhost.localdomain>
 <20090415205656.GA32509@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:47440 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZDWT4q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 15:56:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIK000WGKQ3GMB3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 14:56:28 -0500 (CDT)
In-reply-to: <20090415205656.GA32509@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 15 Apr 2009, Matthew Garrett wrote:

> How about we just replace these with the following?
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 3a22eb9..cf7e7c2 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -71,6 +71,7 @@ config DRM_I915
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	select FB
> +	select ACPI_VIDEO if ACPI
>  	tristate "i915 driver"
>  	help
>  	  Choose this option if you have a system that has Intel 830M, 845G,
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
