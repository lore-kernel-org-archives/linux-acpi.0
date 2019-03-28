From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Thu, 28 Mar 2019 15:35:39 +0100
Message-ID: <20190328143539.nty4xzwnml47vcj2@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
 <20190327141047.bhndwqde7vjz6bad@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327141047.bhndwqde7vjz6bad@paasikivi.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed 2019-03-27 16:10:48, Sakari Ailus wrote:
> Hi Petr,
> 
> On Tue, Mar 26, 2019 at 04:13:07PM +0100, Petr Mladek wrote:
> > On Fri 2019-03-22 17:29:30, Sakari Ailus wrote:
> > > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > > support printing full path of the node, including its name ("f") and only
> > > the node's name ("P") in the printk family of functions. The two flags
> > > have equivalent functionality to existing %pOF with the same two modifiers
> > > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > > based systems is added by this patch.
> > > 
> > > On ACPI based systems the resulting strings look like
> > > 
> > > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > > 
> > > where the nodes are separated by a dot (".") and the first three are
> > > ACPI device nodes and the latter two ACPI data nodes.
> > > 
> > > Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")
> > 
> > Reusing obsolete modifiers is dangerous from many reasons:
> > 
> >    + people might miss the change of the meaning
> >    + backporting mistakes
> >    + 3rd party modules
> > 
> > It might be acceptable if the long term gain is bigger
> > than a short time difficulties. But it would be better
> > to it a safe way when possible.
> > 
> > Fortunately, we could keep the backward compatibility
> > for "%pf" and handle only "%pfw*" with the fwnode api.
> 
> The v2 of this patch produces a warning (using WARN_ONCE()) for "%pf" not
> immediately followed by "w". "%pfw" was not a valid conversion specifier
> before this set, so we're actually not re-using the exactly same conversion
> specifiers.

I see. I would keep the two patchsets separate. I mean that this
patchset should expect that the original handling of %pf is still
there.

The way how to remove or obsolete "%pf" should be handled in
the patchset removing all %pf users or it can be done
in a completely separate patch.

The conflict can get handled when merging the two patchsets.

Best Regards,
Petr
