From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 11:52:58 -0600
Message-ID: <4D882B2A020000230002A319@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Old=C5=99ich,

=E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 05:26 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> Add Cc. to experts: Johannes Berg, David S. Miller, Marcel Holtmann a=
nd
> Gary Lin
>=20
> Hi Old=C5=99ich,=20
>=20
> =E6=96=BC =E6=97=A5=EF=BC=8C2011-03-20 =E6=96=BC 21:09 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > Hi Joey Lee,
> >=20
> > Finally I've got little time to expriment.
> >=20
>=20
> Thank's for you also reserve time to trace it. And, I also add commen=
t
> on bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D31002
>=20
> > On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> > > Hi Old=C5=99ich,
> > >=20
> > > =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=BC=
=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > > After trace rfkill-input stuff, I thought this is rfkill-inpu=
t's normal
> > > > > behavior but not a bug.
> > > > >=20
> > > > > Unfortunately, I didn't find any workaround way when a driver=
 need to
> > > > > call rfkill_init_sw_state, e.g. acer-wmi driver.
> > > > >=20
> > > > > The rfkill-input will sync the rfkill state to all killswitch=
s that
> > > > > have the same type. For example, acer-wmi set the initial sof=
tware
> > > > > switch to _BLOCK_ when driver initial, then rfkill-input will=
 also set
> > > > > any new bluetooth killswitch state to _BLOCK_ .
> > > >=20
> > > > The rfkill_sync_work syncs with rfkill_global_states, which is =
set during
> > > > intitialization or by rfkill_switch_all, if I read it correctly=
=2E This
> > > > should be independent to acer-bluetooth state. The
> > > > rfkill_global_states[BLUETOOTH] should be unblocked initially, =
I need to
> > > > verify it.
> > >=20
> > > Yes!
> > > Ideally, killswitch state should be independent to different driv=
er,
> > > even the killswitch type is the same.
> > >=20
> > > But,
> > > If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will rep=
licate
> > > state for each killswitch that have the same type:
> > >=20
> > > vi net/rfkill/core.c
> > >=20
> > > int __must_check rfkill_register(struct rfkill *rfkill)
> > > {
> > > ...
> > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > >                 schedule_work(&rfkill->sync_work);
> > >         } else {		/* if rfkill->persistent then set the state to =
all=20
> > the
> > > same type */ #ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL_INP=
UT =3D Y */
> > >                 bool soft_blocked =3D !!(rfkill->state & RFKILL_B=
LOCK_SW);
> > >=20
> > >                 if (!atomic_read(&rfkill_input_disabled))
> > >                         __rfkill_switch_all(rfkill->type, soft_bl=
ocked);	/*
> > > here call switch all to sync state */ #endif
> > >         }
> > >=20
> > > When any driver call rfkill_init_sw_state for set the initial sta=
te to
> > > killswitch, this rfkill->persistent will set to true:
> > >=20
> > > void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)	/*=
 acer-
> > wmi
> > > driver used it to set inital killswitch state */ {
> > > ....
> > >         spin_lock_irqsave(&rfkill->lock, flags);
> > >         __rfkill_set_sw_state(rfkill, blocked);
> > >         rfkill->persistent =3D true			/* persistent set to true *=
/
> > >=20
> > >=20
> > > That's why acer-wmi bluetooth killswitch's state was been replica=
te to
> > > hci_core's killswitch state.
> > >=20
> > > When CONFIG_RFKILL_INPUT set to Y, and any driver call
> > > rfkill_init_sw_state before register rfkill, then rfkill_register=
 will
> > > try to sync state to the same killswitch type like the above.
> > >=20
> > > It's make sense,
> > > because rfkill-input only can block/unblock the same killswitch t=
ype at
> > > the same time, before rfkill-input active, it want all the same t=
ype's
> > > state is full the same.
> > >=20
> > > And,
> > > rfkill-input also suppose user only can use keycode (maybe Fn key=
) to
> > > control killswitch state, so, direct use rkill tool or echo state=
 to
> > > killswitch for change the state will cause killswitchs' state los=
t link.
> > > It like we do.
> > >=20
> > > > There is some magic in rfkill/input.c that plays with global st=
ates, but
> > > > I don't know if or how that one is used in my case.
> > >=20
> > > Suggest you can disable CONFIG_RFKILL_INPUT or markup the followi=
ng
> > > code. You will see the new bluetooth killswitch will be unblock w=
hen it
> > > created.
> > >=20
> > > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > > index 0198191..0dec078 100644
> > > --- a/net/rfkill/core.c
> > > +++ b/net/rfkill/core.c
> > > @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct rfk=
ill
> > > *rfkill)
> > >=20
> > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > >                 schedule_work(&rfkill->sync_work);
> > > -       } else {
> > > -#ifdef CONFIG_RFKILL_INPUT
> > > -               bool soft_blocked =3D !!(rfkill->state & RFKILL_B=
LOCK_SW);
> > > -
> > > -               if (!atomic_read(&rfkill_input_disabled))
> > > -                       __rfkill_switch_all(rfkill->type, soft_bl=
ocked);
> > > -#endif
> > > -       }
> > > +       } //else {
> > > +//#ifdef CONFIG_RFKILL_INPUT
> > > +//             bool soft_blocked =3D !!(rfkill->state & RFKILL_B=
LOCK_SW);
> > > +//
> > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > +//                     __rfkill_switch_all(rfkill->type, soft_bl=
ocked);
> > > +//#endif
> > > +//     }
> > >=20
> > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> >=20
> > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second I=
've tried to=20
> > enable CONFIG_RFKILL_INPUT, but remove the mentioned block of code.=
 The result=20
> > is working bluetooth HW switch.
> >=20
>=20
> Yes, that because the following patch introduce
> driver with persistent state will affect the global state only if rfk=
ill-input
> is enabled:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19
>=20
> It maybe workaround another rfkill-input issue, but causes it replica=
te acer-wmi's=20
> bluetooth killswitch initial state (or any driver that used rfkill_in=
it_sw_state)=20
> to any new bluetooth killswitch.
>=20
> It's not make sense.
>=20
> > > > > Acer's BIOS default setup bluetooth's state is disable when s=
ystem cold
> > > > > boot, and BIOS also can save the connection devices' state wh=
en system
> > > > > reboot. Currently, acer-wmi driver have right behavior to syn=
c the
> > > > > state with BIOS.
> > > > >=20
> > > > > Face to your situation, my suggestion is:
> > > > >=20
> > > > > - Use userland application to correct killswitch state.
> > > > >=20
> > > > >   highly suggest You can try urfkill daemon:
> > > > > http://www.freedesktop.org/wiki/Software/urfkill or
> > > > >=20
> > > > >   write a startup script to enable bluetooth when system boot=
=2E
> > > > >=20
> > > > > - Disable rfkill-input module if you didn't real use it.
> > > > >=20
> > > > >   The TravelMate 5730G have wifi hotkey that only emit KEY_WL=
AN, but
> > > > >   doesn't emit KEY_BLUETOOTH, that means rfkill-input cann't =
help you
> > > > >   enable bluetooth killswitch.
> > > >=20
> > > > I didn't have time to look at the problem more deeply to identi=
fy who is
> > > > setting the global state to "blocked" or what really happens. A=
nyway, I
> > > > did some testing with pressing the HW bluetooth switch and I sa=
w the
> > > > following immediately _after_ pressing the HW switch to enable
> > > > bluetooth:
> > > >=20
> > > > oldium ~ # rfkill list
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
> > > > I had this output 3 times immediately after each other. I'm usi=
ng
> > > > keyboard "up" and "enter" to repeat the last shell command, so =
this is a
> > > > relatively slow operation. So the state when the acer-bluetooth=
 was
> > > > unbloc> > > >=20
> > > > oldium ~ # rfkill list
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
> > > >         Hard blocked> > >=20
> > > > 5: hci0: Bluetooth
> > > >=20
> > > >         Soft blocked: yes
> > > >         Hard blocked: no
> > >=20
> > > My Acer machine have no HW bluetooth key but only have one HW WLA=
N key
> > > that emit KEY_WLAN.
> > > Please use lshal to monitor your HW bluetooth key and make sure i=
t emit
> > > KEY_BLUETOOTH.
> >=20
> > `lshal -m` outputs this:
> >=20
> > <bluetooth key pressed>
> > 20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input condit=
ion=20
> > ButtonPressed =3D bluetooth
> > 20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth pro=
perty=20
> > killswitch.state =3D 1 (0x1)
> > 20:45:54.678: usb_device_a5c_2101_noserial added
> > ...
> > <bluetooth key pressed again>
> > 20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input condit=
ion=20
> > ButtonPressed =3D brightness-up
> > 20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth pro=
perty=20
> > killswitch.state =3D 0 (0x0)
> > 20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
> > ...
> >=20
> > Strange is "brightness-up" key, somebody is wrong here.
> >=20
>=20
> Yes, brightness-up key is another story, maybe you can enable acpi de=
bug
> to look at montior which acpi method or _Q event method used:
>=20
> echo 0xFFFFFFFF >/sys/module/acpi/parameters/debug_layer
> echo 0xF >/sys/module/acpi/parameters/debug_level
>=20
> But, this is not related to our current killswitch issue, let us skip
> it.
>=20
> > > > So it looks like the hci0 went blocked even when the acer-bluet=
ooth
> > > > switch was unblocked. So it looks like the hci0 state is indepe=
ndent on
> > > > the initial acer- bluetooth state.
> > > >=20
> > > > Hopefully I have some time this evening (CET timezone) to add s=
ome stack
> > > > traces and logs to see what really happens on my system.
> > > >=20
> > > > Cheers,
> > > > Old=C5=99ich.
> > >=20
> > > Still suggest you can disable CONFIG_RFKILL_INPUT then use rfkill=
 tool
> > > to set acer-wmi bluetooth killswitch for test, must have differen=
t
> > > result.
> >=20
> > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at Kc=
onfig in=20
> > net/rfkill and there is a line "default y if !EXPERT" which means (=
I think)=20
> > that it would be enabled by default for anybody not enabling expert=
 options.=20
> > So other non-expert users would have the same troubles as I have.
> >=20
>=20
> I agreed your point, and I don't think rfkill-input need enable for a=
ll
> non-Expert user because it sometimes have conflict with EC or userlan=
d
> behavior.
>=20
> I still suggest you can disable rfkill-input then please try Gary Lin=
's
> urfkill daemon, it can do what does rfkill-input do and more
> flexibility.
>=20
> > I've tried `rfkill unblock <acer-bluetooth number>` with my second =
test=20
> > (enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works perfec=
tly.
> >=20
> > Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to some d=
egree,=20
> > because enabling the config switch changes bluetooth HW/SW switch f=
rom working=20
> > to not-fully-working.
> >=20
> > Cheers,
> > Old=C5=99ich.
> >=20
>=20
> The root cause is what I said in the above, it's hard to fix in kerne=
l
> module because user only can choice enable/disable rfkill-input in
> Kconfig and even cann't choice it when system boot.
>=20
> I thought we need:
>  - set rfkill-input to EXPERT, remove !EXPERT
>  - add a kernel option to rfkill for user can choice enable it or not
> when system boot.
>  - Add comment in Documentation/rfkill.txt for remind user can use
> urfkill daemon (or any other userland daemon) to replace rfkill-input=
=2E
>=20
> Of course need rfkill experts' more professional comments for this
> topic.
> I will try to gener> Thank's a lot!
> Joey Lee

=46inally, I removed rfkill_init_sw_state and maintain a rfkill_inited
flag to workaround issue, please kindly help to test the following
acer-wmi patch, it works fine to me on my acer travelmate 8572 machine.
Maybe it will be our backup solution after you tested:


>From dd3d9208aa63d9670d24409b4aaaeb619f3137d6 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee@novell.com>
Date: Tue, 22 Mar 2011 01:43:11 +0800
Subject: [PATCH] acer-wmi: remove rfkill_init_sw_state to workaround rf=
kill-input issue

acer-wmi: remove rfkill_init_sw_state to workaround issue for bko#31002

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
index 38b34a7..3d3cb46 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -222,6 +222,7 @@ struct acer_debug {
 static struct rfkill *wireless_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *threeg_rfkill;
+static int rfkill_inited;
=20
 /* Each low-level interface must define at least some of the following=
 */
 struct wmi_interface {
@@ -1161,9 +1162,13 @@ static int acer_rfkill_set(void *data, bool bloc=
ked)
 {
 	acpi_status status;
 	u32 cap =3D (unsigned long)data;
-	status =3D set_u32(!blocked, cap);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+
+	if (rfkill_inited) {
+		status =3D set_u32(!blocked, cap);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+	}
+
 	return 0;
 }
=20
@@ -1187,14 +1192,16 @@ static struct rfkill *acer_rfkill_register(stru=
ct device *dev,
 		return ERR_PTR(-ENOMEM);
=20
 	status =3D get_device_status(&state, cap);
-	if (ACPI_SUCCESS(status))
-		rfkill_init_sw_state(rfkill_dev, !state);
=20
 	err =3D rfkill_register(rfkill_dev);
 	if (err) {
 		rfkill_destroy(rfkill_dev);
 		return ERR_PTR(err);
 	}
+
+	if (ACPI_SUCCESS(status))
+		rfkill_set_sw_state(rfkill_dev, !state);
+
 	return rfkill_dev;
 }
=20
@@ -1229,6 +1236,8 @@ static int acer_rfkill_init(struct device *dev)
 		}
 	}
=20
+	rfkill_inited =3D 1;
+
 	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
=20
 	return 0;
--=20
1.6.0.2
