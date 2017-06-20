From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7.2 7/7] device property: Get rid of struct
 fwnode_handle type field
Date: Tue, 20 Jun 2017 15:14:14 +0100
Message-ID: <20170620141414.GA11351@red-moon>
References: <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbdFTOMv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jun 2017 10:12:51 -0400
Content-Disposition: inline
In-Reply-To: <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

On Tue, Jun 20, 2017 at 11:49:56AM +0300, Sakari Ailus wrote:

[...]

> +#define DECLARE_ACPI_FWNODE_OPS(ops) \
> +	const struct fwnode_operations ops = {				\
> +		.device_is_available = acpi_fwnode_device_is_available, \
> +		.property_present = acpi_fwnode_property_present,	\
> +		.property_read_int_array =				\
> +			acpi_fwnode_property_read_int_array,		\
> +		.property_read_string_array =				\
> +			acpi_fwnode_property_read_string_array,		\
> +		.get_parent = acpi_node_get_parent,			\
> +		.get_next_child_node = acpi_get_next_subnode,		\
> +		.get_named_child_node = acpi_fwnode_get_named_child_node, \
> +		.graph_get_next_endpoint =				\
> +			acpi_fwnode_graph_get_next_endpoint,		\
> +		.graph_get_remote_endpoint =				\
> +			acpi_fwnode_graph_get_remote_endpoint,		\
> +		.graph_get_port_parent = acpi_node_get_parent,		\
> +		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
> +	};								\
> +	EXPORT_SYMBOL_GPL(ops)
> +
> +DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
> +DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
> +DECLARE_ACPI_FWNODE_OPS(acpi_static_fwnode_ops);

I do not think it is a great idea to associate valid fwnode_operations
to a static ACPI fwnode (which is just a tag - like the IRQCHIP one).

Thanks,
Lorenzo

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fe379a0..53e268b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1435,8 +1435,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>  	device->device_type = type;
>  	device->handle = handle;
>  	device->parent = acpi_bus_get_parent(handle);
> -	device->fwnode.type = FWNODE_ACPI;
> -	device->fwnode.ops = &acpi_fwnode_ops;
> +	device->fwnode.ops = &acpi_device_fwnode_ops;
>  	acpi_set_device_status(device, sta);
>  	acpi_device_get_busid(device);
>  	acpi_set_pnp_ids(handle, &device->pnp, type);
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 692007e..09770fc 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -25,9 +25,11 @@ struct property_set {
>  	const struct property_entry *properties;
>  };
>  
> +static const struct fwnode_operations pset_fwnode_ops;
> +
>  static inline bool is_pset_node(struct fwnode_handle *fwnode)
>  {
> -	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_PDATA;
> +	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
>  }
>  
>  static inline struct property_set *to_pset_node(struct fwnode_handle *fwnode)
> @@ -900,7 +902,6 @@ int device_add_properties(struct device *dev,
>  	if (IS_ERR(p))
>  		return PTR_ERR(p);
>  
> -	p->fwnode.type = FWNODE_PDATA;
>  	p->fwnode.ops = &pset_fwnode_ops;
>  	set_secondary_fwnode(dev, &p->fwnode);
>  	return 0;
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index c96389b..edd629b 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -912,3 +912,4 @@ const struct fwnode_operations of_fwnode_ops = {
>  	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
>  	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
>  };
> +EXPORT_SYMBOL_GPL(of_fwnode_ops);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 197f3ff..e724afc 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -394,15 +394,21 @@ struct acpi_data_node {
>  	struct completion kobj_done;
>  };
>  
> +extern const struct fwnode_operations acpi_device_fwnode_ops;
> +extern const struct fwnode_operations acpi_data_fwnode_ops;
> +extern const struct fwnode_operations acpi_static_fwnode_ops;
> +
>  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>  {
> -	return !IS_ERR_OR_NULL(fwnode) && (fwnode->type == FWNODE_ACPI
> -		|| fwnode->type == FWNODE_ACPI_DATA);
> +	return !IS_ERR_OR_NULL(fwnode) &&
> +		(fwnode->ops == &acpi_device_fwnode_ops
> +		 || fwnode->ops == &acpi_data_fwnode_ops);
>  }
>  
>  static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
>  {
> -	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI;
> +	return !IS_ERR_OR_NULL(fwnode) &&
> +		fwnode->ops == &acpi_device_fwnode_ops;
>  }
>  
>  static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
> @@ -413,7 +419,12 @@ static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwno
>  
>  static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
>  {
> -	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
> +	return fwnode && fwnode->ops == &acpi_data_fwnode_ops;
> +}
> +
> +static inline bool is_acpi_static_node(struct fwnode_handle *fwnode)
> +{
> +	return fwnode && fwnode->ops == &acpi_static_fwnode_ops;
>  }
>  
>  static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b8f23c5..ad19760 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -56,9 +56,6 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>  	acpi_fwnode_handle(adev) : NULL)
>  #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
>  
> -
> -extern const struct fwnode_operations acpi_fwnode_ops;
> -
>  static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
>  {
>  	struct fwnode_handle *fwnode;
> @@ -67,15 +64,14 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
>  	if (!fwnode)
>  		return NULL;
>  
> -	fwnode->type = FWNODE_ACPI_STATIC;
> -	fwnode->ops = &acpi_fwnode_ops;
> +	fwnode->ops = &acpi_static_fwnode_ops;
>  
>  	return fwnode;
>  }
>  
>  static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
>  {
> -	if (WARN_ON(!fwnode || fwnode->type != FWNODE_ACPI_STATIC))
> +	if (WARN_ON(!fwnode || !is_acpi_static_node(fwnode)))
>  		return;
>  
>  	kfree(fwnode);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9ab3754..e7ca4c5 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -14,20 +14,9 @@
>  
>  #include <linux/types.h>
>  
> -enum fwnode_type {
> -	FWNODE_INVALID = 0,
> -	FWNODE_OF,
> -	FWNODE_ACPI,
> -	FWNODE_ACPI_DATA,
> -	FWNODE_ACPI_STATIC,
> -	FWNODE_PDATA,
> -	FWNODE_IRQCHIP
> -};
> -
>  struct fwnode_operations;
>  
>  struct fwnode_handle {
> -	enum fwnode_type type;
>  	struct fwnode_handle *secondary;
>  	const struct fwnode_operations *ops;
>  };
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 9f36160..ee1910c 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -233,9 +233,11 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
>  	return node ? &node->fwnode : NULL;
>  }
>  
> +extern const struct fwnode_operations irqchip_fwnode_ops;
> +
>  static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
>  {
> -	return fwnode && fwnode->type == FWNODE_IRQCHIP;
> +	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
>  }
>  
>  static inline
> diff --git a/include/linux/of.h b/include/linux/of.h
> index cdbfa88..6e39aa1 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -104,7 +104,6 @@ extern const struct fwnode_operations of_fwnode_ops;
>  static inline void of_node_init(struct device_node *node)
>  {
>  	kobject_init(&node->kobj, &of_node_ktype);
> -	node->fwnode.type = FWNODE_OF;
>  	node->fwnode.ops = &of_fwnode_ops;
>  }
>  
> @@ -152,7 +151,7 @@ void of_core_init(void);
>  
>  static inline bool is_of_node(const struct fwnode_handle *fwnode)
>  {
> -	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
> +	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &of_fwnode_ops;
>  }
>  
>  #define to_of_node(__fwnode)						\
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 31805f2..e746c42 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -31,6 +31,8 @@ struct irqchip_fwid {
>  	void *data;
>  };
>  
> +const struct fwnode_operations irqchip_fwnode_ops;
> +
>  /**
>   * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
>   *                           identifying an irq domain
> @@ -55,7 +57,7 @@ struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
>  
>  	fwid->name = name;
>  	fwid->data = data;
> -	fwid->fwnode.type = FWNODE_IRQCHIP;
> +	fwid->fwnode.ops = &irqchip_fwnode_ops;
>  	return &fwid->fwnode;
>  }
>  EXPORT_SYMBOL_GPL(irq_domain_alloc_fwnode);
> -- 
> 2.7.4
> 
