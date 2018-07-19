From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: battery: remove redundant old_present check on insertion
Date: Thu, 19 Jul 2018 12:55:21 +0200
Message-ID: <4448104.DkuDPgeVpq@aspire.rjw.lan>
References: <1531608019-5785-1-git-send-email-lucas.magasweran@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531608019-5785-1-git-send-email-lucas.magasweran@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Magasweran <lucas.magasweran@ieee.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, July 15, 2018 12:40:18 AM CEST Lucas Magasweran wrote:
> From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> 
> On removal battery_present changes from 1 to 0 after calling
> acpi_battery_get_statu() and battery->update_time is set to 0
> before returning.
> 
> On insertion battery_present changes from 0 to 1 after calling
> acpi_battery_get_status() and acpi_battery_get_info() is called
> because battery->update_time is 0.
> 
> The old_present condition is therefore redundant.
> 
> This was added in the commit below when there was a path without
> sysfs that would skip getting the newly inserted battery info.
> 
> commit 50b178512b7d ("Newly inserted battery might differ from one
> just removed, so update of battery info fields is required.")
> 
> Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
> ---
>  drivers/acpi/battery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f88bc9f..c280e8e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -918,10 +918,11 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
>  
>  static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>  {
> -	int result, old_present = acpi_battery_present(battery);
> -	result = acpi_battery_get_status(battery);
> +	int result = acpi_battery_get_status(battery);
> +
>  	if (result)
>  		return result;
> +
>  	if (!acpi_battery_present(battery)) {
>  		sysfs_remove_battery(battery);
>  		battery->update_time = 0;
> @@ -931,8 +932,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>  	if (resume)
>  		return 0;
>  
> -	if (!battery->update_time ||
> -	    old_present != acpi_battery_present(battery)) {
> +	if (!battery->update_time) {
>  		result = acpi_battery_get_info(battery);
>  		if (result)
>  			return result;
> 

Applied, thanks!
