From: Al Cutter <alien-bxPqUFq66fhTnqHRgSL67VaTQe2KTcn/@public.gmane.org>
Subject: Re: Quick, Quick, Slooow
Date: Tue, 5 Nov 2002 09:54:15 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021105095415.A53504@azure.melloworld.com>
References: <20021105001358.A54213@azure.melloworld.com> <20021105094334.C1465@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021105094334.C1465-JhLEnvuH02M@public.gmane.org>; from linux-JhLEnvuH02M@public.gmane.org on Tue, Nov 05, 2002 at 09:43:34AM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 05, 2002 at 09:43:34AM +0100, Dominik Brodowski wrote:
> Actually, this would be the wrong way 'round:
> 
> There are several "techniques" to switch the performance states / the CPU
> freuqency. One is ACPI, others are "legacy" interfaces for Intel SpeedStep,
> AMD PowerNow, Cyrix Longhaul, Transmeta Crusoe, ... 
> 
> cpufreq offers an unified interface for all these drivers (and a bit
> more...) - and so you shouldn't even recognize from reading this interface,
> /proc/cpufreq, what cpufreq driver (ACPI, SpeedStep, etc.) is used. 
> 
> Your patch would actually remove the ACPI cpufreq driver. Additionally,
> you shouldn't try to use the ACPI generic interface to access a general
> CPUfreq driver; but use /proc/cpufreq [or /proc/sys/cpu/0/] directly.
> 
> 	Dominik

Whoops, must pay more attention !

Thanks for explaining.

	Al


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
