From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Thermal managment broken
Date: Wed, 18 Sep 2002 12:25:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020918102555.GB18221@atrey.karlin.mff.cuni.cz>
References: <20020916163600.GA11617@elf.ucw.cz> <20020916225518.B2247@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020916225518.B2247-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > First is strict bugfix, please take. Second is needed, please take it,
> > too.
> While I'd "vote" for the second patch "in general", there are two aspects
> which should be mentioned first:
> 
> 
> > +	tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
> > +	tz->trips.hot.temperature = CELSIUS_TO_KELVIN(hot);
> > +	tz->trips.passive.temperature = CELSIUS_TO_KELVIN(passive);
> > +	tz->trips.active[0].temperature = CELSIUS_TO_KELVIN(active0);
> > +	tz->trips.active[1].temperature = CELSIUS_TO_KELVIN(active1);
> 
> You explicitely want to support _two_ active trip points here. While this
> seems to be the amount of active trip points seen on most systems, I'd
> prefer you'd do a more flexible interface [zero to ACPI_THERMAL_MAX_ACTIVE
> would be best]. 

Okay.

[Andrew, do you want to take this one and then followup which adds
many active points, or do you want whole new patch?]

> Additionally, it might be better to specify a "starting" and
> "stopping" trip point - so that you don't have a fan going
> on-off-on-off-on-off repeatedly. (IIRC someone complained about this a few
> months ago on this list). But even without this "feature", I'd like to see
> the user-specified trip points in the acpi patch.

I believe this is orthogonal. You need to do two thresholds even
without user help, so it needs to be solved some other way.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
