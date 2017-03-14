From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] device property: of_property_read_string_array()
 returns number of strings
Date: Tue, 14 Mar 2017 09:17:32 +0200
Message-ID: <bf544a26-d551-e5e5-6ca1-513f35d057b4@linux.intel.com>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com>
 <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
 <1840694.EMHZKJ1jEg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1840694.EMHZKJ1jEg-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 03/14/17 00:24, Rafael J. Wysocki wrote:
> On Monday, March 06, 2017 03:26:31 PM Sakari Ailus wrote:
>> of_property_read_string_array() returns number of strings read if the
>> target array of pointers is non-NULL. fwnode_property_read_string_array()
>> is documented to return 0 in that case. Fix this.
> 
> Well, if we want people to use fwnode_property_read_string_array() instead of
> of_property_read_string_array(), it should better behave analogously, shouldn't it?

Not necessarily.

The documentation states that fwnode_property_read_string_array()
returns 0 on success. That makes sense since the callers often check
whether the return value is non-zero and then return based on that.
Returning zero on success is just simpler for the caller.

Often the number of elements to read from an array is known beforehand,
so there's little use for the actual number read.

Besides the fwnode variants, also the OF integer array access functions
return zero on success.

Rob had a similar comment but the discussion did not continue after my
initial reply. I can sure change that if you still think it's better the
other way.

-- 
Kind regards,

Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
