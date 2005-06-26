From: Stefan Baums <baums@u.washington.edu>
Subject: Re: Fw: ACPI and the idle loop - possible bug
Date: Sat, 25 Jun 2005 20:40:55 -0700
Message-ID: <20050626034055.GA18992@localhost.localdomain>
References: <20050625151923.738504b1.akpm@osdl.org> <1119744303.14822.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1119744303.14822.9.camel@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This Problem also occures on a lot of ASUS Laptops, sounds a bit
> like the morse alpabet ;-)

Yes, it does.  It is rather unpleasant.

> My suggestion is that this sounds are created by the
> powerconverters.  And it only occurs on my ASUS M6 when the
> processor is in C3.  So the described behaviour is clear, cause
> if you unload the processor ACPI module, you processor will stop
> going in C3 and thou the sounds stop.

   [...]

> >    idle=halt
> 
> What exactly does this parameter do ? Using for all C-States the
> hlt instruction ?

I have no idea.  A contributor to the ThinkWiki page that I
referred to had heard 'in several forums' that the problem may
have to do with the '"idle"-state (or "C3") of the processor'.
That got me googling, I came across the 'idle' kernel boot
parameter, and tried it out.  The documentation for this parameter
in linux-2.6.12/Documentation/kernel-parameters.txt is a
two-liner:

   idle=           [HW]
                   Format: idle=poll or idle=halt

and I could find no further information about this on the
Internet.  I guess somebody familiar with that part of the kernel
code will have to tell us what the parameter does.

Googling revealed that the C3 state seems to have caused another
(unrelated?) problem with the wireless driver on last year's
ThinkPad models:

   http://www.thinkwiki.org/wiki/Patch_disabling_ACPI_C3

That resulted in a patch to disable C3 (but not C2) entirely, but
I don't know if that patch still works with 2.6.12, and to be
honest, I'd rather keep my C3.  Whatever it is that idle=halt does
(until ACPI apparently switches it off) seems preferable.

Stefan

-- 
Stefan Baums
Asian Languages and Literature
University of Washington


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
