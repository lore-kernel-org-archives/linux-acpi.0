From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Fix acpi_bus_get_device() check
Date: Thu, 31 Jan 2013 12:14:17 +0900
Message-ID: <5109E189.7040105@jp.fujitsu.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan> <6099377.PFvsxPeyib@vostro.rjw.lan> <5109E11A.5030400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39123 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab3AaDOj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2013 22:14:39 -0500
In-Reply-To: <5109E11A.5030400@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>

acpi_bus_get_device() returns int not acpi_status.

The patch change not to apply ACPI_FAILURE() to the return value of
acpi_bus_get_device().

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
  drivers/acpi/device_pm.c |    6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c	2013-01-31 11:04:30.000000000 +0900
+++ linux-pm/drivers/acpi/device_pm.c	2013-01-31 11:28:51.366849592 +0900
@@ -213,7 +213,7 @@ int acpi_pm_device_sleep_state(struct de
  	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
  	struct acpi_device *adev;
  
-	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+	if (!handle || acpi_bus_get_device(handle, &adev)) {
  		dev_dbg(dev, "ACPI handle without context in %s!\n", __func__);
  		return -ENODEV;
  	}
@@ -290,7 +290,7 @@ int acpi_pm_device_run_wake(struct devic
  		return -EINVAL;
  
  	handle = DEVICE_ACPI_HANDLE(phys_dev);
-	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+	if (!handle || acpi_bus_get_device(handle, &adev)) {
  		dev_dbg(phys_dev, "ACPI handle without context in %s!\n",
  			__func__);
  		return -ENODEV;
@@ -334,7 +334,7 @@ int acpi_pm_device_sleep_wake(struct dev
  		return -EINVAL;
  
  	handle = DEVICE_ACPI_HANDLE(dev);
-	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
+	if (!handle || acpi_bus_get_device(handle, &adev)) {
  		dev_dbg(dev, "ACPI handle without context in %s!\n", __func__);
  		return -ENODEV;
  	}

