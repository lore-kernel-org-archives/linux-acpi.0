From: christian graf <chr.graf-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Sun, 18 Jan 2004 20:28:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074454096.719.29.camel@dragon>
References: <1074382993.674.24.camel@dragon>
	 <1074424728.1914.24.camel@firefly> <400A8381.2050607@pca.it>
	 <20040118171017.GF2375@inferi.kami.home>  <400ACAC3.1050504@pca.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <400ACAC3.1050504-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Configure your 2.6.1 kernel 
Power management options (ACPI,..)-> ACPI
	->CPU-Frequency scaling -> and there you see all the "governors".
Include powersave, performance and set the Default CPUFreq governor to
userspace.
DOwn in the make menuconfig screen you have to choose your cpu wich fits
your system !

load the newly added modules and you should find either one of the
following options (depends on your configured modules):
echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed 
or
echo 600000 > /proc/sys/cpu/0/speed 
or
echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 

the 600000 is just an example. check out your frequency range by:

if you have mounted your sysfs, you should see the dir (and your
frequency-range min, max):
/sys/devices/system/cpu/cpu0/cpufreq$ ls
cpuinfo_max_freq             scaling_driver    scaling_min_freq
cpuinfo_min_freq             scaling_governor  scaling_setspeed
scaling_available_governors  scaling_max_freq


	
hope this helps

christian

Am So, den 18.01.2004 schrieb Luca Capello um 19:04:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 01/18/04 18:10, Mattia Dongili wrote:
> > no, it doesn't. Other cpufreq related daemons need it, not cpufreqd.
> thx, I didn't know this :-) So, I read the 'man' page and I found that
> it uses the ACPI/APM/PMU battery info and the 'cpufreq' driver...
> 
> > you only load the code into the kernel, you can then use procfs to select
> > frequencies ang governor.
> Well, stupid question, but I can't find it: where are the 'governor'
> entries?
> 
> Ciao (for the Italians), bye (for all the others),
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFACsrCVAp7Xm10JmkRAuRlAJ4ohELCGFFGukKIqY0vAuYPPUmT5gCdFCiw
> 8+7vNAb27svwZvFMm3390ao=
> =+Jn0
> -----END PGP SIGNATURE-----
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
