From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] fujitsu-laptop: fix section mismatch warning
Date: Wed, 08 Oct 2008 20:25:45 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810082023460.3041@localhost.localdomain>
References: <48ED249B.7050908@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:60004 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYJIAZs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 20:25:48 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8G001NU3UZFHE6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 19:25:47 -0500 (CDT)
In-reply-to: <48ED249B.7050908@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, akpm <akpm@linux-foundation.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

applied to acpi-test.

thanks,
-Len

On Wed, 8 Oct 2008, Randy Dunlap wrote:

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
> cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> ---
>  drivers/misc/fujitsu-laptop.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lin2627-r9g1-sections.orig/drivers/misc/fujitsu-laptop.c
> +++ lin2627-r9g1-sections/drivers/misc/fujitsu-laptop.c
> @@ -455,7 +455,7 @@ static int dmi_check_cb_s6410(const stru
>  	return 0;
>  }
>  
> -static struct dmi_system_id __initdata fujitsu_dmi_table[] = {
> +static struct dmi_system_id fujitsu_dmi_table[] = {
>  	{
>  	 .ident = "Fujitsu Siemens",
>  	 .matches = {
> 
