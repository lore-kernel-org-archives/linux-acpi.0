From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH - 2.6.19 -2/2] Properly reset psmouse at suspend
Date: Wed, 21 Feb 2007 18:08:21 +0100
Message-ID: <1172077701.10619.104.camel@d36.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:34859 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422707AbXBURIW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 12:08:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stable <Stable@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>

psmouse - properly reset mouse on shutdown/suspend

Some people report that they need psmouse module unloaded
for suspend to ram/disk to work properly. Let's make port
cleanup behave the same way as driver unload.

This fixes "bad state" problem on various HP laptops, such
as nx7400.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---

 drivers/input/mouse/psmouse-base.c |   28 ++++++++++++++++++++++++++++
 drivers/input/mouse/psmouse.h      |    1 +
 drivers/input/mouse/synaptics.c    |    1 +
 3 files changed, 30 insertions(+)

Index: linux-2.6.19/drivers/input/mouse/psmouse-base.c
===================================================================
--- linux-2.6.19.orig/drivers/input/mouse/psmouse-base.c
+++ linux-2.6.19/drivers/input/mouse/psmouse-base.c
@@ -986,8 +986,36 @@ static void psmouse_resync(void *p)
 static void psmouse_cleanup(struct serio *serio)
 {
 	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *parent = NULL;
+
+	mutex_lock(&psmouse_mutex);
+
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
+		parent = serio_get_drvdata(serio->parent);
+		psmouse_deactivate(parent);
+	}
+
+	psmouse_deactivate(psmouse);
+
+	if (psmouse->cleanup)
+		psmouse->cleanup(psmouse);
 
 	psmouse_reset(psmouse);
+
+/*
+ * Some boxes, such as HP nx7400, get terribly confused if mouse
+ * is not fully enabled before suspending/shutting down.
+ */
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+	if (parent) {
+		if (parent->pt_deactivate)
+			parent->pt_deactivate(parent);
+
+		psmouse_activate(parent);
+	}
+
+	mutex_unlock(&psmouse_mutex);
 }
 
 /*
Index: linux-2.6.19/drivers/input/mouse/psmouse.h
===================================================================
--- linux-2.6.19.orig/drivers/input/mouse/psmouse.h
+++ linux-2.6.19/drivers/input/mouse/psmouse.h
@@ -68,6 +68,7 @@ struct psmouse {
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
+	void (*cleanup)(struct psmouse *psmouse);
 	int (*poll)(struct psmouse *psmouse);
 
 	void (*pt_activate)(struct psmouse *psmouse);
Index: linux-2.6.19/drivers/input/mouse/synaptics.c
===================================================================
--- linux-2.6.19.orig/drivers/input/mouse/synaptics.c
+++ linux-2.6.19/drivers/input/mouse/synaptics.c
@@ -652,6 +652,7 @@ int synaptics_init(struct psmouse *psmou
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->cleanup = synaptics_reset;
 	psmouse->pktsize = 6;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;


