From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ACPI dock: move some functions to .init.text
Date: Mon, 21 Jun 2010 15:31:13 +0200
Message-ID: <1277127073-10485-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100618073950.GA12822@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38047 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab0FUNbe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2010 09:31:34 -0400
In-Reply-To: <20100618073950.GA12822@pengutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org

These functions are some of the few stoppers of moving
platform_device_register_data to .init.text, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/dock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 3fe29e9..2b16563 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -929,7 +929,7 @@ static struct attribute_group dock_attribute_group =
=3D {
  * allocated and initialize a new dock station device.  Find all devic=
es
  * that are on the dock station, and register for dock event notificat=
ions.
  */
-static int dock_add(acpi_handle handle)
+static int __init dock_add(acpi_handle handle)
 {
 	int ret, id;
 	struct dock_station ds, *dock_station;
@@ -1023,7 +1023,7 @@ static int dock_remove(struct dock_station *ds)
  *
  * This is called by acpi_walk_namespace to look for dock stations.
  */
-static acpi_status
+static __init acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	if (is_dock(handle))
@@ -1032,7 +1032,7 @@ find_dock(acpi_handle handle, u32 lvl, void *cont=
ext, void **rv)
 	return AE_OK;
 }
=20
-static acpi_status
+static __init acpi_status
 find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	/* If bay is a dock, it's already handled */
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
