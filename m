From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/6] eeepc-laptop: enable Bluetooth for Asus EEE 901
Date: Fri, 09 Jan 2009 16:24:09 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091623400.16697@localhost.localdomain>
References: <200901092017.n09KHA3E014942@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49318 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbZAIVYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:24:15 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD800B733GDP669@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:24:14 -0600 (CST)
In-reply-to: <200901092017.n09KHA3E014942@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, santiago@crfreenet.org, corentincj@iksaif.net, mjg59@srcf.ucam.org

the original version of this patch is already in my tree
queued for linus.

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:

> From: Ondrej Zajicek <santiago@crfreenet.org>
> 
> eeepc-laptop driver has interface for enabling/disabling Bluetooth, but it
> does not work.  This patch fixes it.
> 
> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Corentin Chary <corentincj@iksaif.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/platform/x86/eeepc-laptop.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-enable-bluetooth-for-asus-eee-901 drivers/platform/x86/eeepc-laptop.c
> --- a/drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-enable-bluetooth-for-asus-eee-901
> +++ a/drivers/platform/x86/eeepc-laptop.c
> @@ -90,7 +90,7 @@ enum {
>  };
>  
>  static const char *cm_getv[] = {
> -	"WLDG", NULL, NULL, NULL,
> +	"WLDG", "BTHG", NULL, NULL,
>  	"CAMG", NULL, NULL, NULL,
>  	NULL, "PBLG", NULL, NULL,
>  	"CFVG", NULL, NULL, NULL,
> @@ -99,7 +99,7 @@ static const char *cm_getv[] = {
>  };
>  
>  static const char *cm_setv[] = {
> -	"WLDS", NULL, NULL, NULL,
> +	"WLDS", "BTHS", NULL, NULL,
>  	"CAMS", NULL, NULL, NULL,
>  	"SDSP", "PBLS", "HDPS", NULL,
>  	"CFVS", NULL, NULL, NULL,
> _
> 
