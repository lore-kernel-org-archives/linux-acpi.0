From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
Date: Tue, 05 Apr 2005 08:56:38 +1000
Message-ID: <1112655398.3757.36.camel@desktop.cunningham.myip.net.au>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <20050404052844.GB3611@otto>
	 <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
	 <20050404153345.GC3611@otto>
	 <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
	 <20050404224620.GD3611@otto>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261446AbVDEAPN@vger.kernel.org>
In-Reply-To: <20050404224620.GD3611@otto>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Lynch <ntl@pobox.com>
Cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>, ACPI List <acpi-devel@lists.sourceforge.net>, Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-04-05 at 08:46, Nathan Lynch wrote:
> Hi Nigel!
> 
> On Tue, Apr 05, 2005 at 08:14:25AM +1000, Nigel Cunningham wrote:
> > 
> > On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
> > > > Yes, exactly. Someone who understand do_exit please help clean up the
> > > > code. I'd like to remove the idle thread, since the smpboot code will
> > > > create a new idle thread.
> > > 
> > > I'd say fix the smpboot code so that it doesn't create new idle tasks
> > > except during boot.
> > 
> > Would that mean that CPUs that were physically hotplugged wouldn't get
> > idle threads?
> 
> No, that wouldn't work.  I am saying that there's little to gain by
> adding all this complexity for destroying the idle tasks when it's
> fairly simple to create num_possible_cpus() - 1 idle tasks* to
> accommodate any additional cpus which may come along.  This is what
> ppc64 does now, and it should be feasible on any architecture which
> supports cpu hotplug.

Ah. Ta. I was a little confused :>

Nigel

> * num_possible_cpus() - 1 because the idle task for the boot cpu is
>   created in sched_init.
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net
