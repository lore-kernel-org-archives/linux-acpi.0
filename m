From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Correct error return value of create_modalias()
Date: Mon, 22 Sep 2014 16:03:33 +0200
Message-ID: <9604394.Yo3KjvmQfD@vostro.rjw.lan>
References: <1410510790-21251-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57864 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754021AbaIVNnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2014 09:43:47 -0400
In-Reply-To: <1410510790-21251-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Friday, September 12, 2014 11:33:10 AM Mika Westerberg wrote:
> There is a typo, it should be negative -errno instead.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Queued up for 3.17-rc7, thanks!

> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 3bf7764659a4..d5e6ac5042d8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -130,7 +130,7 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
>  	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
>  		count = snprintf(&modalias[len], size, "%s:", id->id);
>  		if (count < 0)
> -			return EINVAL;
> +			return -EINVAL;
>  		if (count >= size)
>  			return -ENOMEM;
>  		len += count;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
