From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 1/2] Sonypi: use synchronize_irq instead of
	sycnronize_sched
Date: Wed, 21 Nov 2007 08:08:36 +0900
Message-ID: <20071120230836.GB25225@inferi.kami.home>
References: <200710310041.54252.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:37297 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbXKTXIp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 18:08:45 -0500
Content-Disposition: inline
In-Reply-To: <200710310041.54252.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Oct 31, 2007 at 12:41:54AM -0400, Dmitry Torokhov wrote:
> Hi Mattia,
> 
> It looks like you are also looking after sonypi...
> 
> -- 
> Dmitry
> 
> Subject: Sonypi: use synchronize_irq instead of sycnronize_sched
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> We know exactly what IRQ we are using, so synchronize_irq()
> suits much better. Plus synchronize_sched() will not work
> for us in -rt kernels.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Mattia Dongili <malattia@linux.it>

> ---
>  drivers/char/sonypi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/drivers/char/sonypi.c
> ===================================================================
> --- linux.orig/drivers/char/sonypi.c
> +++ linux/drivers/char/sonypi.c
> @@ -1432,7 +1432,7 @@ static int __devexit sonypi_remove(struc
>  {
>  	sonypi_disable();
>  
> -	synchronize_sched();  /* Allow sonypi interrupt to complete. */
> +	synchronize_irq(sonypi_device.irq);
>  	flush_scheduled_work();
>  
>  	if (useinput) {
> 
-- 
mattia
:wq!
