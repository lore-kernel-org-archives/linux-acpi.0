From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: SSDT on Sony VAIO
Date: Thu, 16 Jan 2003 19:46:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030116184605.GB1389@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A11E@orsmsx401.jf.intel.com> <20030116074624.GA1239@brodo.de> <20030116165128.GA13608@bungled.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030116165128.GA13608-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Conrad <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 16, 2003 at 11:51:28AM -0500, Nathan Conrad wrote:
> I did not have CONFIG_CPU_FREQ and CONFIG_ACPI_PROCESSOR_PERF
> enabled. Once I enabled them, a performance file appeared in my
> /proc/acpi/processor/CPU0 directory. This file contained '<not
> supported>'. I also noticed the following message when I boot:
> 
> acpi_processor-0959 [17] acpi_processor_get_per: Unsupported address
> space [127] (control_register)
> 
> Is there a way for me to examine the ACPI namespace in order to
> determine what the parser has put in my CPU0 structure?
> 
> In what way are cpufreq and ACPI related? My laptop has an Athlon4 in
> it, which is not supported by the kernel's cpufreq (yet).

cpufreq is a generic, cross-architecture kernel infrastructure for CPU
frequency and voltage scaling support. This has several advantages:

- the user shouldn't have to care what technique is used to scale the CPU
frequency and voltage, whether that is a legacy interface like speedstep, 
powernow-k6, longrun etc. or whether the interface is "ACPI P-States
support". All these techniques can be managed through one unified userspace 
interface ( http://www.brodo.de/cpufreq/interface.html )

- on almost all architectures, timing codes need to be updated (so that
"sleep 1" still takes one second, and not two when switching to low 
frequency). The cpufreq core takes care of that, independent of what
scaling technique is used.

- dynamic voltage scaling only has to be implemented at one place, and not
for each "cpufreq driver" on its own. ( DVS isn't yet ready for prime time, 
but that will change soon. If you're interested, you can follow the 
development at http://www.brodo.de/cpufreq/advanced.html )

- because of these reasons, ACPI P-States use the cpufreq infrastructure in
2.5. So you need to enable the cpufreq core if you want to use ACPI
P-States. No need for the legacy drivers, though, in case ACPI P-States
work.

Concerning the powernow-k7 / Athlon driver: Dave Jones is working on it. 

	Dominik


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
