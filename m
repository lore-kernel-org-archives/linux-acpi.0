From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: 25 Mar 2005 14:07:43 -0500
Message-ID: <1111777662.19921.43.camel@d845pe>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
	 <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
	 <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
	 <1111603235.17317.883.camel@d845pe>  <1111688662.24547.26.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111688662.24547.26.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>, Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thu, 2005-03-24 at 13:24, Bjorn Helgaas wrote:
> On Wed, 2005-03-23 at 13:40 -0500, Len Brown wrote:
> > But checking skip_ioapic_setup in the non-ACPI case
> > isn't quite right.  This is set for "noapic".  But
> > it is not set in the PIC-mode case where the kernel
> > supports IOAPIC but the hardware does not -- in that
> > case the quirk would erroneously exit.
> 
> Ah, right, thanks.  I changed it to:
> 
>         if (nr_ioapics && !skip_ioapic_setup)
>                 return;
> 
> Is that better?
> 
> > Also, the original quirk_via_irqpic()
> > had a udelay(15) before the write -- I have no idea
> > if that was significant or not -- maybe soembody else
> > on the list does -- as none of us have VIA documentation...
> 
> Yes, I was worried about that, too.  I added it back.
> 
> > ps. we need to fix this on 2.4 also.
> 
> Here's yet another iteration for 2.6.  If this works OK,
> I can back-port it to 2.4.
...



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
