From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH 10/10] thinkpad-acpi: sync input
 device EV_SW state directly
Date: Wed, 9 Dec 2009 18:32:01 -0200
Message-ID: <20091209203201.GC29575@khazad-dum.debian.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
 <1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
 <200912081745.14725.dmitry.torokhov@gmail.com>
 <20091209163041.GA29575@khazad-dum.debian.net>
 <20091209172119.GB4456@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39929 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050AbZLIUb6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 15:31:58 -0500
Content-Disposition: inline
In-Reply-To: <20091209172119.GB4456@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Len Brown <lenb@kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ibm-acpi-devel@lists.sourceforge.net

On Wed, 09 Dec 2009, Dmitry Torokhov wrote:
> > input_report_switch() will call input_event(), which will have a 50% chance
> > of doing the wrong thing at startup (i.e. issue an event) since it will look
> > at the state of the sw bitmap to decide whether to issue an event or not.
> > 
> 
> It will not propagate events because until you register the device there
> won't be any consumers attached to it. So the only thing that will
> happen is that it will sync internal state of the device from input core
> point of view with the true state of the hardware.

Ah, I see.  Cute trick, and yes, that would work just fine.  I will do that,
it certainly beats accessing the sw bitmap directly.

Is it documented anywhere?

Still, please look at the patch below...  Would something like this be a
cleaner API?  It is certainly more obvious, and it is cleaner on the driver
side (one function call does everything, instead of a call to
input_set_capability plus a call to whatever the driver needs to issue the
initial EV_SW event)...

I left the thinkpad-acpi hunk in it to show how it makes things easier for
the driver.

Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sun Dec 6 14:04:30 2009 -0200

    input: add API to set initial EV_SW state
    
    Add an API for input drivers to init EV_SW switches.
    
    Change the thinkpad-acpi driver to use the new API.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: Dmitry Torokhov <dtor@mail.ru>

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 7c237e6..4fcb362 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1388,6 +1388,33 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
 EXPORT_SYMBOL(input_set_capability);
 
 /**
+ * input_init_switch - prepare device to handle a certain EV_SW event
+ * @dev: device that is capable of issuing the EV_SW event
+ * @code: event code
+ * @state: initial state for the switch
+ *
+ * This function sets the corresponding bits in the capability bitmap,
+ * switch capability bitmap, and switch state bitmap.
+ */
+void input_init_switch(struct input_dev *dev, unsigned int code, bool state)
+{
+	if (code > SW_MAX) {
+		printk(KERN_ERR
+			"input_init_switch: unknown code %u\n",
+			code);
+		dump_stack();
+		return;
+	}
+
+	input_set_capability(dev, EV_SW, code);
+	if (state)
+		__set_bit(code, dev->sw);
+	else
+		__clear_bit(code, dev->sw);
+}
+EXPORT_SYMBOL(input_init_switch);
+
+/**
  * input_register_device - register device with input core
  * @dev: device to be registered
  *
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a63ceb1..efa6830 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3365,16 +3365,12 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		}
 	}
 
-	if (tp_features.hotkey_wlsw) {
-		input_set_capability(tpacpi_inputdev, EV_SW, SW_RFKILL_ALL);
-		if (radiosw_state)
-			__set_bit(SW_RFKILL_ALL, tpacpi_inputdev->sw);
-	}
-	if (tp_features.hotkey_tablet) {
-		input_set_capability(tpacpi_inputdev, EV_SW, SW_TABLET_MODE);
-		if (tabletsw_state)
-			__set_bit(SW_TABLET_MODE, tpacpi_inputdev->sw);
-	}
+	if (tp_features.hotkey_wlsw)
+		input_init_switch(tpacpi_inputdev,
+				  SW_RFKILL_ALL, radiosw_state);
+	if (tp_features.hotkey_tablet)
+		input_init_switch(tpacpi_inputdev,
+				  SW_TABLET_MODE, tabletsw_state);
 
 	/* Do not issue duplicate brightness change events to
 	 * userspace */
diff --git a/include/linux/input.h b/include/linux/input.h
index 8b3bc3e..40ecd48 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1353,6 +1353,8 @@ static inline void input_set_abs_params(struct input_dev *dev, int axis, int min
 int input_get_keycode(struct input_dev *dev, int scancode, int *keycode);
 int input_set_keycode(struct input_dev *dev, int scancode, int keycode);
 
+void input_init_switch(struct input_dev *dev, unsigned int code, bool state);
+
 extern struct class input_class;
 
 /**


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
