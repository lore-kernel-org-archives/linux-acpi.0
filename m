From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 4/5] lib/vsprintf: Make use of fwnode API to obtain node
 names and separators
Date: Wed, 27 Mar 2019 15:49:12 +0200
Message-ID: <20190327134912.knvr4anvbef6iqld@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-5-sakari.ailus@linux.intel.com>
 <20190327125356.s7hockgf5yfyhx52@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327125356.s7hockgf5yfyhx52@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Petr,

Thank you for reviewing these patches.

On Wed, Mar 27, 2019 at 01:53:56PM +0100, Petr Mladek wrote:
> On Fri 2019-03-22 17:29:29, Sakari Ailus wrote:
> > Instead of implementing our own means of discovering parent nodes, node
> > names or counting how many parents a node has, use the newly added
> > functions in the fwnode API to obtain that information.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 37 +++++++++++++++----------------------
> >  1 file changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 5f60b8d41277..91f2a3e4892e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -37,6 +37,7 @@
> >  #include <net/addrconf.h>
> >  #include <linux/siphash.h>
> >  #include <linux/compiler.h>
> > +#include <linux/property.h>
> >  #ifdef CONFIG_BLOCK
> >  #include <linux/blkdev.h>
> >  #endif
> > @@ -1720,32 +1721,23 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
> >  	return format_flags(buf, end, flags, names);
> >  }
> >  
> > -static const char *device_node_name_for_depth(const struct device_node *np, int depth)
> > -{
> > -	for ( ; np && depth; depth--)
> > -		np = np->parent;
> > -
> > -	return kbasename(np->full_name);
> > -}
> > -
> >  static noinline_for_stack
> > -char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
> > +char *fwnode_gen_full_name(struct fwnode_handle *fwnode, char *buf, char *end)
> 
> I first read this as fwnode_get_full_name(), see "get" vs. "gen".
> I guess that it was because there is used also fwnode_get_name().
> 
> Please, rename it to fwnode_full_name_string() or so ;-)

Works for me.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
