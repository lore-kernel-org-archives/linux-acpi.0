From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] fix X[ ARRAY_SIZE(X) ]
Date: Sat, 17 Jan 2009 20:20:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901172020200.20606@localhost.localdomain>
References: <4971F06F.9030309@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:33034 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZARBU1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 20:20:27 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDN00F3B7Q17NY0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 17 Jan 2009 19:20:26 -0600 (CST)
In-reply-to: <4971F06F.9030309@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

applied

thanks,
--
Len Brown, Intel Open Source Technology Center

On Sat, 17 Jan 2009, Roel Kluin wrote:

> Ensure pcc->keymap[ ARRAY_SIZE(pcc->keymap) ] does not occur.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index f30db36..c47a44d 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -507,7 +507,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
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
