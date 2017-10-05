From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/1] device properties: Fix return codes for
 __acpi_node_get_property_reference
Date: Thu, 5 Oct 2017 17:01:48 +0300
Message-ID: <20171005140147.epmyxhcc7dtlam27@kekkonen.localdomain>
References: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
 <14664181.1rcyu63NdN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22923 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdJEOB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Oct 2017 10:01:58 -0400
Content-Disposition: inline
In-Reply-To: <14664181.1rcyu63NdN@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, mika.westerberg@intel.com, hyungwoo.yang@intel.com

Hi Rafael,

On Thu, Oct 05, 2017 at 02:59:45PM +0200, Rafael J. Wysocki wrote:
> On Thursday, October 5, 2017 8:04:24 AM CEST Sakari Ailus wrote:
> > Fix more return codes for device property: Align return codes of
> > __acpi_node_get_property_reference. In particular what was missed
> > previously:
> > 
> > -EPROTO could be returned in certain cases, now -EINVAL;
> > -EINVAL was returned if the property was not found, now -ENOENT;
> > -EINVAL was returned also if the index was higher than the number of
> > entries in a package, now -ENOENT.
> > 
> > Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> > ---
> > Hi Rafael,
> > 
> > Unfortunately the patch I posted the previous time to remedy the issue
> > ("device property: Align return codes of
> > _acpi_node_get_property_reference") did not fully fix the issue.
> 
> OK, thanks for letting me know, but why didn't it?

My testing appears to have been more limited than I thought, Hyungwoo later
on found this out. (Reported-by: Hyungwoo... would be appropriate, I'll add
that the next time.)

> 
> >  drivers/acpi/property.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 5a8ac5e1081b..8c28c516e7ec 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -592,8 +592,16 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >  		return -ENOENT;
> >  
> >  	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
> > -	if (ret)
> > -		return ret;
> > +	switch (ret) {
> > +	case -EINVAL:
> > +		return -ENOENT;
> > +	case -EPROTO:
> > +		return -EINVAL;
> > +	default:
> > +		if (ret)
> > +			return ret;
> > +		break;
> > +	}
> 
> To be clear, I'm not going to apply anything like the above.

On exactly what grounds? You don't like the combination of switch and if,
or because of the return values themselves? Or something else?

> 
> >  
> >  	/*
> >  	 * The simplest case is when the value is a single reference.  Just
> > @@ -605,7 +613,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >  
> >  		ret = acpi_bus_get_device(obj->reference.handle, &device);
> >  		if (ret)
> > -			return ret;
> > +			return ret == -ENODEV ? -EINVAL : ret;
> >  
> >  		args->adev = device;
> >  		args->nargs = 0;
> > @@ -621,8 +629,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >  	 * The index argument is then used to determine which reference
> >  	 * the caller wants (along with the arguments).
> >  	 */
> > -	if (obj->type != ACPI_TYPE_PACKAGE || index >= obj->package.count)
> > -		return -EPROTO;
> > +	if (obj->type != ACPI_TYPE_PACKAGE)
> > +		return -EINVAL;
> > +	if (index >= obj->package.count)
> > +		return -ENOENT;
> >  
> >  	element = obj->package.elements;
> >  	end = element + obj->package.count;
> > 
> 
> 

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
