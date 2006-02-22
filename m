From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: "Device is not power manageable"
Date: Tue, 21 Feb 2006 18:59:20 -0800
Message-ID: <20060221185920.df65a7e3.rdunlap@xenotime.net>
References: <20060221042708.653944c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:60348 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751252AbWBVC6S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 21:58:18 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2006 18:58:17 -0800
In-Reply-To: <20060221042708.653944c1.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 21 Feb 2006 04:27:08 -0800 Andrew Morton wrote:

> 
> What does this mean?
> 
> sony:/home/akpm> dmesg -s 1000000 | grep 199
> Detected 1995.262 MHz processor.
> Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> e100: Copyright(c) 1999-2005 Intel Corporation
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> ACPI (acpi_bus-0199): Device is not power manageable [20060210]
> 
> <suspend-to-ram>
> <resume>
> 
> ACPI Error (evevent-0314): No installed handler for fixed event [00000002] [20060210]
> 
> 
> And how does one identify that device?

Here's the patch that I have used.

-- 

From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>

Identify which device is not power-manageable to make
the message more useful.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/bus.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2616-rc4.orig/drivers/acpi/bus.c
+++ linux-2616-rc4/drivers/acpi/bus.c
@@ -197,8 +197,9 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				  "Device is not power manageable\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Device '%s' is not power manageable\n",
+					device->kobj.name));
 		return_VALUE(-ENODEV);
 	}
 	/*

