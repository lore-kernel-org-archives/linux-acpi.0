From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [RESEND PATCH 2/4] ACPI/dock: Fix acpi_bus_get_device() check in
 drivers/acpi/ddock.c
Date: Thu, 31 Jan 2013 12:23:53 +0900
Message-ID: <5109E3C9.2010804@jp.fujitsu.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan> <6099377.PFvsxPeyib@vostro.rjw.lan> <5109E11A.5030400@jp.fujitsu.com> <5109E1C7.5020702@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55416 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab3AaDYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2013 22:24:15 -0500
In-Reply-To: <5109E1C7.5020702@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>

I forgot to change subject. So I resend a patch.

---
acpi_bus_get_device() returns int not acpi_status.

The patch change not to apply ACPI_SUCCESS() to the return value of
acpi_bus_get_device().

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
  drivers/acpi/dock.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c	2013-01-31 11:39:40.574849906 +0900
+++ linux-pm/drivers/acpi/dock.c	2013-01-31 11:50:11.329850213 +0900
@@ -836,7 +836,7 @@ static ssize_t show_docked(struct device
  
  	struct dock_station *dock_station = dev->platform_data;
  
-	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
+	if (!acpi_bus_get_device(dock_station->handle, &tmp))
  		return snprintf(buf, PAGE_SIZE, "1\n");
  	return snprintf(buf, PAGE_SIZE, "0\n");
  }

