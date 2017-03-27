From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] device property: Move FW type specific functionality
 to FW specific files
Date: Mon, 27 Mar 2017 14:31:00 +0300
Message-ID: <20170327113100.GZ2957@lahna.fi.intel.com>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29870 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbdC0LfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Mar 2017 07:35:02 -0400
Content-Disposition: inline
In-Reply-To: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On Fri, Mar 24, 2017 at 01:03:50PM +0200, Sakari Ailus wrote:
> +static int acpi_fwnode_property_read_int_array(

This is really ugly way to split arguments into multiple lines IMHO.

> +	struct fwnode_handle *fwnode, const char *propname,
> +	unsigned int elem_size, void *val, size_t nval)


I would much more see something like:

static int
acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
	const char *propname, unsigned int elem_size, void *val, size_t nval)

or even

static int
acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
				    const char *propname,
				    unsigned int elem_size,
				    void *val, size_t nval)

ditto for all occurences.

Other than that this patch looks reasonable to me.
