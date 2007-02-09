From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Fri, 9 Feb 2007 01:42:05 -0500
Message-ID: <200702090142.06253.dtor@insightbb.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp> <1170701940.25027.422.camel@d36.suse.de> <d120d5000702051149n2f713859na46b8c1b2398e17d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+eBzFF0Z1+SmCUE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:42175 "EHLO
	asav11.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946150AbXBIGv4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Feb 2007 01:51:56 -0500
In-Reply-To: <d120d5000702051149n2f713859na46b8c1b2398e17d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Luming Yu <luming.yu@gmail.com>, emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org

--Boundary-00=_+eBzFF0Z1+SmCUE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 05 February 2007 14:49, Dmitry Torokhov wrote:
> Hi,
> 
> On 2/5/07, Thomas Renninger <trenn@suse.de> wrote:
> > I have a patch that should fix the psmouse unload thing (at the end).
> > Not sure whether it's still needed in 2.6.20-rcX, there was some work
> > done... it definitely helps on 2.6.18 and 2.6.16 kernels.
> > Ok, I quickly tried on 2.6.20-rc7 and it seems to work without the
> > patch.
> 
> Just a limited number of boxes seems to have problems...
> 
> > Maybe Dmitry can comment on that and push this one if still needed?
> 
> I do not like the idea of removing port at shutdown. I will look into
> extending psmouse_cleanup so it leaves the port in the same state as
> psmouse_disconnect.
> 

Hi,

Could you please try the 2 attached patches and let me know if it improves
suspend and psmouse iteractions.

Thanks!

-- 
Dmitry

--Boundary-00=_+eBzFF0Z1+SmCUE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="psmouse-fiddle-with-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="psmouse-fiddle-with-reset.patch"

Subject: psmouse - properly reset mouse on shutdown/suspend

Input: psmouse - properly reset mouse on shutdown/suspend

Some people report that they need psmouse module unloaded
for suspend to ram/disk to work properly. Let's make port
cleanup behave the same way as driver unload.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |   17 +++++++++++++++++
 drivers/input/mouse/psmouse.h      |    1 +
 drivers/input/mouse/synaptics.c    |    1 +
 3 files changed, 19 insertions(+)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -987,8 +987,25 @@ static void psmouse_resync(struct work_s
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
 
+	psmouse_deactivate(psmouse);
+	if (psmouse->cleanup)
+		psmouse->cleanup(psmouse);
 	psmouse_reset(psmouse);
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+	if (parent)
+		psmouse_activate(parent);
+
+	mutex_unlock(&psmouse_mutex);
 }
 
 /*
Index: work/drivers/input/mouse/psmouse.h
===================================================================
--- work.orig/drivers/input/mouse/psmouse.h
+++ work/drivers/input/mouse/psmouse.h
@@ -68,6 +68,7 @@ struct psmouse {
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
+	void (*cleanup)(struct psmouse *psmouse);
 	int (*poll)(struct psmouse *psmouse);
 
 	void (*pt_activate)(struct psmouse *psmouse);
Index: work/drivers/input/mouse/synaptics.c
===================================================================
--- work.orig/drivers/input/mouse/synaptics.c
+++ work/drivers/input/mouse/synaptics.c
@@ -652,6 +652,7 @@ int synaptics_init(struct psmouse *psmou
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->cleanup = synaptics_reset;
 	psmouse->pktsize = 6;
 	/* Synaptics can usually stay in sync without extra help */
 	psmouse->resync_time = 0;

--Boundary-00=_+eBzFF0Z1+SmCUE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="serio-cleanup-to-bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="serio-cleanup-to-bus.patch"

Subject: XXX
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   30 ++++++------------------------
 drivers/input/serio/serio.c |   25 +++++++++++++++++++++++++
 include/linux/serio.h       |    6 ------
 3 files changed, 31 insertions(+), 30 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -791,27 +791,6 @@ static void i8042_controller_reset(void)
 
 
 /*
- * Here we try to reset everything back to a state in which the BIOS will be
- * able to talk to the hardware when rebooting.
- */
-
-static void i8042_controller_cleanup(void)
-{
-	int i;
-
-/*
- * Reset anything that is connected to the ports.
- */
-
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio)
-			serio_cleanup(i8042_ports[i].serio);
-
-	i8042_controller_reset();
-}
-
-
-/*
  * i8042_panic_blink() will flash the keyboard LEDs and is called when
  * kernel panics. Flashing LEDs is useful for users running X who may
  * not see the console and will help distingushing panics from "real"
@@ -858,12 +837,15 @@ static long i8042_panic_blink(long count
 #undef DELAY
 
 /*
- * Here we try to restore the original BIOS settings
+ * Here we try to restore the original BIOS settings. We only want to
+ * do that once, when we really suspend, not when we need to take a
+ * snapshot.
  */
 
 static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
-	i8042_controller_cleanup();
+	if (state.event == PM_EVENT_SUSPEND)
+		i8042_controller_reset();
 
 	return 0;
 }
@@ -919,7 +901,7 @@ static int i8042_resume(struct platform_
 
 static void i8042_shutdown(struct platform_device *dev)
 {
-	i8042_controller_cleanup();
+	i8042_controller_reset();
 }
 
 static int __devinit i8042_create_kbd_port(void)
Index: work/drivers/input/serio/serio.c
===================================================================
--- work.orig/drivers/input/serio/serio.c
+++ work/drivers/input/serio/serio.c
@@ -778,6 +778,19 @@ static int serio_driver_remove(struct de
 	return 0;
 }
 
+static void serio_cleanup(struct serio *serio)
+{
+	if (serio->drv && serio->drv->cleanup)
+		serio->drv->cleanup(serio);
+}
+
+static void serio_shutdown(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	serio_cleanup(serio);
+}
+
 static void serio_attach_driver(struct serio_driver *drv)
 {
 	int error;
@@ -910,6 +923,16 @@ static int serio_uevent(struct device *d
 
 #endif /* CONFIG_HOTPLUG */
 
+static int serio_suspend(struct device *dev, pm_message_t state)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	if (state.event == PM_EVENT_SUSPEND)
+		serio_cleanup(serio);
+
+	return 0;
+}
+
 static int serio_resume(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
@@ -974,6 +997,8 @@ static struct bus_type serio_bus = {
 	.uevent		= serio_uevent,
 	.probe		= serio_driver_probe,
 	.remove		= serio_driver_remove,
+	.shutdown	= serio_shutdown,
+	.suspend	= serio_suspend,
 	.resume		= serio_resume,
 };
 
Index: work/include/linux/serio.h
===================================================================
--- work.orig/include/linux/serio.h
+++ work/include/linux/serio.h
@@ -108,12 +108,6 @@ static inline void serio_drv_write_wakeu
 		serio->drv->write_wakeup(serio);
 }
 
-static inline void serio_cleanup(struct serio *serio)
-{
-	if (serio->drv && serio->drv->cleanup)
-		serio->drv->cleanup(serio);
-}
-
 /*
  * Use the following functions to manipulate serio's per-port
  * driver-specific data.

--Boundary-00=_+eBzFF0Z1+SmCUE--
