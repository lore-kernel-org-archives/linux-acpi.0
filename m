From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]cpuset: add new API to change cpuset top group's cpus
Date: Tue, 19 May 2009 17:06:33 +0800
Message-ID: <20090519090633.GA14597@sli10-desk.sh.intel.com>
References: <20090519073942.GA10864@sli10-desk.sh.intel.com> <1242722454.26820.461.camel@twins> <20090519084852.GA13682@sli10-desk.sh.intel.com> <1242723364.26820.466.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753460AbZESJGn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1242723364.26820.466.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "menage@google.com" <menage@google.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 19, 2009 at 04:56:04PM +0800, Peter Zijlstra wrote:
> On Tue, 2009-05-19 at 16:48 +0800, Shaohua Li wrote:
> > On Tue, May 19, 2009 at 04:40:54PM +0800, Peter Zijlstra wrote:
> > > On Tue, 2009-05-19 at 15:39 +0800, Shaohua Li wrote:
> > > > ACPI 4.0 defines processor aggregator device. The device can notify OS to idle
> > > > some CPUs to save power. This isn't to hot remove cpus, but just makes cpus
> > > > idle.
> > > > 
> > > > This patch adds one API to change cpuset top group's cpus. If we want to
> > > > make one cpu idle, simply remove the cpu from cpuset top group's cpu list,
> > > > then all tasks will be migrate to other cpus, and other tasks will not be
> > > > migrated to this cpu again. No functional changes.
> > > > 
> > > > We will use this API in new ACPI processor aggregator device driver later.
> > > 
> > > I don't think so. There really is a lot more to do than move processes
> > > about.
> > no processor running is good enough for us, we don't care about interrupts/softirq/
> > timers so far.
> 
> Well, I don't care for this interface.
> 
> > > Furthermore, I object to being able to remove online cpus from the top
> > > cpuset, that just doesn't make sense.
> > > 
> > > I'd suggest using hotplug for this.
> 
> > cpu hotplug involves too much things, and we are afraid it's not reliable.
> 
> Then make it more reliable instead of providing ugly ass shit like this.
I wonder why this is that ugly. We have a cpu_isolated_map, which is just like
this.
