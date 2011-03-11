From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Fri, 11 Mar 2011 21:21:19 +0100
Message-ID: <201103112121.20076.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Joey Lee,

On Thursday 10 March 2011 23:02:27 Joey Lee wrote:
> =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-10 =E6=96=BC 19:37 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Hi all,
> >=20
> > This is about Acer WMI driver and bluetooth support. I hope I'm at =
the
> > right place with my question :-)
> >=20
> > I tried to use bluetooth again on my Acer TravelMate 5730G and disc=
overed
> > a usability problem. I've checked 2.6.38-rc7:
> >=20
> > 0. On startup, the bluetooth LED is off, acer-bluetooth SW rfkill i=
s
> > blocked.
>=20
> Yes, this is right behavior.
>=20
> Because have a acer-wmi patch in 2.6.38 to sync the connection device=
s
> (wlan, bluetooth, 3G) status with BIOS.
> Acer BIOS fills-in the device initial states in SMBIOS when system bo=
ot,
> then acer-wmi dirver sync this states with killswitch. By default, Ac=
er
> BIOS set the bluetooth to off.
>=20
> > 1. I have to enable the HW bluetooth switch to get the bluetooth LE=
D
> > running (USB device appears in lsusb). The acer-bluetooth SW rfkill=
 is
> > unblocked, the SW rfkill of hci0 is blocked.
>=20
> Yes, this is also right behavior, because acer-wmi driver will mainta=
in
> the killswitch status with BIOS.
>=20
> > 2. Next I have to unblock SW rfkill on hci0 by a call to `rfkill un=
block
> > <number of hci0>`.
> > 3. Last I have to enable the HCI by the call to `hciconfig hci0 up`=
=2E
>=20
> About 2. - 3.
> I thought the above behavior causes by rfkill-input reverse the hci0'=
s
> killswitch when you pressed HW bluetooth, the HW bluetooth send out a
> KEY_BLUETHOOTH keycode then rfkill-input capture it to do hci0's stat=
us
> reverse.
> I suggest leave userland application to do killswitch, don't use
> rfkill-input.
>=20
> You can do:
> 	- Use rfkill unblock acer-bluetooth SW killswitch, don't use HW blue=
tooth
> switch. - If you still want to use HW bluetooth switch, then I sugges=
t
> disable your rfkill-input. Have 2 way:
> 		+ Use urfkill daemon:=20
http://www.freedesktop.org/wiki/Software/urfkill
> 		  This is a userland daemon can lock the rfkill-input to disable it
> temporarily. + Direct set CONFIG_RFKILL_INPUT=3DN in kernel, but you =
will
> need to rebuild kernel. After set rfkill-input disable, you need cont=
rol
> killswitch from userland. You can control it by rfkill tool or also t=
ry
> urfkill daemon.

Actually this doesn't work. When I unblock the SW switch by=20
calling `rfkill unblock <number of acer-bluetooth>`, it unblocks the SW=
=20
killswitch, the bluetooth LED goes up, the hci0 shows-up (USB device an=
d=20
killswitch), but initial state of hci0's killswitch is "blocked". So I =
still=20
need to unblock it manually. I would preffer to don't be forced to do s=
tep 2,=20
also for the HW switch (which should do the same job I think).

Cheers,
Old=C5=99ich.

>=20
> We are adding more feature in urfkill daemon, I and Gary's plan is us=
e
> urfkill daemon to replace the rfkill-input in kernel.
>=20
> > How is this supposed to work? I tried to use "rfkill.default_state=3D=
1" on
> > kernel command line, but without any success.
>=20
> Yes, rfkill default_state doesn't help, because acer-wmi driver will
> sync the devices status from BIOS, it's right behavior.
>=20
> > When I boot into 2.6.37, the bluetooth LED goes ON automatically an=
d
> > hciconfig shows the hci0 as UP.
>=20
> Yes, that because acer-wmi didn't sync the bluetooth status with BIOS
> when system boot in 2.6.37 kernel.
>=20
> > Thanks.
> >=20
> > Best regards,
> > Old=C5=99ich.
>=20
> Thank's
> Joey Lee
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
