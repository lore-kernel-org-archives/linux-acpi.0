From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 3 Mar 2005 10:27:25 +0100
Message-ID: <20050303092725.GA3346@crusoe.alcove-fr>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002E2E026@hdsmsx401.amr.corp.intel.com>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3002E2E026-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 02, 2005 at 05:37:44PM -0500, Brown, Len wrote:

> >But still, I don't see why there is no place for a sony acpi somewhere
> >where there are already drivers for ibm, toshiba and asus laptops.
> 
> The goal is to DELETE ibm, toshiba, and asus drivers -- or at least the
> duplicated functions in them.

Did you look at the code in those drivers ? There is no way you can
delete them because each of them is very specific in the functionalities
it offers and the way to achieve it.

Sure, for basic stuff like the brightness you can hope to have a 
common code (like video.c today). It may even work on future laptops.
But it won't work on older (todays) laptops (I'm not sure about the
other brands, but it won't work on Sony Vaios). And even if when it
works it won't do everything because vendors will always implement
extensions.

And you can choose to either not have access to those extensions
under Linux (which sucks) or have platform specific drivers.

> platform specific drivers make it harder, not easier, to support more
> hardware -- there are a zillion vendors out there, implementing special
> drivers for each of them is a strategy of last resort.

There are hardly "a zillion vendors" in the laptop market. I'd say
that IBM + HP + Sony + Toshiba + Dell form 90+ % of the market.

> >I attached to the bugzilla entry the DSDTs for two Vaio laptops, which
> >should hopefuly prove that those laptops do not support the standard
> >ACPI way to access the video. Did you look at them ?
> 
> thanks for filing the bug, it is in the queue.

The point of the question was to point out that I've already provided
proof that Vaios do not support standard ACPI video methods.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
