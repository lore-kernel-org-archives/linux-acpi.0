From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: 23 Dec 2004 00:30:55 -0500
Message-ID: <1103779855.2577.76.camel@d845pe>
References: <20041127215118.GA30309@dominikbrodowski.de>
	 <1103698332.17318.170.camel@d845pe> <1103747852.17331.237.camel@d845pe>
	 <20041223001830.GC8289@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041223001830.GC8289-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
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

On Wed, 2004-12-22 at 19:18, Dominik Brodowski wrote:
> On Wed, Dec 22, 2004 at 03:37:32PM -0500, Len Brown wrote:
> > I removed the D600 from the port replicator, and now
> > it is able to run in C4 w/o any hacks:
> Glad to hear that. Was the port replicator causing some sort of
> periodic bus master activity which keeps it out of getting to C4
> sleep?

Yes, bus-master activity went from always on to sometimes on.
Maybe there is a USB hub in the port replicator...

> 
> > So a list of things we need comes to mind:
> - wait and see if issues appear with the split-up and _CST addition

I'll push this into 2.6.11 as soon as it opens up,
so it should get broad exposure quite quickly, and quite
early in the release cycle.

> - > Enable > C1 on SMP
> ... this I'd like to delay a short bit until we make the idle state
> algorithm a bit smarter.

Bob and Venki prototyped updated algorithms a while back.
I'm hopeful that they can port that work to the new code
and it can make early 2.6.11 also.

> - > max_cstate able to disable C4 w/o disabling C3
> ... see other post, suggesting max_idle_state instead
> - > "nocst" flag to compare FADT method w/ _CST
> - > bm_check code fix -- currently has no clue of HZ
>  >      a 100HZ kernel gets into C4 less than
>  >      a 1000HZ kernel, likely because of this.
> ... Yes, this is a bug IMHO.

I think the bug is that our sampling of BM activity ages
10x faster in the 1000HZ case.

>  Also, if the idle loop hasn't been entered for one
> (or two? or hundred?) ticks, I think it should re-start at C1-type
> sleep.

Agreed.  The current promote/demote code looks at idleness when it
should look at busy-ness and system load.

> - > tick-less idle loop
> - _CSD support (depends on _OSC/_PDC framework)

We need to handle SMP C-states even if the system doesn't
supply us with _CSD.

cheers,
-Len







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
