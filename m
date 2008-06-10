From: Len Brown <lenb@kernel.org>
Subject: Re: [patch (for 2.6.26?) 2/2] acpi: fix drivers/acpi/glue.c build error
Date: Tue, 10 Jun 2008 12:14:08 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101212360.14381@localhost.localdomain>
References: <200806092348.m59NmJnC015625@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:63950 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYFJQU3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 12:20:29 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2900MHD93MIOJ7@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 10 Jun 2008 11:14:12 -0500 (CDT)
In-reply-to: <200806092348.m59NmJnC015625@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, mingo@elte.hu, bjorn.helgaas@hp.com



On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> x86.git testing found the following build bug:
> 
>   drivers/built-in.o: In function `acpi_rtc_init':
>   glue.c:(.init.text+0x16c3): undefined reference to `pnp_bus_type'
> 
> this tries to use PNP bus infrastructure even in the !PNP case.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/glue.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -puN drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error drivers/acpi/glue.c
> --- a/drivers/acpi/glue.c~acpi-fix-drivers-acpi-gluec-build-error
> +++ a/drivers/acpi/glue.c
> @@ -303,6 +303,7 @@ static void rtc_wake_off(struct device *
>  
>  static struct cmos_rtc_board_info rtc_info;
>  
> +#ifdef CONFIG_PNP
>  
>  /* PNP devices are registered in a subsys_initcall();
>   * ACPI specifies the PNP IDs to use.
> @@ -364,4 +365,6 @@ static int __init acpi_rtc_init(void)
>  /* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
>  fs_initcall(acpi_rtc_init);
>  
> +#endif /* CONFIG_PNP */
> +
>  #endif

ENOREPRODUCE

I'm unable to convince "make oldconfig" to allow a
CONFIG_ACPI=y CONFIG_PNP=n build.

-Len

