From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] thermal active cooling step
Date: Wed, 23 Jun 2004 11:25:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040623092557.GA16698@elf.ucw.cz>
References: <6E0C289723A0564F9A8279E236E8565F07A55409@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6E0C289723A0564F9A8279E236E8565F07A55409-4yWAQGcml64divtuJNk2fFDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Fine. Resend patch below.
> 
> -zhen
> 
> 
> --- linux-2.6.7/drivers/acpi/thermal.c.orig     2004-06-23 09:16:13.360411712 +0800
> +++ linux-2.6.7/drivers/acpi/thermal.c  2004-06-23 09:17:51.985418432 +0800
> @@ -610,7 +610,7 @@ acpi_thermal_active (
>                  * associated with this active threshold.
>                  */
>                 if (tz->temperature >= active->temperature) {
> -                       if (active->temperature > maxtemp)
> +                       if (active->temperature > maxtemp){

Put space between ) and {

>                                 tz->state.active_index = i, maxtemp = active->temperature;
>                         if (!active->flags.enabled) {
>                                 for (j = 0; j < active->devices.count; j++) {
> @@ -623,6 +623,7 @@ acpi_thermal_active (
>                                         ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling device [%p] now 'on'\n", active->devices.handles[j]));
>                                 }
>                         }

This whole block needs to be moved one tab to the right...

> +                       }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
