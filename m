From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [FIX PATCH] ACPI/EC: Restart transaction even when IBF flag setting
Date: Wed, 08 May 2013 02:00:30 +0200
Message-ID: <2059413.MqXkV1l8ih@vostro.rjw.lan>
References: <1367810620-9369-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37714 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755804Ab3EGXwF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 19:52:05 -0400
In-Reply-To: <1367810620-9369-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, May 06, 2013 11:23:40 AM Lan Tianyu wrote:
> Some time, EC works abnormally with IBF flag always setting.
> IBF means "The host has written a byte of data to the command
> or data port, but the embedded controller has not yet read it".
> This will cause all EC requests to be failed with timeout error.
> 
> After several trials, find restarting transaction with IBF flag
> setting can make EC work again. This patch is to remove the
> IBF flag check before restarting transaction and increase the
> repeat number to 5. Some time, once restart is not enough.
> 
> This bug happens on the different machines. (e.g Asus V1S,
> Dell Latitude E6530, Samsung R719, Acer Aspire 5930G,
> Sony Vaio SR19VN and so on).
> 
> Related bugs:
> 	https://bugzilla.kernel.org/show_bug.cgi?id=14733
> 	https://bugzilla.kernel.org/show_bug.cgi?id=15560
> 	https://bugzilla.kernel.org/show_bug.cgi?id=15946
> 	https://bugzilla.kernel.org/show_bug.cgi?id=42945
> 	https://bugzilla.kernel.org/show_bug.cgi?id=48221
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Queued up for a post-3.10-rc1 push as 3.10 (and -stable) material.

Thanks,
Rafael


> ---
>  drivers/acpi/ec.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index d45b287..edc0081 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -223,7 +223,7 @@ static int ec_check_sci_sync(struct acpi_ec *ec, u8 state)
>  static int ec_poll(struct acpi_ec *ec)
>  {
>  	unsigned long flags;
> -	int repeat = 2; /* number of command restarts */
> +	int repeat = 5; /* number of command restarts */
>  	while (repeat--) {
>  		unsigned long delay = jiffies +
>  			msecs_to_jiffies(ec_delay);
> @@ -241,8 +241,6 @@ static int ec_poll(struct acpi_ec *ec)
>  			}
>  			advance_transaction(ec, acpi_ec_read_status(ec));
>  		} while (time_before(jiffies, delay));
> -		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
> -			break;
>  		pr_debug(PREFIX "controller reset, restart transaction\n");
>  		spin_lock_irqsave(&ec->lock, flags);
>  		start_transaction(ec);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
