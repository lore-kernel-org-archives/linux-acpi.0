From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Quick, Quick, Slooow
Date: Tue, 5 Nov 2002 09:43:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021105094334.C1465@brodo.de>
References: <20021105001358.A54213@azure.melloworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021105001358.A54213-bxPqUFq66fhTnqHRgSL67VaTQe2KTcn/@public.gmane.org>; from alien-acpirep-xE0Zs7GtCLTd8Zgiw/MPxQ@public.gmane.org on Tue, Nov 05, 2002 at 12:13:59AM +0000
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Al Cutter <alien-acpirep-xE0Zs7GtCLTd8Zgiw/MPxQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Al,

On Tue, Nov 05, 2002 at 12:13:59AM +0000, Al Cutter wrote:
> 	I've just started playing around with this acpi business, but the
> 	processor performance (echo 1 > /proc/acpi/.../performance) didn't seem
> 	to work on my Sony SRX41P, it'd timeout in 
> 	acpi_processor_set_performance() ("Transition failed"). 
> 
> 	The cpufreq interface seems to work fine however, so I made a little 
> 	patch against acpi-20021101 on 2.5.45 which makes :
> 		* acpi_processor_set_performance() call cpufreq to change the 
> 			clock speed, and
> 		* acpi_processor_write_performance() call ..._set_performance()
> 
> 	Don't know if this makes sense, or it's just a kludge that gets around
> 	my particular problem, but it seems to work quite well with 
> 	autospeedstep (http://gpsdrive.kraftvoll.at/speedstep.shtml).
Actually, this would be the wrong way 'round:

There are several "techniques" to switch the performance states / the CPU
freuqency. One is ACPI, others are "legacy" interfaces for Intel SpeedStep,
AMD PowerNow, Cyrix Longhaul, Transmeta Crusoe, ... 

cpufreq offers an unified interface for all these drivers (and a bit
more...) - and so you shouldn't even recognize from reading this interface,
/proc/cpufreq, what cpufreq driver (ACPI, SpeedStep, etc.) is used. 

Your patch would actually remove the ACPI cpufreq driver. Additionally,
you shouldn't try to use the ACPI generic interface to access a general
CPUfreq driver; but use /proc/cpufreq [or /proc/sys/cpu/0/] directly.

	Dominik


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
