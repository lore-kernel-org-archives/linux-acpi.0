From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / sleep: Make acpi_sleep_syscore_init static
Date: Wed, 02 Aug 2017 01:15:23 +0200
Message-ID: <2204384.bLoi9Ef087@aspire.rjw.lan>
References: <20170731114013.75bc1b0a@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47254 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750854AbdHAXXa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2017 19:23:30 -0400
In-Reply-To: <20170731114013.75bc1b0a@endymion>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Monday, July 31, 2017 11:40:13 AM Jean Delvare wrote:
> Function acpi_sleep_syscore_init has no external user so it should be
> static.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/sleep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-4.13-rc3.orig/drivers/acpi/sleep.c	2017-07-31 10:51:43.665159497 +0200
> +++ linux-4.13-rc3/drivers/acpi/sleep.c	2017-07-31 11:34:07.180873669 +0200
> @@ -870,7 +870,7 @@ static struct syscore_ops acpi_sleep_sys
>  	.resume = acpi_restore_bm_rld,
>  };
>  
> -void acpi_sleep_syscore_init(void)
> +static void acpi_sleep_syscore_init(void)
>  {
>  	register_syscore_ops(&acpi_sleep_syscore_ops);
>  }
> 
> 
> 

Applied, thanks!

