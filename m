From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: thermal zone causing insta-reboot on bootup of 2.6.3
Date: Wed, 17 Mar 2004 23:53:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317225330.GA466@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB747@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB747-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> The following patch is from Pavel, and maybe it is suitable for this
> case. --Luming

Probably not. In my case, sensor randomly lies. In his case, it seems
to report 255 all the time...
								Pavel

> @@ -457,7 +460,17 @@
>  		return_VALUE(-EINVAL);
>  
>  	if (tz->temperature >= tz->trips.critical.temperature) {
> +		long old_temperature = tz->temperature;
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
> +
> +		result = acpi_thermal_get_temperature(tz);
> +		if (!result) {
> +			if (tz->temperature < (tz->trips.critical.temperature - 100)) {
> +				printk(KERN_ALERT "ACPI changed its mind about temperature, was %ld C, now %ld C", 
> +				       KELVIN_TO_CELSIUS(old_temperature), KELVIN_TO_CELSIUS(tz->temperature));
> +				return_VALUE(0);
> +			}
> +		}
>  		tz->trips.critical.flags.enabled = 1;
>  	}
>  	else if (tz->trips.critical.flags.enabled)
> 
>   
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
