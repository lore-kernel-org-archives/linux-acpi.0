From: "Yury V. Umanets" <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: can't switch CPU frequency while running on battery
	power
Date: Sat, 03 Jan 2004 18:39:56 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073144396.1771.28.camel@firefly>
References: <32886.192.168.36.2.1072957501.squirrel@defiant.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <32886.192.168.36.2.1072957501.squirrel-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Defiant <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-01-01 at 14:45, Defiant wrote:
> Hello,
> 
> I can easily switch my CPU frequency between 1,2 and 1,6 Ghz while running
> with the ac adapter with
> echo "1200000:1600000:powersave" > /proc/cpufreq
> and
> echo "1200000:1600000:performance" > /proc/cpufreq
> 
> Maybe using the cpufreq will do the same - I don't know (see below)
> 
> Now a cat /proc/cpuinfo shows me, that my command was successful.
> Now If I disconnect the ac adapter and the laptop is running only from
> battery it doesn't work anymore. I can do a echo everything want I want to
> /proc/cpufreq - it is doing nothing - looking at /proc/cpuinfo the Laptop
> is always running with 1.6Ghz - that is full power for me.
I guess I have the same problem with ASUS M3700N. I can't adjust cpu
frequency if laptop is not power supplied. But the way I have discovered
it was a little bit different. When I boot without AC, cpu has half of
possible frequency (600MHz) (possible due to Pentium 4 clock modulation
turned on) and then I can't increase it, but definitely can decrease
(down to 75MHz).
> 
> I dunno if it is important, but at bootime I get this message:
> cpufreq: No CPUs supporting ACPI performance management found.
> and /proc/acpi/processor/CPU0/performance is not available - even I
> enabled it (CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y).
> 
> Well - I hope someone is able to help me - AND a happy new year :)
This is due to CONFIG_X86_ACPI_CPUFREQ=y, which adds cpufreq driver for
adjusting cpu frequency via ACPI Processor Performance States. But this
is not supported by hardware I guess.
> 
> Erik Andresen
> 
> /info:
> ------
> I'm running linux kernel 2.6.0-mm2 on a Sony Vaio PCG-NV105.
> My cpu is a
> model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
> and my kernel .config:
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_RELAXED_AML is not set
> # CONFIG_X86_PM_TIMER is not set
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_PROC_INTF=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_TABLE=y
> 
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_SPEEDSTEP_ICH=y
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> CONFIG_X86_SPEEDSTEP_LIB=y
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
> 
> --
> 
> All I ask is a tall ship, and a star to steer her by
> > defiant.homedns.org <
>  -cause Experience is Knowledge
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
umka



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
