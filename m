From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/5] acpi: toshiba_acpi.c fix sparse signedness mismatch
 warnings
Date: Fri, 10 Oct 2008 12:58:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101257550.7059@localhost.localdomain>
References: <200809222137.m8MLbUjg030999@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:33659 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759224AbYJJQ6G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 12:58:06 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J00I0D8GSWXC3@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 11:58:05 -0500 (CDT)
In-reply-to: <200809222137.m8MLbUjg030999@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, harvey.harrison@gmail.com, andi@firstfloor.org, hmh@hmh.eng.br, mjg59@srcf.ucam.org

applied.

thanks,
-Len

On Mon, 22 Sep 2008, akpm@linux-foundation.org wrote:

> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> set_bit expects unsigned int, and we start with a u32 anyway.
> drivers/acpi/toshiba_acpi.c:397:14: warning: incorrect type in argument 1 (different signedness)
> drivers/acpi/toshiba_acpi.c:397:14:    expected unsigned int [usertype] *word
> drivers/acpi/toshiba_acpi.c:397:14:    got int *<noident>
> drivers/acpi/toshiba_acpi.c:399:14: warning: incorrect type in argument 1 (different signedness)
> drivers/acpi/toshiba_acpi.c:399:14:    expected unsigned int [usertype] *word
> drivers/acpi/toshiba_acpi.c:399:14:    got int *<noident>
> drivers/acpi/toshiba_acpi.c:401:14: warning: incorrect type in argument 1 (different signedness)
> drivers/acpi/toshiba_acpi.c:401:14:    expected unsigned int [usertype] *word
> drivers/acpi/toshiba_acpi.c:401:14:    got int *<noident>
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/toshiba_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/toshiba_acpi.c~acpi-toshiba_acpic-fix-sparse-signedness-mismatch-warnings drivers/acpi/toshiba_acpi.c
> --- a/drivers/acpi/toshiba_acpi.c~acpi-toshiba_acpic-fix-sparse-signedness-mismatch-warnings
> +++ a/drivers/acpi/toshiba_acpi.c
> @@ -548,7 +548,7 @@ static unsigned long write_video(const c
>  
>  	hci_read1(HCI_VIDEO_OUT, &video_out, &hci_result);
>  	if (hci_result == HCI_SUCCESS) {
> -		int new_video_out = video_out;
> +		unsigned int new_video_out = video_out;
>  		if (lcd_out != -1)
>  			_set_bit(&new_video_out, HCI_VIDEO_OUT_LCD, lcd_out);
>  		if (crt_out != -1)
> _
> 
