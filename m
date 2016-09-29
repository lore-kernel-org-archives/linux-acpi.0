From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] ACPI / property: Allow holes in reference properties
Date: Thu, 29 Sep 2016 13:53:50 +0200
Message-ID: <5499849.PK7BgMsTju@vostro.rjw.lan>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com> <CAJZ5v0iGmUmFnQ2+6TVQ4SFvcxnEkA0yFM6wNGMmALFzRmBs4A@mail.gmail.com> <20160929064829.GG1218@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60254 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755203AbcI2LrZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Sep 2016 07:47:25 -0400
In-Reply-To: <20160929064829.GG1218@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, September 29, 2016 09:48:29 AM Mika Westerberg wrote:
> On Wed, Sep 28, 2016 at 11:36:10PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Sep 23, 2016 at 4:57 PM, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > DT allows holes or empty phandles for references. This is used for example
> > > in SPI subsystem where some chip selects are native and others are regular
> > > GPIOs. In ACPI _DSD we currently do not support this but instead the
> > > preceding reference "consumes" all following integer arguments.
> > >
> > > For example we would like to support something like the below ASL fragment
> > > for SPI:
> > >
> > >   Package () {
> > >       "cs-gpios",
> > >       Package () {
> > >           ^GPIO, 19, 0, 0, // GPIO CS0
> > >           0,               // Native CS

One thing just occurred to me: what if this value is not 0?

> > >           ^GPIO, 20, 0, 0, // GPIO CS1
> > >       }
> > >   }
> > >
> > > The zero in the middle means "no entry" or NULL reference. To support this
> > > we add a new function acpi_node_get_property_reference_fixed_args() that
> > > takes number of expected arguments as parameter. Function returns -ENOENT
> > > if the corresponding index resolves to the "no entry" reference.
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 116 +++++++++++++++++++++++++++++++++++-------------
> > >  include/linux/acpi.h    |   3 ++
> > >  2 files changed, 89 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index f2fd3fee588a..b255c4442a05 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -472,6 +472,7 @@ static int acpi_data_get_property_array(struct acpi_device_data *data,
> > >   * @data: ACPI device data object containing the property
> > >   * @propname: Name of the property
> > >   * @index: Index of the reference to return
> > > + * @num_args: Maximum number of arguments after each reference
> > >   * @args: Location to store the returned reference with optional arguments
> > >   *
> > >   * Find property with @name, verifify that it is a package containing at least
> > > @@ -485,8 +486,8 @@ static int acpi_data_get_property_array(struct acpi_device_data *data,
> > >   * Return: %0 on success, negative error code on failure.
> > >   */
> > >  static int acpi_data_get_property_reference(struct acpi_device_data *data,
> > > -                                           const char *propname, size_t index,
> > > -                                           struct acpi_reference_args *args)
> > > +       const char *propname, size_t index, size_t num_args,
> > > +       struct acpi_reference_args *args)
> > >  {
> > >         const union acpi_object *element, *end;
> > >         const union acpi_object *obj;
> > > @@ -532,41 +533,52 @@ static int acpi_data_get_property_reference(struct acpi_device_data *data,
> > >         while (element < end) {
> > >                 u32 nargs, i;
> > >
> > > -               if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
> > > -                       return -EPROTO;
> > > -
> > > -               ret = acpi_bus_get_device(element->reference.handle, &device);
> > > -               if (ret)
> > > -                       return -ENODEV;
> > > -
> > > -               element++;
> > > -               nargs = 0;
> > > -
> > > -               /* assume following integer elements are all args */
> > > -               for (i = 0; element + i < end; i++) {
> > > -                       int type = element[i].type;
> > > +               if (element->type == ACPI_TYPE_LOCAL_REFERENCE) {
> > > +                       ret = acpi_bus_get_device(element->reference.handle,
> > > +                                                 &device);
> > > +                       if (ret)
> > > +                               return -ENODEV;
> > > +
> > > +                       nargs = 0;
> > > +                       element++;
> > > +
> > > +                       /* assume following integer elements are all args */
> > > +                       for (i = 0; element + i < end && i < num_args; i++) {
> > > +                               int type = element[i].type;
> > > +
> > > +                               if (type == ACPI_TYPE_INTEGER)
> > > +                                       nargs++;
> > > +                               else if (type == ACPI_TYPE_LOCAL_REFERENCE)
> > > +                                       break;
> > > +                               else
> > > +                                       return -EPROTO;
> > > +                       }
> > >
> > > -                       if (type == ACPI_TYPE_INTEGER)
> > > -                               nargs++;
> > > -                       else if (type == ACPI_TYPE_LOCAL_REFERENCE)
> > > -                               break;
> > > -                       else
> > > +                       if (nargs > MAX_ACPI_REFERENCE_ARGS)
> > >                                 return -EPROTO;
> > > -               }
> > >
> > > -               if (idx++ == index) {
> > > -                       args->adev = device;
> > > -                       args->nargs = nargs;
> > > -                       for (i = 0; i < nargs; i++)
> > > -                               args->args[i] = element[i].integer.value;
> > > +                       if (idx == index) {
> > > +                               args->adev = device;
> > > +                               args->nargs = nargs;
> > > +                               for (i = 0; i < nargs; i++)
> > > +                                       args->args[i] = element[i].integer.value;
> > >
> > > -                       return 0;
> > > +                               return 0;
> > > +                       }
> > > +
> > > +                       element += nargs;
> > > +               } else if (element->type == ACPI_TYPE_INTEGER) {
> > > +                       if (idx == index)
> > > +                               return -ENOENT;
> > > +                       element++;
> > > +               } else {
> > > +                       return -EPROTO;
> > >                 }
> > >
> > > -               element += nargs;
> > > +               idx++;
> > >         }
> > >
> > > -       return -EPROTO;
> > > +       return -ENODATA;
> > >  }
> > >
> > >  /**
> > > @@ -582,10 +594,54 @@ int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
> > >  {
> > >         struct acpi_device_data *data = acpi_device_data_of_node(fwnode);
> > >
> > > -       return data ? acpi_data_get_property_reference(data, name, index, args) : -EINVAL;
> > > +       if (!data)
> > > +               return -EINVAL;
> > > +
> > > +       return acpi_data_get_property_reference(data, name, index,
> > > +               MAX_ACPI_REFERENCE_ARGS, args);
> > >  }
> > >  EXPORT_SYMBOL_GPL(acpi_node_get_property_reference);
> > 
> > gpiolib-acpi is the only user of this AFAICS, so why don't we change
> > the definition of acpi_node_get_property_reference() to take one extra
> > argument and update the caller to pass MAX_ACPI_REFERENCE_ARGS?
> 
> Unfortunately there are these (which I think should not call that
> function directly anyway):

Right.

It looks like exactly the same usage pattern that should better be
implemented as a library function, ie. workarounds for something missing.

> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c: status = acpi_node_get_property_reference(fw_node, "phy-handle", 0,
> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:      rc = acpi_node_get_property_reference(
> drivers/net/ethernet/hisilicon/hns/hns_enet.c:          ret = acpi_node_get_property_reference(dev->fwnode,
> 
> So we would need to update those as well. Not a big deal, though.

Or rename it to __acpi_node_get_property_reference() and define
acpi_node_get_property_reference() as a static inline wrapper passing
MAX_ACPI_REFERENCE_ARGS to it.

Thanks,
Rafael

