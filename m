From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Tue, 8 Sep 2015 12:40:08 +0200
Message-ID: <20150908104008.GD3644@twins.programming.kicks-ass.net>
References: <55E54FE2.7030601@linux.intel.com>
 <CAJZ5v0itBxg_gQzEe=nVfxOVpw5WBs9u8VDP7PHoyXyirnmdPQ@mail.gmail.com>
 <55ED0057.1000806@linux.intel.com>
 <2165815.z3RZSlC1oy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2165815.z3RZSlC1oy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, mingo@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2015 at 11:33:21PM +0200, Rafael J. Wysocki wrote:
> On Monday, September 07, 2015 11:11:19 AM Jiang Liu wrote:
> Peter, Ingo, some help from lockdep expert is needed.
> 
> We have a splat that almost certainly is a false positive (the original report
> is here http://marc.info/?l=linux-kernel&m=144109156901959&w=4) and no ideas
> how to make it go away.  Can you please have a look and advise?

I can't even find the relevant code :/

>From that email I get kernfs_fop_write() which calls
kernfs_get_active(), but that does _NOT_ call cpu_up(), so that
callchain is shite.

The actual lockdep splat is also not really helpful, and is spraying
names over: acpi, device, sysfs and kernfs (do we really need that many
layeres of obfuscation for a simple file?)

So, please, start by explaining the thing proper such that simple people
like me know what to look for.
