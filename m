From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Wed, 6 Apr 2005 16:19:23 +0200
Message-ID: <20050406141923.GZ2298@poupinou.org>
References: <200504042214.15648.jfrey@gmx.de> <200504051813.28983.jfrey@gmx.de> <20050405180826.GU2298@poupinou.org> <200504052223.17547.jfrey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504052223.17547.jfrey-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 05, 2005 at 10:23:17PM +0200, Jan Frey wrote:
> > BTW, are you sure throttling work OK?
> 
> At least you can notice remarkable slowdown and loss of responsiveness when 
> throttling is supposed to be active. This effect is also dependent on the 
> throttling level, the higher it is the more noticeable those delays are...
> So at least on the "slow-down" side of things it seems to be working, but 
> unfortunately it does not decrease CPU temp...

Well...  BTW, throttling is only a way to force somehow a certain amount
of idle time to be done, somehow.  If you have some trouble even if the
system is mostly idle, throttling wont help.

> > Then mail me the acpidmp.out.bz2
>  
> I will do so as soon as possible.

OK, got it.  Will look.

> > I'm still wondering if I'm right to think that its not an intel
> > chipset.  If its an Intel one, then something is wrong.  Intel chipset
> > support 8 throttling levels, not 16.  Could you please do a lspci -v?
> 
> Oh yes, I totally forgot. If I remember correctly it is some VIA chipset.
> lspci output will also follow.

I remember that some southbridge are broken, though I'm only aware
problem with some PIIX4 (it is in an errata, I don't remember exactly
which version).  Maybe its the case here?
Does your laptop hang if forcing throttling level at 12%?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
