From: Nathan Lynch <ntl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Mon, 4 Apr 2005 17:46:20 -0500
Message-ID: <20050404224620.GD3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com> <20050404052844.GB3611@otto> <1112593338.4194.362.camel@sli10-desk.sh.intel.com> <20050404153345.GC3611@otto> <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1112652864.3757.31.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Nigel!

On Tue, Apr 05, 2005 at 08:14:25AM +1000, Nigel Cunningham wrote:
> 
> On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
> > > Yes, exactly. Someone who understand do_exit please help clean up the
> > > code. I'd like to remove the idle thread, since the smpboot code will
> > > create a new idle thread.
> > 
> > I'd say fix the smpboot code so that it doesn't create new idle tasks
> > except during boot.
> 
> Would that mean that CPUs that were physically hotplugged wouldn't get
> idle threads?

No, that wouldn't work.  I am saying that there's little to gain by
adding all this complexity for destroying the idle tasks when it's
fairly simple to create num_possible_cpus() - 1 idle tasks* to
accommodate any additional cpus which may come along.  This is what
ppc64 does now, and it should be feasible on any architecture which
supports cpu hotplug.


Nathan

* num_possible_cpus() - 1 because the idle task for the boot cpu is
  created in sched_init.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
