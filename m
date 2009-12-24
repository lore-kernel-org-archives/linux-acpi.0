From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] x86 platform drivers, hp-wmi: Fix two memleaks
Date: Thu, 24 Dec 2009 00:56:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912240054570.6541@localhost.localdomain>
References: <1261146563-2228-1-git-send-email-trenn@suse.de>
 <1261146563-2228-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:42903 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZLXF5V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 00:57:21 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV500GG377691S5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Dec 2009 23:57:09 -0600 (CST)
In-reply-to: <1261146563-2228-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org



thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 18 Dec 2009, Thomas Renninger wrote:

> CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: linux-acpi@vger.kernel.org
> CC: Len Brown <lenb@kernel.org>
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/platform/x86/hp-wmi.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 63c3e65..01a0913 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -134,10 +134,15 @@ static int hp_wmi_perform_query(int query, int write, int value)
>  
>  	obj = output.pointer;
>  
> -	if (!obj || obj->type != ACPI_TYPE_BUFFER)
> +	if (!obj)
>  		return -EINVAL;
> +	else if (obj->type != ACPI_TYPE_BUFFER) {
> +		kfree(obj);
> +		return -EINVAL;
> +	}
>  
>  	bios_return = *((struct bios_return *)obj->buffer.pointer);
> +	kfree(obj);
>  	if (bios_return.return_code > 0)
>  		return bios_return.return_code * -1;
>  	else
> @@ -340,10 +345,13 @@ static void hp_wmi_notify(u32 value, void *context)
>  
>  	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
>  		printk(KERN_INFO "HP WMI: Unknown response received\n");
> +		if (obj)
> +			kfree(obj);

WARNING: kfree(NULL) is safe this check is probably not required
#44: FILE: drivers/platform/x86/hp-wmi.c:349:
+		if (obj)
+			kfree(obj);

so I deleted "if(obj)" above and applied the patch.

thanks,
Len Brown, Intel Open Source Technology Center

>  		return;
>  	}
>  
>  	eventcode = *((u8 *) obj->buffer.pointer);
> +	kfree(obj);
>  	if (eventcode == 0x4)
>  		eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
>  						0);
> -- 

