From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 04 Apr 2005 18:01:11 +1000
Message-ID: <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
	 <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1112582947.4194.352.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I'm switching suspend2 to use hotplug too. Li, I'll try adding your
patches as well as Zwane's if you like (suspend2 can enter S3, S4 or S5
after writing the image). I'd love to try it on my HT desktop, and
hotplug will get more testing too :>

Nigel

On Mon, 2005-04-04 at 12:49, Li Shaohua wrote:
> On Mon, 2005-04-04 at 10:48, Andrew Morton wrote:
> > Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > On Mon, 2005-04-04 at 10:37, Andrew Morton wrote:
> > > > Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > > >
> > > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > > >  tree.
> > > > 
> > > > Should I merge that thing into mainline?  It seems that a few people are
> > > > needing it.
> > > I'd like to listen to some comments first. There are still some things
> > > I'm not sure, such as the do_exit_idle.
> > > 
> > 
> > I was referring to Zwane's i386-cpu-hotplug-updated-for-mm.patch
> Yep, great. Pavel's swsusp also need it.
> 
> Thanks,
> Shaohua
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
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
