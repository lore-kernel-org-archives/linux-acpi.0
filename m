From: pumpkin <pumpkin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Wed, 20 Jul 2005 21:29:33 +0200
Message-ID: <200507202129.33823.pumpkin@gmx.de>
References: <200507192050.28343.pumpkin@gmx.de> <42DD85F3.9050300@tzi.de> <200507201921.43576.pumpkin@gmx.de>
Reply-To: pumpkin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507201921.43576.pumpkin-Mmb7MZpHnFY@public.gmane.org>
Content-Disposition: inline
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

Hello

i have made some experiments and now i'm scared shitless:

Removing and reinserting ieee1394, eth1394 and ohic1394 stops all bus master 
activity, even under X. USB and WLAN are active. Now the CPU stays at C4, a 
mode which didn't even show up before.

Now one battery charge should be enough for 4 hours. IBM says 3 and a half 
hours. That's why i love linux.

Thanks,

On Wednesday 20 July 2005 19:21, pumpkin wrote:
> Hello
>
> > Sometimes an active WLAN driver causes bus master activity...
>
> Inserted USB, removed WLAN and ieee1394. C2/C3-ratio dropps to 10:90 in
> console-mode. That's better. I don't mind removing ieee1349, but without
> networking the laptop is more or less useless. So i'm f***ed.
>
> > You also should not use an USB Mouse...
>
> No USB in use except the 4 root-hubs (the trackpoint is using PS/2).
>
> > And by the way, what's wrong with 50:50 C2 C3 ?
> > This seems pretty normal to me.
>
> I have seen 10:90 on AthlonXP-systems running XFree. That's what i want,
> even if it is a long way to go.
>
> So i only have 2 problems left:
>
> - Is it possible to reconfigure WLAN to cause less Bus Master Activity ? (i
> will ask the ipw2200 guys and grok the code)
>
> - and why is the radeon driver causing ffffffff-Activity ?
>
> Running x without radeon driver is not an option. The radeon driver enables
> powerplay, which in turn saves quite a bit.
>
>
> Thanks,
>
> > > On Tuesday 19 July 2005 22:18, Bob Lees wrote:
> > >>Hi
> > >>
> > >>In a word USB.  I don't fully understand why, but if I disable USB then
> > >>both my laptops will go into C3 or C4, with USB enabled stays in C2.
> > >>
> > >>Laptops are Compaq EVO 800c and IBM T42p both running SUSE 9.3 with a
> > >> stock SuSE kernel 2.6.11-suse modified
> > >>
> > >>Bob
> >
> > -------------------------------------------------------
> > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > informative Webcasts and more! Get everything you need to get up to
> > speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
