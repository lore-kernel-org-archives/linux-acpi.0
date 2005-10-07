From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI problem
Date: Fri, 07 Oct 2005 12:50:54 +0200
Message-ID: <4346530E.1070500@suse.de>
References: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giacomo Rizzo <giacomorizzo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Giacomo Rizzo wrote:
> Hi,
> Len Brown gave me your address because I talked to him
> about a problem I'm having while trying installing linux (I tried
> several distros)
> The problem is that my notebook (a sony pcg-nvr23)
> shuts down after a random number of seconds during the installation process.
> I think it's an acpi problem because once I tried booting Knoppix by keeping
> the temperature around
> my notebook really low (it was a really cold winter night)
> Looking at /proc/acpi/temperature I realized that the cpu temperature was
> getting higher and higher as the second passed, untill my computer turned
> off.
> Another weird thing is this. I installed Suse 9.1 always being in a cold
> place and it seems that the temperature is quite stable (it's not so low but
> at least it's far from upper limit). I would like to know if it's possible,
> a way to install any linux distribution without keeping the notebook cool.
This is probably because of powersave daemon controlling your cpufreq.
This package was only available for SUSE and ALT Linux.
Currently people are working on a Debian and Gentoo package. Not sure if there 
are already finished packages (please let me know if you find them).

You could use the cpufreqd (now called cpuspeed?) package that only scales 
cpufreq or you can try to adopt the powersaved (that also includes a lot 
additional features) to Knoppix (CVS hosted on forge.novell.com), be sure you 
get help on the mailing list there.

Still, if you are running on full power for a long time you will probably always 
suffer of a critical thermal shutdown.
This could be related to http://bugzilla.kernel.org/show_bug.cgi?id=3410.
Hopefully this patch goes mainline soon.
If you have a high tsp value (check cat /proc/acpi/thermal_zone/*/trip_points) 
for your passive mode it's probably bug #3410.
As a workaround you could lower the passive trip point value there by:
echo C:H:P:A1:A2 >/proc/acpi/thermal_zone/*/trip_points
C -> critical limit
H -> hot limit
P -> passive limit
A1/2 -> active limit
Just pass any value if a limit is not defined in your BIOS, e.g. echo 
100:90:60:50:45 sets passive cooling trip point limit (cpufreq will be lowered) 
to 60 degree.

     Thomas


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
