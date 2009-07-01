From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Wed, 1 Jul 2009 11:29:58 -0700
Message-ID: <20090701112958.1d24e06f.akpm@linux-foundation.org>
References: <4A4BA8F9.9070803@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32944 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbZGASbG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2009 14:31:06 -0400
In-Reply-To: <4A4BA8F9.9070803@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: astarikovskiy@suse.de, lenb@kernel.org, linux-acpi@vger.kernel.org

On Wed, 01 Jul 2009 20:20:41 +0200
Hector Martin <hector@marcansoft.com> wrote:

> My Acer Aspire 8930G laptop reports the battery current as a 16-bit
> signed negative when it is charging. It also reports it as 0x10000 when
> the current is 0. This patch adds a quirk for this which takes the
> absolute value of the reported current cast to an s16. This is a DSDT
> bug present in the latest BIOS revision (the EC register is 16 bits
> signed and the DSDT attempts to take the 16-bit two's complement of
> this, which works for discharge but not charge. It also breaks zero
> values because a 32-bit register is used and the high bits aren't thrown
> away).
> 
> I've enabled this for all Acer systems which report in mA units. This
> should be safe since it won't break compliant systems unless they report
> a current above 32A, which is insane.
> 
>
> ...
>
> +++ a/drivers/acpi/battery.c
> @@ -85,6 +85,10 @@ static const struct acpi_device_id batte
>  
>  MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>  
> +/* For buggy DSDTs that report negative 16-bit values for either charging
> + * or discharging and/or report 0 as 65536 due to bad math.
> + */
> +#define QUIRK_SIGNED16_CURRENT 0x0001
>  
>  struct acpi_battery {
>  	struct mutex lock;
> @@ -112,6 +116,7 @@ struct acpi_battery {
>  	int state;
>  	int power_unit;
>  	u8 alarm_present;
> +	long quirks;
>  };
>  
>  #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
> @@ -390,6 +395,10 @@ static int acpi_battery_get_state(struct
>  				 state_offsets, ARRAY_SIZE(state_offsets));
>  	battery->update_time = jiffies;
>  	kfree(buffer.pointer);
> +
> +	if (battery->quirks & QUIRK_SIGNED16_CURRENT)
> +		battery->current_now = abs((s16)battery->current_now);
> +
>  	return result;

acpi_battery has no field `current_now' in 2.6.30 or 2.6.31-rc1.  Which
kernel version are you patching here?


Also, I wonder if we need a quirk.  Is a "negative" value _ever_
correct?  If not, could we do the negation unconditionally?

