From: Jason Uhlenkott <jasonuhl-sJ/iWh9BUns@public.gmane.org>
Subject: Re: Re: 2.6.12-rc1-mm3
Date: Fri, 25 Mar 2005 21:52:55 -0800
Message-ID: <20050326055255.GA210003@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org> <20050326014327.GB207782@dragonfly.engr.sgi.com> <1111802218.19916.59.camel@d845pe> <20050326020212.GC207782@dragonfly.engr.sgi.com> <1111803861.19920.91.camel@d845pe> <20050326025704.GE207782@dragonfly.engr.sgi.com> <1111810359.19919.113.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111810359.19919.113.camel@d845pe>
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
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 25, 2005 at 11:12:39PM -0500, Len Brown wrote:
> I realize now I didn't answer your original question.
> The reason ACPI now depends on PM is that
> it makes it easier for us to do a more orderly shutdown --
> acpi registers as a device so it can do some stuff
> upon the PM device shutdowns -- before interrupts are disabled.
> 
> I think with all the twisty turney passages
> related to the suspend states, poweroff, sys-req, and now kexec,
> that it is best if we can keep the code paths as
> common as possible or some of them will never get the
> testing needed to prevent them from getting broken.
> 
> Also, it is now common practice to include PM && ACPI together
> in the x86 world.  Though technically one could have
> ACPI w/o PM and you'd have lost only ACPI_SLEEP, virtually
> nobody seems to use/depend-on that combination.

OK, that makes sense.  I see now that Jesse has already sent a patch
to allow CONFIG_PM on sn2, so we'll be fine as soon as that gets
merged.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
