From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: [PATCHES] add _CST support
Date: Thu, 23 Dec 2004 01:18:30 +0100
Message-ID: <20041223001830.GC8289@dominikbrodowski.de>
References: <20041127215118.GA30309@dominikbrodowski.de> <1103698332.17318.170.camel@d845pe> <1103747852.17331.237.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1103747852.17331.237.camel@d845pe>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 22, 2004 at 03:37:32PM -0500, Len Brown wrote:
> I removed the D600 from the port replicator, and now
> it is able to run in C4 w/o any hacks:
Glad to hear that. Was the port replicator causing some sort of periodic bus
master activity which keeps it out of getting to C4 sleep?

> So a list of things we need comes to mind:
- wait and see if issues appear with the split-up and _CST addition
- > Enable > C1 on SMP
... this I'd like to delay a short bit until we make the idle state
algorithm a bit smarter.
- > max_cstate able to disable C4 w/o disabling C3
... see other post, suggesting max_idle_state instead
- > "nocst" flag to compare FADT method w/ _CST
- > bm_check code fix -- currently has no clue of HZ
 > 	a 100HZ kernel gets into C4 less than
 > 	a 1000HZ kernel, likely because of this.
... Yes, this is a bug IMHO. Also, if the idle loop hasn't been entered for one
(or two? or hundred?) ticks, I think it should re-start at C1-type sleep.
- > tick-less idle loop
- _CSD support (depends on _OSC/_PDC framework)

> ps.
> I haven't been able to reproduce the rmmod processor failure,
> though I did have a console log to show that I wasn't halucinating
> at 2AM this morning:

Hm. Did you use some cpufreq module? Will stress-test the processor module
in a few hours, after I get some sleep...

Thanks,
	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
