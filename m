From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI: Evaluate _CRS while creating device node
 objects
Date: Tue, 13 Nov 2012 09:12:09 +0200
Message-ID: <20121113071208.GF31759@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <11281928.0BBlrNprhI@vostro.rjw.lan>
 <20121112144621.GE31759@intel.com>
 <1935553.kFsUz07opN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1935553.kFsUz07opN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, Bjorn Helgaas <bhelgaas@google.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 12, 2012 at 10:03:56PM +0100, Rafael J. Wysocki wrote:
> > > +static acpi_status acpi_bus_add_resource(struct acpi_resource *res,
> > > +					 void *context)
> > > +{
> > > +	struct list_head *list = context;
> > > +	struct acpi_resource_list_entry *entry;
> > > +
> > > +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > > +	if (!entry)
> > > +		return AE_NO_MEMORY;
> > > +
> > > +	entry->resource = *res;
> > 
> > This does not work well with all resource types - specifically those that
> > contain pointers, like acpi_resource_gpio and acpi_resource_source.
> 
> Good point.
> 
> Well, this pretty much means we can't copy those things.

Yeah. I only noticed this yesterday when I tested the GPIO translation in a
custom driver (since it uses the acpi_resource_gpio).

> > The memory for the resources gets freed once acpi_walk_resources() is done.
> 
> I know that.
> 
> Having to evaluate _CRS and creating a buffer, converting the output into
> ACPI resources and so on every time we need to look into the device's current
> resources is totally inefficient.  We _need_ to cache the _CRS output.

I agree and besides having adev->resources is much easier to use than
calling acpi_walk_resources() everytime.

> Now, because of the pointers in certain types of resources, we can't
> make copies of the resource objects used by acpi_walk_resources() which
> makes that function totally unuseful to us.
>
> I suppose we can just do acpi_get_current_resources() and play with the
> buffer returned by it.  That won't be nice, but still better than what we
> have.

I don't know any better option.

Thanks.
