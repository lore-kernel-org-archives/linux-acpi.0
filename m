From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] device properties: Fix return codes for
 __acpi_node_get_property_reference
Date: Tue, 10 Oct 2017 15:43:11 +0300
Message-ID: <20171010124311.26hxvjesiyqwkotu@paasikivi.fi.intel.com>
References: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
 <14664181.1rcyu63NdN@aspire.rjw.lan>
 <20171005140147.epmyxhcc7dtlam27@kekkonen.localdomain>
 <2032313.C0WbF9e4VT@aspire.rjw.lan>
 <20171005220431.yija6nj6ghir6cqr@kekkonen.localdomain>
 <CAJZ5v0gtmw1DxuiQDt9GAHcO168gw8YPm-8Ka1EUrSpejPhUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755165AbdJJMnU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Oct 2017 08:43:20 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gtmw1DxuiQDt9GAHcO168gw8YPm-8Ka1EUrSpejPhUtA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>

Hi Rafael,

On Fri, Oct 06, 2017 at 12:22:54AM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 6, 2017 at 12:04 AM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > Hi Rafael,
> >
> > On Thu, Oct 05, 2017 at 05:30:37PM +0200, Rafael J. Wysocki wrote:
> >> On Thursday, October 5, 2017 4:01:48 PM CEST Sakari Ailus wrote:
> >> > Hi Rafael,
> >> >
> >> > On Thu, Oct 05, 2017 at 02:59:45PM +0200, Rafael J. Wysocki wrote:
> >> > > On Thursday, October 5, 2017 8:04:24 AM CEST Sakari Ailus wrote:
> >> > > > Fix more return codes for device property: Align return codes of
> >> > > > __acpi_node_get_property_reference. In particular what was missed
> >> > > > previously:
> >> > > >
> >> > > > -EPROTO could be returned in certain cases, now -EINVAL;
> >> > > > -EINVAL was returned if the property was not found, now -ENOENT;
> >> > > > -EINVAL was returned also if the index was higher than the number of
> >> > > > entries in a package, now -ENOENT.
> >> > > >
> >> > > > Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
> >> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >> > > > Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> >> > > > ---
> >> > > > Hi Rafael,
> >> > > >
> >> > > > Unfortunately the patch I posted the previous time to remedy the issue
> >> > > > ("device property: Align return codes of
> >> > > > _acpi_node_get_property_reference") did not fully fix the issue.
> >> > >
> >> > > OK, thanks for letting me know, but why didn't it?
> >> >
> >> > My testing appears to have been more limited than I thought, Hyungwoo later
> >> > on found this out. (Reported-by: Hyungwoo... would be appropriate, I'll add
> >> > that the next time.)
> >> >
> >> > >
> >> > > >  drivers/acpi/property.c | 20 +++++++++++++++-----
> >> > > >  1 file changed, 15 insertions(+), 5 deletions(-)
> >> > > >
> >> > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> >> > > > index 5a8ac5e1081b..8c28c516e7ec 100644
> >> > > > --- a/drivers/acpi/property.c
> >> > > > +++ b/drivers/acpi/property.c
> >> > > > @@ -592,8 +592,16 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >> > > >                 return -ENOENT;
> >> > > >
> >> > > >         ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
> >> > > > -       if (ret)
> >> > > > -               return ret;
> >> > > > +       switch (ret) {
> >> > > > +       case -EINVAL:
> >> > > > +               return -ENOENT;
> >> > > > +       case -EPROTO:
> >> > > > +               return -EINVAL;
> >> > > > +       default:
> >> > > > +               if (ret)
> >> > > > +                       return ret;
> >> > > > +               break;
> >> > > > +       }
> >> > >
> >> > > To be clear, I'm not going to apply anything like the above.
> >> >
> >> > On exactly what grounds? You don't like the combination of switch and if,
> >> > or because of the return values themselves? Or something else?
> >>
> >> I just don't like changing error codes into different ones on the fly like
> >> this.  It always indicates some bad design somewhere and this particular
> >> piece of code just goes over the top with that IMO.
> >
> > acpi_data_get_property() is used in quite a few places and the error codes
> > it returns are more or less used as such elsewhere.
> >
> > The ACPI and OF frameworks tend to use slightly different error codes to
> > signal various error conditions. In this case, the OF archetype of
> > fwnode_property_get_reference_args(), of_parse_phandle_with_args(), also
> > uses different error codes than the rest of the OF framework. We decided to
> > align the error codes with the OF framework, as has been done with the rest
> > of the functions. Therefore the error codes returned by ACPI functions need
> > to be converted to what is expected to be seen on the device property API
> > (or OF API).
> >
> > My original proposal was to switch between the conventions in the ACPI
> > fwnode callback acpi_fwnode_get_reference_args() but based on the review
> > comments I made the changes to __acpi_node_get_property_reference()
> > instead. Which is where we're now.
> >
> > fwnode_property_get_reference_args() (as does of_parse_phandle_with_args())
> > returns -ENOENT on
> >
> > - no reference found at given index (but entry exists),
> >
> > - no index exists in property or
> >
> > - the property does not exist.
> >
> > Originally __acpi_node_get_property_reference() used -ENOENT, -ENODATA and
> > -EINVAL respectively. Consequenty -EINVAL returned by
> > acpi_data_get_property(), called by __acpi_node_get_property_reference()
> > needs to be turned to -ENOENT instead. Likewise -EPROTO changes to -EINVAL,
> > as fwnode_property_get_reference_args() isn't expected to return -EPROTO.
> 
> Can we just return -EINVAL (or whatever generic error) on all errors
> from acpi_data_get_property() and avoid this super-ugliness, please?

acpi_data_get_property() is used by a number of functions and those
functions have well defined error codes for various conditions. In
particular, these conditions are more finely separated for use in other
fwnode_property_read_*() functions than they are for
fwnode_property_get_reference_args(). So we can't change what
acpi_data_get_property() returns without breaking the rest.

If you want it to be clean, then the best option to implement it is in the
fwnode property framework which uses OF-like error codes, not ACPI-like.

> 
> Or if some caller really cares, you can do
> 
> if (ret)
>     return ret == -EINVAL ? -ENOENT : -EINVAL;
> 
> which at least is one line of code instead of several.

Ah, acpi_data_get_property() only returns the two. Yes, I can change the
implementation to that. I'll submit v2.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
