From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Sun, 20 Mar 2011 21:09:52 +0100
Message-ID: <201103202109.53484.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <201103160732.15488.oldium.pro@seznam.cz> <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: Al Cho <ACho@novell.com>, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Joey Lee,

=46inally I've got little time to expriment.

On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> Hi Old=C5=99ich,
>=20
> =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > > After trace rfkill-input stuff, I thought this is rfkill-input's =
normal
> > > behavior but not a bug.
> > >=20
> > > Unfortunately, I didn't find any workaround way when a driver nee=
d to
> > > call rfkill_init_sw_state, e.g. acer-wmi driver.
> > >=20
> > > The rfkill-input will sync the rfkill state to all killswitchs th=
at
> > > have the same type. For example, acer-wmi set the initial softwar=
e
> > > switch to _BLOCK_ when driver initial, then rfkill-input will als=
o set
> > > any new bluetooth killswitch state to _BLOCK_ .
> >=20
> > The rfkill_sync_work syncs with rfkill_global_states, which is set =
during
> > intitialization or by rfkill_switch_all, if I read it correctly. Th=
is
> > should be independent to acer-bluetooth state. The
> > rfkill_global_states[BLUETOOTH] should be unblocked initially, I ne=
ed to
> > verify it.
>=20
> Yes!
> Ideally, killswitch state should be independent to different driver,
> even the killswitch type is the same.
>=20
> But,
> If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will replica=
te
> state for each killswitch that have the same type:
>=20
> vi net/rfkill/core.c
>=20
> int __must_check rfkill_register(struct rfkill *rfkill)
> {
> ...
>         if (!rfkill->persistent || rfkill_epo_lock_active) {
>                 schedule_work(&rfkill->sync_work);
>         } else {		/* if rfkill->persistent then set the state to all=20
the
> same type */ #ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL_INPUT =3D=
 Y */
>                 bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK=
_SW);
>=20
>                 if (!atomic_read(&rfkill_input_disabled))
>                         __rfkill_switch_all(rfkill->type, soft_blocke=
d);	/*
> here call switch all to sync state */ #endif
>         }
>=20
> When any driver call rfkill_init_sw_state for set the initial state t=
o
> killswitch, this rfkill->persistent will set to true:
>=20
> void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)	/* ace=
r-
wmi
> driver used it to set inital killswitch state */ {
> ....
>         spin_lock_irqsave(&rfkill->lock, flags);
>         __rfkill_set_sw_state(rfkill, blocked);
>         rfkill->persistent =3D true			/* persistent set to true */
>=20
>=20
> That's why acer-wmi bluetooth killswitch's state was been replicate t=
o
> hci_core's killswitch state.
>=20
> When CONFIG_RFKILL_INPUT set to Y, and any driver call
> rfkill_init_sw_state before register rfkill, then rfkill_register wil=
l
> try to sync state to the same killswitch type like the above.
>=20
> It's make sense,
> because rfkill-input only can block/unblock the same killswitch type =
at
> the same time, before rfkill-input active, it want all the same type'=
s
> state is full the same.
>=20
> And,
> rfkill-input also suppose user only can use keycode (maybe Fn key) to
> control killswitch state, so, direct use rkill tool or echo state to
> killswitch for change the state will cause killswitchs' state lost li=
nk.
> It like we do.
>=20
> > There is some magic in rfkill/input.c that plays with global states=
, but
> > I don't know if or how that one is used in my case.
>=20
> Suggest you can disable CONFIG_RFKILL_INPUT or markup the following
> code. You will see the new bluetooth killswitch will be unblock when =
it
> created.
>=20
> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> index 0198191..0dec078 100644
> --- a/net/rfkill/core.c
> +++ b/net/rfkill/core.c
> @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct rfkill
> *rfkill)
>=20
>         if (!rfkill->persistent || rfkill_epo_lock_active) {
>                 schedule_work(&rfkill->sync_work);
> -       } else {
> -#ifdef CONFIG_RFKILL_INPUT
> -               bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK=
_SW);
> -
> -               if (!atomic_read(&rfkill_input_disabled))
> -                       __rfkill_switch_all(rfkill->type, soft_blocke=
d);
> -#endif
> -       }
> +       } //else {
> +//#ifdef CONFIG_RFKILL_INPUT
> +//             bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK=
_SW);
> +//
> +//             if (!atomic_read(&rfkill_input_disabled))
> +//                     __rfkill_switch_all(rfkill->type, soft_blocke=
d);
> +//#endif
> +//     }
>=20
>         rfkill_send_events(rfkill, RFKILL_OP_ADD);

Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second I've =
tried to=20
enable CONFIG_RFKILL_INPUT, but remove the mentioned block of code. The=
 result=20
is working bluetooth HW switch.

> > > Acer's BIOS default setup bluetooth's state is disable when syste=
m cold
> > > boot, and BIOS also can save the connection devices' state when s=
ystem
> > > reboot. Currently, acer-wmi driver have right behavior to sync th=
e
> > > state with BIOS.
> > >=20
> > > Face to your situation, my suggestion is:
> > >=20
> > > - Use userland application to correct killswitch state.
> > >=20
> > >   highly suggest You can try urfkill daemon:
> > > http://www.freedesktop.org/wiki/Software/urfkill or
> > >=20
> > >   write a startup script to enable bluetooth when system boot.
> > >=20
> > > - Disable rfkill-input module if you didn't real use it.
> > >=20
> > >   The TravelMate 5730G have wifi hotkey that only emit KEY_WLAN, =
but
> > >   doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't help=
 you
> > >   enable bluetooth killswitch.
> >=20
> > I didn't have time to look at the problem more deeply to identify w=
ho is
> > setting the global state to "blocked" or what really happens. Anywa=
y, I
> > did some testing with pressing the HW bluetooth switch and I saw th=
e
> > following immediately _after_ pressing the HW switch to enable
> > bluetooth:
> >=20
> > oldium ~ # rfkill list
> > 0: acer-wireless: Wireless LAN
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > 1: acer-bluetooth: Bluetooth
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > 2: acer-threeg: Wireless WAN
> >=20
> >         Soft blocked: yes
> >         Hard blocked: no
> >=20
> > 3: phy0: Wireless LAN
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > I had this output 3 times immediately after each other. I'm using
> > keyboard "up" and "enter" to repeat the last shell command, so this=
 is a
> > relatively slow operation. So the state when the acer-bluetooth was
> > unblocked stayed for relatively long time before hci0 appeared in
> > rfkill. Afterwards I saw:
> >=20
> > oldium ~ # rfkill list
> > 0: acer-wireless: Wireless LAN
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > 1: acer-bluetooth: Bluetooth
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > 2: acer-threeg: Wireless WAN
> >=20
> >         Soft blocked: yes
> >         Hard blocked: no
> >=20
> > 3: phy0: Wireless LAN
> >=20
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > 5: hci0: Bluetooth
> >=20
> >         Soft blocked: yes
> >         Hard blocked: no
>=20
> My Acer machine have no HW bluetooth key but only have one HW WLAN ke=
y
> that emit KEY_WLAN.
> Please use lshal to monitor your HW bluetooth key and make sure it em=
it
> KEY_BLUETOOTH.

`lshal -m` outputs this:

<bluetooth key pressed>
20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input condition=20
ButtonPressed =3D bluetooth
20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth propert=
y=20
killswitch.state =3D 1 (0x1)
20:45:54.678: usb_device_a5c_2101_noserial added
=2E..
<bluetooth key pressed again>
20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input condition=20
ButtonPressed =3D brightness-up
20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth propert=
y=20
killswitch.state =3D 0 (0x0)
20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
=2E..

Strange is "brightness-up" key, somebody is wrong here.

> > So it looks like the hci0 went blocked even when the acer-bluetooth
> > switch was unblocked. So it looks like the hci0 state is independen=
t on
> > the initial acer- bluetooth state.
> >=20
> > Hopefully I have some time this evening (CET timezone) to add some =
stack
> > traces and logs to see what really happens on my system.
> >=20
> > Cheers,
> > Old=C5=99ich.
>=20
> Still suggest you can disable CONFIG_RFKILL_INPUT then use rfkill too=
l
> to set acer-wmi bluetooth killswitch for test, must have different
> result.

Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at Kconfi=
g in=20
net/rfkill and there is a line "default y if !EXPERT" which means (I th=
ink)=20
that it would be enabled by default for anybody not enabling expert opt=
ions.=20
So other non-expert users would have the same troubles as I have.

I've tried `rfkill unblock <acer-bluetooth number>` with my second test=
=20
(enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works perfectly.

Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to some degre=
e,=20
because enabling the config switch changes bluetooth HW/SW switch from =
working=20
to not-fully-working.

Cheers,
Old=C5=99ich.

>=20
>=20
> Thank's
> Joey Lee
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
