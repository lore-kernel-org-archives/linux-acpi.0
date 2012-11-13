From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] ACPI: Add debugfs support for ACPICA boot time
 measurement.
Date: Tue, 13 Nov 2012 02:39:37 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828D3479C@FMSMSX108.amr.corp.intel.com>
References: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54456 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab2KMCji convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Nov 2012 21:39:38 -0500
In-Reply-To: <a4f15c34285624904d483e22b9b7a10c7d97fc3d.1352339077.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Always nice to see performance measurement and analysis!

Lets skip the debugfs file -- it is only read once,
and so you might as well use dmesg.


[00000.0000] ACPI: acpi_bus_scan took 45.082 usec

if (usec > 100 usec)
	printk(...)
else be quiet


----------
please show the next edition output
as a result of a grep on dmesg

thanks,
-Len

