From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7.1 7/7] device property: Get rid of struct
 fwnode_handle type field
Date: Sun, 18 Jun 2017 09:58:53 +0300
Message-ID: <20170618065853.GO629@lahna.fi.intel.com>
References: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:40405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdFRG67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 18 Jun 2017 02:58:59 -0400
Content-Disposition: inline
In-Reply-To: <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

On Tue, Jun 13, 2017 at 02:49:08PM +0300, Sakari Ailus wrote:
> +#define DECLARE_ACPI_FWNODE_OPS(ops) \
> +	const struct fwnode_operations ops = { \
> +		.device_is_available = acpi_fwnode_device_is_available, \
> +		.property_present = acpi_fwnode_property_present, \
> +		.property_read_int_array = \
> +			acpi_fwnode_property_read_int_array, \
> +		.property_read_string_array = \
> +			acpi_fwnode_property_read_string_array, \
> +		.get_parent = acpi_node_get_parent, \
> +		.get_next_child_node = acpi_get_next_subnode, \
> +		.get_named_child_node = acpi_fwnode_get_named_child_node, \
> +		.graph_get_next_endpoint = \
> +			acpi_fwnode_graph_get_next_endpoint, \
> +		.graph_get_remote_endpoint = \
> +			acpi_fwnode_graph_get_remote_endpoint, \
> +		.graph_get_port_parent = acpi_node_get_parent, \
> +		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
> +	}; \
> +	EXPORT_SYMBOL_GPL(ops)

Can you align those backslashes, like

	const struct fwnode_operations ops = { 				\
		.device_is_available = acpi_fwnode_device_is_available, \
		.property_present = acpi_fwnode_property_present,	\
		...

other than that the patch looks good.
