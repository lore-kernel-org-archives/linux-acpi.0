From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] panasonic-laptop: beyond ARRAY_SIZE of pcc->keymap
Date: Wed, 27 May 2009 18:14:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271812310.25587@localhost.localdomain>
References: <4A15B5CA.9060907@gmail.com> <20090522021933.GA10832@linux-sh.org>
 <4A1692F1.9010004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:17246 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZE0Wec (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 18:34:32 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKB008UTPSEA831@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 May 2009 17:14:39 -0500 (CDT)
In-reply-to: <4A1692F1.9010004@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

This patch already shipped in 2.6.29.

2b190e76def5233c542f6025b4a133b1d4bd1a37
"panasonic-laptop: fix X[ ARRAY_SIZE(X) ]"

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 22 May 2009, Roel Kluin wrote:

> Do not go beyond ARRAY_SIZE of pcc->keymap
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> > Presumably you meant to send this to linux-acpi or linux-kernel instead
> > of linux-sh ;-)
> 
> I was not sure, but linux-acpi is cc'ed now.
> 
> diff --git a/drivers/misc/panasonic-laptop.c b/drivers/misc/panasonic-laptop.c
> index 4a1bc64..d82d1cc 100644
> --- a/drivers/misc/panasonic-laptop.c
> +++ b/drivers/misc/panasonic-laptop.c
> @@ -515,7 +515,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
>  
>  	hkey_num = result & 0xf;
>  
> -	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(pcc->keymap)) {
> +	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>  				  "hotkey number out of range: %d\n",
>  				  hkey_num));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
