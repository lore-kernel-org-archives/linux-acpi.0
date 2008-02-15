From: Greg KH <gregkh@suse.de>
Subject: Re: [linux-pm] [PATCH 2.6.25-rc1] cpufreq: fix cpufreq policy
	refcount imbalance
Date: Fri, 15 Feb 2008 10:24:21 -0800
Message-ID: <20080215182421.GA5593@suse.de>
References: <1203032921.3897.10.camel@yangyi-dev.bj.intel.com> <Pine.LNX.4.44L0.0802151043230.3423-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760693AbYBOS0n@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802151043230.3423-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Yi Yang <yi.y.yang@intel.com>, akpm@linux-foundation.org, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 15, 2008 at 10:52:51AM -0500, Alan Stern wrote:
> On Fri, 15 Feb 2008, Yi Yang wrote:
> 
> > This patch adds kobject_put to balance refcount. I noticed Greg suggests
> > it will fix a power-off issue to remove kobject_get statement block, but i
> > think that isn't the best way because those code block has existed very long
> > and it is helpful because the successive statements are invoking relevant
> > data.
> 
> Are you referring to this section of code (before the region affected 
> by your patch)?
> 
> 	if (!kobject_get(&data->kobj)) {
> 		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 		cpufreq_debug_enable_ratelimit();
> 		unlock_policy_rwsem_write(cpu);
> 		return -EFAULT;
> 	}
> 
> Greg is correct that the kobject_get() here is useless and should be
> removed.  kobject_get() never returns NULL unless its argument is NULL.  
> Since &data->kobj can never be NULL, the "if" test will never fail.  
> Hence there's no point in making the test at all.
> 
> The fact that a section of code has existed for a long time doesn't 
> mean that it is right.  :-)
> 
> Furthermore, there's no reason to do the kobject_get().  Holding 2 
> references to a kobject is no better than holding just 1 reference.  
> Assuming you know that the kobject is still registered, then you also 
> know that there is already a reference to it.  So you have no reason to 
> take an additional reference.

There's the additional problem that this second reference count is never
dropped, causing a bug :)

thanks,

greg k-h
