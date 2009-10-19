From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v4 3/6] ACPI: dock: remove global 'dock_device_name'
Date: Mon, 19 Oct 2009 15:14:35 -0600
Message-ID: <20091019211434.5412.13924.stgit@bob.kio>
References: <20091019211132.5412.80438.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:16021 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806AbZJSVOv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 17:14:51 -0400
In-Reply-To: <20091019211132.5412.80438.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =shaohua.li@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

We only use it in one spot, so it probably gets optimized out, but there's
still no need to use a global variable for this.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/dock.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 347ea98..45bdff7 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -50,7 +50,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
 	" before undocking");
 
 static struct atomic_notifier_head dock_notifier_list;
-static char dock_device_name[] = "dock";
 
 static const struct acpi_device_id dock_device_ids[] = {
 	{"LNXDOCK", 0},
@@ -964,7 +963,7 @@ static int dock_add(acpi_handle handle)
 
 	/* initialize platform device stuff */
 	dock_station->dock_device =
-		platform_device_register_simple(dock_device_name,
+		platform_device_register_simple("dock",
 			dock_station_count, NULL, 0);
 	dock_device = dock_station->dock_device;
 	if (IS_ERR(dock_device)) {

