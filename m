From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: RE: CONFIG_PM, CONFIG_ACPI, CONFIG_ACPI_SLEEP
Date: Thu, 10 Mar 2005 14:48:55 +1100
Message-ID: <1110426535.8870.90.camel@desktop.cunningham.myip.net.au>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F22F17@hdsmsx401.amr.corp.intel.com>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3002F22F17-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2005-03-10 at 14:36, Brown, Len wrote:
>  >> Why shouldn't CONFIG_ACPI depend on CONFIG_PM
> >> Why shouldn't CONFIG_ACPI_SLEEP simply be CONFIG_ACPI
> >> 
> >> I can't think of any good reasons not to simplify here, can you?
> >
> >That sounds confusing to me. I thought that ACPI was much more 
> >than just power management. Doesn't it include IRQ routing, device 
> >enumeration and so on too?
> 
> Yes, ACPI does a lot of configuration too -- but there really isn't any
> concept of having the config part of ACPI without having the power
> management part.
> 
> The real question is if CONFIG_PM=n is an interesting configuration on
> ACPI-enabled systems.  I'm thinking that a couple of years ago it was,
> but today everybody is using CONFIG_PM=y.

I think 'everybody' is an overstatement. If I put things in the wrong
place such that I break CONFIG_PM=n, I hear about it. That said, I do
agree that CONFIG_PM=y can increasingly be taken for granted.

Perhaps there's an issue somewhere else though. After all, I'd be
surprised if you argued that CONFIG_ACPI_FAN was a power management
function. Maybe ACPI config options could be split up a little so that
those related to PM did come under CONFIG_PM, and those related to PNP
or whatever else could appear elsewhere? Of course I'm speaking as
someone who doesn't know exactly how closely all of this functionality
inter-relates, so what makes sense to me might not make sense to you :>

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
