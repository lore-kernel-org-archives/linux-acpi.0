From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Fix acpi_bus_get_device() check
Date: Thu, 31 Jan 2013 12:19:11 +0900
Message-ID: <5109E2AF.2000107@jp.fujitsu.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan> <6099377.PFvsxPeyib@vostro.rjw.lan> <5109E11A.5030400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53001 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab3AaDTf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2013 22:19:35 -0500
In-Reply-To: <5109E11A.5030400@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, daniel.vetter@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org

acpi_bus_get_device() returns int not acpi_status.

The patch change not to apply ACPI_FAILURE() to the return value of
acpi_bus_get_device().

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
  drivers/gpu/drm/i915/intel_opregion.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/gpu/drm/i915/intel_opregion.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/i915/intel_opregion.c	2013-01-31 11:39:37.075849905 +0900
+++ linux-pm/drivers/gpu/drm/i915/intel_opregion.c	2013-01-31 11:52:18.796850274 +0900
@@ -347,7 +347,7 @@ static void intel_didl_outputs(struct dr
  	int i = 0;
  
  	handle = DEVICE_ACPI_HANDLE(&dev->pdev->dev);
-	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev)))
+	if (!handle || acpi_bus_get_device(handle, &acpi_dev))
  		return;
  
  	if (acpi_is_video_device(acpi_dev))

