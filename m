From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Battery status reading problems
Date: Tue, 23 Sep 2003 18:25:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064334307.14784.92.camel@idoru.kc.de>
References: <m2vfrpthxt.fsf@tnuctip.rychter.com>
	 <Pine.LNX.4.58.0309192257480.1613@phoenix.kerstin.at>
	 <3F6EAADC.4020509@basmevissen.nl>
	 <Pine.LNX.4.53.0309220954120.9385@dynast.gaugusch.at>
	 <1064230622.8592.14.camel@dhcp23.swansea.linux.org.uk>
	 <3F703933.50604@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F703933.50604-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Di, 2003-09-23 um 14.14 schrieb Bas Mevissen:
> Alan Cox wrote:
> > Several vendors implement the actual battery reading logic as an SMI
> > trap and disable interrupts during their slow chat with the battery.
> > There isnt much anyone can do about that bit alas (except read it a lot
> > less often)
> OK. I'll check with Win XP and Linux with latest ACPI CA to see if I 
> notice a speed difference between Windows and Linux. The XP battery 
> indicator detects AC/battery power changes in a few seconds, so I expect 
> the batery status polling in Windows to occur at the same speed.
> (or does the AC/battery power work with an event? The my assumption 
> won't hold then)

I could very well accept CPU load.
I would even accept delays, given they are small.
But I experienced kernel hangs, i.e. short periods of no I/O activity at
all when querying the battery status. And even that could be acceptable.
What was not acceptable were very bizarre happenings that lokked like
lost interrupts!? Events that did not cause the reaction they should
have. Less severe were lost mouse events but more severe was packet loss
on network.

So for me it looks more like a bug in the ACPI code than just a
performnce issue or hardware misdesign.
The other thing that leads to this assumption is that so many of us see
this happening, with various notebooks by various manufacturers. It is
not bound to certain or limited number of "bad" machines.

> Bas.
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
