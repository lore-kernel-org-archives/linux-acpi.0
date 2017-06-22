From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v7.2 7/7] device property: Get rid of struct
 fwnode_handle type field
Date: Thu, 22 Jun 2017 13:29:21 +0300
Message-ID: <20170622102921.GE12407@valkosipuli.retiisi.org.uk>
References: <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497948596-1009-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170620141414.GA11351@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:52072 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752897AbdFVK32 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jun 2017 06:29:28 -0400
Content-Disposition: inline
In-Reply-To: <20170620141414.GA11351@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

Hi Lorenzo,

On Tue, Jun 20, 2017 at 03:14:14PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jun 20, 2017 at 11:49:56AM +0300, Sakari Ailus wrote:
> 
> [...]
> 
> > +#define DECLARE_ACPI_FWNODE_OPS(ops) \
> > +	const struct fwnode_operations ops = {				\
> > +		.device_is_available = acpi_fwnode_device_is_available, \
> > +		.property_present = acpi_fwnode_property_present,	\
> > +		.property_read_int_array =				\
> > +			acpi_fwnode_property_read_int_array,		\
> > +		.property_read_string_array =				\
> > +			acpi_fwnode_property_read_string_array,		\
> > +		.get_parent = acpi_node_get_parent,			\
> > +		.get_next_child_node = acpi_get_next_subnode,		\
> > +		.get_named_child_node = acpi_fwnode_get_named_child_node, \
> > +		.graph_get_next_endpoint =				\
> > +			acpi_fwnode_graph_get_next_endpoint,		\
> > +		.graph_get_remote_endpoint =				\
> > +			acpi_fwnode_graph_get_remote_endpoint,		\
> > +		.graph_get_port_parent = acpi_node_get_parent,		\
> > +		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
> > +	};								\
> > +	EXPORT_SYMBOL_GPL(ops)
> > +
> > +DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
> > +DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
> > +DECLARE_ACPI_FWNODE_OPS(acpi_static_fwnode_ops);
> 
> I do not think it is a great idea to associate valid fwnode_operations
> to a static ACPI fwnode (which is just a tag - like the IRQCHIP one).

Thanks for the review!

I'll fix that in v8 of the set (by using a struct with all ops being NULL,
just as for IRQCHIP).

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
