From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: battery: use cache_time as cache "enabled"
Date: Thu, 19 Jul 2018 12:55:08 +0200
Message-ID: <10585866.b9VflrVt2K@aspire.rjw.lan>
References: <1531607910-4975-1-git-send-email-lucas.magasweran@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531607910-4975-1-git-send-email-lucas.magasweran@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Magasweran <lucas.magasweran@ieee.org>
Cc: linux-acpi@vger.kernel.org, Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, July 15, 2018 12:38:29 AM CEST Lucas Magasweran wrote:
> From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> 
> When battery state is not cached the module parameter cache_time is 0
> and battery->update_time starts at 0. However, it set to jiffies in
> each call to acpi_battery_get_state() and should not be used to
> determine if a cache time is used.
> 
> Using battery->update_time causes the evaluation of time_before()
> even though cache_time is 0.
> 
> This is a minor issue as the behavior is still as expected.
> Even if kernel HZ was very slow and jiffies remained equal, the
> expected branch (false) would be taken because time_before() is
> used instead of time_before_eq().
> 
> Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> ---
>  drivers/acpi/battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index d79ad84..f88bc9f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -549,7 +549,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  	if (!acpi_battery_present(battery))
>  		return 0;
>  
> -	if (battery->update_time &&
> +	if (cache_time &&
>  	    time_before(jiffies, battery->update_time +
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
> 

Applied, thanks!
