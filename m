From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: bk-acpi causes freezes on ia64/tiger
Date: Tue, 12 Apr 2005 13:25:13 +1000
Message-ID: <1113276313.3645.1130.camel@desktop.cunningham.myip.net.au>
References: <20050408011437.7fe1159d.akpm@osdl.org>
	 <1113190685.2420.36.camel@d845pe> <1113252341.2419.44.camel@d845pe>
	 <20050411182951.52f76e93.akpm@osdl.org>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050411182951.52f76e93.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-04-12 at 11:29, Andrew Morton wrote:
> Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > On Sun, 2005-04-10 at 23:38, Len Brown wrote:
> >  > On Fri, 2005-04-08 at 04:14, Andrew Morton wrote:
> >  > > Current bk-acpi tree causes my Intel tiger box to freeze partway
> >  > > through boot.
> > 
> >  Looks like the freeze may be due to the "C1 patch":
> > 
> >  http://linux-acpi.bkbits.net:8080/to-akpm/cset@424cccb33M89YNHJOda1O6L0B6ucjw
> > 
> >  If you revert that one does your tiger live?
> 
> That server appears to be dead.  I took a punt and reverted the below
> patch.  That fixed things up.

Larry posted a message on LKML a short while ago saying bk-bits is down,
and offering to go and reboot it if anyone so desired.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
