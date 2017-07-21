From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/8] Remove fwnode type field, constify property fwnode arguments
Date: Fri, 21 Jul 2017 13:52:18 +0200
Message-ID: <CAJZ5v0gWvjd4m0etYAiUJxKyDL1GkzKdKWBynjKExvZ+3KF8jw@mail.gmail.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, erik.veijola-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2017 at 1:39 PM, Sakari Ailus
<sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hello everyone,
>
> This set removes the struct fwnode_handle type field and constifies the
> fwnode arguments in the fwnode property API more or less the way they are
> const in OF property API.
>
> Comments are welcome.
>
> All the dependent patches are now in linux-pm master branch.
>
> <URL:http://www.spinics.net/lists/linux-acpi/msg75957.html>
>
> v1 can be found here:
>
> <URL:http://www.spinics.net/lists/linux-acpi/msg74564.html>
>
> changes since v2:
>
> - Add 8th patch "device property: Introduce
>   fwnode_property_get_reference_args". This allows obtaining references
>   with integer arguments using the fwnode interface.
>
>   The functionality will be soon needed in adding support for nvmem
>   framework on ACPI as well as in referring to e.g. lens and flash devices
>   on V4L2.

OK, so if people have no objections, I'll queue this up for 4.14.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
