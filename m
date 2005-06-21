From: Eran Tromer <acpi2eran-IJe252wrQBYdnm+yROfE0A@public.gmane.org>
Subject: Re: /proc/acpi/alarm miscalculations and RTC century corruption
Date: Tue, 21 Jun 2005 06:03:33 +0300
Message-ID: <42B78385.4080206@tromer.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575025A17EF@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575025A17EF-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 21/06/05 05:07, Li, Shaohua wrote:

> Century alarm is optional. I didn't find any system which supports
> century alarm at hand. Is there any real hardware support it?

As far as I can tell, there is no century alarm in the ACPI spec. There
is not even a year alarm. But there is a century field for the real-time
clock, and /proc/acpi/alarm is overriding *that* one.

I have experimentally verified that this indeed corrupts the RTC CMOS
date on ThinkPad T21. The laptop will then no longer boot until you
reset the date through the BIOS (and would behave very strangely,
requiring multiple boots to recover). And in some plausible scenarios, a
corrupted RTC could lead to data loss when file dates are mangled.

I stress again that this is the most serious bug in this code, and can
be solved just by deleting those two lines. The other bugs may only
cause lost or mistimed wakups, which is less severe. Please get this
fixed regardless of the rest.


> Yes, we should add more check. Please send a patch to Len.

I'll leave the actual patch writing and submission to you guys, I'm just
reporting the bugs.


>>dates, but even valid inputs (e.g, RTC "2000-01-31 12:00" and relative
>>date "+0000-00-31 12:00") can yield an invalid output ("2000-02-32
>>00:00"), and that's before we get to variable month lengths. How safe
> 
> is it to let this stuff hit the CMOS?
> 
> No, the format written to alarm is fixed. It's just an interface and so
> it's no reason to let kernel parse the complex string. If you want a
> more user friendly interface, please write a tool.

The kernel is already parsing and processing the complex string! But
it's doing it incorrectly. As you say, it's an interface -- so it must
do what it commits to.

To take another example, consider the following very realistic scenario:
if I echo "+0000-00-00 01:00" > /proc/acpi/alarm, I expect the machine
to wake up in an hour, right? That's the interface. Now, what if the
current time happens to be 2005-02-28 23:30? The alarm will be set to
2005-02-29 00:30 and probably won't occur until the next leap year.
Who's fault is that?

The easiest way out is to disable the relative time (adjust=1) interface
and allow only specification of absolute time, thereby breaking existing
code; then declare that the provided time string must be valid and blame
the caller if he feeds you silly data and the sky falls. As for how
prudent it is to let junk values be written to the CMOS through an
apparently innocuous kernel interface, I'll leave that to the good
people of this list.


>>While at it, there is currently no way to disable the ACPI alarm; at
>>most you can set it to a date in the past or in the far future. It
> would >>be nice if writing some special value (maybe "" or "off") to
>>/proc/acpi/alarm disabled the alarm, by removing RTC_AIE from the
>>RTC_CONTROL CMOS field and/or by disabling ACPI_EVENT_RTC.
> 
> ACPI alarm is disabled by default. It only enabled if you give it alarm
> date. 

Right. But suppose an alarm has already been set and now I want to
cancel it? For example, if something else woke me up early so the alarm
so it is no longer pertinent. That's basic functionality.


> But it is good not enabling it if the alarm date is invalid. In
> addition, a 'off' or a special value like '0000-00-00 00:00.00' to
> disable alarm makes sense to me.

Using "0000-00-00 00:00.00" would be pretty dangerous in light of the
century bug, since on legacy kernels it will silently corrupt the RTC
(in fact this is how I originally encountered the bug). So I think an
"off" or the empty string would be better.


  Eran


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
