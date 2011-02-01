From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] gpu/stub: fix acpi_video build error, fix stub kconfig
 dependencies
Date: Tue, 1 Feb 2011 11:17:28 -0800
Message-ID: <20110201111728.cb786487.randy.dunlap@oracle.com>
References: <20101220200013.df8fbc88.sfr@canb.auug.org.au>
	<20101220085340.7ba098b9.randy.dunlap@oracle.com>
	<20110126114203.GA16754@elte.hu>
	<20110201120323.GA6714@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:50853 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1BATSM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Feb 2011 14:18:12 -0500
In-Reply-To: <20110201120323.GA6714@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Luming Yu <luming.yu@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

From: Randy Dunlap <randy.dunlap@oracle.com>

The comments under "config STUB_POULSBO" are close to correct,
but they are not being followed.  This patch updates them to reflect
the requirements for THERMAL.

This build error is caused by STUB_POULSBO selecting ACPI_VIDEO
when ACPI_VIDEO's config requirements are not met.

ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/gpu/stub/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- lnx-2638-rc3.orig/drivers/gpu/stub/Kconfig
+++ lnx-2638-rc3/drivers/gpu/stub/Kconfig
@@ -1,11 +1,13 @@
 config STUB_POULSBO
 	tristate "Intel GMA500 Stub Driver"
 	depends on PCI
+	depends on NET # for THERMAL
 	# Poulsbo stub depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
+	select THERMAL if ACPI
 	help
 	  Choose this option if you have a system that has Intel GMA500
 	  (Poulsbo) integrated graphics. If M is selected, the module will
