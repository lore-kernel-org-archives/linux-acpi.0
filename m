From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: OT: Asus L3C BIOS update
Date: Sat, 7 Jun 2003 00:43:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030606224335.GB11776@hell.org.pl>
References: <20030525154505.5b5967ad.nils@kernelconcepts.de> <20030526204142.39798871.nils@kernelconcepts.de> <20030527212456.GB9203@hell.org.pl> <20030528112032.32b0e481.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030528112032.32b0e481.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nils Faerber:
> > Does it happen to fix the occasional:
> > acpi_bus-0447 [2181] acpi_bus_set_power    : Device does not support
> > D1 acpi_power-0363 [2194] acpi_power_transition : Error transitioning
> > device [CFAN] to D0 acpi_bus-0496 [2193] acpi_bus_set_power    : Error
> > transitioning device [CFAN] to D0
> > 
> > at boot time, and a consequent oops + hang of everything which makes
> > use of ACPI? This is so rare that I consider it a sort of hardware /
> > BIOS bug(happens once a month, or so), but I would be really happy to
> > have it fixed. Or is it only me who experiences those?
> I think I have seen this too and yes I think it is gone now :)
> At least the bootup error message does not appear anymore.

Unfortunately, I've experienced this at least once for the new BIOS.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
