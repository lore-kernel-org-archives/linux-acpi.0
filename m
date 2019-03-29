From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Date: Fri, 29 Mar 2019 15:04:36 +0200
Message-ID: <20190329130436.4fxzki5kljprhyai@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <20190328141036.mbns3ei4agnginsg@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328141036.mbns3ei4agnginsg@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Petr,

On Thu, Mar 28, 2019 at 03:10:36PM +0100, Petr Mladek wrote:
> On Wed 2019-03-27 16:20:37, Sakari Ailus wrote:
> > Hi Petr,
> > 
> > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > > > Add two convenience functions for accessing node's parents:
> > > > 
> > > > fwnode_count_parents() returns the number of parent nodes a given node
> > > > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > > > from the node itself.
> > > > 
> > > > Also reorder fwnode_get_parent() in property.c according to the same order
> > > > as in property.h.
> > > > 
> > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > index 8b91ab380d14..61eb6ceacc3f 100644
> > > > --- a/drivers/base/property.c
> > > > +++ b/drivers/base/property.c
> > > > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > > >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > > >  
> > > >  /**
> > > > - * fwnode_get_parent - Return parent firwmare node
> > > > - * @fwnode: Firmware whose parent is retrieved
> > > > + * fwnode_count_parents - Return the number of parents a node has
> > > > + * @fwnode: The node the parents of which are to be counted
> > > >   *
> > > > - * Return parent firmware node of the given node if possible or %NULL if no
> > > > - * parent was available.
> > > > + * Returns the number of parents a node has.
> > > >   */
> > > > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > > > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> > > >  {
> > > > -	return fwnode_call_ptr_op(fwnode, get_parent);
> > > > +	unsigned int count;
> > > > +
> > > > +	fwnode_handle_get(fwnode);
> > > > +
> > > > +	for (count = 0; fwnode; count++)
> > > > +		fwnode = fwnode_get_next_parent(fwnode);
> > > 
> > > Is it guaranteed that all parents stay when
> > > fwnode_get_next_parent() releases the reference count
> > > for each counted member?
> > 
> > fwnode_get_next_parent() only releases the child node after it has acquired
> > the parent. The only implementation with refcounting for single nodes is
> > actually OF.
> 
> I am still a bit confused. The function is later used the following way:
> 
> 	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> 		struct fwnode_handle *__fwnode =
> 			fwnode_get_nth_parent(fwnode, depth);
> 
> 		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
> 			     default_str_spec);
> 		buf = string(buf, end, fwnode_get_name(__fwnode),
> 			     default_str_spec);
> 
> 		fwnode_handle_put(__fwnode);
> 	}
> 
> It uses the number to walk the hierarchy over and over again to print
> the path from root.
> 
> I would expect that parents could not get removed until all children
> are removed. And that the most bottom child (fwnode) must not get
> removed. Otherwise we would access freed memory in each cycle.
> 
> Then there is a question why we need to get the reference of the
> parents
> at all.
> 
> It might be because we do not need touch refcounting of the parents
> in this scenario. But we are re-using existing functions where
> the ref-counting hang-over is important.
> 
> Or we really need to increase refcounting of parents. Then it looks
> suspicious because we want to traverse the same path several times
> and always have only one node locked (refcounted).

I hope I understand your concern better this time.

You basically have to have a reference to a node until you're done
accessing it. The refcounting in the fwnode framework is based on the OF
API --- otherwise you couldn't access OF nodes using the framework. ACPI
does not have those (as you can't dynamically remove nodes). The newly
added swnode does have refcounting of individual nodes as well.

Even if a node's parent did disappear while printing an fwnode full name,
it'd mean that

1) fwnode_count_parents() returned an incorrect value (less than expected)
   or

2) some of the node names could be NULL if node references could not be
   obtained.

Both would result into garbled output in that case. I have to admit I'm not
sure if this is possible with OF.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
