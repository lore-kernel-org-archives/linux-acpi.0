From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: 23 Dec 2004 00:07:22 -0500
Message-ID: <1103778442.2577.51.camel@d845pe>
References: <20041127215118.GA30309@dominikbrodowski.de>
	 <1103698332.17318.170.camel@d845pe>
	 <20041223001024.GB8289@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041223001024.GB8289-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-12-22 at 19:10, Dominik Brodowski wrote:
> > I found I had to disable the bm_check to get out of C1
> > on my D600.  This doesn't sound right, as bm_check
> > should only have an effect on entering C3.
> 
> Huh, yes, this sounds like a bug. Can't reproduce it here, though :-(

neither can I...

> >  cat /proc/acpi/processor/CPU0/power
> > active state:            3
> > max_cstate:              C42
> > bus master activity:     00000000
> > states:
> >     1:                  type[C1] promotion[2] demotion[-]
> latency[001]
> > usage[00000010]
> >     2:                  type[C2] promotion[3] demotion[1]
> latency[001]
> > usage[00003280]
> >    *3:                  type[C3] promotion[4] demotion[2]
> latency[085]
> > usage[00000819]
> >     4:                  type[C3] promotion[-] demotion[2]
> latency[185]
> > usage[00000000]
> >
> > It appears the demotion from C4 is to C2, when one would expect C3.
> 
> Actually, this was on purpose: I think we want to leave C3-type sleep
> quickly to advance bus master activity...

The hardware transitions us from C3 to C0 automatically, and retires the
bus master activity automatically.

The software bookeeping here is only to decide what to enter
the next time we enter idle.

I agree that the promote/demote algorithm needs some work, particularly
its tracking of bus master activity, and system busy-ness rather than
just idleness.  But with the current scheme, I believe that C4 should
demote to C3, not to C2.

thanks,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
