From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Tue, 26 Mar 2019 15:24:50 +0200
Message-ID: <20190326132450.GB9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
 <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8c6accab-9e0c-c2d4-ce93-ea3ede60f34e@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 02:11:35PM +0100, Rasmus Villemoes wrote:
> On 26/03/2019 13.41, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.

> > +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> > +		if (pass) {
> > +			if (buf < end)
> > +				*buf = ':';
> > +			buf++;
> > +		}
> > +
> > +		switch (*fmt) {
> > +		case 'f':	/* full_name */
> > +			buf = fwnode_gen_full_name(fwnode, buf, end);
> > +			break;
> > +		case 'P':	/* name */
> > +			buf = string(buf, end, fwnode_get_name(fwnode),
> > +				     str_spec);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> 
> This seems awfully complicated. Why would anyone ever pass more than one
> of 'f' and 'P'? Why not just
> 
> switch(*fmt) {
> case 'P':
>    ...
> case 'f':
> default:
>    ...
> }
> 
> which avoids the loop and the strcspn. Or, drop the default: case and
> don't have logic at all for falling back to 'f' if neither is present.
> 
> > +	return widen_string(buf, buf - buf_start, end, spec);
> > +}

My point as well (as per sent comments against previous version).
Sakari, can you add test cases at the same time?

> >  			return device_node_string(buf, end, ptr, spec, fmt + 1);

> > +			return fwnode_string(buf, end, ptr, spec, fmt + 1);
> 
> Why not pass fmt+2; we know that fmt+1 points at a 'w'. Just to avoid
> doing the fmt++ inside fwnode_string().

I guess in order to be consistent with existing %pOF case. But wouldn't be
better to fix %pOF for that sooner or later?

-- 
With Best Regards,
Andy Shevchenko
