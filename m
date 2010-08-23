From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Don't report current_now if battery reports in mWh
Date: Mon, 23 Aug 2010 23:37:19 +0200
Message-ID: <201008232337.19715.rjw@sisk.pl>
References: <1282595132-5026-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282595132-5026-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cbou@mail.ru, dwmw2@infradead.org, lenb@kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Monday, August 23, 2010, Matthew Garrett wrote:
> ACPI batteries can report in units of either current or energy. Right
> now we expose the current_now file even if the battery is reporting
> energy units, resulting in a file that should contain mA instead
> containing mW. Don't expose this value unless the battery is reporting
> current.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/acpi/battery.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dc58402..9841720 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -273,7 +273,6 @@ static enum power_supply_property energy_battery_props[] = {
>  	POWER_SUPPLY_PROP_CYCLE_COUNT,
>  	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> -	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_POWER_NOW,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,
> 
