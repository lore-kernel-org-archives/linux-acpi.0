From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Remove non-standard log emphasis
Date: Wed, 18 Feb 2015 07:18:43 +0100
Message-ID: <7706896.L1jj2myRTu@vostro.rjw.lan>
References: <alpine.LNX.2.11.1502151932250.630@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54556 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750787AbbBRFza (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 00:55:30 -0500
In-Reply-To: <alpine.LNX.2.11.1502151932250.630@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, February 15, 2015 07:43:08 PM Scot Doyle wrote:
> Remove unusual pr_info() visual emphasis introduced in ad479e7f47ca
> "ACPI / EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag".
> 
> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>

Applied, thanks!

> ---
>  drivers/acpi/ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 982b67f..857175e 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -680,7 +680,7 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
>  		/* Enable GPE for event processing (SCI_EVT=1) */
>  		if (!resuming)
>  			acpi_ec_submit_request(ec);
> -		pr_info("+++++ EC started +++++\n");
> +		pr_info("EC started\n");
>  	}
>  	spin_unlock_irqrestore(&ec->lock, flags);
>  }
> @@ -712,7 +712,7 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
>  			acpi_ec_complete_request(ec);
>  		clear_bit(EC_FLAGS_STARTED, &ec->flags);
>  		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
> -		pr_info("+++++ EC stopped +++++\n");
> +		pr_info("EC stopped\n");
>  	}
>  	spin_unlock_irqrestore(&ec->lock, flags);
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
