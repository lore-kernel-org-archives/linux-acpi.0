From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] device property: Move FW type specific functionality
 to FW specific files
Date: Fri, 31 Mar 2017 16:20:22 +0300
Message-ID: <f356b466-38b9-83b7-bfb7-1e64f686f212@linux.intel.com>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170327113100.GZ2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170327113100.GZ2957-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Mika,

Thanks for the review again!

Mika Westerberg wrote:
> On Fri, Mar 24, 2017 at 01:03:50PM +0200, Sakari Ailus wrote:
>> +static int acpi_fwnode_property_read_int_array(
>
> This is really ugly way to split arguments into multiple lines IMHO.
>
>> +	struct fwnode_handle *fwnode, const char *propname,
>> +	unsigned int elem_size, void *val, size_t nval)
>
>
> I would much more see something like:
>
> static int
> acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
> 	const char *propname, unsigned int elem_size, void *val, size_t nval)
>
> or even
>
> static int
> acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
> 				    const char *propname,
> 				    unsigned int elem_size,
> 				    void *val, size_t nval)
>
> ditto for all occurences.
>
> Other than that this patch looks reasonable to me.

I don't think CodingStyle defines any particular points where to wrap 
the lines. Different conventions seem to exist:

$ git grep '^\(static\|const\|inline\|int\|struct\|u\[0-9\).*($' |wc -l
3106

Not all of the occurrences found exhibit such indentation but then again 
the above does not catch all of those that do either.

I can change that if you insist but I'm telling you that it wouldn't be 
alone in the kernel. :-)

-- 
Kind regards,

Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
