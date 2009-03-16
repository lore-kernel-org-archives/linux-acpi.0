From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/8] acpi: bus.c, remove doubled status checking
Date: Sun, 15 Mar 2009 23:42:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152342190.30317@localhost.localdomain>
References: <200903041955.n24JtSHW028000@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:62966 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbZCPDmd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:42:33 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK000ENYAVRGSK@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:42:32 -0500 (CDT)
In-reply-to: <200903041955.n24JtSHW028000@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, jirislaby@gmail.com

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

> From: Jiri Slaby <jirislaby@gmail.com>
> 
> There was a misplaced status test (two consequent tests without a
> statement in between) in acpi_bus_init for ages.  Remove it, since the
> function which should be checked (acpi_os_initialize1) has BUG_ONs on
> failure paths.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/bus.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff -puN drivers/acpi/bus.c~acpi-busc-remove-doubled-status-checking drivers/acpi/bus.c
> --- a/drivers/acpi/bus.c~acpi-busc-remove-doubled-status-checking
> +++ a/drivers/acpi/bus.c
> @@ -758,8 +758,7 @@ static int __init acpi_bus_init(void)
>  	acpi_status status = AE_OK;
>  	extern acpi_status acpi_os_initialize1(void);
>  
> -
> -	status = acpi_os_initialize1();
> +	acpi_os_initialize1();
>  
>  	status =
>  	    acpi_enable_subsystem(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE);
> @@ -769,12 +768,6 @@ static int __init acpi_bus_init(void)
>  		goto error1;
>  	}
>  
> -	if (ACPI_FAILURE(status)) {
> -		printk(KERN_ERR PREFIX
> -		       "Unable to initialize ACPI OS objects\n");
> -		goto error1;
> -	}
> -
>  	/*
>  	 * ACPI 2.0 requires the EC driver to be loaded and work before
>  	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
> _
> 
