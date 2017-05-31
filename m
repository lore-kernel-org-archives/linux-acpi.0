From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 2/5] device property: Move FW type specific
 functionality to FW specific files
Date: Wed, 31 May 2017 12:44:28 +0300
Message-ID: <20170531094428.GB2784@lahna.fi.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-3-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41656 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdEaJvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 05:51:05 -0400
Content-Disposition: inline
In-Reply-To: <1495443202-22817-3-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On Mon, May 22, 2017 at 11:53:19AM +0300, Sakari Ailus wrote:
> +static int acpi_fwnode_property_read_int_array(

Yuck!

> +	struct fwnode_handle *fwnode, const char *propname,
> +	unsigned int elem_size, void *val, size_t nval)

Can you please write it like:

static int acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
	const char *propname, unsigned int elem_size, void *val, size_t nval)

or even

static int acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
					       const char *propname,
					       unsigned int elem_size,
					       void *val, size_t nval)

Ditto to all similar constructs in this whole series.
