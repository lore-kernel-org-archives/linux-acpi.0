From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi_bus_register_driver() and latest acpi trees
Date: Thu, 01 Feb 2007 09:58:35 +0800
Message-ID: <1170295115.24637.5.camel@localhost.localdomain>
References: <200701311611.l0VGBCwY395506@fcbayern.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24244 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161080AbXBAB54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Jan 2007 20:57:56 -0500
In-Reply-To: <200701311611.l0VGBCwY395506@fcbayern.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: len.brown@intel.com, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, akpm@osdl.org, ayoung@sgi.com, shaohua.li@intel.com

On Wed, 2007-01-31 at 10:11 -0600, John Keller wrote:
> Len,
>   When building kernels from your ACPI release or test trees,
> as well as the -mm tree, SN Altix boots are crashing in the
> kobject code when calling acpi_bus_register_driver().
> The crash is because kset->list has not been initialized yet.
> 
>  kobject_add()
>   list_add_tail(&kobj->entry,&kobj->kset->list);
> 
> 
> Is there now a restriction on how early acpi_bus_register_driver()
> can be called? If so, at what point in time can calls be made,
> and is it still possible to register a driver early enough such
> that it will be called at device discovery time vs registration time?
>
Yes, this is caused by the recent ACPI sysfs conversion changes.
Now we make ACPI use driver model.
All the ACPI drivers should register after the ACPI bus has registered,
i.e. we can not call acpi_bus_register_driver() before acpi_scan_init()
in drivers/acpi/scan.c. 
