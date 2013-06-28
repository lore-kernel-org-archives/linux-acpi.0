From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] ACPI / dock: Simplify dock_init_hotplug() and dock_release_hotplug()
Date: Fri, 28 Jun 2013 21:48:12 +0200
Message-ID: <6889707.ugqJleQ6Ld@vostro.rjw.lan>
References: <1640211.P0jyS5muX2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54384 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab3F1Tiq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jun 2013 15:38:46 -0400
In-Reply-To: <1640211.P0jyS5muX2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make dock_init_hotplug() and dock_release_hotplug() slightly simpler
and move some checks in those functions to the code paths where they
are needed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dock.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -134,19 +134,16 @@ static int dock_init_hotplug(struct dock
 	int ret = 0;
 
 	mutex_lock(&hotplug_lock);
-
-	if (dd->hp_context) {
+	if (WARN_ON(dd->hp_context)) {
 		ret = -EEXIST;
 	} else {
 		dd->hp_refcount = 1;
 		dd->hp_ops = ops;
 		dd->hp_context = context;
 		dd->hp_release = release;
+		if (init)
+			init(context);
 	}
-
-	if (!WARN_ON(ret) && init)
-		init(context);
-
 	mutex_unlock(&hotplug_lock);
 	return ret;
 }
@@ -161,22 +158,17 @@ static int dock_init_hotplug(struct dock
  */
 static void dock_release_hotplug(struct dock_dependent_device *dd)
 {
-	void (*release)(void *) = NULL;
-	void *context = NULL;
-
 	mutex_lock(&hotplug_lock);
-
 	if (dd->hp_context && !--dd->hp_refcount) {
+		void (*release)(void *) = dd->hp_release;
+		void *context = dd->hp_context;
+
 		dd->hp_ops = NULL;
-		context = dd->hp_context;
 		dd->hp_context = NULL;
-		release = dd->hp_release;
 		dd->hp_release = NULL;
+		if (release)
+			release(context);
 	}
-
-	if (release && context)
-		release(context);
-
 	mutex_unlock(&hotplug_lock);
 }
 

