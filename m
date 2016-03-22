From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5 6/6] serial: pl011: add EARLYCON_DECLARE
Date: Tue, 22 Mar 2016 09:15:15 -0700
Message-ID: <56F16F93.808@hurleysoftware.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-7-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36328 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbcCVQPU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2016 12:15:20 -0400
Received: by mail-pf0-f175.google.com with SMTP id u190so318665634pfb.3
        for <linux-acpi@vger.kernel.org>; Tue, 22 Mar 2016 09:15:20 -0700 (PDT)
In-Reply-To: <1458643595-14719-7-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, Jiri Slaby <jslaby@suse.com>

On 03/22/2016 03:46 AM, Aleksey Makarov wrote:
> This patch adds definition of early console data for pl011.
> It allows setting up an early console with a string passed in
> command line or compiled by the ACPI SPCR table handler.

This shouldn't be necessary in 4.5+ since OF_EARLYCON_DECLARE()
should be equivalent to EARLYCON_DECLARE() as well.

Regards,
Peter Hurley


> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 59b743f..af6f87cf 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2385,6 +2385,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>  	return 0;
>  }
>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
> +EARLYCON_DECLARE(pl011, pl011_early_console_setup);
>  
>  #else
>  #define AMBA_CONSOLE	NULL
> 

