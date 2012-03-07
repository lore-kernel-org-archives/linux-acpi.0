From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [PATCH] Eject button handling in quickstart driver
Date: Wed, 07 Mar 2012 15:02:47 +0100
Message-ID: <4F576A87.1080401@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:13772 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab2CGOCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 09:02:49 -0500
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

Matthew Garrett advised me that there is a quickstart driver in staging=
 that
was designed to handle the PNP0C32 devices. I had a look at it and it n=
eeded
patching for my purpose because

- the driver only reports the pressed button on wakeup events, but in
  my case it should report the pressure of the "Optical Disc Drive Ejec=
t"
  button during runtime.
- The driver was generating character input events when I pressed the b=
utton
  during runtime, resulting in the funny question of the bash open if I=
 want
  to see all possible completions.

So I made a minor change to this driver to handle my "ODDE" button even=
t as I want
it and to be minimal intrusive to the remaining functionality.

Of course this needs a small "daemon like skript" that polls the presse=
d_button file
frequently and initiates the eject command if the button is pressed. Th=
is one
(modified from the Sourceforge quickstart download) works:

#!/bin/bash
#
# Sample application launcher.
# Angelo Arrifano <miknix@gmail.com>
# http://quickstart.sourceforge.net
#
# Put this script on ~/.config/autostart.
#

# Add your button actions here
LAUNCH["ODDE"]=3D"eject /dev/sr0"

# The sysfs file telling which button was pressed
PRESSEDFILE=3D"/sys/devices/platform/quickstart/pressed_button"

if [[ ! -e "$PRESSEDFILE" ]]; then
        exit 1
fi

while (true) do
PRESSEDBUTTON=3D"$(cat "$PRESSEDFILE")"
if [[ "$PRESSEDBUTTON" !=3D "none" ]]; then
        ${LAUNCH[$PRESSEDBUTTON]};
        echo -n "none" > "$PRESSEDFILE"
fi
sleep 1;
done

# End of script

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

---

--- upstream/drivers/staging/quickstart/quickstart.c    2012-03-07 14:3=
2:37.000000000 +0100
+++ new/drivers/staging/quickstart/quickstart.c 2012-03-07 14:50:36.000=
000000 +0100
@@ -223,10 +223,16 @@
        if (event =3D=3D QUICKSTART_EVENT_WAKE)
                quickstart_data.pressed =3D quickstart->btn;
        else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
-               input_report_key(quickstart_input, quickstart->btn->id,=
 1);
-               input_sync(quickstart_input);
-               input_report_key(quickstart_input, quickstart->btn->id,=
 0);
-               input_sync(quickstart_input);
+                if (strncasecmp(quickstart->btn->name, "ODDE", 4) =3D=3D=
 0) {
+                  /* ODDE is Optical Disc Drive Eject */
+                  quickstart_data.pressed =3D quickstart->btn;
+                }
+                else {
+                 input_report_key(quickstart_input, quickstart->btn->i=
d, 1);
+                 input_sync(quickstart_input);
+                 input_report_key(quickstart_input, quickstart->btn->i=
d, 0);
+                 input_sync(quickstart_input);
+                }
        }
        return;
 }


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
