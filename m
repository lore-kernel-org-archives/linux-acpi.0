From: Marcel Selhorst <selhorst-Un86pfwebVPMYnii8HsYE0T4CPmD8wNEs0AfqQuZ5sE@public.gmane.org>
Subject: Re: Accessing DSDT entries within a kernel device driver
Date: Wed, 03 Aug 2005 00:05:43 +0200
Message-ID: <42EFEE37.2090500@crypto.rub.de>
References: <42EFC9AD.8060607@selhorst.net> <1123015115.5110.28.camel@tdi>	 <42EFE697.8030701@selhorst.net> <1123019412.5110.52.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123019412.5110.52.camel@tdi>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>   Heh, I should pay better attention to who I'm talking to ;^)

lol, sounds a little like the godfather:
<italian sound on>
you better pay attention whom you're talking to
<italian sound off>

:-))

>    Very cool.  While you're at it, I think we're going to end up having
> TPMs that live in MMIO space instead of I/O port space.  I assume the
> access semantics are pretty similar, readb/writeb vs inb/outb, but it's
> probably a good time to add that too.

great idea, I will think about that :)

>    Completely untested, but based on 8250_pnp, I think you'd need
> something like this: [...]

wow, that was quick, thanks for the fast reply and the detailled examples!
I will try them out now (hmm, hope this is not going to be an insomnian night).

> I probably have some scrap
> code around from when I was trying that approach if you'd like it.

For the moment I should have enough :)

>    Cool, sounds like things are on the right track.  Let me know if I
> can help further. 

Yes, thanks, you can test the new code, when its done :-)

Bye,

Marcel Selhorst


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
