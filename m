From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Date: Sun, 24 Mar 2019 20:17:46 +0200
Message-ID: <20190324181745.vgckevapfwi7mul7@mara.localdomain>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322172114.GY9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the comments.

On Fri, Mar 22, 2019 at 07:21:14PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 22, 2019 at 05:29:30PM +0200, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.
> 
> Do we encourage people to use it instead of %pOF cases where it is suitable?

For code that is used on both OF and ACPI based systems, I think so. But if
you have something that is only used on OF, %pOF is better --- it has more
functionality that seems quite OF specific. In general I think the ability
to print a node's full name is way more important on OF. On ACPI you don't
need it so often --- which is probably the reason it hasn't been supported.

> 
> > On ACPI based systems the resulting strings look like
> > 
> > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > 
> > where the nodes are separated by a dot (".") and the first three are
> > ACPI device nodes and the latter two ACPI data nodes.
> 
> Do we support swnode here?

Good question. The swnodes have no hierarchy at the moment (they're only
created for a struct device as a parent) and they do not have human-readable
names. So I'd say it's not relevant right now. Should these two change,
support for swnode could (and should) be added later on.

> 
> > +static noinline_for_stack
> > +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> > +		    struct printf_spec spec, const char *fmt)
> > +{
> > +	const char * const modifiers = "fP";
> > +	struct printf_spec str_spec = spec;
> > +	char *buf_start = buf;
> > +	bool pass;
> > +
> > +	str_spec.field_width = -1;
> > +
> 
> > +	if ((unsigned long)fwnode < PAGE_SIZE)
> > +		return string(buf, end, "(null)", spec);
> 
> Just put there a NULL pointer, we would not like to maintain duplicated strings
> over the kernel.
> 
> I remember Petr has a patch series related to address space check, though I
> don't remember the status of affairs.

This bit has been actually adopted from the OF counterpart. If there are
improvements in this area, then I'd just change both at the same time.

> 
> > +
> > +	/* simple case without anything any more format specifiers */
> > +	fmt++;
> > +	if (fmt[0] == '\0' || strcspn(fmt, modifiers) > 0)
> > +		fmt = "f";
> > +
> > +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
> 
> I don't see test cases.
> 
> What would we get out of %pfwfffPPPfff?
> 
> Hint: I'm expecting above to be equivalent to %pfwf

I guess it's a matter of expectations. :-) Again this works the same way
than the OF counterpart. Right now there's little to print (just the name
and the full name), but if support is added for more, then this mechanism is
fully relevant again.

The alternative would be to remove that now and add it back if it's needed
again. I have a slight preference towards keeping it extensible (i.e. as
it's now).

> 
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
> > +
> > +	return widen_string(buf, buf - buf_start, end, spec);
> > +}
> 

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
