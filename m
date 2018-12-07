From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/3] device property: Introduce fwnode_get_name()
Date: Fri, 7 Dec 2018 11:24:27 -0600
Message-ID: <20181207172427.GA6642@bogus>
References: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
 <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 28, 2018 at 02:59:50PM +0300, Heikki Krogerus wrote:
> This helper returns the name of the node. The name is
> primarily expected to be returned from a new fwnode
> operation meant for this purpose, but when no name is
> returned, the helper will also attempt to read a device
> property "name".
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/property.h |  2 ++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..8bd35b44d9ec 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1156,6 +1156,42 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_handle_put);
>  
> +/**
> + * fwnode_get_name - Copy the name of an fwnode to a buffer
> + * @fwnode: Pointer to the node
> + * @buf: Buffer where the name is copied to
> + * @len: Size of the buffer
> + *
> + * Copies the node name of @fwnode to @buf. The routine attempts to first use
> + * the get_name fwnode op of @fwnode, and if it fails, the routine attempts to
> + * read a property "name".
> + *
> + * NOTE: @buf must be large enough to accommodate the name and trailing '\0'.
> + *
> + * Returns 0 on success or errno in case of an error.
> + */
> +int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> +{
> +	const char *name;
> +	int ret;
> +
> +	ret = fwnode_call_int_op(fwnode, get_name, buf, len);
> +	if (ret == 0 || ret == -EOVERFLOW)
> +		return ret;
> +
> +	ret = fwnode_call_int_op(fwnode, property_read_string_array,
> +				 "name", &name, 1);

Do you expect this to work on DT? It does today, but I plan to change 
that. 'name' is a fake property on FDT.

Again, I think this is all working at too low of a level. Name is used 
either for matching or an informational string. For matching, this 
should remain firmware specific. For imformational strings, 
device_node.full_name works.

Rob
