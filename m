From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: SSDT on Sony VAIO
Date: Fri, 17 Jan 2003 02:19:44 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000e01c2bd83$79f88210$134425db@sayonara>
References: <20030116165128.GA13608@bungled.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030116165128.GA13608-aYgNHrD+FxfR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Nathan Conrad' <conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org>, 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Nathan, 
Can you please take a look at the following msg that I posted before? It
tells all about the unsupported address space 127. 

http://marc.theaimsgroup.com/?l=acpi4linux&m=104022580902620&w=2

Incidentally I didn't know the existence of CpuFreq project when I made
the above statement. Dominik, if BIOS tells OS via ACPI _PCT to access
FFH to initiate FID/VID change (in AMD PowerNow!), how current code
coordinates it? I'm going to look into code soon, but I'd appreciate
very much if you give me some insight in advance.

Thanks,
- Adachi, Kenichi

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> Nathan Conrad
> Sent: Friday, January 17, 2003 1:51 AM
> To: Dominik Brodowski
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; andrew.grover@intel.com
> Subject: Re: [ACPI] SSDT on Sony VAIO
> 
> 
> I did not have CONFIG_CPU_FREQ and CONFIG_ACPI_PROCESSOR_PERF 
> enabled. Once I enabled them, a performance file appeared in 
> my /proc/acpi/processor/CPU0 directory. This file contained '<not
> supported>'. I also noticed the following message when I boot:
> 
> acpi_processor-0959 [17] acpi_processor_get_per: Unsupported 
> address space [127] (control_register)
> 
> Is there a way for me to examine the ACPI namespace in order 
> to determine what the parser has put in my CPU0 structure?
> 
> In what way are cpufreq and ACPI related? My laptop has an 
> Athlon4 in it, which is not supported by the kernel's cpufreq (yet).
> 
> My SSDT is attached.
> 
> -Nathan
> 
> On Thu, Jan 16, 2003 at 08:46:24AM +0100, Dominik Brodowski wrote:
> > On Wed, Jan 15, 2003 at 05:08:40PM -0800, Grover, Andrew wrote:
> > > > From: Nathan Conrad [mailto:conrad-aYgNHrD+FxfR7s880joybQ@public.gmane.org]
> > > > I am using kernel 2.5.55 on a Sony Vaio PCG-FXA49. Right now,
> > > > /proc/acpi/processor/CPU0/info says that performance 
> management is
> > > > not available. My CPU (1.2 GHz mobile Athlon4) supports 
> PowerNow, and
> > > > I would expect this would qualify as performance management.
> > > > 
> > > > I have looked at my ACPI tables and there is a listing of 5 
> > > > P-states in my SSDT (1200 MHz,1000,800,600,500 MHz).
> > > > 
> > > > Why are these not listed in my /proc/acpi/processor/CPU0 
> > > > directory?
> > > > 
> > > > Does the current Linux ACPI driver look at the SSDT tables, or 
> > > > does it only look at the DSDT for AML?
> > > 
> > > It should consume both SSDT and DSDT tables.
> > > 
> > > You might try taking a look at the "performance 
> management" section 
> > > of drivers/acpi/processor.c. Stick some printk's in 
> > > acpi_processor_get_performance_states and see where 
> things are going 
> > > awry.
> > > 
> > > Also, if _PCT isn't present in the namespace as well, 
> then it flags 
> > > perf support as not available.
> > 
> > Also, do you have CONFIG_CPU_FREQ and CONFIG_ACPI_PROCESSOR_PERF 
> > enabled? If not, support for "performance management" will be 
> > disabled.
> > 
> > 	Dominik
> 




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
