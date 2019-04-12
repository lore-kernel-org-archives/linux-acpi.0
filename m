From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 04/12] software node: Implement .get_reference_args
 fwnode operation
Date: Fri, 12 Apr 2019 10:48:41 +0200
Message-ID: <CAJZ5v0jTR6TqMxRoRhBzG8Rf8JgGfriuCLsGKBYxjBOZz_7yBA@mail.gmail.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com> <20190410152505.87041-5-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410152505.87041-5-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 10, 2019 at 5:26 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> This makes it possible to support drivers that use
> fwnode_property_get_reference_args() function.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/swnode.c | 56 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 39b8f8f35cfe..d6a9b56cb073 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -534,6 +534,61 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
>         return NULL;
>  }
>
> +static int
> +software_node_get_reference_args(const struct fwnode_handle *fwnode,
> +                                const char *propname, const char *nargs_prop,
> +                                unsigned int nargs, unsigned int index,
> +                                struct fwnode_reference_args *args)
> +{
> +       struct software_node *swnode = to_software_node(fwnode);
> +       struct software_node_reference *ref;
> +       const struct property_entry *prop;
> +       int ret = -ENOENT;
> +       int i;
> +
> +       mutex_lock(&swnode->lock);
> +
> +       if (!swnode || list_empty(&swnode->references))
> +               goto err_unlock;
> +
> +       if (nargs_prop) {
> +               prop = property_entry_get(swnode->properties, nargs_prop);
> +               if (!prop) {
> +                       ret = -EINVAL;
> +                       goto err_unlock;
> +               }
> +
> +               nargs = prop->value.u32_data;
> +       }
> +
> +       if (nargs > NR_FWNODE_REFERENCE_ARGS) {
> +               ret = -EINVAL;
> +               goto err_unlock;
> +       }
> +
> +       list_for_each_entry(ref, &swnode->references, list) {
> +               if (strcmp(ref->name, propname))
> +                       continue;
> +
> +               if (index > (ref->nrefs - 1))
> +                       break;
> +
> +               args->nargs = nargs;
> +               args->fwnode = software_node_get(ref->args[index].fwnode);
> +
> +               for (i = 0; i < nargs; i++)
> +                       args->args[i] = ref->args[index].args[i];

If nargs is provided by the caller, can't it be greater than the
number of args[index].args[] entries?

> +
> +               ret = 0;
> +               break;
> +       }
> +
> +err_unlock:
> +       mutex_unlock(&swnode->lock);
> +
> +       return ret;
> +}
> +
>  static const struct fwnode_operations software_node_ops = {
>         .get = software_node_get,
>         .put = software_node_put,
> @@ -543,6 +598,7 @@ static const struct fwnode_operations software_node_ops = {
>         .get_parent = software_node_get_parent,
>         .get_next_child_node = software_node_get_next_child,
>         .get_named_child_node = software_node_get_named_child_node,
> +       .get_reference_args = software_node_get_reference_args,
>  };
>
>  /* -------------------------------------------------------------------------- */
