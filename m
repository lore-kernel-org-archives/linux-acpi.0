From: christian graf <chr.graf-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi_processor.c - kernel 2.6.1
Date: Sun, 18 Jan 2004 18:39:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074447569.719.9.camel@dragon>
References: <1074382993.674.24.camel@dragon>
	 <1074424728.1914.24.camel@firefly>
Mime-Version: 1.0
Content-Type: text/plain
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
To: "Yury V. Umanets" <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hu Yuri, hi Yu

I have enabled all 3 governors:

cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
powersave performance userspace


Actual after logging in I run the command:
TARGET=/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
F_LOW=powersave
echo $F_LOW > $TARGET

But it does not really matter to which governor I'm switching, my CPU
stays in C2 independant from load and used governor. My notebook in a
Siemens Lifebook E4010D, newest Bios.


But I thought setting a governor is totally independant from setting the
cpu_freq, using speedstep-technology?


Any other ideas for me?

Thanks

christian


Am So, den 18.01.2004 schrieb Yury V. Umanets um 12:18:
> On Sun, 2004-01-18 at 02:43, christian graf wrote:
> > Hi,
> Hello,
> > 
> > reading the /usr/src/linux-2.6.1/drivers/acpi/processor.c
> > i thought the kernel should set the state dynamically, based on the
> > load. Maybe it is possible to set the processor-state of my centrino
> > manually. Can please anybody tell me how to get it right?
> > 
> 
> There is an user-space daemon, which adjusts CPU speed basing on current
> loading. And it is able to change CPU frequency if userspace cpufreq
> governor is turned on. I would like to see this functionality in kernel
> though.
> 
> > The reason I'm asking is, that once I do load the processor.ko module,
> > my Centrino switches immediately into C2-state. It never switches back
> > to C1 state, even under heavy load like compiling the kernel.
> > 
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
> > I think the kernel should switch back from C2 to C1 state from alone????
> > 
> > Please ask me whatever you need to help me swtiching back into C1 state.
> > 
> > christian



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
