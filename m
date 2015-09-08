From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Wed, 09 Sep 2015 00:28:12 +0200
Message-ID: <4305045.rOCzS8rSge@vostro.rjw.lan>
References: <55E54FE2.7030601@linux.intel.com> <2165815.z3RZSlC1oy@vostro.rjw.lan> <20150908104008.GD3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150908104008.GD3644@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, mingo@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, September 08, 2015 12:40:08 PM Peter Zijlstra wrote:
> On Mon, Sep 07, 2015 at 11:33:21PM +0200, Rafael J. Wysocki wrote:
> > On Monday, September 07, 2015 11:11:19 AM Jiang Liu wrote:
> > Peter, Ingo, some help from lockdep expert is needed.
> > 
> > We have a splat that almost certainly is a false positive (the original report
> > is here http://marc.info/?l=linux-kernel&m=144109156901959&w=4) and no ideas
> > how to make it go away.  Can you please have a look and advise?
> 
> I can't even find the relevant code :/
> 
> From that email I get kernfs_fop_write() which calls
> kernfs_get_active(), but that does _NOT_ call cpu_up(), so that
> callchain is shite.
> 
> The actual lockdep splat is also not really helpful, and is spraying
> names over: acpi, device, sysfs and kernfs (do we really need that many
> layeres of obfuscation for a simple file?)
> 
> So, please, start by explaining the thing proper such that simple people
> like me know what to look for.

OK, I'll try to get that later this week.

Or maybe Jiang Liu can beat me to doing that. :-)

Thanks,
Rafael
