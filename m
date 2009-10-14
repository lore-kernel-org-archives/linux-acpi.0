From: Alex Chiang <achiang@hp.com>
Subject: [PATCH v2 3/6] ACPI: dock: remove global 'dock_device_name'
Date: Wed, 14 Oct 2009 16:46:26 -0600
Message-ID: <20091014224626.18044.41454.stgit@bob.kio>
References: <20091014224415.18044.88208.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:31495 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761346AbZJNWrK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2009 18:47:10 -0400
In-Reply-To: <20091014224415.18044.88208.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

We only use it in one spot, so it probably gets optimized out, but there's
still no need to use a global variable for this.

Signed-off-by: Alex Chiang <achiang@hp.com>
---

 drivers/acpi/dock.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 10cf833..e57be55 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -50,7 +50,6 @@ MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
 	" before undocking");
 
 static struct atomic_notifier_head dock_notifier_list;
-static char dock_device_name[] = "dock";
 
 static const struct acpi_device_id dock_device_ids[] = {
 	{"LNXDOCK", 0},
@@ -951,7 +950,7 @@ static int dock_add(acpi_handle handle)
 
 	/* initialize platform device stuff */
 	dock_station->dock_device =
-		platform_device_register_simple(dock_device_name,
+		platform_device_register_simple("dock",
 			dock_station_count, NULL, 0);
 	dock_device = dock_station->dock_device;
 	ret = IS_ERR(dock_device) ? PTR_ERR(dock_device) : 0;

