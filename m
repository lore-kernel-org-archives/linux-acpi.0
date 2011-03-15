From: "Joey Lee" <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Tue, 15 Mar 2011 05:11:50 -0600
Message-ID: <4D7FE4260200002300029D70@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103112154.09729.oldium.pro@seznam.cz>
 <4D7B2E010200002300029B57@novprvlin0050.provo.novell.com>
 <201103112234.42885.oldium.pro@seznam.cz>
 <4D7B32B10200002300029B5E@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D7B32B10200002300029B5E-jb/6P8Q/KsjOKUPnnb0SpZ/xhEQF/MHJojBamW5iJbs@public.gmane.org>
Content-Disposition: inline
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Old=C5=99ich,

=E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 14:45 -0700=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Old=C5=99ich,
> > > > > > >=20
> > > > > > > > 1. I have to enable the HW bluetooth switch to get the =
bluetooth
> > > > > > > > LED running (USB device appears in lsusb). The acer-blu=
etooth SW
> > > > > > > > rfkill is unblocked, the SW rfkill of hci0 is blocked.
> > > > > > >=20
> > > > > > > Yes, this is also right behavior, because acer-wmi driver=
 will
> > > > > > > maintain the killswitch status with BIOS.
> > > > > > >=20
> > > > > > > > 2. Next I have to unblock SW rfkill on hci0 by a call t=
o `rfkill
> > > > > > > > unblock <number of hci0>`.
> > > > > > > > 3. Last I have to enable the HCI by the call to `hcicon=
fig hci0
> > > > > > > > up`.
> > > > >
> > > > `rfkill list` shows the following
> > > >=20
> > > > 1) Before I enable the SW killswitch:
> > > >=20
> > > > 0: acer-wireless: Wireless LAN
> > > >=20
> > > >         Soft blocked: no
> > > >         Hard blocked: no
> > > >=20
> > > > 1: acer-bluetooth: Bluetooth
> > > >=20
> > > >         Soft blocked: yes
> > > >         Hard blocked: no
> > > >=20
> > > > 2: acer-threeg: Wireless WAN
> > > >=20
> > > >         Soft blocked: yes
> > > >         Hard blocked: no
> > > >=20
> > > > 3: phy0: Wireless LAN
> > > >=20
> > > >         Soft blocked: no
> > > >         Hard blocked: no
> > > >=20
> > > > 2) After I run `rfkill unblock 1`:
> > > >=20
> > > > 0: acer-wireless: Wireless LAN
> > > >=20
> > > >         Soft blocked: no
> > > >         Hard blocked: no
> > > >=20
> > > > 1: acer-bluetooth: Bluetooth
> > > >=20
> > > >         Soft blocked: no
> > > >         Hard blocked: no
> > > >=20
> > > > 2: acer-threeg: Wireless WAN
> > > >=20
> > > >         Soft blocked: yes
> > > >         Hard blocked: no
> > > >=20
> > > > 3: phy0: Wireless LAN
> > > >=20
> > > >         Soft blocked: no
> > > >         Hard blocked: no
> > > >=20
> > > > 6: hci0: Bluetooth
> > > >=20
> > > >         Soft blocked: yes
> > > >         Hard blocked: no
> > > >=20
> > > > I've repeated it several times, so hci0 has number 6 now.
> > > >=20
> > > > Thanks for help,
> > > > Old=C5=99ich.
> > >=20
> > > Thank's for your test result.
> > > Want to double confirm with you...
> > > The above result is base on CONFIG_RFKILL_INPUT=3DN ?
> >=20
> > No, that was just a formatting problem of a "reply" to a mail. That=
 wasn't my=20
> > reaction, it was just a word from the previous line. I'm still usin=
g=20
> > CONFIG_RFKILL_INPUT=3DY.
> >=20
> > Old=C5=99ich.
> >=20
>=20
> That's make sense now!
>=20
> Thank's for your bug report, I am tracing and try to find out solutio=
n.
> Joey Lee
>=20


After trace rfkill-input stuff, I thought this is rfkill-input's normal
behavior but not a bug.

Unfortunately, I didn't find any workaround way when a driver need to
call rfkill_init_sw_state, e.g. acer-wmi driver.

The rfkill-input will sync the rfkill state to all killswitchs that hav=
e
the same type. For example, acer-wmi set the initial software switch to
_BLOCK_ when driver initial, then rfkill-input will also set any new
bluetooth killswitch state to _BLOCK_ .

Acer's BIOS default setup bluetooth's state is disable when system cold
boot, and BIOS also can save the connection devices' state when system
reboot. Currently, acer-wmi driver have right behavior to sync the stat=
e
with BIOS.

=46ace to your situation, my suggestion is:=20

- Use userland application to correct killswitch state.
  highly suggest You can try urfkill daemon: http://www.freedesktop.org=
/wiki/Software/urfkill
  or
  write a startup script to enable bluetooth when system boot.

- Disable rfkill-input module if you didn't real use it.
  The TravelMate 5730G have wifi hotkey that only emit KEY_WLAN, but=20
  doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't help you=20
  enable bluetooth killswitch.


Thank's a lot!
Joey Lee
