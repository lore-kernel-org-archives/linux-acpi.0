From: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Date: Mon, 4 Apr 2005 13:42:04 -0600 (MDT)
Message-ID: <Pine.LNX.4.61.0504041322490.30273@montezuma.fsmlabs.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
 <20050403193750.40cdabb2.akpm@osdl.org> <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
 <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050404113129.GA7120-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel!

On Mon, 4 Apr 2005, Pavel Machek wrote:

> > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > >  tree.
> > > 
> > > Should I merge that thing into mainline?  It seems that a few people are
> > > needing it.
> > 
> > Perhaps we should address the MTRR issue first.
> > 
> > I've had code in Suspend2 for quite a while (6 months+) that removes the
> > sysdev support for MTRRs and saves and restores them with CPU context,
> > thereby avoiding the smp_call-while-interrupts-disabled issue. Perhaps
> > it would be helpful here?
> 
> This seems like separate issue... I'd prefer not to block this patch.
> 
> MTRRs should be probably handled by some kind of "cpu is going down"
> and "cpu is going up" callbacks... Zwane, do you have any ideas?
> Linklist of handlers should be enough...

Hmm, it seems to me that we if we're bringing up additional processors we 
only need to update the processor coming online (using mtrrs from an 
online processor) and hold a lock stopping any other updates. So for that, 
we definitely need online and offline callbacks.

Thanks,
	Zwane



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
