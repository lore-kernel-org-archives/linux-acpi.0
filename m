From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v7.1 7/7] device property: Get rid of struct
 fwnode_handle type field
Date: Tue, 20 Jun 2017 11:51:51 +0300
Message-ID: <20170620085150.GZ12407@valkosipuli.retiisi.org.uk>
References: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
 <1497354548-17502-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170618065853.GO629@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:46538 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751082AbdFTIwE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jun 2017 04:52:04 -0400
Content-Disposition: inline
In-Reply-To: <20170618065853.GO629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

On Sun, Jun 18, 2017 at 09:58:53AM +0300, Mika Westerberg wrote:
> On Tue, Jun 13, 2017 at 02:49:08PM +0300, Sakari Ailus wrote:
> > +#define DECLARE_ACPI_FWNODE_OPS(ops) \
> > +	const struct fwnode_operations ops = { \
> > +		.device_is_available = acpi_fwnode_device_is_available, \
> > +		.property_present = acpi_fwnode_property_present, \
> > +		.property_read_int_array = \
> > +			acpi_fwnode_property_read_int_array, \
> > +		.property_read_string_array = \
> > +			acpi_fwnode_property_read_string_array, \
> > +		.get_parent = acpi_node_get_parent, \
> > +		.get_next_child_node = acpi_get_next_subnode, \
> > +		.get_named_child_node = acpi_fwnode_get_named_child_node, \
> > +		.graph_get_next_endpoint = \
> > +			acpi_fwnode_graph_get_next_endpoint, \
> > +		.graph_get_remote_endpoint = \
> > +			acpi_fwnode_graph_get_remote_endpoint, \
> > +		.graph_get_port_parent = acpi_node_get_parent, \
> > +		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
> > +	}; \
> > +	EXPORT_SYMBOL_GPL(ops)
> 
> Can you align those backslashes, like
> 
> 	const struct fwnode_operations ops = { 				\
> 		.device_is_available = acpi_fwnode_device_is_available, \
> 		.property_present = acpi_fwnode_property_present,	\
> 		...
> 
> other than that the patch looks good.

Thanks for the review.

Fixed in v7.2.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
