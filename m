From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / watchdog: Fix init failure with overlapping register regions
Date: Mon, 24 Jul 2017 22:37:17 +0200
Message-ID: <2680739.BCCY7oeAKy@aspire.rjw.lan>
References: <20170715214818.24979-1-ryan5544@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42933 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755734AbdGXUpO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jul 2017 16:45:14 -0400
In-Reply-To: <20170715214818.24979-1-ryan5544@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ryan Kennedy <ryan5544@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Saturday, July 15, 2017 05:48:18 PM Ryan Kennedy wrote:
> Partially overlapping regions cause platform device creation
> to fail. The latter of two overlapping resources will fail to be
> reserved. Fix this by merging overlapping resource ranges while
> enumerating WDAT table entries.
> 
> Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
> ---
>  drivers/acpi/acpi_watchdog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 8c4e0a1..bf22c29 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -86,7 +86,12 @@ void __init acpi_watchdog_init(void)
>  
>  		found = false;
>  		resource_list_for_each_entry(rentry, &resource_list) {
> -			if (resource_contains(rentry->res, &res)) {
> +			if (rentry->res->flags == res.flags &&
> +			    resource_overlaps(rentry->res, &res)) {
> +				if (res.start < rentry->res->start)
> +					rentry->res->start = res.start;
> +				if (res.end > rentry->res->end)
> +					rentry->res->end = res.end;
>  				found = true;
>  				break;
>  			}
> 

Mika, can you have a look at this, please?

