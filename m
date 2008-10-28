From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: revert msleep patch
Date: Tue, 28 Oct 2008 09:05:18 +0800
Message-ID: <1225155918.5189.69.camel@yakui_zhao.sh.intel.com>
References: <20081027213530.7104.27639.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10546 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYJ1A6o (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 27 Oct 2008 20:58:44 -0400
In-Reply-To: <20081027213530.7104.27639.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Mon, 2008-10-27 at 14:35 -0700, Alexey Starikovskiy wrote:
> With the better solution for EC interrupt storm issue,
> there is no need to use msleep over udelay.
> 
Why is msleep replaced by udelay again? When udelay is used, CPU will
execute the loop while doing EC transaction.Although this only affects
some laptops, this still is not very reasonable.
	For example: EC GPE interrupt storms; 
	there is no EC interrupt while doing some EC transaction;
	force_poll is 1.

IMO it is necessary to get the root cause of bug. We had better not
revert something for some bugs and when another bug appears, we revert
it again.

Thanks.
> References:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=11810
> 	http://bugzilla.kernel.org/show_bug.cgi?id=10724
> 
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index ef42316..3ef5b79 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -239,10 +239,10 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
>  static int ec_poll(struct acpi_ec *ec)
>  {
>  	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> -	msleep(1);
> +	udelay(ACPI_EC_UDELAY);
>  	while (time_before(jiffies, delay)) {
>  		gpe_transaction(ec, acpi_ec_read_status(ec));
> -		msleep(1);
> +		udelay(ACPI_EC_UDELAY);
>  		if (ec_transaction_done(ec))
>  			return 0;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

