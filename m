From: Thomas Eschenbacher <Thomas.Eschenbacher-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: freqency scaling on compaq nx9010
Date: Sun, 09 Jan 2005 21:33:08 -0300
Message-ID: <41E1CD44.1090107@gmx.de>
References: <41E1B46D.1070107@gmx.de> <20050109225655.GA27910@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050109225655.GA27910-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski wrote:
> [...]
>>I have a compaq nx9010 laptop, running on kernel 2.6.9-gentoo-r13, with 
>>ACPI enabled and speedstep for frequency scaling.
> 
> Which variant of speedstep?

The file "scaling_driver" told me it was "speedstep-smi".
(which makes no sense to me, I have an ALI and no Intel chipset...)
No idea what it really was, I saw no kernel message about
speedstep or so.
(ACPI version is 20040816)

> [...]
>>On the other hand my dsdt contains two entries in the _PSS section, one 
>>for 3059MHz (100%) and one for 1596MHz (~50%) - but those two 
>>frequencies appear nowhere in /proc or /sys/devices/... !?
> 
> What does using the acpi-cpufreq driver lead to?

...to success :-)   Great, this was the right hint!

I kicked out all speedstep stuff from my kernel config and now I see 
30590000 and 15960000 in 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies -
the same values as in my DSDT, using acpi-cpufreq as driver.

So what would be the advantage of speedstep over acpi-cpufreq ?
Does it also switch core voltage or do other things?

thanks for the quick reply and the help,
    Thomas


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
