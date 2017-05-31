From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 2/5] device property: Move FW type specific
 functionality to FW specific files
Date: Wed, 31 May 2017 13:08:49 +0300
Message-ID: <b5d632a9-4c35-13b0-0b80-1e58b78660cf@linux.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495443202-22817-3-git-send-email-sakari.ailus@linux.intel.com>
 <20170531094428.GB2784@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46304 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdEaKIy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 06:08:54 -0400
In-Reply-To: <20170531094428.GB2784@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Hi Mika,

Thanks for the review.

On 05/31/17 12:44, Mika Westerberg wrote:
> On Mon, May 22, 2017 at 11:53:19AM +0300, Sakari Ailus wrote:
>> +static int acpi_fwnode_property_read_int_array(
> 
> Yuck!
> 
>> +	struct fwnode_handle *fwnode, const char *propname,
>> +	unsigned int elem_size, void *val, size_t nval)
> 
> Can you please write it like:
> 
> static int acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
> 	const char *propname, unsigned int elem_size, void *val, size_t nval)
> 
> or even
> 
> static int acpi_fwnode_property_read_int_array(struct fwnode_handle *fwnode,
> 					       const char *propname,
> 					       unsigned int elem_size,
> 					       void *val, size_t nval)
> 
> Ditto to all similar constructs in this whole series.

Ah. I forgot you didn't like this wrapping and indentation. ;-)

That's not uncommon e.g. in V4L2 but many have argued that it's not
where you should look for examples. X-) I'll change them.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
