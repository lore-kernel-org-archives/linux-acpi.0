From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/4] device property: Introduce fwnode_name()
Date: Mon, 5 Nov 2018 16:57:33 +0200
Message-ID: <20181105145733.GA1777@kuha.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
 <20181105143731.GK10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105143731.GK10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> > +const char *fwnode_name(const struct fwnode_handle *fwnode)
> > +{
> > +	const char *name = fwnode_call_ptr_op(fwnode, name);
> > +
> > +	if (!name)
> > +		fwnode_call_int_op(fwnode, property_read_string_array,
> > +				   "name", &name, 1);
> 
> Is it going to be extended in the future?
> 
> Otherwise I would rather go with (few more LOCs, yes)
> 
> 	const char *name;
> 
> 	name = fwnode_call_ptr_op(fwnode, name);
> 	if (name)
> 		return name;
> 
> 	fwnode_call_int_op(fwnode, property_read_string_array, "name", &name, 1);
> 	return name;

That does look better. I'll fix it.

thanks,

-- 
heikki
