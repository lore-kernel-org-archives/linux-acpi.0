From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] RFC: Xen pad logic
Date: Mon, 26 Mar 2012 12:51:17 -0400
Message-ID: <20120326165117.GG10236@phenom.dumpdata.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD0A6@SHSMSX101.ccr.corp.intel.com>
 <20120314001833.GB20363@phenom.dumpdata.com>
 <DE8DF0795D48FD4CA783C40EC8292335105DB9@SHSMSX101.ccr.corp.intel.com>
 <20120326163820.GD10236@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120326163820.GD10236@phenom.dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Jinsong" <jinsong.liu@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Kernel development list <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "keir.xen@gmail.com" <keir.xen@gmail.com>, Jan Beulich <JBeulich@suse.com>, "Li, Shaohua" <shaohua.li@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 26, 2012 at 12:38:20PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 26, 2012 at 06:18:36AM +0000, Liu, Jinsong wrote:
> > Konrad Rzeszutek Wilk wrote:
> > > On Thu, Feb 23, 2012 at 01:31:25PM +0000, Liu, Jinsong wrote:
> > >>> From ba9abf6ee7e5fe0515e2d51b14743c8d5416285c Mon Sep 17 00:00:00
> > >>> 2001 
> > >> From: Liu, Jinsong <jinsong.liu@intel.com>
> > >> Date: Fri, 24 Feb 2012 02:18:02 +0800
> > >> Subject: [PATCH 2/2] Xen pad logic
> > >> 
> > >> This patch implement Xen pad logic, and when getting pad device
> > >> notification, it hypercalls to Xen hypervisor for core parking.
> > > 
> > > Can you explain to me how and what pad device is? And how it functions
> > > right now in baremetal? And what kind of hardware do you need to use
> > > this? 
> > > And what happens if you do not use it? Can one ignore the "pad"
> > > support? 
> > > Please assume that I've a basic understanding of ACPI.
> > > 
> > > 
> > > Also, what happens now, if the this patch is not implemented? What
> > > will/is dom0 doing without these patches (so 3.2 for example on this
> > > machine)? 
> > > Is it just idling using mwait on idle CPUs and ending up trapping in
> > > the hypervisor? Or is not mwaiting since the cstate.c doesn't get
> > > executed since we have: 
> > > 
> > >        boot_option_idle_override = IDLE_HALT;
> > > 
> > > in arch/x86/xen/setup.c ?
> > 
> > 
> > Pad is an ACPI device used to direct os taking some action (depend on os itsef) for the sake of power consumption. 2 objs (PUR and OST) could be declared under PAD and as bios/os interface.
> > 
> > PAD itself is pointless, unless it co-work with some external power control s/w (like NPTM). For example currently in baremetal, NPTM engine trigger sci to ospm, then evaluate and call sci handler, through which bios notify os with PUR value by which os could take corresponding action and feedback bios through OST. I don't think it's a problem if user don't use PAD or ignore it, it only make some external power control s/w unuseable.
> 
> What is NPTM? Sounds like a SMI firmware?
> 
> > 
> > As for how os handle pad notify is os business. Native kernel use round robin and mwait, considering some app workload affinity (I was told so). For xen we don't need care it since it's a question of vcpu level. For xen acpi_pad, dom0 patches used to parse PUR and hypercall to hypervisor, which in turn idle pcpu by its own algorithm.
> 
> I presume you have some of this hardware - if you launch the latest linus/master (along with these
> patches https://bugzilla.redhat.com/show_bug.cgi?id=804347 patches) and compile CONFIG_ACPI_PAD_PROCESSOR=y
> and are running under Xen 4.1, what happens when the _PUR notifcation takes affect?

err, Xen-unstable, as the MWAIT_LEAF expose patch depends on patches that are only
in Xen-unstable, not Xen 4.1.
