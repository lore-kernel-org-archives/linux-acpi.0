From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Wed, 16 Mar 2011 02:59:16 -0600
Message-ID: <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <4D7B32B10200002300029B5E@novprvlin0050.provo.novell.com>
 <4D7FE4260200002300029D70@novprvlin0050.provo.novell.com>
 <201103160732.15488.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201103160732.15488.oldium.pro@seznam.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: Al Cho <ACho@novell.com>, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Old=C5=99ich,

=E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > After trace rfkill-input stuff, I thought this is rfkill-input's no=
rmal
> > behavior but not a bug.
> >=20
> > Unfortunately, I didn't find any workaround way when a driver need =
to
> > call rfkill_init_sw_state, e.g. acer-wmi driver.
> >=20
> > The rfkill-input will sync the rfkill state to all killswitchs that=
 have
> > the same type. For example, acer-wmi set the initial software switc=
h to
> > _BLOCK_ when driver initial, then rfkill-input will also set any ne=
w
> > bluetooth killswitch state to _BLOCK_ .
>=20
> The rfkill_sync_work syncs with rfkill_global_states, which is set du=
ring=20
> intitialization or by rfkill_switch_all, if I read it correctly. This=
 should=20
> be independent to acer-bluetooth state. The rfkill_global_states[BLUE=
TOOTH]=20
> should be unblocked initially, I need to verify it.
>=20

Yes!
Ideally, killswitch state should be independent to different driver,
even the killswitch type is the same.

But,=20
If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will replicate
state for each killswitch that have the same type:

vi net/rfkill/core.c

int __must_check rfkill_register(struct rfkill *rfkill)
{
=2E..
        if (!rfkill->persistent || rfkill_epo_lock_active) {
                schedule_work(&rfkill->sync_work);
        } else {		/* if rfkill->persistent then set the state to all th=
e same type */
#ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL_INPUT =3D Y */
                bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK_S=
W);

                if (!atomic_read(&rfkill_input_disabled))
                        __rfkill_switch_all(rfkill->type, soft_blocked)=
;	/* here call switch all to sync state */
#endif
        }

When any driver call rfkill_init_sw_state for set the initial state to
killswitch, this rfkill->persistent will set to true:

void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)	/* acer-=
wmi driver used it to set inital killswitch state */
{
=2E...
        spin_lock_irqsave(&rfkill->lock, flags);
        __rfkill_set_sw_state(rfkill, blocked);=09
        rfkill->persistent =3D true			/* persistent set to true */


That's why acer-wmi bluetooth killswitch's state was been replicate to
hci_core's killswitch state.

When CONFIG_RFKILL_INPUT set to Y, and any driver call
rfkill_init_sw_state before register rfkill, then rfkill_register will
try to sync state to the same killswitch type like the above.

It's make sense,
because rfkill-input only can block/unblock the same killswitch type at
the same time, before rfkill-input active, it want all the same type's
state is full the same.

And,
rfkill-input also suppose user only can use keycode (maybe Fn key) to
control killswitch state, so, direct use rkill tool or echo state to
killswitch for change the state will cause killswitchs' state lost link=
=2E
It like we do.


> There is some magic in rfkill/input.c that plays with global states, =
but I=20
> don't know if or how that one is used in my case.
>=20

Suggest you can disable CONFIG_RFKILL_INPUT or markup the following
code. You will see the new bluetooth killswitch will be unblock when it
created.

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 0198191..0dec078 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -950,14 +950,14 @@ int __must_check rfkill_register(struct rfkill *r=
fkill)
=20
        if (!rfkill->persistent || rfkill_epo_lock_active) {
                schedule_work(&rfkill->sync_work);
-       } else {
-#ifdef CONFIG_RFKILL_INPUT
-               bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK_S=
W);
-
-               if (!atomic_read(&rfkill_input_disabled))
-                       __rfkill_switch_all(rfkill->type, soft_blocked)=
;
-#endif
-       }
+       } //else {
+//#ifdef CONFIG_RFKILL_INPUT
+//             bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK_S=
W);
+//
+//             if (!atomic_read(&rfkill_input_disabled))
+//                     __rfkill_switch_all(rfkill->type, soft_blocked)=
;
+//#endif
+//     }
=20
        rfkill_send_events(rfkill, RFKILL_OP_ADD);

> > Acer's BIOS default setup bluetooth's state is disable when system =
cold
> > boot, and BIOS also can save the connection devices' state when sys=
tem
> > reboot. Currently, acer-wmi driver have right behavior to sync the =
state
> > with BIOS.
> >
> > Face to your situation, my suggestion is:
> >=20
> > - Use userland application to correct killswitch state.
> >   highly suggest You can try urfkill daemon:
> > http://www.freedesktop.org/wiki/Software/urfkill or
> >   write a startup script to enable bluetooth when system boot.
> >=20
> > - Disable rfkill-input module if you didn't real use it.
> >   The TravelMate 5730G have wifi hotkey that only emit KEY_WLAN, bu=
t
> >   doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't help y=
ou
> >   enable bluetooth killswitch.
>=20
> I didn't have time to look at the problem more deeply to identify who=
 is=20
> setting the global state to "blocked" or what really happens. Anyway,=
 I did=20
> some testing with pressing the HW bluetooth switch and I saw the foll=
owing=20
> immediately _after_ pressing the HW switch to enable bluetooth:
>=20
> oldium ~ # rfkill list
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
>=20
> I had this output 3 times immediately after each other. I'm using key=
board=20
> "up" and "enter" to repeat the last shell command, so this is a relat=
ively=20
> slow operation. So the state when the acer-bluetooth was unblocked st=
ayed for=20
> relatively long time before hci0 appeared in rfkill. Afterwards I saw=
:
>=20
> oldium ~ # rfkill list
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
> 5: hci0: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
>=20

My Acer machine have no HW bluetooth key but only have one HW WLAN key
that emit KEY_WLAN.
Please use lshal to monitor your HW bluetooth key and make sure it emit
KEY_BLUETOOTH.

> So it looks like the hci0 went blocked even when the acer-bluetooth s=
witch was=20
> unblocked. So it looks like the hci0 state is independent on the init=
ial acer-
> bluetooth state.
>=20
> Hopefully I have some time this evening (CET timezone) to add some st=
ack=20
> traces and logs to see what really happens on my system.
>=20
> Cheers,
> Old=C5=99ich.
>=20

Still suggest you can disable CONFIG_RFKILL_INPUT then use rfkill tool
to set acer-wmi bluetooth killswitch for test, must have different
result.


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
