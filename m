From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [Patch] Eject button for button driver
Date: Wed, 07 Mar 2012 08:59:23 +0100
Message-ID: <4F57155B.6080401@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:46398 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab2CGIJD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 03:09:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Background: Fujitsu is releasing currently small desktop systems like t=
he
ESPRIMO Q510 that have no direct accessible eject button for the optica=
l drive.

http://www.fujitsu.com/fts/products/computing/pc/desktops/all-round/esp=
rimo-q510/index.html

Instead of an eject button on the drive the system has a button on the
mainboard that will send a notify event to the assigned device using th=
e
following ACPI code:

Scope(\_GPE)
{
        Method(_L15, 0)                                         // ODD =
Eject GPIO handler
        {
                 Notify(\_SB.ODDE, 0x80)                         // Not=
ify a ODD Eject Button event
to the OS
        }
} //Scope(\_GPE)

Scope(\_SB)
{
//
// Direct Application Launch Button definition used for Windows Vista, =
Windows 7, Linux ...
//
        Device(ODDE)                                            // Ejec=
t Button Device
        {
                Name(_HID, EISAID("PNP0C32"))   // HID ACPI button devi=
ce
                Name(_UID, 1)                                   // Uniq=
ue instance # of that device
                Name(_STA, 0x0F)                                // Devi=
ce is working properly

                Method(GHID, 0)                                 // Butt=
on "role" method
                {
                        Return(Buffer(){1})                 // Applicat=
ion Launch Button role
                }
        }

To implement this I modified the button.c driver by adding the eject bu=
tton code.
During testing it came out, that the button is constantly firing GPE15 =
events as
long at is pressed, so I added some code that only handles one event pe=
r second
and drops the other events.

To make the eject function work the user also needs to add a rule to ac=
pid that
triggers the eject command on the eject event.

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

---

--- upstream/drivers/acpi/button.c      2012-03-06 10:12:04.000000000 +=
0100
+++ new/drivers/acpi/button.c   2012-03-06 10:25:23.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>  /* for accepting only on eject event per s=
econd */
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>

@@ -57,6 +58,11 @@
 #define ACPI_BUTTON_DEVICE_NAME_LID    "Lid Switch"
 #define ACPI_BUTTON_TYPE_LID           0x05

+#define ACPI_BUTTON_SUBCLASS_EJECT      "eject"
+#define ACPI_BUTTON_HID_EJECT           "PNP0C32"
+#define ACPI_BUTTON_DEVICE_NAME_EJECT   "Eject Button"
+#define ACPI_BUTTON_TYPE_EJECT          0x07
+
 #define _COMPONENT             ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");

@@ -70,6 +76,7 @@
        {ACPI_BUTTON_HID_SLEEPF, 0},
        {ACPI_BUTTON_HID_POWER,  0},
        {ACPI_BUTTON_HID_POWERF, 0},
+        {ACPI_BUTTON_HID_EJECT,  0},
        {"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
@@ -102,6 +109,8 @@
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;

+static unsigned long eject_expire; /* when do the eject jiffies expire=
? */
+
 /* -------------------------------------------------------------------=
-------
                               FS Interface (/proc)
    -------------------------------------------------------------------=
------- */
@@ -287,6 +296,16 @@
                input =3D button->input;
                if (button->type =3D=3D ACPI_BUTTON_TYPE_LID) {
                        acpi_lid_send_state(device);
+                        acpi_bus_generate_proc_event(device, event, ++=
button->pushed);
+                } else if (button->type =3D=3D ACPI_BUTTON_TYPE_EJECT)=
 {
+                        if (time_is_before_jiffies(eject_expire)) {
+                          eject_expire =3D jiffies+HZ;  /* expire dela=
y 1 second */
+                          input_report_key(input, KEY_EJECTCD, 1);
+                          input_sync(input);
+                          input_report_key(input, KEY_EJECTCD, 0);
+                          input_sync(input);
+                          acpi_bus_generate_proc_event(device, event, =
++button->pushed);
+                  }
                } else {
                        int keycode =3D test_bit(KEY_SLEEP, input->keyb=
it) ?
                                                KEY_SLEEP : KEY_POWER;
@@ -295,11 +314,9 @@
                        input_sync(input);
                        input_report_key(input, keycode, 0);
                        input_sync(input);
-
+                        acpi_bus_generate_proc_event(device, event, ++=
button->pushed);
                        pm_wakeup_event(&device->dev, 0);
                }
-
-               acpi_bus_generate_proc_event(device, event, ++button->p=
ushed);
                break;
        default:
                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -357,6 +374,12 @@
                strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
                sprintf(class, "%s/%s",
                        ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
+        } else if (!strcmp(hid, ACPI_BUTTON_HID_EJECT)) {
+                button->type =3D ACPI_BUTTON_TYPE_EJECT;
+                strcpy(name, ACPI_BUTTON_DEVICE_NAME_EJECT);
+                sprintf(class, "%s/%s",
+                        ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_EJECT)=
;
+                eject_expire =3D jiffies; /* initial value for the eje=
ct delay */
        } else {
                printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
                error =3D -ENODEV;
@@ -390,6 +413,10 @@
                input->evbit[0] =3D BIT_MASK(EV_SW);
                set_bit(SW_LID, input->swbit);
                break;
+        case ACPI_BUTTON_TYPE_EJECT:
+                input->evbit[0] =3D BIT_MASK(EV_KEY);
+                set_bit(KEY_EJECTCD, input->keybit);
+                break;
        }

        error =3D input_register_device(input);

--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. TSP WPS R&D SW OSE

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
