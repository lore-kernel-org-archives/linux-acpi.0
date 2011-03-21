From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 05:26:10 -0600
Message-ID: <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103160732.15488.oldium.pro@seznam.cz>
 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
 <201103202109.53484.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201103202109.53484.oldium.pro@seznam.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Add Cc. to experts: Johannes Berg, David S. Miller, Marcel Holtmann and
Gary Lin

Hi Old=C5=99ich,=20

=E6=96=BC =E6=97=A5=EF=BC=8C2011-03-20 =E6=96=BC 21:09 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey Lee,
>=20
> Finally I've got little time to expriment.
>=20

Thank's for you also reserve time to trace it. And, I also add comment
on bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=3D31002

> On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> > Hi Old=C5=99ich,
> >=20
> > =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > > After trace rfkill-input stuff, I thought this is rfkill-input'=
s normal
> > > > behavior but not a bug.
> > > >=20
> > > > Unfortunately, I didn't find any workaround way when a driver n=
eed to
> > > > call rfkill_init_sw_state, e.g. acer-wmi driver.
> > > >=20
> > > > The rfkill-input will sync the rfkill state to all killswitchs =
that
> > > > have the same type. For example, acer-wmi set the initial softw=
are
> > > > switch to _BLOCK_ when driver initial, then rfkill-input will a=
lso set
> > > > any new bluetooth killswitch state to _BLOCK_ .
> > >=20
> > > The rfkill_sync_work syncs with rfkill_global_states, which is se=
t during
> > > intitialization or by rfkill_switch_all, if I read it correctly. =
This
> > > should be independent to acer-bluetooth state. The
> > > rfkill_global_states[BLUETOOTH] should be unblocked initially, I =
need to
> > > verify it.
> >=20
> > Yes!
> > Ideally, killswitch state should be independent to different driver=
,
> > even the killswitch type is the same.
> >=20
> > But,
> > If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will repli=
cate
> > state for each killswitch that have the same type:
> >=20
> > vi net/rfkill/core.c
> >=20
> > int __must_check rfkill_register(struct rfkill *rfkill)
> > {
> > ...
> >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> >                 schedule_work(&rfkill->sync_work);
> >         } else {		/* if rfkill->persistent then set the state to al=
l=20
> the
> > same type */ #ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL_INPUT=
 =3D Y */
> >                 bool soft_blocked =3D !!(rfkill->state & RFKILL_BLO=
CK_SW);
> >=20
> >                 if (!atomic_read(&rfkill_input_disabled))
> >                         __rfkill_switch_all(rfkill->type, soft_bloc=
ked);	/*
> > here call switch all to sync state */ #endif
> >         }
> >=20
> > When any driver call rfkill_init_sw_state for set the initial state=
 to
> > killswitch, this rfkill->persistent will set to true:
> >=20
> > void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)	/* a=
cer-
> wmi
> > driver used it to set inital killswitch state */ {
> > ....
> >         spin_lock_irqsave(&rfkill->lock, flags);
> >         __rfkill_set_sw_state(rfkill, blocked);
> >         rfkill->persistent =3D true			/* persistent set to true */
> >=20
> >=20
> > That's why acer-wmi bluetooth killswitch's state was been replicate=
 to
> > hci_core's killswitch state.
> >=20
> > When CONFIG_RFKILL_INPUT set to Y, and any driver call
> > rfkill_init_sw_state before register rfkill, then rfkill_register w=
ill
> > try to sync state to the same killswitch type like the above.
> >=20
> > It's make sense,
> > because rfkill-input only can block/unblock the same killswitch typ=
e at
> > the same time, before rfkill-input active, it want all the same typ=
e's
> > state is full the same.
> >=20
> > And,
> > rfkill-input also suppose user only can use keycode (maybe Fn key) =
to
> > control killswitch state, so, direct use rkill tool or echo state t=
o
> > killswitch for change the state will cause killswitchs' state lost =
link.
> > It like we do.
> >=20
> > > There is some magic in rfkill/input.c that plays with global stat=
es, but
> > > I don't know if or how that one is used in my case.
> >=20
> > Suggest you can disable CONFIG_RFKILL_INPUT or markup the following
> > code. You will see the new bluetooth killswitch will be unblock whe=
n it
> > created.
> >=20
> > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > index 0198191..0dec078 100644
> > --- a/net/rfkill/core.c
> > +++ b/net/rfkill/core.c
> > @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct rfkil=
l
> > *rfkill)
> >=20
> >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> >                 schedule_work(&rfkill->sync_work);
> > -       } else {
> > -#ifdef CONFIG_RFKILL_INPUT
> > -               bool soft_blocked =3D !!(rfkill->state & RFKILL_BLO=
CK_SW);
> > -
> > -               if (!atomic_read(&rfkill_input_disabled))
> > -                       __rfkill_switch_all(rfkill->type, soft_bloc=
ked);
> > -#endif
> > -       }
> > +       } //else {
> > +//#ifdef CONFIG_RFKILL_INPUT
> > +//             bool soft_blocked =3D !!(rfkill->state & RFKILL_BLO=
CK_SW);
> > +//
> > +//             if (!atomic_read(&rfkill_input_disabled))
> > +//                     __rfkill_switch_all(rfkill->type, soft_bloc=
ked);
> > +//#endif
> > +//     }
> >=20
> >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
>=20
> Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second I'v=
e tried to=20
> enable CONFIG_RFKILL_INPUT, but remove the mentioned block of code. T=
he result=20
> is working bluetooth HW switch.
>=20

Yes, that because the following patch introduce
driver with persistent state will affect the global state only if rfkil=
l-input
is enabled:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19

It maybe workaround another rfkill-input issue, but causes it replicate=
 acer-wmi's=20
bluetooth killswitch initial state (or any driver that used rfkill_init=
_sw_state)=20
to any new bluetooth killswitch.

It's not make sense.

> > > > Acer's BIOS default setup bluetooth's state is disable when sys=
tem cold
> > > > boot, and BIOS also can save the connection devices' state when=
 system
> > > > reboot. Currently, acer-wmi driver have right behavior to sync =
the
> > > > state with BIOS.
> > > >=20
> > > > Face to your situation, my suggestion is:
> > > >=20
> > > > - Use userland application to correct killswitch state.
> > > >=20
> > > >   highly suggest You can try urfkill daemon:
> > > > http://www.freedesktop.org/wiki/Software/urfkill or
> > > >=20
> > > >   write a startup script to enable bluetooth when system boot.
> > > >=20
> > > > - Disable rfkill-input module if you didn't real use it.
> > > >=20
> > > >   The TravelMate 5730G have wifi hotkey that only emit KEY_WLAN=
, but
> > > >   doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't he=
lp you
> > > >   enable bluetooth killswitch.
> > >=20
> > > I didn't have time to look at the problem more deeply to identify=
 who is
> > > setting the global state to "blocked" or what really happens. Any=
way, I
> > > did some testing with pressing the HW bluetooth switch and I saw =
the
> > > following immediately _after_ pressing the HW switch to enable
> > > bluetooth:
> > >=20
> > > oldium ~ # rfkill list
> > > 0: acer-wireless: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 1: acer-bluetooth: Bluetooth
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 2: acer-threeg: Wireless WAN
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> > >=20
> > > 3: phy0: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > I had this output 3 times immediately after each other. I'm using
> > > keyboard "up" and "enter" to repeat the last shell command, so th=
is is a
> > > relatively slow operation. So the state when the acer-bluetooth w=
as
> > > unblocked stayed for relatively long time before hci0 appeared in
> > > rfkill. Afterwards I saw:
> > >=20
> > > oldium ~ # rfkill list
> > > 0: acer-wireless: Wireless LAN
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 1: acer-bluetooth: Bluetooth
> > >=20
> > >         Soft blocked: no
> > >         Hard blocked: no
> > >=20
> > > 2: acer-threeg: Wireless WAN
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked> > >=20
> > > 5: hci0: Bluetooth
> > >=20
> > >         Soft blocked: yes
> > >         Hard blocked: no
> >=20
> > My Acer machine have no HW bluetooth key but only have one HW WLAN =
key
> > that emit KEY_WLAN.
> > Please use lshal to monitor your HW bluetooth key and make sure it =
emit
> > KEY_BLUETOOTH.
>=20
> `lshal -m` outputs this:
>=20
> <bluetooth key pressed>
> 20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input conditio=
n=20
> ButtonPressed =3D bluetooth
> 20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth prope=
rty=20
> killswitch.state =3D 1 (0x1)
> 20:45:54.678: usb_device_a5c_2101_noserial added
> ...
> <bluetooth key pressed again>
> 20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input conditio=
n=20
> ButtonPressed =3D brightness-up
> 20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth prope=
rty=20
> killswitch.state =3D 0 (0x0)
> 20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
> ...
>=20
> Strange is "brightness-up" key, somebody is wrong here.
>=20

Yes, brightness-up key is another story, maybe you can enable acpi debu=
g
to look at montior which acpi method or _Q event method used:

echo 0xFFFFFFFF >/sys/module/acpi/parameters/debug_layer
echo 0xF >/sys/module/acpi/parameters/debug_level

But, this is not related to our current killswitch issue, let us skip
it.

> > > So it looks like the hci0 went blocked even when the acer-bluetoo=
th
> > > switch was unblocked. So it looks like the hci0 state is independ=
ent on
> > > the initial acer- bluetooth state.
> > >=20
> > > Hopefully I have some time this evening (CET timezone) to add som=
e stack
> > > traces and logs to see what really happens on my system.
> > >=20
> > > Cheers,
> > > Old=C5=99ich.
> >=20
> > Still suggest you can disable CONFIG_RFKILL_INPUT then use rfkill t=
ool
> > to set acer-wmi bluetooth killswitch for test, must have different
> > result.
>=20
> Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at Kcon=
fig in=20
> net/rfkill and there is a line "default y if !EXPERT" which means (I =
think)=20
> that it would be enabled by default for anybody not enabling expert o=
ptions.=20
> So other non-expert users would have the same troubles as I have.
>=20

I agreed your point, and I don't think rfkill-input need enable for all
non-Expert user because it sometimes have conflict with EC or userland
behavior.

I still suggest you can disable rfkill-input then please try Gary Lin's
urfkill daemon, it can do what does rfkill-input do and more
flexibility.

> I've tried `rfkill unblock <acer-bluetooth number>` with my second te=
st=20
> (enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works perfectl=
y.
>=20
> Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to some deg=
ree,=20
> because enabling the config switch changes bluetooth HW/SW switch fro=
m working=20
> to not-fully-working.
>=20
> Cheers,
> Old=C5=99ich.
>=20

The root cause is what I said in the above, it's hard to fix in kernel
module because user only can choice enable/disable rfkill-input in
Kconfig and even cann't choice it when system boot.

I thought we need:
 - set rfkill-input to EXPERT, remove !EXPERT
 - add a kernel option to rfkill for user can choice enable it or not
when system boot.
 - Add comment in Documentation/rfkill.txt for remind user can use
urfkill daemon (or any other userland daemon) to replace rfkill-input.

Of course need rfkill experts' more professional comments for this
topic.
I will try to generate a patches to implement the above 3 things then
send out to rfkill experts for review.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
