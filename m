From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: enhanced speedstep / speedstep for mobile p4-M @ 2.6GHz
Date: Tue, 1 Jul 2003 21:03:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030701190300.GA1682@brodo.de>
References: <20030701131312.GE873@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030701131312.GE873-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 01, 2003 at 03:13:13PM +0200, Sebastian Henschel wrote:
> - why is it binary only and not included in the current implementation?
> - will there be an updated version? currently it is for 2.4.21-rc1 and it
>   complains about some missing symbols (acpi_ut*) with 2.4.21 + acpi20030619.
> 
> currently, i have a Xeron GrafX here with a mobile p4-M at 2.6GHz and
> (regular) speedstep does not work. :(

that driver won't help for a mobile p4-M - it's for mobile pentium M only;
and Jeremey Fitzhardinge wrote a driver [which IMHO is better than the ACPI
variant] for mobile pentium m (centrino) which is in latest 2.4-ac and 2.5.
kernels. For your "mobile pentium 4 with 533 MHz FSB" proper (cpufreq-based)
speedstep support should be in 2.5.-bk-current, I'll update the backport for
2.4. and the 2.4-ac version soon.

	Dominik


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
