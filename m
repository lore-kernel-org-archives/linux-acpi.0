From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: Re: Thermal managment broken
Date: Mon, 16 Sep 2002 22:55:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020916225518.B2247@brodo.de>
References: <20020916163600.GA11617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020916163600.GA11617-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>; from pavel-+ZI9xUNit7I@public.gmane.org on Mon, Sep 16, 2002 at 06:36:01PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Pavel, Andrew, list;

> First is strict bugfix, please take. Second is needed, please take it,
> too.
While I'd "vote" for the second patch "in general", there are two aspects
which should be mentioned first:


> +	tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
> +	tz->trips.hot.temperature = CELSIUS_TO_KELVIN(hot);
> +	tz->trips.passive.temperature = CELSIUS_TO_KELVIN(passive);
> +	tz->trips.active[0].temperature = CELSIUS_TO_KELVIN(active0);
> +	tz->trips.active[1].temperature = CELSIUS_TO_KELVIN(active1);

You explicitely want to support _two_ active trip points here. While this
seems to be the amount of active trip points seen on most systems, I'd
prefer you'd do a more flexible interface [zero to ACPI_THERMAL_MAX_ACTIVE
would be best]. 

Additionally, it might be better to specify a "starting" and
"stopping" trip point - so that you don't have a fan going
on-off-on-off-on-off repeatedly. (IIRC someone complained about this a few
months ago on this list). But even without this "feature", I'd like to see
the user-specified trip points in the acpi patch.

	Dominik




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
