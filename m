From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: Re: [patch 11/12] new sony_acpi driver
Date: Thu, 3 Mar 2005 10:39:50 +0100
Message-ID: <20050303093949.GB3346@crusoe.alcove-fr>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <1109790760.2097.587.camel@d845pe> <20050302205324.GA5486@deep-space-9.dsnet> <1109839245.4866.10.camel@nouse.net>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109839245.4866.10.camel-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 03, 2005 at 09:40:45AM +0100, Timo Hoenig wrote:

> On Wed, 2005-03-02 at 21:53 +0100, Stelian Pop wrote:
> [...]
> >
> >I have no problem keeping it out of the tree, it has been this was
> >for quite a long time now. Anyway the distro maintainers are starting
> >to put it into their kernels so it won't be a problem for endusers
> >any longer. BTW, it was those distro maintainers who asked me to
> >resubmit the driver lately...
> >
> I guess you're talking about me.

Not only you.

> I did not contact you being a distro
> maintainer.  As developer, my intention was -- and still is -- that we
> really should get as many laptop specific functions into mainline as
> possible.  I care about happy users.

So do I. 

Unhappy users also come bugging me (because I also maintain a non-ACPI
sony driver which did work with older models but works less and less 
with newer ones) and I have to tell them about sony_acpi. Maybe I
should tell them to bug acpi_devel instead ?

> It's a shame that there are actually drivers out there but users simply
> do not benefit from them because they are not merged with mainline.

I fully agree.

> Anyway, as Len proposed, a generic solution is definitely the best
> solution.  Let's get this work done.

Except the generic solution doesn't exist. It could be partly 
implemented (like acpi_video), but it will never be complete.

> >But still, I don't see why there is no place for a sony acpi somewhere
> >where there are already drivers for ibm, toshiba and asus laptops.
> 
> They will disappear once the generic solution is implemented.

Maybe the problem here is that the ACPI based drivers should not
be at all in the ACPI tree.

drivers/acpi contain today both the ACPI layer and the ACPI drivers.
Maybe a split up like the networking code would be saner: $KDIR/acpi
for the layer and $KDIR/drivers/acpi for the drivers using the acpi
API to implements specific drivers.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
