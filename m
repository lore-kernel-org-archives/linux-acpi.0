From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/15] device property: Add support for remote endpoints
Date: Fri, 27 Jan 2017 15:45:04 -0600
Message-ID: <CAL_JsqL+avBhLD9jwk-yfCsxYWTBPZo5OrNB0JBLs8Ri6xtOgw@mail.gmail.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com> <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdA0Vpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Jan 2017 16:45:46 -0500
In-Reply-To: <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>

On Fri, Jan 27, 2017 at 10:03 AM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> This follows DT implementation of of_graph_* APIs but we call them
> fwnode_graph_* instead. For DT nodes the existing of_graph_* implementation
> will be used. For ACPI we use the new ACPI graph implementation instead.
>
> This commit includes code from Sakari Ailus.

Then it should have your S-o-b. Actually, either way it should have it.

Whether or not copying DT graphs is a good idea or not, I'll let
someone else chime in on that...

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/base/property.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |   9 ++++
>  2 files changed, 131 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c0011cf..cf602c3 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_graph.h>
>  #include <linux/property.h>
>  #include <linux/etherdevice.h>
>  #include <linux/phy.h>
> @@ -1111,3 +1112,124 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
>         return device_get_mac_addr(dev, "address", addr, alen);
>  }
>  EXPORT_SYMBOL(device_get_mac_address);
> +
> +/**
> + * device_graph_get_next_endpoint - Get next endpoint firmware node
> + * @fwnode: Pointer to the parent firmware node
> + * @prev: Previous endpoint node or %NULL to get the first
> + *
> + * Returns an endpoint firmware node pointer or %NULL if no more endpoints
> + * are available.
> + */
> +struct fwnode_handle *
> +fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
> +                              struct fwnode_handle *prev)
> +{
> +       struct fwnode_handle *endpoint = NULL;
> +
> +       if (is_of_node(fwnode)) {
> +               struct device_node *node;
> +
> +               node = of_graph_get_next_endpoint(to_of_node(fwnode),
> +                                                 to_of_node(prev));
> +
> +               if (node)
> +                       endpoint = &node->fwnode;
> +       } else if (is_acpi_node(fwnode)) {
> +               endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
> +               if (IS_ERR(endpoint))
> +                       endpoint = NULL;
> +       }

This is an ugly pattern IMO. Why not define an ops struct and set it
to OF or ACPI rather than check on every function call with
is_{of,acpi}_node()?

The of_graph_* functions need some better helpers too, so duplicating
them 2 more times is not ideal. Basically, drivers are left to do too
much of the walking of nodes themselves.

Rob
