From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Sun, 18 Jan 2004 14:00:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <400A8381.2050607@pca.it>
References: <1074382993.674.24.camel@dragon> <1074424728.1914.24.camel@firefly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074424728.1914.24.camel-YqzrDssuZYw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 01/18/04 12:18, Yury V. Umanets wrote:
> I guess, that there is no code in kernel, which does watch current
> loading and adjust CPU speed. Also this is job for a cpufreq governor,
> not for CPU driver.
>
> For now, there are three governors:
> (1) powersave -- setting CPU frequency statically to lowest available
> frequency.
> (2) performance -- setting to highest available frequency.
> (3) userspace -- used for setting CPU frequency manually.
>
> Probably there also should be number (4), which will set it basing on
> current loading.
some questions and/or suggestions for kernel 2.6.1:

- - 'Power management option (ACPI, APM)' should be changed in 'Power
management option (ACPI, APM, CPUFreq)'

- - why 'Power management option > CPU Frequency scaling > Default CPUFreq
governor' shows only 'performance|userspace' and not also 'powersave'?

- - here my config section for 'Power management option > CPU Frequency
scaling':
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_PROC_INTF=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> CONFIG_CPU_FREQ_GOV_USERSPACE=m
> # CONFIG_CPU_FREQ_24_API is not set
> CONFIG_CPU_FREQ_TABLE=y

as I didn't know (I had never read docs before and the help from 'make
menuconfig' isn't complete IMHO), I've never load the
'cpufreq_userspace' module, even if I was thinking to use the
'cpufreqd'. If I've correctly understood, 'cpufreqd' need the
'userspace' option/module to work, right? So, why even without the
'userspace' module loaded, is 'cpufreqd' working? I can see it via
/proc/cpuinfo plugging in/out the AC-Adapter.

- - what does loading 'cpufreq_' modules cause? I can see no differences
when I load 'cpufreq_[powersave|userspace]'...

I finished, for now :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFACoOAVAp7Xm10JmkRAs+aAJ9w5ZC7Nn5G6K5K5uemEvyb+Q7c9ACfYANJ
c9A6Rz2Sns701M4qsdi77iw=
=qN86
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
