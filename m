From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [PATCH] keymap function for quickstart driver
Date: Mon, 19 Mar 2012 09:35:37 +0100
Message-ID: <4F66EFD9.7090408@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:4050 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572Ab2CSIfj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 04:35:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

back again with a patch for the quickstart driver that implements a
keymap for the runtime events that quickstart generates. A custom
keymap can be assigned via a simple udev rule.

Background for this: Fujitsu is going to ship very small systems
with no direct eject button for the optical drive. Instead you have
a hotkey that is recognized by the quickstart driver. This patch now
allows to map the key event (0x1) to the keycode "ejectcd" and then
react to this in your desktop manager software.

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

--- upstream/drivers/staging/quickstart/quickstart.c    2012-03-19 08:2=
5:33.000000000 +0100
+++ new/drivers/staging/quickstart/quickstart.c 2012-03-19 09:03:02.000=
000000 +0100
@@ -216,6 +216,8 @@
 static void quickstart_acpi_notify(acpi_handle handle, u32 event, void=
 *data)
 {
        struct quickstart_acpi *quickstart =3D data;
+        unsigned int key;
+        struct input_keymap_entry ke;

        if (!quickstart)
                return;
@@ -223,9 +225,13 @@
        if (event =3D=3D QUICKSTART_EVENT_WAKE)
                quickstart_data.pressed =3D quickstart->btn;
        else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
-               input_report_key(quickstart_input, quickstart->btn->id,=
 1);
+                ke.flags =3D INPUT_KEYMAP_BY_INDEX;
+                ke.index =3D quickstart->btn->id;
+                quickstart_input->getkeycode(quickstart_input, &ke);
+                key =3D ke.keycode;
+               input_report_key(quickstart_input, key, 1);
                input_sync(quickstart_input);
-               input_report_key(quickstart_input, quickstart->btn->id,=
 0);
+               input_report_key(quickstart_input, key, 0);
                input_sync(quickstart_input);
        }
        return;
@@ -374,8 +380,9 @@
 static int __init quickstart_init_input(void)
 {
        struct quickstart_btn **ptr =3D &quickstart_data.btn_lst;
-       int count;
        int ret;
+        int maxkey =3D 0, id;
+        unsigned int *keymap;

        quickstart_input =3D input_allocate_device();

@@ -386,11 +393,30 @@
        quickstart_input->id.bustype =3D BUS_HOST;

        while (*ptr) {
-               count++;
                set_bit(EV_KEY, quickstart_input->evbit);
                set_bit((*ptr)->id, quickstart_input->keybit);
+                if ((*ptr)->id > maxkey)
+                  maxkey =3D (*ptr)->id;
                ptr =3D &((*ptr)->next);
        }
+
+        /* build a character map that at the moment maps GHID ids to k=
eycodes */
+        /* this map can be replaced from userspace to map the correct =
keycodes */
+        maxkey++;
+        quickstart_input->keycodemax =3D maxkey;
+        quickstart_input->keycodesize =3D sizeof(unsigned int);
+        quickstart_input->keycode =3D
kzalloc(quickstart_input->keycodemax*quickstart_input->keycodesize, GFP=
_KERNEL);
+        if (!quickstart_input->keycode)
+            return -ENOMEM;
+
+        keymap =3D quickstart_input->keycode;
+
+        ptr =3D &quickstart_data.btn_lst;
+        while(*ptr) {
+            id =3D (*ptr)->id;
+            keymap[id] =3D id;
+            ptr =3D &((*ptr)->next);
+        }

        ret =3D input_register_device(quickstart_input);
        if (ret) {



--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

=46ujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
