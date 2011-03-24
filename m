From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Thu, 24 Mar 2011 22:56:09 +0100
Message-ID: <201103242256.10386.oldium.pro@seznam.cz>
References: <4D882B2A020000230002A319@novprvlin0050.provo.novell.com> <201103212144.28512.oldium.pro@seznam.cz> <4D88A4D1020000230002A366@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_637iNr9WZFcF6BW"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46463 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1CXV4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Mar 2011 17:56:19 -0400
In-Reply-To: <4D88A4D1020000230002A366@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

--Boundary-00=_637iNr9WZFcF6BW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Joey Lee,

On Tuesday 22 March 2011 03:32:01 Joey Lee wrote:
> =E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 21:44 +0100=EF=BC=8COld=
=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Hi Joey Lee,
> >=20
> > On Monday 21 March 2011 18:52:58 Joey Lee wrote:
> > > Hi Old=C5=99ich,
> > >=20
> > > =E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 05:26 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Add Cc. to experts: Johannes Berg, David S. Miller, Marcel Holtmann
> > > > and Gary Lin
> > > >=20
> > > > Hi Old=C5=99ich,
> > > >=20
> > > > =E6=96=BC =E6=97=A5=EF=BC=8C2011-03-20 =E6=96=BC 21:09 +0100=EF=BC=
=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > Hi Joey Lee,
> > > > >=20
> > > > > Finally I've got little time to expriment.
> > > >=20
> > > > Thank's for you also reserve time to trace it. And, I also add
> > > > comment on bugzilla:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D31002
> > > >=20
> > > > > On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> > > > > > Hi Old=C5=99ich,
> > > > > >=20
> > > > > > =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=
=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > > >=20
> > > > > > > > After trace rfkill-input stuff, I thought this is
> > > > > > > > rfkill-input's normal behavior but not a bug.
> > > > > > > >=20
> > > > > > > > Unfortunately, I didn't find any workaround way when a driv=
er
> > > > > > > > need to call rfkill_init_sw_state, e.g. acer-wmi driver.
> > > > > > > >=20
> > > > > > > > The rfkill-input will sync the rfkill state to all
> > > > > > > > killswitchs that have the same type. For example, acer-wmi
> > > > > > > > set the initial software switch to _BLOCK_ when driver
> > > > > > > > initial, then rfkill-input will also set any new bluetooth
> > > > > > > > killswitch state to _BLOCK_ .
> > > > > > >=20
> > > > > > > The rfkill_sync_work syncs with rfkill_global_states, which is
> > > > > > > set during intitialization or by rfkill_switch_all, if I read
> > > > > > > it correctly. This should be independent to acer-bluetooth
> > > > > > > state. The rfkill_global_states[BLUETOOTH] should be unblocked
> > > > > > > initially, I need to verify it.
> > > > > >=20
> > > > > > Yes!
> > > > > > Ideally, killswitch state should be independent to different
> > > > > > driver, even the killswitch type is the same.
> > > > > >=20
> > > > > > But,
> > > > > > If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will
> > > > > > replicate state for each killswitch that have the same type:
> > > > > >=20
> > > > > > vi net/rfkill/core.c
> > > > > >=20
> > > > > > int __must_check rfkill_register(struct rfkill *rfkill)
> > > > > > {
> > > > > > ...
> > > > > >=20
> > > > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > > > >        =20
> > > > > >                 schedule_work(&rfkill->sync_work);
> > > > > >        =20
> > > > > >         } else {		/* if rfkill->persistent then set the=20
state
> >=20
> > to all
> >=20
> > > > > the
> > > > >=20
> > > > > > same type */ #ifdef CONFIG_RFKILL_INPUT	/* when
> > > > > > CONFIG_RFKILL_INPUT =3D Y */
> > > > > >=20
> > > > > >                 bool soft_blocked =3D !!(rfkill->state &
> > > > > >                 RFKILL_BLOCK_SW);
> > > > > >                =20
> > > > > >                 if (!atomic_read(&rfkill_input_disabled))
> > > > > >                =20
> > > > > >                         __rfkill_switch_all(rfkill->type,
> > > > > >                         soft_blocked);	/*
> > > > > >=20
> > > > > > here call switch all to sync state */ #endif
> > > > > >=20
> > > > > >         }
> > > > > >=20
> > > > > > When any driver call rfkill_init_sw_state for set the initial
> > > > > > state to killswitch, this rfkill->persistent will set to true:
> > > > > >=20
> > > > > > void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)=
=09
/*
> > > > > > acer-
> > > > >=20
> > > > > wmi
> > > > >=20
> > > > > > driver used it to set inital killswitch state */ {
> > > > > > ....
> > > > > >=20
> > > > > >         spin_lock_irqsave(&rfkill->lock, flags);
> > > > > >         __rfkill_set_sw_state(rfkill, blocked);
> > > > > >         rfkill->persistent =3D true			/* persistent set=20
to
> >=20
> > true */
> >=20
> > > > > > That's why acer-wmi bluetooth killswitch's state was been
> > > > > > replicate to hci_core's killswitch state.
> > > > > >=20
> > > > > > When CONFIG_RFKILL_INPUT set to Y, and any driver call
> > > > > > rfkill_init_sw_state before register rfkill, then rfkill_regist=
er
> > > > > > will try to sync state to the same killswitch type like the
> > > > > > above.
> > > > > >=20
> > > > > > It's make sense,
> > > > > > because rfkill-input only can block/unblock the same killswitch
> > > > > > type at the same time, before rfkill-input active, it want all
> > > > > > the same type's state is full the same.
> > > > > >=20
> > > > > > And,
> > > > > > rfkill-input also suppose user only can use keycode (maybe Fn
> > > > > > key) to control killswitch state, so, direct use rkill tool or
> > > > > > echo state to killswitch for change the state will cause
> > > > > > killswitchs' state lost link. It like we do.
> > > > > >=20
> > > > > > > There is some magic in rfkill/input.c that plays with global
> > > > > > > states, but I don't know if or how that one is used in my cas=
e.
> > > > > >=20
> > > > > > Suggest you can disable CONFIG_RFKILL_INPUT or markup the
> > > > > > following code. You will see the new bluetooth killswitch will
> > > > > > be unblock when it created.
> > > > > >=20
> > > > > > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > > > > > index 0198191..0dec078 100644
> > > > > > --- a/net/rfkill/core.c
> > > > > > +++ b/net/rfkill/core.c
> > > > > > @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct
> > > > > > rfkill *rfkill)
> > > > > >=20
> > > > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > > > >        =20
> > > > > >                 schedule_work(&rfkill->sync_work);
> > > > > >=20
> > > > > > -       } else {
> > > > > > -#ifdef CONFIG_RFKILL_INPUT
> > > > > > -               bool soft_blocked =3D !!(rfkill->state &
> > > > > > RFKILL_BLOCK_SW); -
> > > > > > -               if (!atomic_read(&rfkill_input_disabled))
> > > > > > -                       __rfkill_switch_all(rfkill->type,
> > > > > > soft_blocked); -#endif
> > > > > > -       }
> > > > > > +       } //else {
> > > > > > +//#ifdef CONFIG_RFKILL_INPUT
> > > > > > +//             bool soft_blocked =3D !!(rfkill->state &
> > > > > > RFKILL_BLOCK_SW); +//
> > > > > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > > > > +//                     __rfkill_switch_all(rfkill->type,
> > > > > > soft_blocked); +//#endif
> > > > > > +//     }
> > > > > >=20
> > > > > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> > > > >=20
> > > > > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second
> > > > > I've tried to enable CONFIG_RFKILL_INPUT, but remove the mentioned
> > > > > block of code. The result is working bluetooth HW switch.
> > > >=20
> > > > Yes, that because the following patch introduce
> > > > driver with persistent state will affect the global state only if
> > > > rfkill-input is enabled:
> > > >=20
> > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dco
> > > > mmit ;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19
> > > >=20
> > > > It maybe workaround another rfkill-input issue, but causes it
> > > > replicate acer-wmi's bluetooth killswitch initial state (or any
> > > > driver that used rfkill_init_sw_state) to any new bluetooth
> > > > killswitch.
> > > >=20
> > > > It's not make sense.
> > > >=20
> > > > > > > > Acer's BIOS default setup bluetooth's state is disable when
> > > > > > > > system cold boot, and BIOS also can save the connection
> > > > > > > > devices' state when system reboot. Currently, acer-wmi
> > > > > > > > driver have right behavior to sync the state with BIOS.
> > > > > > > >=20
> > > > > > > > Face to your situation, my suggestion is:
> > > > > > > >=20
> > > > > > > > - Use userland application to correct killswitch state.
> > > > > > > >=20
> > > > > > > >   highly suggest You can try urfkill daemon:
> > > > > > > > http://www.freedesktop.org/wiki/Software/urfkill or
> > > > > > > >=20
> > > > > > > >   write a startup script to enable bluetooth when system
> > > > > > > >   boot.
> > > > > > > >=20
> > > > > > > > - Disable rfkill-input module if you didn't real use it.
> > > > > > > >=20
> > > > > > > >   The TravelMate 5730G have wifi hotkey that only emit
> > > > > > > >   KEY_WLAN, but doesn't emit KEY_BLUETOOTH, that means
> > > > > > > >   rfkill-input cann't help you enab> > > > > > I didn't have
> > > > > > > >   time to look at the problem more deeply to identify
> > > > > > >=20
> > > > > > > who is setting the global state to "blocked" or what really
> > > > > > > happens. Anyway, I did some testing with pressing the HW
> > > > > > > bluetooth switch and I saw the following immediately _after_
> > > > > > > pressing the HW switch to enable bluetooth:
> > > > > > >=20
> > > > > > > oldium ~ # rfkill list
> > > > > > > 0: acer-wireless: Wireless LAN
> > > > > > >=20
> > > > > > >         Soft blocked: no
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > 1: acer-bluetooth: Bluetooth
> > > > > > >=20
> > > > > > >         Soft blocked: no
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > 2: acer-threeg: Wireless WAN
> > > > > > >=20
> > > > > > >         Soft blocked: yes
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > 3: phy0: Wireless LAN
> > > > > > >=20
> > > > > > >         Soft blocked: no
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > I had this output 3 times immediately after each other. I'm
> > > > > > > using keyboard "up" and "enter" to repeat the last shell
> > > > > > > command, so this is a relatively slow operation. So the state
> > > > > > > when the
> > > > > > > acer-bluetooth was unbloc> > > >
> > > > > > > oldium ~ # rfkill list
> > > > > > > 0: acer-wireless: Wireless LAN
> > > > > > >=20
> > > > > > >         Soft blocked: no
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > 1: acer-bluetooth: Bluetooth
> > > > > > >=20
> > > > > > >         Soft blocked: no
> > > > > > >         Hard blocked: no
> > > > > > >=20
> > > > > > > 2: acer-threeg: Wireless WAN
> > > > > > >=20
> > > > > > >         Soft blocked: yes
> > > > > > >         Hard blocked> > >
> > > > > > >=20
> > > > > > > 5: hci0: Bluetooth
> > > > > > >=20
> > > > > > >         Soft blocked: yes
> > > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > My Acer machine have no HW bluetooth key but only have one HW
> > > > > > WLAN key that emit KEY_WLAN.
> > > > > > Please use lshal to monitor your HW bluetooth key and make sure
> > > > > > it emit KEY_BLUETOOTH.
> > > > >=20
> > > > > `lshal -m` outputs this:
> > > > >=20
> > > > > <bluetooth key pressed>
> > > > > 20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input
> > > > > condition ButtonPressed =3D bluetooth
> > > > > 20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > > > property killswitch.state =3D 1 (0x1)
> > > > > 20:45:54.678: usb_device_a5c_2101_noserial added
> > > > > ...
> > > > > <bluetooth key pressed again>
> > > > > 20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input
> > > > > condition ButtonPressed =3D brightness-up
> > > > > 20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > > > property killswitch.state =3D 0 (0x0)
> > > > > 20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
> > > > > ...
> > > > >=20
> > > > > Strange is "brightness-up" key, somebody is wrong here.
> > > >=20
> > > > Yes, brightness-up key is another story, maybe you can enable acpi
> > > > debug to look at montior which acpi method or _Q event method used:
> > > >=20
> > > > echo 0xFFFFFFFF >/sys/module/acpi/parameters/debug_layer
> > > > echo 0xF >/sys/module/acpi/parameters/debug_level
> > > >=20
> > > > But, this is not related to our current killswitch issue, let us sk=
ip
> > > > it.
> > > >=20
> > > > > > > So it looks like the hci0 went blocked even when the
> > > > > > > acer-bluetooth switch was unblocked. So it looks like the hci0
> > > > > > > state is independent on the initial acer- bluetooth state.
> > > > > > >=20
> > > > > > > Hopefully I have some time this evening (CET timezone) to add
> > > > > > > some stack traces and logs to see what really happens on my
> > > > > > > system.
> > > > > > >=20
> > > > > > > Cheers,
> > > > > > > Old=C5=99ich.
> > > > > >=20
> > > > > > Still suggest you can disable CONFIG_RFKILL_INPUT then use rfki=
ll
> > > > > > tool to set acer-wmi bluetooth killswitch for test, must have
> > > > > > different result.
> > > > >=20
> > > > > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at
> > > > > Kconfig in net/rfkill and there is a line "default y if !EXPERT"
> > > > > which means (I think) that it would be enabled by default for
> > > > > anybody not troubles as I have.
> > > >=20
> > > > I agreed your point, and I don't think rfkill-input need enable for
> > > > all non-Expert user because it sometimes have conflict with EC or
> > > > userland behavior.
> > > >=20
> > > > I still suggest you can disable rfkill-input then please try Gary
> > > > Lin's urfkill daemon, it can do what does rfkill-input do and more
> > > > flexibility.
> > > >=20
> > > > > I've tried `rfkill unblock <acer-bluetooth number>` with my second
> > > > > test (enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works
> > > > > perfectly.
> > > > >=20
> > > > > Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to some
> > > > > degree, because enabling the config switch changes bluetooth HW/SW
> > > > > switch from working to not-fully-working.
> > > > >=20
> > > > > Cheers,
> > > > > Old=C5=99ich.
> > > >=20
> > > > The root cause is what I said in the above, it's hard to fix in
> > > > kernel module because user only can choice enable/disable
> > > > rfkill-input in Kconfig and even cann't choice it when system boot.
> > > >=20
> > > > I thought we need:
> > > >  - set rfkill-input to EXPERT, remove !EXPERT
> > > >  - add a kernel option to rfkill for user can choice enable it or n=
ot
> > > >=20
> > > > when system boot.
> > > >=20
> > > >  - Add comment in Documentation/rfkill.txt for remind user can use
> > > >=20
> > > > urfkill daemon (or any other userland daemon) to replace
> > > > rfkill-input.
> > > >=20
> > > > Of course need rfkill experts' more professional comments for this
> > > > topic.
> > > > I will try to gener> Thank's a lot!
> > > > Joey Lee
> > >=20
> > > Finally, I removed rfkill_init_sw_state and maintain a rfkill_inited
> > > flag to workaround issue, please kindly help to test the following
> > > acer-wmi patch, it works fine to me on my acer travelmate 8572 machin=
e.
>=20
> > > Maybe it will be our backup solution after you tested:
> I attached this workaround patch to bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D31002#c8
>=20
> > The patch works more than well - the bluetooth starts-up automatically
> > during boot. I don't know who does it, because it looks like the last
> > action done before any service gets started.
> >=20
> > ...
> > [    4.434293] acer-wmi: Acer Laptop ACPI-WMI Extras
> > ...
> > [    4.559937] acer-wmi: Brightness must be controlled by generic video
> > driver ...
> > [    6.024186] usb 8-2: new full speed USB device using uhci_hcd and
> > address 2 [    6.183561] usb 8-2: New USB device found, idVendor=3D0a5c,
> > idProduct=3D2101 ...
> > [    9.763265] udev[1947]: starting version 164
> >=20
> > It looks like the sync work synchronizes the state to "unblocked". I
> > don't have more time to investigate the difference today, so maybe in
> > following days - if it is important.
> >=20
> > Regards,
> > Old=C5=99ich.
>=20
> That's good but odd, good is the patch fixed your issue, odd is the
> behavior is not what I want and not match with my TravelMate 8572.

The key is the global state. I've used the same patch as I sent today to ge=
t=20
the details, what is going on (log attached). The acer-bluetooth gets enabl=
ed=20
from the global bluetooth state (rfkill_sync_work), so the hci0 gets=20
automatically enabled afterwards too from the same global state.

Cheers,
Old=C5=99ich.

> Please then me clear up it. On my TravelMate 8572, the BIOS have 2
> different behavior for cold boot (shutdown then press HW power button),
> and warm boot (reboot). BIOS is:
> 	- Cold boot: back to default config is WLAN on, BT off, WWAN on
> 	- Warm boot: keep the devices state before last time reboot.
>=20
> So, you can see the above, on my machine when cold boot, the BT state is
> off, the rfkill list like following:
>=20
> linux-7y1r:~ # rfkill list
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: acer-bluetooth: Bluetooth
>         Soft blocked: yes		# BIOS default value is disable when cold=20
boot
>         Hard blocked: no
> 2: acer-threeg: Wireless WAN
>         Soft blocked: no
>         Hard blocked: no
> 3: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
>=20
> Then I did rfkill unblock acer-bluetooth (sorry my machine have no BT HW
> key):
>=20
> linux-7y1r:~ # rfkill unblock 1
> linux-7y1r:~ # rfkill list
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: acer-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 2: acer-threeg: Wireless WAN
>         Soft blocked: no
>         Hard blocked: no
> 3: phy0: Wireless4: hci0: Bluetooth
>         Soft blocked: no		#fixed by my patch, hci0's rkfill state default
> is unblock Hard blocked: no
>=20
> I am not sure your TravelMate 5730G's behavior is fully the same with
> mine. Could you please find a bit time to look at rfkill state when
> system cold boot ?
>=20
> Of course, please enable rfkill-input and remove any other patch but
> only keep my workaround patch:
> 0001-acer-wmi-remove-rfkill_init_sw_state-to-workaround.patch
>=20
>=20
> Thank's a lot!
> Joey Lee
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Boundary-00=_637iNr9WZFcF6BW
Content-Type: text/x-log;
  charset="UTF-8";
  name="rfkill-patched.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rfkill-patched.log"

[    0.259380] rfkill_input: (rfkill_handler_init) registering rfkill_handler, returned 0
[    4.711808] rfkill: (rfkill_register) registering wlan acer-wireless
[    4.711984] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    4.711989] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    4.712115] rfkill: (rfkill_sync_work) syncing wlan acer-wireless to unblocked
[    4.712119] rfkill: (rfkill_set_block) switching acer-wireless to unblocked
[    4.774756] rfkill: (rfkill_register) registering bluetooth acer-bluetooth
[    4.774921] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to blocked
[    4.774926] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw blocked
[    4.775114] rfkill: (rfkill_register) registering wwan acer-threeg
[    4.775253] rfkill: (rfkill_set_sw_state) setting state of acer-threeg to blocked
[    4.775258] rfkill: (__rfkill_set_sw_state) setting state of acer-threeg to sw blocked
[    4.775332] rfkill: (rfkill_sync_work) syncing bluetooth acer-bluetooth to unblocked
[    4.775337] rfkill: (rfkill_set_block) switching acer-bluetooth to unblocked
[    4.871212] rfkill: (rfkill_sync_work) syncing wwan acer-threeg to unblocked
[    4.871217] rfkill: (rfkill_set_block) switching acer-threeg to unblocked
[    5.707612] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    5.707622] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    5.709096] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[    5.709103] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[    6.271996] rfkill: (rfkill_register) registering bluetooth hci0
[    6.272428] rfkill: (rfkill_sync_work) syncing bluetooth hci0 to unblocked
[    6.272434] rfkill: (rfkill_set_block) switching hci0 to unblocked
[    6.707634] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    6.707645] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    6.709084] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[    6.709139] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[    7.707460] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    7.707470] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    7.708586] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[    7.708593] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[    8.707611] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    8.707621] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    8.709074] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[    8.709082] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[    9.707392] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[    9.707403] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[    9.708748] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[    9.708755] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[   10.707366] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[   10.707376] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[   10.708673] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[   10.708680] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[   10.877147] rfkill: (rfkill_set_hw_state) setting state of phy0 to hw unblocked
[   10.877156] rfkill: (__rfkill_set_hw_state) switching phy0 to unblocked
[   10.878092] rfkill: (rfkill_register) registering wlan phy0
[   10.878311] rfkill: (rfkill_sync_work) syncing wlan phy0 to unblocked
[   10.878317] rfkill: (rfkill_set_block) switching phy0 to unblocked
[   11.707002] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[   11.707025] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[   11.708584] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[   11.708591] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[   12.707061] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[   12.707072] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked
[   12.708924] rfkill: (rfkill_set_sw_state) setting state of acer-bluetooth to unblocked
[   12.708931] rfkill: (__rfkill_set_sw_state) setting state of acer-bluetooth to sw unblocked
[   13.708133] rfkill: (rfkill_set_sw_state) setting state of acer-wireless to unblocked
[   13.708142] rfkill: (__rfkill_set_sw_state) setting state of acer-wireless to sw unblocked

--Boundary-00=_637iNr9WZFcF6BW--
