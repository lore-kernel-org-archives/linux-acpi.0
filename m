From: Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Subject: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: Tue, 8 Oct 2002 11:59:59 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210081159.59921.mark.pritchard-acpi@modus.com.au>
References: <200210081115.21667.mark.pritchard-acpi@modus.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210081115.21667.mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I forgot to mention, my dmesg with acpi debugging turned on is available =
at=20
http://www.modus.com.au/scratch/dmesg.acpi.debug.gz

Cheers

Mark

On Tue, 8 Oct 2002 11:15, Mark Pritchard wrote:
> Hi,
>
> I'm having a problem with seeing battery status on my Compaq Evo N800v.=
 The
> proc filesystem has plenty of entries for everything other than the bat=
tery
> (I've included a list below).
>
> I'd really appreciate some advice, and I'm more than happy to provide m=
ore
> info/test things.
>
> Cheers
>
> Mark Pritchard
>
> -------------------
>
> Useful info:
>
> * RedHat 7.3
>
> * Kernel 2.4.20-pre8 with acpi-20021002-2.4.20-pre8.diff.gz
>
> * DSDT available at
>
> =09http://www.modus.com.au/scratch/dsdt.compaq_evo_n800v.gz
>
> * Contents of /proc/acpi:
>
> [pritchma@seth pritchma]$ find /proc/acpi |sort
> /proc/acpi
> /proc/acpi/ac_adapter
> /proc/acpi/ac_adapter/C11A
> /proc/acpi/ac_adapter/C11A/state
> /proc/acpi/alarm
> /proc/acpi/button
> /proc/acpi/button/power
> /proc/acpi/button/power/PWRF
> /proc/acpi/button/power/PWRF/info
> /proc/acpi/dsdt
> /proc/acpi/event
> /proc/acpi/fadt
> /proc/acpi/info
> /proc/acpi/power_resource
> /proc/acpi/power_resource/C0CF
> /proc/acpi/power_resource/C0CF/state
> /proc/acpi/power_resource/C140
> /proc/acpi/power_resource/C140/state
> /proc/acpi/power_resource/C154
> /proc/acpi/power_resource/C154/state
> /proc/acpi/power_resource/C158
> /proc/acpi/power_resource/C158/state
> /proc/acpi/power_resource/C15B
> /proc/acpi/power_resource/C15B/state
> /proc/acpi/power_resource/C164
> /proc/acpi/power_resource/C164/state
> /proc/acpi/power_resource/C1D0
> /proc/acpi/power_resource/C1D0/state
> /proc/acpi/power_resource/C1D1
> /proc/acpi/power_resource/C1D1/state
> /proc/acpi/power_resource/C1D2
> /proc/acpi/power_resource/C1D2/state
> /proc/acpi/power_resource/C1D3
> /proc/acpi/power_resource/C1D3/state
> /proc/acpi/processor
> /proc/acpi/processor/C000
> /proc/acpi/processor/C000/info
> /proc/acpi/processor/C000/limit
> /proc/acpi/processor/C000/performance
> /proc/acpi/processor/C000/power
> /proc/acpi/processor/C000/throttling
> /proc/acpi/sleep
> /proc/acpi/thermal_zone
> /proc/acpi/thermal_zone/TZ1
> /proc/acpi/thermal_zone/TZ1/cooling_mode
> /proc/acpi/thermal_zone/TZ1/polling_frequency
> /proc/acpi/thermal_zone/TZ1/state
> /proc/acpi/thermal_zone/TZ1/temperature
> /proc/acpi/thermal_zone/TZ1/trip_points
> /proc/acpi/thermal_zone/TZ2
> /proc/acpi/thermal_zone/TZ2/cooling_mode
> /proc/acpi/thermal_zone/TZ2/polling_frequency
> /proc/acpi/thermal_zone/TZ2/state
> /proc/acpi/thermal_zone/TZ2/temperature
> /proc/acpi/thermal_zone/TZ2/trip_points
> /proc/acpi/thermal_zone/TZ3
> /proc/acpi/thermal_zone/TZ3/cooling_mode
> /proc/acpi/thermal_zone/TZ3/polling_frequency
> /proc/acpi/thermal_zone/TZ3/state
> /proc/acpi/thermal_zone/TZ3/temperature
> /proc/acpi/thermal_zone/TZ3/trip_points
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
