From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in
 acpi_get_next_subnode()
Date: Tue, 30 Apr 2019 19:47:44 +0300
Message-ID: <20190430164744.GO9224@smile.fi.intel.com>
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
 <20190430163041.GN9224@smile.fi.intel.com>
 <ba56e822-92ee-7a75-5c62-45f3a572ccde@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ba56e822-92ee-7a75-5c62-45f3a572ccde@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 11:41:50AM -0500, Pierre-Louis Bossart wrote:
> On 4/30/19 11:30 AM, Andy Shevchenko wrote:
> > On Tue, Apr 30, 2019 at 10:52:29AM -0500, Pierre-Louis Bossart wrote:
> > > When the DSDT tables expose devices with subdevices and a set of
> > > hierarchical _DSD properties, the data returned by
> > > acpi_get_next_subnode() is incorrect, with the results suggesting a bad
> > > pointer assignment. The parser works fine with device_nodes or
> > > data_nodes, but not with a combination of the two.
> > > 
> > > The problem is traced to an invalid pointer used when jumping from
> > > handling device_nodes to data nodes. The existing code looks for data
> > > nodes below the last subdevice found instead of the common root. Fix
> > > by forcing the acpi_device pointer to be derived from the same fwnode
> > > for the two types of subnodes.
> > > 
> > > This same problem of handling device and data nodes was already fixed
> > > in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
> > > node parsing in acpi_get_next_subnode()")' but broken later by 'commit
> > > 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
> > > this should probably go to linux-stable all the way to 4.12
> > 
> > Period is missed in above sentence.
> > 
> > I think it make sense to add Fixes: tag.
> 
> Thanks Andy for the review. I hesitated to add a fixes tag. The line about
> resetting the adev pointer was indeed removed in the latter commit, but
> there were a slew of other changes done later by Sakari on hierarchical _DSD
> so it's quite complicated to say when this was last fully functional.

I see, btw, you forgot to add Sakari to Cc list, he is doing a lot lately WRT
device properties.

> > Nevertheless,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thank you for fixing this interesting issue!

-- 
With Best Regards,
Andy Shevchenko
