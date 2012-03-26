From: "Liu, Jinsong" <jinsong.liu@intel.com>
Subject: RE: [PATCH 2/2] RFC: Xen pad logic
Date: Mon, 26 Mar 2012 07:29:09 +0000
Message-ID: <DE8DF0795D48FD4CA783C40EC8292335105F35@SHSMSX101.ccr.corp.intel.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD0A6@SHSMSX101.ccr.corp.intel.com>
 <20120314002442.GC20363@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:62308 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2CZH3U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Mar 2012 03:29:20 -0400
In-Reply-To: <20120314002442.GC20363@phenom.dumpdata.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Kernel development list <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "keir.xen@gmail.com" <keir.xen@gmail.com>, Jan Beulich <JBeulich@suse.com>, "Li, Shaohua" <shaohua.li@intel.com>

Konrad Rzeszutek Wilk wrote:
>> +static struct acpi_driver xen_acpi_pad_driver = {
>> +	.name = "processor_aggregator",
>> +	.class = ACPI_PROCESSOR_AGGREGATOR_CLASS,
>> +	.ids = xen_pad_device_ids,
>> +	.ops = {
>> +		.add = xen_acpi_pad_add,
>> +		.remove = xen_acpi_pad_remove,
>> +	},
>> +};
>> +
>> +static int __init xen_acpi_pad_init(void)
>> +{
>> +	return acpi_bus_register_driver(&xen_acpi_pad_driver);
> 
> If the acpi_bus_register_driver function could work with multiple
> acpi_drivers that define the same class (and have some priority) would
> this be easier?

Not quite clear your point, could you elaborate more?

Thanks,
Jinsong