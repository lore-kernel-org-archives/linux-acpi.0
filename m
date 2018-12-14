From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
Date: Fri, 14 Dec 2018 10:36:15 +0100
Message-ID: <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com> <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211131451.52832-4-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This implements get_name fwnode op for DT.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Rob, any objections here?

> ---
>  drivers/of/property.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 08430031bd28..5c10fdded473 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -823,6 +823,18 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
>         of_node_put(to_of_node(fwnode));
>  }
>
> +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
> +                             size_t len)
> +{
> +       const struct device_node *node = to_of_node(fwnode);
> +
> +       if (len < snprintf(NULL, 0, "%pOFn", node) + 1)
> +               return -EOVERFLOW;
> +
> +       sprintf(buf, "%pOFn", node);
> +       return 0;
> +}
> +
>  static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  {
>         return of_device_is_available(to_of_node(fwnode));
> @@ -987,6 +999,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
>  const struct fwnode_operations of_fwnode_ops = {
>         .get = of_fwnode_get,
>         .put = of_fwnode_put,
> +       .get_name = of_fwnode_get_name,
>         .device_is_available = of_fwnode_device_is_available,
>         .device_get_match_data = of_fwnode_device_get_match_data,
>         .property_present = of_fwnode_property_present,
> --
> 2.19.2
>
