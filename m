From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 04 Apr 2005 19:54:04 +1000
Message-ID: <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050403193750.40cdabb2.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

On Mon, 2005-04-04 at 12:37, Andrew Morton wrote:
> Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> >  tree.
> 
> Should I merge that thing into mainline?  It seems that a few people are
> needing it.

Perhaps we should address the MTRR issue first.

I've had code in Suspend2 for quite a while (6 months+) that removes the
sysdev support for MTRRs and saves and restores them with CPU context,
thereby avoiding the smp_call-while-interrupts-disabled issue. Perhaps
it would be helpful here?

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
