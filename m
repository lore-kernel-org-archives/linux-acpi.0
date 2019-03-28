From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Date: Thu, 28 Mar 2019 13:43:51 +0200
Message-ID: <20190328114350.cyzj7zkbmbu4a2i4@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
 <20190326131626.GZ9224@smile.fi.intel.com>
 <20190326133248.2nrm5javjw4vd2yq@paasikivi.fi.intel.com>
 <20190327123659.nna3hqcotnerptiz@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327123659.nna3hqcotnerptiz@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 27, 2019 at 01:36:59PM +0100, Petr Mladek wrote:
> On Tue 2019-03-26 15:32:48, Sakari Ailus wrote:
> > Hi Andy,
> > 
> > On Tue, Mar 26, 2019 at 03:16:26PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> > > > The prefix is used for printing purpose before a node, and it also works
> > > > as a separator between two nodes.
> > > > 
> > > 
> > > One nit below.
> > > 
> > > > +static const char *
> > > > +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> > > > +{
> > > > +	struct fwnode_handle *parent;
> > > > +
> > > 
> > > > +	parent = fwnode_get_parent(fwnode);
> > > > +	/* Root node. */
> > > 
> > > I guess a comment could be easier to read if it goes before parent assignment
> > > line.
> > 
> > Only if the comments are changed accordingly. What we're doing here is
> > trying to figure out whether this is the root node. I can do that for v3.
> 
> IMHO, the comment in acpi_fwnode_get_name() is easier to understand:
> 
> /* Is this the root node? */
> 
> > > 
> > > > +	if (!parent)
> > > > +		return "";
> > > > +
> > > > +	parent = fwnode_get_next_parent(parent);
> > > > +	/* Second node from the root; no prefix here either. */
> > > 
> > > Ditto.
> 
> /* Is this 2nd node from the root? */

I used both the strings.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
