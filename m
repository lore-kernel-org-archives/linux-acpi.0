From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Wed, 16 Mar 2011 07:32:15 +0100
Message-ID: <201103160732.15488.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D7B32B10200002300029B5E@novprvlin0050.provo.novell.com> <4D7FE4260200002300029D70@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D7FE4260200002300029D70-jb/6P8Q/KsjOKUPnnb0SpZ/xhEQF/MHJojBamW5iJbs@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joey Lee <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Joey Lee,

On Tuesday 15 March 2011 12:11:50 Joey Lee wrote:
> Hi Old=C5=99ich,
>=20
> =E6=96=BC =E4=BA=94=EF=BC=8C2011-03-11 =E6=96=BC 14:45 -0700=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Hi Old=C5=99ich,
> >=20
> > > > > > > > > 1. I have to enable the HW bluetooth switch to get th=
e
> > > > > > > > > bluetooth LED running (USB device appears in lsusb). =
The
> > > > > > > > > acer-bluetooth SW rfkill is unblocked, the SW rfkill =
of
> > > > > > > > > hci0 is blocked.
> > > > > > > >=20
> > > > > > > > Yes, this is also right behavior, because acer-wmi driv=
er
> > > > > > > > will maintain the killswitch status with BIOS.
> > > > > > > >=20
> > > > > > > > > 2. Next I have to unblock SW rfkill on hci0 by a call=
 to
> > > > > > > > > `rfkill unblock <number of hci0>`.
> > > > > > > > > 3. Last I have to enable the HCI by the call to `hcic=
onfig
> > > > > > > > > hci0 up`.
> > > > >=20
> > > > > `rfkill list` shows the following
> > > > >=20
> > > > > 1) Before I enable the SW killswitch:
> > > > >=20
> > > > > 0: acer-wireless: Wireless LAN
> > > > >=20
> > > > >         Soft blocked: no
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 1: acer-bluetooth: Bluetooth
> > > > >=20
> > > > >         Soft blocked: yes
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 2: acer-threeg: Wireless WAN
> > > > >=20
> > > > >         Soft blocked: yes
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 3: phy0: Wireless LAN
> > > > >=20
> > > > >         Soft blocked: no
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 2) After I run `rfkill unblock 1`:
> > > > >=20
> > > > > 0: acer-wireless: Wireless LAN
> > > > >=20
> > > > >         Soft blocked: no
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 1: acer-bluetooth: Bluetooth
> > > > >=20
> > > > >         Soft blocked: no
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 2: acer-threeg: Wireless WAN
> > > > >=20
> > > > >         Soft blocked: yes
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 3: phy0: Wireless LAN
> > > > >=20
> > > > >         Soft blocked: no
> > > > >         Hard blocked: no
> > > > >=20
> > > > > 6: hci0: Bluetooth
> > > > >=20
> > > > >         Soft blocked: yes
> > > > >         Hard blocked: no
> > > > >=20
> > > > > I've repeated it several times, so hci0 has number 6 now.
> > > > >=20
> > > > > Thanks for help,
> > > > > Old=C5=99ich.
> > > >=20
> > > > Thank's for your test result.
> > > > Want to double confirm with you...
> > > > The above result is base on CONFIG_RFKILL_INPUT=3DN ?
> > >=20
> > > No, that was just a formatting problem of a "reply" to a mail. Th=
at
> > > wasn't my reaction, it was just a word from the previous line. I'=
m
> > > still using CONFIG_RFKILL_INPUT=3DY.
> > >=20
> > > Old=C5=99ich.
> >=20
> > That's make sense now!
> >=20
> > Thank's for your bug report, I am tracing and try to find out solut=
ion.
> > Joey Lee
>=20
> After trace rfkill-input stuff, I thought this is rfkill-input's norm=
al
> behavior but not a bug.
>=20
> Unfortunately, I didn't find any workaround way when a driver need to
> call rfkill_init_sw_state, e.g. acer-wmi driver.
>=20
> The rfkill-input will sync the rfkill state to all killswitchs that h=
ave
> the same type. For example, acer-wmi set the initial software switch =
to
> _BLOCK_ when driver initial, then rfkill-input will also set any new
> bluetooth killswitch state to _BLOCK_ .

The rfkill_sync_work syncs with rfkill_global_states, which is set duri=
ng=20
intitialization or by rfkill_switch_all, if I read it correctly. This s=
hould=20
be independent to acer-bluetooth state. The rfkill_global_states[BLUETO=
OTH]=20
should be unblocked initially, I need to verify it.

There is some magic in rfkill/input.c that plays with global states, bu=
t I=20
don't know if or how that one is used in my case.

> Acer's BIOS default setup bluetooth's state is disable when system co=
ld
> boot, and BIOS also can save the connection devices' state when syste=
m
> reboot. Currently, acer-wmi driver have right behavior to sync the st=
ate
> with BIOS.
>
> Face to your situation, my suggestion is:
>=20
> - Use userland application to correct killswitch state.
>   highly suggest You can try urfkill daemon:
> http://www.freedesktop.org/wiki/Software/urfkill or
>   write a startup script to enable bluetooth when system boot.
>=20
> - Disable rfkill-input module if you didn't real use it.
>   The TravelMate 5730G have wifi hotkey that only emit KEY_WLAN, but
>   doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't help you
>   enable bluetooth killswitch.

I didn't have time to look at the problem more deeply to identify who i=
s=20
setting the global state to "blocked" or what really happens. Anyway, I=
 did=20
some testing with pressing the HW bluetooth switch and I saw the follow=
ing=20
immediately _after_ pressing the HW switch to enable bluetooth:

oldium ~ # rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: acer-threeg: Wireless WAN
        Soft blocked: yes
        Hard blocked: no
3: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

I had this output 3 times immediately after each other. I'm using keybo=
ard=20
"up" and "enter" to repeat the last shell command, so this is a relativ=
ely=20
slow operation. So the state when the acer-bluetooth was unblocked stay=
ed for=20
relatively long time before hci0 appeared in rfkill. Afterwards I saw:

oldium ~ # rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: acer-threeg: Wireless WAN
        Soft blocked: yes
        Hard blocked: no
3: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
5: hci0: Bluetooth
        Soft blocked: yes
        Hard blocked: no

So it looks like the hci0 went blocked even when the acer-bluetooth swi=
tch was=20
unblocked. So it looks like the hci0 state is independent on the initia=
l acer-
bluetooth state.

Hopefully I have some time this evening (CET timezone) to add some stac=
k=20
traces and logs to see what really happens on my system.

Cheers,
Old=C5=99ich.

>=20
> Thank's a lot!
> Joey Lee
