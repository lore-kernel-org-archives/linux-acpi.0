From: Cyril Wattebled <neurowork-GANU6spQydw@public.gmane.org>
Subject: Re: Centrino question
Date: Sun, 23 May 2004 13:21:22 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040523132122.6ba363b4.neurowork@free.fr>
References: <3ACA40606221794F80A5670F0AF15F84046AA243@PDSMSX403.ccr.corp.intel.com>
	<20040522005658.640e1d91.neurowork@free.fr>
	<1085282649.12352.739.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1085282649.12352.739.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 22 May 2004 23:24:10 -0400
Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Fri, 2004-05-21 at 20:56, Cyril Wattebled wrote:
> > On Fri, 21 May 2004 19:42:58
> > "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > > How did you run windows ? 
> > Well, the first thing to say is that, on Windows, when the laptop is
> > unplugged, the processor slows down to 200 mhz instead of 600 mhz when
> > plugged. That says a lot of heat and, I guess power. When I say up to 6h, I
> > mean when the laptop is idle of course.
> > 
> > > How did you run Linux?
> > 
> > Same here, I tried to let it idle and it hold 2h30 ..
> 
> Linux slows the processor to 600MHz when Windows gets down to 200MHz?

Yes, I have already asked around why this happends. Windows slows the processor
down to 200 mhz when unplugged and down to 600 mhz when plugged. Windows
behaves just like linux with the AC power on but when on battery, it manages
to slow it down to 200mhz. This allows the laptop to last more than on linux
and also, the temperature of the overall laptop is cooler (which is really more
confortable).
It seems that Windows is using some kind of clock modulation along with the
enhanced speedstep. I'm not sure about that but, I was told that it should be
something like it. (cf cpufreq mailing list, thread called "Pentium M minimum
clock modulation").

> How about the display -- is the brightness comparable on Linux vs
> Windows?

yes, The screen brightness is set to the same value.

> thanks,
> -Len

Thanks,

--
Cyril Wattebled
neurowork-GANU6spQydw@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
