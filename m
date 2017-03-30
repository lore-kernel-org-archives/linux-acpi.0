From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 2/3] device property: Move fwnode graph ops to firmware
 specific locations
Date: Thu, 30 Mar 2017 18:10:19 +0300
Message-ID: <20170330151019.GL16657@valkosipuli.retiisi.org.uk>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
 <1490353432-12017-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170327115200.GB2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:40264 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933206AbdC3PK1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Mar 2017 11:10:27 -0400
Content-Disposition: inline
In-Reply-To: <20170327115200.GB2957@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Hi Mika,

Thank you for the review.

On Mon, Mar 27, 2017 at 02:52:00PM +0300, Mika Westerberg wrote:
> On Fri, Mar 24, 2017 at 01:03:51PM +0200, Sakari Ailus wrote:
> >  const struct fwnode_operations acpi_fwnode_ops = {
> >  	.property_present = acpi_fwnode_property_present,
> >  	.property_read_int_array = acpi_fwnode_property_read_int_array,
> > @@ -1193,4 +1248,9 @@ const struct fwnode_operations acpi_fwnode_ops = {
> >  	.get_parent = acpi_fwnode_get_parent,
> >  	.get_next_child_node = acpi_get_next_subnode,
> >  	.get_named_child_node = acpi_fwnode_get_named_child_node,
> > +	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
> > +	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
> > +	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
> > +	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
> > +	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
> >  };
> 
> Not sure if it is possible but it would be nice to have a single
> primitive implementation specific graph callback and then build
> everything else on top of that in generic code. Here you have 5
> callbacks just for graph support.

Getting the parent of the port in OF graph is OF specific, the port parent
is not necessarily a direct parent node of the port (in presence of the
"ports" node that contains all port nodes).

I could potentially remove graph_get_remote_port() and use
graph_get_remote_endpoint() and graph_get_parent() instead. I didn't
originally do that as I thought it could be better ot leave it up to the
implementation.

What do you think?

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
