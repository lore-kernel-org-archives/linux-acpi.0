From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Tue, 05 Apr 2005 08:14:25 +1000
Message-ID: <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <20050404052844.GB3611@otto>
	 <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
	 <20050404153345.GC3611@otto>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050404153345.GC3611@otto>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Lynch <ntl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
> > Yes, exactly. Someone who understand do_exit please help clean up the
> > code. I'd like to remove the idle thread, since the smpboot code will
> > create a new idle thread.
> 
> I'd say fix the smpboot code so that it doesn't create new idle tasks
> except during boot.

Would that mean that CPUs that were physically hotplugged wouldn't get
idle threads?

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
