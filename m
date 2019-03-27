From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Wed, 27 Mar 2019 16:10:48 +0200
Message-ID: <20190327141047.bhndwqde7vjz6bad@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Petr,

On Tue, Mar 26, 2019 at 04:13:07PM +0100, Petr Mladek wrote:
> On Fri 2019-03-22 17:29:30, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.
> > 
> > On ACPI based systems the resulting strings look like
> > 
> > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > 
> > where the nodes are separated by a dot (".") and the first three are
> > ACPI device nodes and the latter two ACPI data nodes.
> > 
> > Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")
> 
> Reusing obsolete modifiers is dangerous from many reasons:
> 
>    + people might miss the change of the meaning
>    + backporting mistakes
>    + 3rd party modules
> 
> It might be acceptable if the long term gain is bigger
> than a short time difficulties. But it would be better
> to it a safe way when possible.
> 
> Fortunately, we could keep the backward compatibility
> for "%pf" and handle only "%pfw*" with the fwnode api.

The v2 of this patch produces a warning (using WARN_ONCE()) for "%pf" not
immediately followed by "w". "%pfw" was not a valid conversion specifier
before this set, so we're actually not re-using the exactly same conversion
specifiers.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
