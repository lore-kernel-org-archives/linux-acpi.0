From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] device property:
 fwnode_property_read_string_array() returns nr of strings
Date: Tue, 28 Mar 2017 16:07:13 +0300
Message-ID: <20170328130712.GC16657@valkosipuli.retiisi.org.uk>
References: <1490703739-28270-1-git-send-email-sakari.ailus@linux.intel.com>
 <1490703739-28270-4-git-send-email-sakari.ailus@linux.intel.com>
 <20170328125231.GP2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170328125231.GP2957-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Mika,

Thank you for the review!

On Tue, Mar 28, 2017 at 03:52:31PM +0300, Mika Westerberg wrote:
> On Tue, Mar 28, 2017 at 03:22:19PM +0300, Sakari Ailus wrote:
> > -		ret = acpi_copy_property_array_string(items, (char **)val, nval);
> > +		ret = acpi_copy_property_array_string(
> > +			items, (char **)val,
> > +			min_t(u32, nval, obj->package.count));
> 
> I think this looks better if written like:
> 
> 		ret = acpi_copy_property_array_string(items, (char **)val,
> 					min_t(u32, nval, obj->package.count));

I prefer the former although I have no strong opinion either way. Using an
indentation that is automatically intended by a text editor is also an
advantage.

I can change it if you insist. :-)

> 
> Regardless of that,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Thanks!

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
