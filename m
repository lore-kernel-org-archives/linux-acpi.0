From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/4] device property: Move fwnode graph ops to firmware
 specific locations
Date: Mon, 20 Mar 2017 16:15:53 -0500
Message-ID: <CAL_JsqK0LeJ7UckS0XRQEikTPcUa-4i9yeyNiMu60SNL+i=d=Q@mail.gmail.com>
References: <1489671289-20406-1-git-send-email-sakari.ailus@linux.intel.com> <1489671289-20406-5-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489671289-20406-5-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 16, 2017 at 8:34 AM, Sakari Ailus
<sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Move firmware specific implementations of the fwnode graph operations to
> firmware specific locations.
>
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/acpi/property.c | 61 ++++++++++++++++++++++++++++++++
>  drivers/base/property.c | 92 +++----------------------------------------------
>  drivers/of/base.c       | 70 +++++++++++++++++++++++++++++++++++++
>  include/linux/fwnode.h  | 16 +++++++++
>  4 files changed, 152 insertions(+), 87 deletions(-)

As I've mentioned before, this is just propagating APIs I would like
to get rid of. See my series cleaning up DRM users[1].

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index e483dd1..a8686a8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2624,6 +2624,71 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
>         return NULL;
>  }
>
> +static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
> +       struct fwnode_handle *fwnode, struct fwnode_handle *prev)
> +{
> +       struct device_node *node;
> +
> +       node = of_graph_get_next_endpoint(to_of_node(fwnode),
> +                                         to_of_node(prev));
> +       if (node)
> +               return of_fwnode_handle(node);
> +
> +       return NULL;
> +}

For example, most callers of of_graph_get_next_endpoint really just
want port=0, endpoint=0 and then they want the remote node. As the
assignment of port and endpoint numbers are fixed for a device,
drivers should be explicit about which port/endpoint they want. The
actual handle to either the port or endpoint nodes are mostly
irrelevant. We only really need the endpoint node handles when we have
properties in the endpoints.

Rob

[1] https://lkml.org/lkml/2017/2/9/592
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
