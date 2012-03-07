From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] Eject button handling in quickstart driver
Date: Wed, 7 Mar 2012 15:31:44 +0100
Message-ID: <CAHR064gcPAyHU-Fe81PzB7LthWyMU36ULfaGo2WhffjD2U_TLw@mail.gmail.com>
References: <4F576A87.1080401@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33383 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab2CGObq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Mar 2012 09:31:46 -0500
Received: by bkcik5 with SMTP id ik5so5257503bkc.19
        for <linux-acpi@vger.kernel.org>; Wed, 07 Mar 2012 06:31:45 -0800 (PST)
In-Reply-To: <4F576A87.1080401@ts.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Mar 7, 2012 at 3:02 PM, Rainer Koenig
<Rainer.Koenig@ts.fujitsu.com> wrote:
> Background: Fujitsu is releasing currently small desktop systems like=
 the
> ESPRIMO Q510 that have no direct accessible eject button for the opti=
cal drive.
>
> http://www.fujitsu.com/fts/products/computing/pc/desktops/all-round/e=
sprimo-q510/index.html
>
> Instead of an eject button on the drive the system has a button on th=
e
> mainboard that will send a notify event to the assigned device using =
the
> following ACPI code:
>
> Scope(\_GPE)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Method(_L15, 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // ODD Eject GPIO handler
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Notify(\_SB.O=
DDE, 0x80) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 // Notify a ODD Eject Button event
> to the OS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> } //Scope(\_GPE)
>
> Scope(\_SB)
> {
> //
> // Direct Application Launch Button definition used for Windows Vista=
, Windows 7, Linux ...
> //
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Device(ODDE) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Eject Button Device
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name(_HID, EIS=
AID("PNP0C32")) =C2=A0 // HID ACPI button device
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name(_UID, 1) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Unique instance # of t=
hat device
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name(_STA, 0x0=
=46) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Device is working prope=
rly
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Method(GHID, 0=
) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Button "role" method
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Return(Buffer(){1}) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 // Application Launch Button role
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> Matthew Garrett advised me that there is a quickstart driver in stagi=
ng that
> was designed to handle the PNP0C32 devices. I had a look at it and it=
 needed
> patching for my purpose because
>
> - the driver only reports the pressed button on wakeup events, but in
> =C2=A0my case it should report the pressure of the "Optical Disc Driv=
e Eject"
> =C2=A0button during runtime.
> - The driver was generating character input events when I pressed the=
 button
> =C2=A0during runtime, resulting in the funny question of the bash ope=
n if I want
> =C2=A0to see all possible completions.
>
> So I made a minor change to this driver to handle my "ODDE" button ev=
ent as I want
> it and to be minimal intrusive to the remaining functionality.
>
> Of course this needs a small "daemon like skript" that polls the pres=
sed_button file
> frequently and initiates the eject command if the button is pressed. =
This one
> (modified from the Sourceforge quickstart download) works:
>
> #!/bin/bash
> #
> # Sample application launcher.
> # Angelo Arrifano <miknix@gmail.com>
> # http://quickstart.sourceforge.net
> #
> # Put this script on ~/.config/autostart.
> #
>
> # Add your button actions here
> LAUNCH["ODDE"]=3D"eject /dev/sr0"
>
> # The sysfs file telling which button was pressed
> PRESSEDFILE=3D"/sys/devices/platform/quickstart/pressed_button"
>
> if [[ ! -e "$PRESSEDFILE" ]]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> fi
>
> while (true) do
> PRESSEDBUTTON=3D"$(cat "$PRESSEDFILE")"
> if [[ "$PRESSEDBUTTON" !=3D "none" ]]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0${LAUNCH[$PRESSEDBUTTON]};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo -n "none" > "$PRESSEDFILE"
> fi
> sleep 1;
> done
>
> # End of script
>
> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
>
> ---
>
> --- upstream/drivers/staging/quickstart/quickstart.c =C2=A0 =C2=A0201=
2-03-07 14:32:37.000000000 +0100
> +++ new/drivers/staging/quickstart/quickstart.c 2012-03-07 14:50:36.0=
00000000 +0100
> @@ -223,10 +223,16 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (event =3D=3D QUICKSTART_EVENT_WAKE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0quickstart_dat=
a.pressed =3D quickstart->btn;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (event =3D=3D QUICKSTART_EVENT_RUN=
TIME) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(q=
uickstart_input, quickstart->btn->id, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(quickst=
art_input);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(q=
uickstart_input, quickstart->btn->id, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(quickst=
art_input);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncase=
cmp(quickstart->btn->name, "ODDE", 4) =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* OD=
DE is Optical Disc Drive Eject */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0quick=
start_data.pressed =3D quickstart->btn;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_repor=
t_key(quickstart_input, quickstart->btn->id, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(=
quickstart_input);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_repor=
t_key(quickstart_input, quickstart->btn->id, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(=
quickstart_input);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>

I'm really not sure it's how this driver is supposed to work.
=46rom what I understand, it reads a keymap from ACPI, associate button
strings to ids, and when a button is pressed, send the button id using
an input device.
Currently raw id are sent to the input device. I think it may be a
good idea to send "real" keycodes like KEY_EJECTCD for well known keys
(using a kind of keymap).


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
