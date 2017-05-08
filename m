From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/5] device property: Move fwnode graph ops to firmware
 specific locations
Date: Mon, 8 May 2017 13:23:44 -0500
Message-ID: <CAL_JsqLCWnDiAbfvEp8h_USwpCho8Qd9ojCp3ebeG9CGdvPzvQ@mail.gmail.com>
References: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com> <1493882051-28814-4-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493882051-28814-4-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 4, 2017 at 2:14 AM, Sakari Ailus
<sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Move firmware specific implementations of the fwnode graph operations to
> firmware specific locations.
>
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/acpi/property.c | 45 +++++++++++++++++++++++
>  drivers/base/property.c | 96 ++++++-------------------------------------------
>  drivers/of/property.c   | 57 +++++++++++++++++++++++++++++
>  include/linux/fwnode.h  | 12 +++++++
>  4 files changed, 125 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index fb3b96f..d26f24d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1183,6 +1183,47 @@ static struct fwnode_handle *acpi_fwnode_get_named_child_node(
>         return NULL;
>  }
>
> +static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
> +       struct fwnode_handle *fwnode, struct fwnode_handle *prev)
> +{
> +       struct fwnode_handle *endpoint;
> +
> +       endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
> +       if (IS_ERR(endpoint))
> +               return NULL;
> +
> +       return endpoint;
> +}
> +
> +static struct fwnode_handle *acpi_fwnode_graph_get_remote_endpoint(
> +       struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *endpoint = NULL;
> +
> +       acpi_graph_get_remote_endpoint(fwnode, NULL, NULL, &endpoint);
> +
> +       return endpoint;
> +}
> +
> +static struct fwnode_handle *acpi_fwnode_graph_get_port_parent(
> +       struct fwnode_handle *fwnode)
> +{
> +       return acpi_node_get_parent(fwnode);
> +}
> +
> +static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
> +                                           struct fwnode_endpoint *endpoint)
> +{
> +       struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
> +
> +       endpoint->local_fwnode = fwnode;
> +
> +       fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
> +       fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
> +
> +       return 0;
> +}
> +
>  const struct fwnode_operations acpi_fwnode_ops = {
>         .property_present = acpi_fwnode_property_present,
>         .property_read_int_array = acpi_fwnode_property_read_int_array,
> @@ -1190,4 +1231,8 @@ const struct fwnode_operations acpi_fwnode_ops = {
>         .get_parent = acpi_fwnode_get_parent,
>         .get_next_child_node = acpi_get_next_subnode,
>         .get_named_child_node = acpi_fwnode_get_named_child_node,
> +       .graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
> +       .graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
> +       .graph_get_port_parent = acpi_fwnode_graph_get_port_parent,
> +       .graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
>  };
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 4dc5ab6..6eccc4e 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1154,24 +1154,7 @@ struct fwnode_handle *
>  fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
>                                struct fwnode_handle *prev)
>  {
> -       struct fwnode_handle *endpoint = NULL;
> -
> -       if (is_of_node(fwnode)) {
> -               struct device_node *node;
> -
> -               node = of_graph_get_next_endpoint(to_of_node(fwnode),
> -                                                 to_of_node(prev));
> -
> -               if (node)
> -                       endpoint = &node->fwnode;
> -       } else if (is_acpi_node(fwnode)) {
> -               endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
> -               if (IS_ERR(endpoint))
> -                       endpoint = NULL;
> -       }
> -
> -       return endpoint;
> -
> +       return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>
> @@ -1184,24 +1167,11 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>  struct fwnode_handle *
>  fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
>  {
> -       struct fwnode_handle *parent = NULL;
> -
> -       if (is_of_node(fwnode)) {
> -               struct device_node *node;
> -
> -               node = of_graph_get_remote_port_parent(to_of_node(fwnode));
> -               if (node)
> -                       parent = &node->fwnode;
> -       } else if (is_acpi_node(fwnode)) {
> -               int ret;
> -
> -               ret = acpi_graph_get_remote_endpoint(fwnode, &parent, NULL,
> -                                                    NULL);
> -               if (ret)
> -                       return NULL;
> -       }
> +       fwnode = fwnode_graph_get_remote_port(fwnode);
> +       if (!fwnode)
> +               return NULL;
>
> -       return parent;
> +       return fwnode_call_ptr_op(fwnode, graph_get_port_parent);

Just make fwnode_call_ptr_op(NULL, ...) return NULL.

>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
>
> @@ -1213,23 +1183,11 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
>   */
>  struct fwnode_handle *fwnode_graph_get_remote_port(struct fwnode_handle *fwnode)
>  {
> -       struct fwnode_handle *port = NULL;
> -
> -       if (is_of_node(fwnode)) {
> -               struct device_node *node;
> -
> -               node = of_graph_get_remote_port(to_of_node(fwnode));
> -               if (node)
> -                       port = &node->fwnode;
> -       } else if (is_acpi_node(fwnode)) {
> -               int ret;
> -
> -               ret = acpi_graph_get_remote_endpoint(fwnode, NULL, &port, NULL);
> -               if (ret)
> -                       return NULL;
> -       }
> +       fwnode = fwnode_graph_get_remote_endpoint(fwnode);
> +       if (!fwnode)
> +               return NULL;
>
> -       return port;
> +       return fwnode_get_parent(fwnode);

Just make fwnode_get_parent(NULL) return NULL.

>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
>
> @@ -1242,25 +1200,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
>  struct fwnode_handle *
>  fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
>  {
> -       struct fwnode_handle *endpoint = NULL;
> -
> -       if (is_of_node(fwnode)) {
> -               struct device_node *node;
> -
> -               node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint",
> -                                       0);
> -               if (node)
> -                       endpoint = &node->fwnode;
> -       } else if (is_acpi_node(fwnode)) {
> -               int ret;
> -
> -               ret = acpi_graph_get_remote_endpoint(fwnode, NULL, NULL,
> -                                                    &endpoint);
> -               if (ret)
> -                       return NULL;
> -       }
> -
> -       return endpoint;
> +       return fwnode_call_ptr_op(fwnode, graph_get_remote_endpoint);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>
> @@ -1276,22 +1216,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>  int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
>                                 struct fwnode_endpoint *endpoint)
>  {
> -       struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
> -
>         memset(endpoint, 0, sizeof(*endpoint));
>
> -       endpoint->local_fwnode = fwnode;
> -
> -       if (is_acpi_node(port_fwnode)) {
> -               fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
> -               fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
> -       } else {
> -               fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
> -               fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
> -       }
> -
> -       fwnode_handle_put(port_fwnode);
> -
> -       return 0;
> +       return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
>  }
>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 984e37e..bb6ac73 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -869,6 +869,59 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
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

Can't of_fwnode_handle() return NULL when node is NULL? Then these
functions become one liners:

return of_fwnode_handle(of_graph_get_next_endpoint(to_of_node(fwnode),
                                         to_of_node(prev)));

> +}
> +
> +static struct fwnode_handle *of_fwnode_graph_get_remote_endpoint(
> +       struct fwnode_handle *fwnode)
> +{
> +       struct device_node *node;
> +
> +       node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint", 0);
> +       if (node)
> +               return of_fwnode_handle(node);
> +
> +       return NULL;
> +}
> +
> +static struct fwnode_handle *of_fwnode_graph_get_port_parent(
> +       struct fwnode_handle *fwnode)
> +{
> +       struct device_node *node;
> +
> +       node = of_graph_get_port_parent(to_of_node(fwnode));
> +       if (node)
> +               return of_fwnode_handle(node);
> +
> +       return NULL;
> +}
> +
> +static int of_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
> +                                         struct fwnode_endpoint *endpoint)
> +{
> +       struct device_node *node = to_of_node(fwnode);
> +       struct device_node *port_node = of_get_parent(node);
> +
> +       endpoint->local_fwnode = fwnode;
> +
> +       of_property_read_u32(port_node, "reg", &endpoint->port);
> +       of_property_read_u32(node, "reg", &endpoint->id);
> +
> +       of_node_put(port_node);
> +
> +       return 0;
> +}
> +
>  const struct fwnode_operations of_fwnode_ops = {
>         .get = of_fwnode_get,
>         .put = of_fwnode_put,
> @@ -878,4 +931,8 @@ const struct fwnode_operations of_fwnode_ops = {
>         .get_parent = of_fwnode_get_parent,
>         .get_next_child_node = of_fwnode_get_next_child_node,
>         .get_named_child_node = of_fwnode_get_named_child_node,
> +       .graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
> +       .graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
> +       .graph_get_port_parent = of_fwnode_graph_get_port_parent,
> +       .graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
>  };
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index e05aaef..35f6626 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -57,6 +57,10 @@ struct fwnode_endpoint {
>   * @get_parent: Return the parent of an fwnode.
>   * @get_next_child_node: Return the next child node in an iteration.
>   * @get_named_child_node: Return a child node with a given name.
> + * @graph_get_next_endpoint: Return an endpoint node in an iteration.
> + * @graph_get_remote_endpoint: Return the remote endpoint node of a local
> + *                            endpoint node.
> + * @graph_get_port_parent: Return the parent node of a port node.
>   */
>  struct fwnode_operations {
>         void (*get)(struct fwnode_handle *fwnode);
> @@ -75,6 +79,14 @@ struct fwnode_operations {
>                 struct fwnode_handle *fwnode, struct fwnode_handle *child);
>         struct fwnode_handle *(*get_named_child_node)(
>                 struct fwnode_handle *fwnode, const char *name);
> +       struct fwnode_handle *(*graph_get_next_endpoint)(
> +               struct fwnode_handle *fwnode, struct fwnode_handle *prev);
> +       struct fwnode_handle *(*graph_get_remote_endpoint)(
> +               struct fwnode_handle *fwnode);
> +       struct fwnode_handle *(*graph_get_port_parent)(
> +               struct fwnode_handle *fwnode);
> +       int (*graph_parse_endpoint)(struct fwnode_handle *fwnode,
> +                                   struct fwnode_endpoint *endpoint);
>  };
>
>  #define fwnode_has_op(fwnode, op)                              \
> --
> 2.7.4
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
