From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 3 Mar 2005 10:45:54 +0100
Message-ID: <20050303094554.GC3346@crusoe.alcove-fr>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002E2E026@hdsmsx401.amr.corp.intel.com> <20050303092725.GA3346@crusoe.alcove-fr> <1109842444.4866.16.camel@nouse.net>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109842444.4866.16.camel-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 03, 2005 at 10:34:04AM +0100, Timo Hoenig wrote:

> On Thu, 2005-03-03 at 10:27 +0100, Stelian Pop wrote:
> >Did you look at the code in those drivers ? There is no way you can
> >delete them because each of them is very specific in the functionalities
> >it offers and the way to achieve it.
> >
> >Sure, for basic stuff like the brightness you can hope to have a 
> >common code (like video.c today). It may even work on future laptops.
> >But it won't work on older (todays) laptops (I'm not sure about the
> >other brands, but it won't work on Sony Vaios). And even if when it
> >works it won't do everything because vendors will always implement
> >extensions.
> 
> Since the function implementations vary but their purpose is the same it
> would be possible by creating generic wrapper functions (hotkey
> implementation, trigger common hardware functions like fan,
> bluetooth...).  I'm not sure which way would be the best to cover laptop
> specific functions which are not covered by the generic wrapper
> functions.

It would be nice to have a common API for userspace. Today this
is done at application level (KDE for example, etc), but it would
be nice if, for the generic functionalities, the kernel would
offer the same API (/proc/acpi, /sys, ioctl based, whatever) to the
userland.

But the discussion here is pretty unrelated. We are talking about
the implementation not interface, and what Len wants is to remove
the specific {ibm,toshiba,asus} implementations and make generic ones 
based on the ACPI stantard.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
