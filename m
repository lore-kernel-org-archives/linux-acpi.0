From: Stefan Seyfried <seife-bro8zJjCcIc@public.gmane.org>
Subject: Re: Help! I lost my C4 states :-)
Date: Fri, 4 Mar 2005 18:05:53 +0100
Message-ID: <20050304170553.GA28717@message-id.s3e.de>
References: <20050221081225.GA10848@message-id.gmane0305.slipkontur.de> <1109885929.2103.813.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109885929.2103.813.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 03, 2005 at 04:38:49PM -0500, Len Brown wrote:
> On Mon, 2005-02-21 at 03:12, Stefan Seyfried wrote:

> > Any hints on how to track down what is causing bus master activity all the
> > time?
> > Has the calculation algorithm changed? Any default settings i could tweak?
> 
> Did you notice a battery life decrease with this decrease in C4
> residency?

Yes, although i lately run the battery down only on rare occasions, but the
"projected" runtime with mostly C4 active was almost 4 hours while now it is
a bit more than 3h30. I do no longer spin down the disk, since my dell locks
up hard sometimes when the disk should spin up again, but the C4 was at least
as big a gain than doing really aggressive disk spindown, (including 
laptop_mode etc, my disk was _really_ spun down for 10 minutes between short
spinups).

In fact, i noticed that C4 started working since i noticed that my battery
started to last longer. When i still spun down the disk, this was hardly
noticeable.
 
> On January 20th we pushed Dominik's jiffies based bm_activity patch
> in drivers/acpi/processor_idle.c  You might find that backing out
> that file a couple of revisions restores the previous behaviour.
> 
> Just after that, I added a tunable that you can tweak --
> with 1000 HZ, its default is all bits enabled, but
> you can reduce this bit mask to make the driver
> ignore less recent history:
> 
> # echo 0 > /sys/module/processor/parameters/bm_history
> 
> Will cause the processor driver to ignore the bus master activity
> completely.  Note that this could cause a performance hit if
> there is BM activity since will just pop the system out of C4
> and no instructions are executed during the transition out of C4.

I tried fiddling with this parameter, but will try again. I think i never
set it to zero, only 0xffff or something like that.
> 
> cheers,
> -Len
> 
> ps.
> If you're tracking battery life, I'd be interested to know if
> you notice a difference between when you build with HZ=100 and HZ=1000.

I'll do it as soon as Andrea Arcangely puts back the "select HZ Patch" back
into the SUSE kernel. Unfortunately i mostly have to run stock compiled
kernels just to be able to file "valid" bugreports :-)
-- 
Stefan Seyfried


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
