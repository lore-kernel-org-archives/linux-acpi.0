From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 10 Mar 2011 15:02:27 -0700
Message-ID: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: Joey Lee <JLee@novell.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-10 =E6=96=BC 19:37 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi all,
>=20
> This is about Acer WMI driver and bluetooth support. I hope I'm at th=
e right=20
> place with my question :-)
>=20
> I tried to use bluetooth again on my Acer TravelMate 5730G and discov=
ered a=20
> usability problem. I've checked 2.6.38-rc7:
>=20
> 0. On startup, the bluetooth LED is off, acer-bluetooth SW rfkill is =
blocked.

Yes, this is right behavior.

Because have a acer-wmi patch in 2.6.38 to sync the connection devices
(wlan, bluetooth, 3G) status with BIOS.
Acer BIOS fills-in the device initial states in SMBIOS when system boot=
,
then acer-wmi dirver sync this states with killswitch. By default, Acer
BIOS set the bluetooth to off.

> 1. I have to enable the HW bluetooth switch to get the bluetooth LED =
running=20
> (USB device appears in lsusb). The acer-bluetooth SW rfkill is unbloc=
ked, the=20
> SW rfkill of hci0 is blocked.

Yes, this is also right behavior, because acer-wmi driver will maintain
the killswitch status with BIOS.

> 2. Next I have to unblock SW rfkill on hci0 by a call to `rfkill unbl=
ock=20
> <number of hci0>`.
> 3. Last I have to enable the HCI by the call to `hciconfig hci0 up`.
>=20

About 2. - 3.
I thought the above behavior causes by rfkill-input reverse the hci0's
killswitch when you pressed HW bluetooth, the HW bluetooth send out a
KEY_BLUETHOOTH keycode then rfkill-input capture it to do hci0's status
reverse.
I suggest leave userland application to do killswitch, don't use
rfkill-input.

You can do:
	- Use rfkill unblock acer-bluetooth SW killswitch, don't use HW blueto=
oth switch.
	- If you still want to use HW bluetooth switch, then I suggest disable=
 your rfkill-input.
	  Have 2 way:
		+ Use urfkill daemon: http://www.freedesktop.org/wiki/Software/urfkil=
l
		  This is a userland daemon can lock the rfkill-input to disable it t=
emporarily.
		+ Direct set CONFIG_RFKILL_INPUT=3DN in kernel, but you will need to =
rebuild kernel.
		  After set rfkill-input disable, you need control killswitch from us=
erland.
		  You can control it by rfkill tool or also try urfkill daemon.

We are adding more feature in urfkill daemon, I and Gary's plan is use =
urfkill daemon to replace
the rfkill-input in kernel.

> How is this supposed to work? I tried to use "rfkill.default_state=3D=
1" on=20
> kernel command line, but without any success.
>=20

Yes, rfkill default_state doesn't help, because acer-wmi driver will
sync the devices status from BIOS, it's right behavior.

> When I boot into 2.6.37, the bluetooth LED goes ON automatically and =
hciconfig=20
> shows the hci0 as UP.
>=20

Yes, that because acer-wmi didn't sync the bluetooth status with BIOS
when system boot in 2.6.37 kernel.

> Thanks.
>=20
> Best regards,
> Old=C5=99ich.


Thank's
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
