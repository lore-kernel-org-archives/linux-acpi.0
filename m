From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: battery: make warning greppable
Date: Wed, 18 Mar 2015 16:27:36 +0100
Message-ID: <3248282.q652f4oAaQ@vostro.rjw.lan>
References: <1426204097-3024-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426204097-3024-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, March 13, 2015 12:48:17 AM Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> I was so angry now, I had to write a change. Please keep things greppable and
> save unnecessary questions and time this way.

Queued up for 4.1, thanks!

>  drivers/acpi/battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index d98ba43..baebd1a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -530,8 +530,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  		battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
>  		(s16)(battery->rate_now) < 0) {
>  		battery->rate_now = abs((s16)battery->rate_now);
> -		printk_once(KERN_WARNING FW_BUG "battery: (dis)charge rate"
> -			" invalid.\n");
> +		printk_once(KERN_WARNING FW_BUG
> +			    "battery: (dis)charge rate invalid.\n");
>  	}
>  
>  	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
