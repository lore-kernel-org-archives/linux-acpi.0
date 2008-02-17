From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Sat, 16 Feb 2008 21:16:03 -0800
Message-ID: <20080216211603.bb4f3582.randy.dunlap@oracle.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:46633 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYBQFQd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Feb 2008 00:16:33 -0500
In-Reply-To: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Sat, 16 Feb 2008 00:25:22 -0800 Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc2/2.6.25-rc2-mm1/

ACPI is enabled, but DMI=n.

linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c: In function 'acpi_thermal_init':
linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: 'thermal_dmi_table' undeclared (first use in this function)
linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: (Each undeclared identifier is reported only once
linux-2.6.25-rc2-mm1/drivers/acpi/thermal.c:1792: error: for each function it appears in.)
make[3]: *** [drivers/acpi/thermal.o] Error 1


---
~Randy
