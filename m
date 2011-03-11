From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Fri, 11 Mar 2011 14:25:37 -0700
Message-ID: <4D7B2E010200002300029B57@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103112121.20076.oldium.pro@seznam.cz>
 <4D7B22000200002300029B4C@novprvlin0050.provo.novell.com>
 <201103112154.09729.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201103112154.09729.oldium.pro@seznam.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: Al Cho <ACho@novell.com>, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Old=C5=99ich,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 21:54 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi again,
>=20
> On Friday 11 March 2011 21:34:24 Joey Lee wrote:
> > =E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 21:21 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Joey Lee,
> > >=20
> > > On Thursday 10 March 2011 23:02:27 Joey Lee wrote:
> > > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-10 =E6=96=BC 19:37 +0100=EF=
=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > This is about Acer WMI driver and bluetooth support. I hope I=
'm at
> > > > > the right place with my question :-)
> > > > >=20
> > > > > I tried to use bluetooth again on my Acer TravelMate 5730G an=
d
> > > > > discovered a usability problem. I've checked 2.6.38-rc7:
> > > > >=20
> > > > > 0. On startup, the bluetooth LED is off, acer-bluetooth SW rf=
kill is
> > > > > blocked.
> > > >=20
> > > > Yes, this is right behavior.
> > > >=20
> > > > Because have a acer-wmi patch in 2.6.38 to sync the connection =
devices
> > > > (wlan, bluetooth, 3G) status with BIOS.
> > > > Acer BIOS fills-in the device initial states in SMBIOS when sys=
tem
> > > > boot, then acer-wmi dirver sync this states with killswitch. By
> > > > default, Acer BIOS set the bluetooth to off.
> > > >=20
> > > > > 1. I have to enable the HW bluetooth switch to get the blueto=
oth LED
> > > > > running (USB device appears in lsusb). The acer-bluetooth SW =
rfkill
> > > > > is unblocked, the SW rfkill of hci0 is blocked.
> > > >=20
> > > > Yes, this is also right behavior, because acer-wmi driver will =
maintain
> > > > the killswitch status with BIOS.
> > > >=20
> > > > > 2. Next I have to unblock SW rfkill on hci0 by a call to `rfk=
ill
> > > > > unblock <number of hci0>`.
> > > > > 3. Last I have to enable the HCI by the call to `hciconfig hc=
i0 up`.
> > > >=20
> > > > About 2. - 3.
> > > > I thought the above behavior causes by rfkill-input reverse the=
 hci0's
> > > > killswitch when you pressed HW bluetooth, the HW bluetooth send=
 out a
> > > > KEY_BLUETHOOTH keycode then rfkill-input capture it to do hci0'=
s status
> > > > reverse.
> > > > I suggest leave userland application to do killswitch, don't us=
e
> > > > rfkill-input.
> > > >=20
> > > > You can do:
> > > > 	- Use rfkill unblock acer-bluetooth SW killswitch, don't use H=
W
> > > > 	bluetooth
> > > >=20
> > > > switch. - If you still want to use HW bluetooth switch, then I =
suggest
> > > >=20
> > > > disable your rfkill-input. Have 2 way:
> > > > 		+ Use urfkill daemon:
> > > http://www.freedesktop.org/wiki/Software/urfkill
> > >=20
> > > > 		  This is a userland daemon can lock the rfkill-input to=20
> disable it

Did you mean you direct set CONFIG_RFKILL_INPUT=3DN in kernel and rebui=
ld
kernel? or you used userland app like urfkill to send out ioctl to
disable rfkill-input?

> > > >=20
> > > > temporarily. + Direct set CONFIG_RFKILL_INPUT=3DN in kernel, bu=
t you will
> > > > need to rebuild kernel. After set rfkill-input disable, you nee=
d
> > > > control killswitch from userland. You can control it by rfkill =
tool or
> > > > also try urfkill daemon.
> > >=20
> > > Actually this doesn't work. When I unblock the SW switch by
> > > calling `rfkill unblock <number of acer-bluetooth>`, it unblocks =
the SW
> > > killswitch, the bluetooth LED goes up, the hci0 shows-up (USB dev=
ice and
> > > killswitch), but initial state of hci0's killswitch is "blocked".=
 So I
> > > still need to unblock it manually. I would preffer to don't be fo=
rced to
> > > do step 2, also for the HW switch (which should do the same job I
> > > think).
> > >=20
> > > Cheers,
> > > Old=C5=99ich.
> >=20
> > That's weird!
> > Because acer-wmi driver only maintain the killswitch on by itself a=
nd
> > will not touch hci driver's killswitch. I don't know why hci's
> > killswitch initial state is 0, need to check hci driver and rfkill
> > staff.
> >=20
> > Could you please share your bluetooth device to us?
> > Please send out "lsusb" result when bluetooth device available.
>=20
> Bus 008 Device 002: ID 0a5c:2101 Broadcom Corp. Bluetooth Controller
>=20
> dmesg shows the following:
>=20
> [ 2422.322067] usb 8-2: new full speed USB device using uhci_hcd and =
address 3
> [ 2422.528212] usb 8-2: New USB device found, idVendor=3D0a5c, idProd=
uct=3D2101
> [ 2422.528223] usb 8-2: New USB device strings: Mfr=3D1, Product=3D2,=
=20
> SerialNumber=3D0
> [ 2422.528231] usb 8-2: Product: Acer Module
> [ 2422.528238] usb 8-2: Manufacturer: Broadcom Corp
>=20
> `rfkill list` shows the following
>=20
> 1) Before I enable the SW killswitch:
>=20
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: acer-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> 2: acer-threeg: Wireless WAN
>         Soft blocked: yes
>         Hard blocked: no
> 3: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
>=20
> 2) After I run `rfkill unblock 1`:
>=20
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: acer-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 2: acer-threeg: Wireless WAN
>         Soft blocked: yes
>         Hard blocked: no
> 3: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 6: hci0: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
>=20
> I've repeated it several times, so hci0 has number 6 now.
>=20
> Thanks for help,
> Old=C5=99ich.

Thank's for your test result.
Want to double confirm with you...
The above result is base on CONFIG_RFKILL_INPUT=3DN ?

I just simply check the rfkill stuff,
I found when CONFIG_RFKILL_INPUT set to enable and there have any drive=
r
call rfkill_init_sw_state before register rfkill object, then rfkill
will sync this state to all killswitch that have the same type and also
will set the same initial state to new killswitch have the same type.

Looks like rfkill will sync the state for the same type killswitch if
used rfkill_init_sw_state, I will do more detail debug and trace for
rfkill stuff, then find out solution.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
