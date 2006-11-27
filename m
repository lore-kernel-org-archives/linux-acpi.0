From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Patch] Default values for asus_acpi
Date: Mon, 27 Nov 2006 17:39:27 +0100
Message-ID: <1164645567.4656.199.camel@queen.suse.de>
References: <200611121422.29019.corentincj@iksaif.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50068 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758385AbWK0Qjk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 11:39:40 -0500
In-Reply-To: <200611121422.29019.corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

On Sun, 2006-11-12 at 14:22 +0100, Corentin CHARY wrote:
> With the current default values, unsuported laptops usualy get a lot of "Asus 
> ACPI: Error reading LCD status" in dmesg. And it's also a problem for apps 
> like kmilo : http://bugs.kde.org/show_bug.cgi?id=102374 .
> So, I think default values should be changed..
IMO the asus_acpi module should not load at all if the model is not
supported.
I've posted a patch to do so a while ago.
The main problem (beside side affects you mention above), is that there
exist sony laptops which provide the sony ACPI device to handle things
(not sure any more what exactly, hotkeys, ...?) and an asus ACPI device.
There, if both modules load even worse things happen like machine
freeze, etc....

The patch should have a message like: "Unsupported Asus model, pls post
acpidump output to linux-acpi@vger.kernel.org or
acpi4asus-user@lists.sourceforge.net to help supporting this one."
Like that those Asus models' ACPI implementation should become much more
robust.

     Thomas

> For example :
> 
> --- linux-2.6.19-rc5/drivers/acpi/asus_acpi.c	2006-11-08 03:24:20.000000000 
> +0100
> +++ asus_acpi.c	2006-11-12 14:10:03.000000000 +0100
> @@ -141,6 +141,7 @@
>  		W3V,            //W3030V
>  		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
>  		//(Centrino)
> +		DEF,            //Others ...
>  		END_MODEL
>  	} model;		//Models currently supported
>  	u16 event_count[128];	//count for each event TODO make this better
> @@ -396,7 +397,19 @@
>  	 .brightness_set = "SPLV",
>  	 .brightness_get = "GPLV",
>  	 .display_set = "SDSP",
> -	 .display_get = "\\ADVG"}
> +	 .display_get = "\\ADVG"},
> +
> +	{
> +	 .name = "???",
> +	 .mt_mled = "MLED",
> +	 .mt_wled = "WLED",
> +	 /* lcd_switch not supported as lcd_status is needed,
> +	    but never the same */
> +	 .brightness_set = "SPLV",
> +	 .brightness_get = "GPLV",
> +	 .display_set = "SDSP",
> +	 .display_get = "\\INFB"}, /* Most of the time, it's \\INFB */
> +
>  };
>  
>  /* procdir we use */
> @@ -1177,7 +1190,7 @@
>  			printk(KERN_NOTICE
>  			       "  Samsung P30 detected, supported\n");
>  		} else {
> -			hotk->model = M2E;
> +			hotk->model = DEF;
>  			printk(KERN_NOTICE "  unsupported model %s, trying "
>  			       "default values\n", string);
>  			printk(KERN_NOTICE
> 
> 

