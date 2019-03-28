From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/6] device property: Add fwnode_get_name for
 returning the name of a node
Date: Thu, 28 Mar 2019 13:31:56 +0200
Message-ID: <20190328113156.o5wfxcww5mphmd6i@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gUZaxyp0Hb228F_PuBhshmQ8v7VFYtv75oZg_Hpo8RTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUZaxyp0Hb228F_PuBhshmQ8v7VFYtv75oZg_Hpo8RTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Mar 28, 2019 at 10:45:57AM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 1:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > The fwnode framework did not have means to obtain the name of a node. Add
> > that now, in form of the fwnode_get_name() function and a corresponding
> > get_name fwnode op. OF and ACPI support is included.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
> >  drivers/base/property.c  | 11 +++++++++++
> >  drivers/of/property.c    |  6 ++++++
> >  include/linux/fwnode.h   |  2 ++
> >  include/linux/property.h |  1 +
> >  5 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 77abe0ec4043..8c9a4c02cde2 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1291,6 +1291,29 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> >                                                   args_count, args);
> >  }
> >
> > +static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
> > +{
> > +       const struct acpi_device *adev;
> > +       struct fwnode_handle *parent;
> > +
> > +       parent = fwnode_get_parent(fwnode);
> > +       /* Is this the root node? */
> > +       if (!parent)
> > +               return "\\";
> > +
> > +       fwnode_handle_put(parent);
> > +
> > +       if (is_acpi_data_node(fwnode)) {
> > +               const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
> > +
> > +               return dn->name;
> > +       }
> > +
> > +       adev = to_acpi_device_node(fwnode);
> > +
> > +       return adev ? acpi_device_bid(adev) : NULL;
> 
> I would do
> 
> if (WARN_ON(!adev))
>          return NULL;
> 
> return acpi_device_bid(adev);

Done.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
