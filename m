From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: acpi_processor_get_per: Unsupported address space
Date: Tue, 22 Jul 2003 14:11:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030722121119.GA1964@brodo.de>
References: <m2oezpghjy.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2oezpghjy.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jul 20, 2003 at 11:49:05AM -0700, Jan Rychter wrote:
> On a Toshiba Dynabook SS S7/290LNKW (Centrino-based), kernel 2.4.22-pre7
> (also tested with pre5).
> 
> I am getting the following message at bootup:
> 
> acpi_processor-0899 [31] acpi_processor_get_per: Unsupported address space [127] (control_register)
> ACPI: Processor [CPU0] (supports C1 C2 C3)
> ACPI: Thermal Zone [THRM] (44 C)
> 
> What does this mean? Does it indicate problems?

It means that the "performance states" == SpeedStep states are only
available using the binary-only processor.o replacement module available at
Intel's ACPI site, or using the cpufreq speedstep-centrino module [patches
in 2.5., or at http://www.codemonkey.org.uk/cpufreq/ once davej's server is
back online]

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
