From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/3] fujitsu-laptop: fix section mismatch warning
Date: Thu, 06 Nov 2008 21:42:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062142280.3106@localhost.localdomain>
References: <200810292113.m9TLDLOO016596@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:37721 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYKGCpP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 21:45:15 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9X000IGZIZH1E0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 20:42:36 -0600 (CST)
In-reply-to: <200810292113.m9TLDLOO016596@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, randy.dunlap@oracle.com, jwoithe@physics.adelaide.edu.au

applied.

thanks,
-len

On Wed, 29 Oct 2008, akpm@linux-foundation.org wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Could fix a bug in a hotplug add scenario.
> 
> WARNING: drivers/misc/fujitsu-laptop.o(.text+0xbde): Section mismatch in reference from the function acpi_fujitsu_add() to the variable .init.data:fujitsu_dmi_table
> The function acpi_fujitsu_add() references
> the variable __initdata fujitsu_dmi_table.
> This is often because acpi_fujitsu_add lacks a __initdata
> annotation or the annotation of fujitsu_dmi_table is wrong.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/misc/fujitsu-laptop.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/misc/fujitsu-laptop.c~fujitsu-laptop-fix-section-mismatch-warning drivers/misc/fujitsu-laptop.c
> --- a/drivers/misc/fujitsu-laptop.c~fujitsu-laptop-fix-section-mismatch-warning
> +++ a/drivers/misc/fujitsu-laptop.c
> @@ -473,7 +473,7 @@ static int dmi_check_cb_p8010(const stru
>  	return 0;
>  }
>  
> -static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
> +static struct dmi_system_id fujitsu_dmi_table[] = {
>  	{
>  	 .ident = "Fujitsu Siemens S6410",
>  	 .matches = {
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
