From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] toshiba_acpi: depends on INPUT
Date: Fri, 10 Oct 2008 13:55:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101354040.7059@localhost.localdomain>
References: <20080919140659.2b526022.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:49355 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbYJJRzS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 13:55:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172069.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J003C2B44VNS2@vms172069.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 12:55:17 -0500 (CDT)
In-reply-to: <20080919140659.2b526022.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, akpm <akpm@linux-foundation.org>

not sure how you coaxed a =m on CONFIG_INPUT,
but this patch is fine, and applied to acpi-test.

thanks,
-Len


On Fri, 19 Sep 2008, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> CONFIG_ACPI_TOSHIBA can =y when CONFIG_INPUT=m, so prevent that
> combination and its subsequent build errors:
> 
> toshiba_acpi.c:(.text+0x3e877): undefined reference to `input_event'
> toshiba_acpi.c:(.text+0x3e98a): undefined reference to `input_unregister_polled_device'
> toshiba_acpi.c:(.text+0x3e994): undefined reference to `input_free_polled_device'
> toshiba_acpi.c:(.init.text+0x21b4): undefined reference to `input_allocate_polled_device'
> toshiba_acpi.c:(.init.text+0x2263): undefined reference to `input_register_polled_device'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/acpi/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20080918.orig/drivers/acpi/Kconfig
> +++ linux-next-20080918/drivers/acpi/Kconfig
> @@ -270,7 +270,7 @@ config ACPI_PANASONIC
>  
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
> -	depends on X86
> +	depends on X86 && INPUT
>  	select INPUT_POLLDEV
>  	select NET
>  	select RFKILL
> 
