From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Sun, 25 Jan 2004 12:59:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040125115946.GA414@ucw.cz>
References: <200401251137.21646.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200401251137.21646.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 25, 2004 at 11:37:19AM +0200, P. Christeas wrote:

> This may be just a minor issue:
> I had to use the setkeycodes utility to enable some extra keys (that weren't 
> mapped by kernel's atkbd tables).
> After waking from sleep 1, those keys were reset. That is, I had to use 
> 'setkeycodes' again to customize the tables again.
> 
> IMHO the way kernel works now is correct. It should *not* have extra code just 
> to handle that. Just make sure anybody that alters his kbd tables puts some 
> extra script to recover the tables after an ACPI wake.
> This should be more like a note to Linux distributors.
> 
> Have a nice day.

Patch attached, please test. It'll make it into 2.6.3, with some luck
even 2.6.2.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=atkbd-noreinit

ChangeSet-SdAw1wE8/5A@public.gmane.org, 2004-01-25 12:58:24+01:00, vojtech@ucw.cz
  input: Bail out in atkbd.c if scancode set is changed, don't
         reinitialize scancode map. This is even more anoying than
         a new keyboard device in the unlikely case of set change.


 atkbd.c |   37 ++++++-------------------------------
 1 files changed, 6 insertions(+), 31 deletions(-)


diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sun Jan 25 12:59:07 2004
+++ b/drivers/input/keyboard/atkbd.c	Sun Jan 25 12:59:07 2004
@@ -743,43 +743,18 @@
 	struct serio_dev *dev = serio->dev;
 	int i;
 
-        if (!dev) {
-                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
-                return -1;
-        }
+	if (!dev) {
+		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
+		return -1;
+	}
 
 	if (atkbd->write) {
 		if (atkbd_probe(atkbd))
 			return -1;
-
-		atkbd->set = atkbd_set_3(atkbd);
+		if (atkbd->set != atkbd_set_3(atkbd))
+			return -1;
 		atkbd_enable(atkbd);
-	} else {
-		atkbd->set = 2;
-		atkbd->id = 0xab00;
 	}
-
-	/*
-	 * Here we probably should check if the keyboard has the same set that
-         * it had before and bail out if it's different. But this will most likely
-         * cause new keyboard device be created... and for the user it will look
-         * like keyboard is lost
-	 */
-
-	if (atkbd->translated) {
-		for (i = 0; i < 128; i++) {
-			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
-			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
-		}
-	} else if (atkbd->set == 2) {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	} else {
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	}
-
-	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
 
 	return 0;
 }

--ikeVEW9yuYc//A+q--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
