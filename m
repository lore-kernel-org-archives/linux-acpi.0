From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Sun, 3 Apr 2005 19:48:07 -0700
Message-ID: <20050403194807.32fd761a.akpm@osdl.org>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	<20050403193750.40cdabb2.akpm@osdl.org>
	<1112582553.4194.349.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1112582553.4194.349.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> On Mon, 2005-04-04 at 10:37, Andrew Morton wrote:
> > Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > >  tree.
> > 
> > Should I merge that thing into mainline?  It seems that a few people are
> > needing it.
> I'd like to listen to some comments first. There are still some things
> I'm not sure, such as the do_exit_idle.
> 

I was referring to Zwane's i386-cpu-hotplug-updated-for-mm.patch


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
