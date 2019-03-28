From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Date: Thu, 28 Mar 2019 15:52:35 +0100
Message-ID: <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com> <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com> <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
 <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Petr,
> > >
> > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> > > > > Add two convenience functions for accessing node's parents:
> > > > >
> > > > > fwnode_count_parents() returns the number of parent nodes a given node
> > > > > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > > > > from the node itself.
> > > > >
> > > > > Also reorder fwnode_get_parent() in property.c according to the same order
> > > > > as in property.h.
> > > > >
> > > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > > index 8b91ab380d14..61eb6ceacc3f 100644
> > > > > --- a/drivers/base/property.c
> > > > > +++ b/drivers/base/property.c
> > > > > @@ -554,17 +567,49 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> > > > >  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
> > > > >
> > > > >  /**
> > > > > - * fwnode_get_parent - Return parent firwmare node
> > > > > - * @fwnode: Firmware whose parent is retrieved
> > > > > + * fwnode_count_parents - Return the number of parents a node has
> > > > > + * @fwnode: The node the parents of which are to be counted
> > > > >   *
> > > > > - * Return parent firmware node of the given node if possible or %NULL if no
> > > > > - * parent was available.
> > > > > + * Returns the number of parents a node has.
> > > > >   */
> > > > > -struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
> > > > > +unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
> > > > >  {
> > > > > -   return fwnode_call_ptr_op(fwnode, get_parent);
> > > > > +   unsigned int count;
> > > > > +
> > > > > +   fwnode_handle_get(fwnode);
> > > > > +
> > > > > +   for (count = 0; fwnode; count++)
> > > > > +           fwnode = fwnode_get_next_parent(fwnode);
> > > >
> > > > Is it guaranteed that all parents stay when
> > > > fwnode_get_next_parent() releases the reference count
> > > > for each counted member?
> > >
> > > fwnode_get_next_parent() only releases the child node after it has acquired
> > > the parent. The only implementation with refcounting for single nodes is
> > > actually OF.
> > >
> > > >
> > > > > +
> > > > > +   return count - 1;
> > > >
> > > > We could start counting from count = -1;
> > >
> > > We could, but then count would need to be made signed (unless overflowing
> > > is preferred instead).
> >
> > What if there are no parents?
> >
> > Or is it guaranteed that there always will be at least one?
>
> If there are no parents, the function will return 0 --- the node itself is
> counted in the loop, too, hence the need to decrement by one.

Right, sorry.

Then I don't see why count cannot be int.  Or call it "iter" to avoid
confusion with negative "counts". :-)
