From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 4 Apr 2005 11:32:13 +0200
Message-ID: <20050404093213.GB14765@elf.ucw.cz>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com> <20050403193750.40cdabb2.akpm@osdl.org> <1112582553.4194.349.camel@sli10-desk.sh.intel.com> <20050403194807.32fd761a.akpm@osdl.org> <1112582947.4194.352.camel@sli10-desk.sh.intel.com> <1112601670.3757.6.camel@desktop.cunningham.myip.net.au> <1112604263.4194.367.camel@sli10-desk.sh.intel.com> <20050404091027.GA14765@elf.ucw.cz> <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1112606651.4194.391.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
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
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > I'm switching suspend2 to use hotplug too. Li, I'll try adding your
> > > > patches as well as Zwane's if you like 
> > > Great!
> > > 
> > > > (suspend2 can enter S3, S4 or S5
> > > > after writing the image). I'd love to try it on my HT desktop, and
> > > > hotplug will get more testing too :>
> > > Unfortunately, my patches break Pavel's swsusp SMP, as my patches break
> > > current 'cpu_up' mechanism. S4 doesn't require to boot AP CPUs from real
> > > mode.
> > 
> > Uh, I don't like that one. Is it possible to put secondary CPUs back
> > to the real mode 
> Possibly doesn't need the trouble. Send a SIPI also can wakeup the a CPU
> in protected mode.
> 
> > so that cpu_up mechanism can handle them?
> If S4 also calls a smp_prepare_cpu, then the patches don't break S4. If
> people don't complain warm boot a CPU is slow, I'd like S4 also use
> smp_prepare_cpu.

Okay, that seems like a solution. Slowness should not really be a
problem (unless it takes > few seconds)...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
