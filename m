From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH 3/5] drivers: base: Introducing software nodes to the
 firmware node framework
Date: Tue, 16 Oct 2018 17:53:03 +0300
Message-ID: <20181016145303.GH24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181012113934.29942-4-heikki.krogerus@linux.intel.com>
 <20181016125743.GX15943@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016125743.GX15943@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 16, 2018 at 03:57:43PM +0300, Andy Shevchenko wrote:
> > +static int property_entry_read_string_array(const struct property_entry *props,
> > +					    const char *propname,
> > +					    const char **strings, size_t nval)
> > +{
> > +	const struct property_entry *prop;
> > +	const void *pointer;
> > +	size_t array_len, length;
> > +
> > +	/* Find out the array length. */
> > +	prop = property_entry_get(props, propname);
> > +	if (!prop)
> > +		return -EINVAL;
> > +
> 
> > +	if (!prop->is_array)
> > +		/* The array length for a non-array string property is 1. */
> > +		array_len = 1;
> > +	else
> > +		/* Find the length of an array. */
> > +		array_len = property_entry_count_elems_of_size(props, propname,
> > +							  sizeof(const char *));
> 
> I understand where it comes from, but here we may use positive condition.

OK.

> > +#define NODE_NAME_MAXSIZE	11
> 
> sizeof(int) = 4 (32 bits), so, 32 * 3 / 10 ~= 10. On top are "node" and '\0'.
> Thus, I would rather put 16 here. Or limit the maximum for ida_simple_get().

Let's make it 16.


thanks,

-- 
heikki
