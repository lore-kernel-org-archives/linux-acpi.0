From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / scan: Annotate physical_node_lock in acpi_scan_is_offline()
Date: Sat, 11 Apr 2015 01:31:08 +0200
Message-ID: <2181841.0nPiIAbDNm@vostro.rjw.lan>
References: <1428397392-26200-1-git-send-email-xiexiuqi@huawei.com> <5219717.RxvSXtBaZ8@vostro.rjw.lan> <12760195.2odgqTkKju@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50595 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754934AbbDJXGv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Apr 2015 19:06:51 -0400
In-Reply-To: <12760195.2odgqTkKju@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Xie XiuQi <xiexiuqi@huawei.com>, guohanjun@huawei.com, hanjun.guo@linaro.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_scan_is_offline() may be called under the physical_node_lock
of the given device object's parent, so prevent lockdep from
complaining about that by annotating that instance with
SINGLE_DEPTH_NESTING.

Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -298,7 +298,11 @@ bool acpi_scan_is_offline(struct acpi_de
 	struct acpi_device_physical_node *pn;
 	bool offline = true;
 
-	mutex_lock(&adev->physical_node_lock);
+	/*
+	 * acpi_container_offline() calls this for all of the container's
+	 * children under the container's physical_node_lock lock.
+	 */
+	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
 		if (device_supports_offline(pn->dev) && !pn->dev->offline) {

