From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: freqency scaling on compaq nx9010
Date: Thu, 13 Jan 2005 16:08:53 +0100
Message-ID: <20050113150853.GA8430@dominikbrodowski.de>
References: <41E1B46D.1070107@gmx.de> <20050109225655.GA27910@dominikbrodowski.de> <41E1CD44.1090107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41E1CD44.1090107-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Eschenbacher <Thomas.Eschenbacher-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 09, 2005 at 09:33:08PM -0300, Thomas Eschenbacher wrote:
> The file "scaling_driver" told me it was "speedstep-smi".
> (which makes no sense to me, I have an ALI and no Intel chipset...)
> No idea what it really was, I saw no kernel message about
> speedstep or so.
> (ACPI version is 20040816)

Then you used the wrong speedstep-driver, AFAICS. It is only meant for
mobile Pentium III CPUs... I need to check why it didn't fail to load.

> I kicked out all speedstep stuff from my kernel config and now I see 
> 30590000 and 15960000 in 
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies -
> the same values as in my DSDT, using acpi-cpufreq as driver.
> 
> So what would be the advantage of speedstep over acpi-cpufreq ?
> Does it also switch core voltage or do other things?

The acpi-cpufreq driver (normally) also scales voltage, it may just be
slower than speedstep-ich or speedstep-centrino. However, it's ot faster or
slower than speedstep-smi.

	Dominik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
