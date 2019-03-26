From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 16:06:33 +0200
Message-ID: <20190326140633.GE7049@kuha.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326131353.GY9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> > > > On ACPI based systems the resulting strings look like
> > > > 
> > > > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > > > 
> > > > where the nodes are separated by a dot (".") and the first three are
> > > > ACPI device nodes and the latter two ACPI data nodes.
> > > 
> > > Do we support swnode here?
> > 
> > Good question. The swnodes have no hierarchy at the moment (they're only
> > created for a struct device as a parent) and they do not have human-readable
> > names. So I'd say it's not relevant right now. Should these two change,
> > support for swnode could (and should) be added later on.
> 
> Heikki, what do you think about this?

Well, the swnodes do have hierarchy. That was kind of the whole point
of introducing them. They now can also be named using "name" property.
See commit 344798206f171c5abea7ab1f9762fa526d7f539d.

thanks,

-- 
heikki
