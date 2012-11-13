From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI: Add debugfs support for ACPICA boot time
 measurement.
Date: Tue, 13 Nov 2012 07:49:28 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BC17E9@SHSMSX101.ccr.corp.intel.com>
References: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C94828D3479C@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48810 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab2KMHtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2012 02:49:33 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94828D3479C@FMSMSX108.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

OK.
Thanks for your suggestion.
I'll prepare the next version and obtain more test results on other platforms.

Thanks and best regards/Lv Zheng

> -----Original Message-----
> From: Brown, Len
> Sent: Tuesday, November 13, 2012 10:40 AM
> To: Zheng, Lv; Wysocki, Rafael J
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: [PATCH] ACPI: Add debugfs support for ACPICA boot time
> measurement.
> 
> Always nice to see performance measurement and analysis!
> 
> Lets skip the debugfs file -- it is only read once, and so you might as well use
> dmesg.
> 
> 
> [00000.0000] ACPI: acpi_bus_scan took 45.082 usec
> 
> if (usec > 100 usec)
> 	printk(...)
> else be quiet
> 
> 
> ----------
> please show the next edition output
> as a result of a grep on dmesg
> 
> thanks,
> -Len

