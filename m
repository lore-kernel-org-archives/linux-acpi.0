From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 20:32:01 -0600
Message-ID: <4D88A4D1020000230002A366@novprvlin0050.provo.novell.com>
References: <4D882B2A020000230002A319@novprvlin0050.provo.novell.com>
 <201103212144.28512.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201103212144.28512.oldium.pro@seznam.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 21:44 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey Lee,
>=20
> On Monday 21 March 2011 18:52:58 Joey Lee wrote:
> > Hi Old=C5=99ich,
> >=20
> > =E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 05:26 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Add Cc. to experts: Johannes Berg, David S. Miller, Marcel Holtma=
nn and
> > > Gary Lin
> > >=20
> > > Hi Old=C5=99ich,
> > >=20
> > > =E6=96=BC =E6=97=A5=EF=BC=8C2011-03-20 =E6=96=BC 21:09 +0100=EF=BC=
=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Joey Lee,
> > > >=20
> > > > Finally I've got little time to expriment.
> > >=20
> > > Thank's for you also reserve time to trace it. And, I also add co=
mment
> > > on bugzilla:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D31002
> > >=20
> > > > On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> > > > > Hi Old=C5=99ich,
> > > > >=20
> > > > > =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=
=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > >=20
> > > > > > > After trace rfkill-input stuff, I thought this is rfkill-=
input's
> > > > > > > normal behavior but not a bug.
> > > > > > >=20
> > > > > > > Unfortunately, I didn't find any workaround way when a dr=
iver
> > > > > > > need to call rfkill_init_sw_state, e.g. acer-wmi driver.
> > > > > > >=20
> > > > > > > The rfkill-input will sync the rfkill state to all killsw=
itchs
> > > > > > > that have the same type. For example, acer-wmi set the in=
itial
> > > > > > > software switch to _BLOCK_ when driver initial, then
> > > > > > > rfkill-input will also set any new bluetooth killswitch s=
tate to
> > > > > > > _BLOCK_ .
> > > > > >=20
> > > > > > The rfkill_sync_work syncs with rfkill_global_states, which=
 is set
> > > > > > during intitialization or by rfkill_switch_all, if I read i=
t
> > > > > > correctly. This should be independent to acer-bluetooth sta=
te. The
> > > > > > rfkill_global_states[BLUETOOTH] should be unblocked initial=
ly, I
> > > > > > need to verify it.
> > > > >=20
> > > > > Yes!
> > > > > Ideally, killswitch state should be independent to different =
driver,
> > > > > even the killswitch type is the same.
> > > > >=20
> > > > > But,
> > > > > If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will
> > > > > replicate state for each killswitch that have the same type:
> > > > >=20
> > > > > vi net/rfkill/core.c
> > > > >=20
> > > > > int __must_check rfkill_register(struct rfkill *rfkill)
> > > > > {
> > > > > ...
> > > > >=20
> > > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > > >        =20
> > > > >                 schedule_work(&rfkill->sync_work);
> > > > >        =20
> > > > >         } else {		/* if rfkill->persistent then set the state=
=20
> to all
> > > >=20
> > > > the
> > > >=20
> > > > > same type */ #ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL=
_INPUT =3D
> > > > > Y */
> > > > >=20
> > > > >                 bool soft_blocked =3D !!(rfkill->state &
> > > > >                 RFKILL_BLOCK_SW);
> > > > >                =20
> > > > >                 if (!atomic_read(&rfkill_input_disabled))
> > > > >                =20
> > > > >                         __rfkill_switch_all(rfkill->type,
> > > > >                         soft_blocked);	/*
> > > > >=20
> > > > > here call switch all to sync state */ #endif
> > > > >=20
> > > > >         }
> > > > >=20
> > > > > When any driver call rfkill_init_sw_state for set the initial=
 state
> > > > > to killswitch, this rfkill->persistent will set to true:
> > > > >=20
> > > > > void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked=
)	/*
> > > > > acer-
> > > >=20
> > > > wmi
> > > >=20
> > > > > driver used it to set inital killswitch state */ {
> > > > > ....
> > > > >=20
> > > > >         spin_lock_irqsave(&rfkill->lock, flags);
> > > > >         __rfkill_set_sw_state(rfkill, blocked);
> > > > >         rfkill->persistent =3D true			/* persistent set to=20
> true */
> > > > >=20
> > > > > That's why acer-wmi bluetooth killswitch's state was been rep=
licate
> > > > > to hci_core's killswitch state.
> > > > >=20
> > > > > When CONFIG_RFKILL_INPUT set to Y, and any driver call
> > > > > rfkill_init_sw_state before register rfkill, then rfkill_regi=
ster
> > > > > will try to sync state to the same killswitch type like the a=
bove.
> > > > >=20
> > > > > It's make sense,
> > > > > because rfkill-input only can block/unblock the same killswit=
ch type
> > > > > at the same time, before rfkill-input active, it want all the=
 same
> > > > > type's state is full the same.
> > > > >=20
> > > > > And,
> > > > > rfkill-input also suppose user only can use keycode (maybe Fn=
 key) to
> > > > > control killswitch state, so, direct use rkill tool or echo s=
tate to
> > > > > killswitch for change the state will cause killswitchs' state=
 lost
> > > > > link. It like we do.
> > > > >=20
> > > > > > There is some magic in rfkill/input.c that plays with globa=
l
> > > > > > states, but I don't know if or how that one is used in my c=
ase.
> > > > >=20
> > > > > Suggest you can disable CONFIG_RFKILL_INPUT or markup the fol=
lowing
> > > > > code. You will see the new bluetooth killswitch will be unblo=
ck when
> > > > > it created.
> > > > >=20
> > > > > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > > > > index 0198191..0dec078 100644
> > > > > --- a/net/rfkill/core.c
> > > > > +++ b/net/rfkill/core.c
> > > > > @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct=
 rfkill
> > > > > *rfkill)
> > > > >=20
> > > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > > >        =20
> > > > >                 schedule_work(&rfkill->sync_work);
> > > > >=20
> > > > > -       } else {
> > > > > -#ifdef CONFIG_RFKILL_INPUT
> > > > > -               bool soft_blocked =3D !!(rfkill->state &
> > > > > RFKILL_BLOCK_SW); -
> > > > > -               if (!atomic_read(&rfkill_input_disabled))
> > > > > -                       __rfkill_switch_all(rfkill->type,
> > > > > soft_blocked); -#endif
> > > > > -       }
> > > > > +       } //else {
> > > > > +//#ifdef CONFIG_RFKILL_INPUT
> > > > > +//             bool soft_blocked =3D !!(rfkill->state &
> > > > > RFKILL_BLOCK_SW); +//
> > > > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > > > +//                     __rfkill_switch_all(rfkill->type,
> > > > > soft_blocked); +//#endif
> > > > > +//     }
> > > > >=20
> > > > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> > > >=20
> > > > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Seco=
nd I've
> > > > tried to enable CONFIG_RFKILL_INPUT, but remove the mentioned b=
lock of
> > > > code. The result is working bluetooth HW switch.
> > >=20
> > > Yes, that because the following patch introduce
> > > driver with persistent state will affect the global state only if
> > > rfkill-input is enabled:
> > >=20
> > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.gi=
t;a=3Dcommit
> > > ;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19
> > >=20
> > > It maybe workaround another rfkill-input issue, but causes it rep=
licate
> > > acer-wmi's bluetooth killswitch initial state (or any driver that=
 used
> > > rfkill_init_sw_state) to any new bluetooth killswitch.
> > >=20
> > > It's not make sense.
> > >=20
> > > > > > > Acer's BIOS default setup bluetooth's state is disable wh=
en
> > > > > > > system cold boot, and BIOS also can save the connection d=
evices'
> > > > > > > state when system reboot. Currently, acer-wmi driver have=
 right
> > > > > > > behavior to sync the state with BIOS.
> > > > > > >=20
> > > > > > > Face to your situation, my suggestion is:
> > > > > > >=20
> > > > > > > - Use userland application to correct killswitch state.
> > > > > > >=20
> > > > > > >   highly suggest You can try urfkill daemon:
> > > > > > > http://www.freedesktop.org/wiki/Software/urfkill or
> > > > > > >=20
> > > > > > >   write a startup script to enable bluetooth when system =
boot.
> > > > > > >=20
> > > > > > > - Disable rfkill-input module if you didn't real use it.
> > > > > > >=20
> > > > > > >   The TravelMate 5730G have wifi hotkey that only emit KE=
Y_WLAN,
> > > > > > >   but doesn't emit KEY_BLUETOOTH, that means rfkill-input=
 cann't
> > > > > > >   help you enab> > > > > > I didn't have time to look at =
the problem more deeply to identify
> > > > > > who is setting the global state to "blocked" or what really
> > > > > > happens. Anyway, I did some testing with pressing the HW bl=
uetooth
> > > > > > switch and I saw the following immediately _after_ pressing=
 the HW
> > > > > > switch to enable bluetooth:
> > > > > >=20
> > > > > > oldium ~ # rfkill list
> > > > > > 0: acer-wireless: Wireless LAN
> > > > > >=20
> > > > > >         Soft blocked: no
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > 1: acer-bluetooth: Bluetooth
> > > > > >=20
> > > > > >         Soft blocked: no
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > 2: acer-threeg: Wireless WAN
> > > > > >=20
> > > > > >         Soft blocked: yes
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > 3: phy0: Wireless LAN
> > > > > >=20
> > > > > >         Soft blocked: no
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > I had this output 3 times immediately after each other. I'm=
 using
> > > > > > keyboard "up" and "enter" to repeat the last shell command,=
 so this
> > > > > > is a relatively slow operation. So the state when the
> > > > > > acer-bluetooth was unbloc> > > >
> > > > > > oldium ~ # rfkill list
> > > > > > 0: acer-wireless: Wireless LAN
> > > > > >=20
> > > > > >         Soft blocked: no
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > 1: acer-bluetooth: Bluetooth
> > > > > >=20
> > > > > >         Soft blocked: no
> > > > > >         Hard blocked: no
> > > > > >=20
> > > > > > 2: acer-threeg: Wireless WAN
> > > > > >=20
> > > > > >         Soft blocked: yes
> > > > > >         Hard blocked> > >
> > > > > >=20
> > > > > > 5: hci0: Bluetooth
> > > > > >=20
> > > > > >         Soft blocked: yes
> > > > > >         Hard blocked: no
> > > > >=20
> > > > > My Acer machine have no HW bluetooth key but only have one HW=
 WLAN
> > > > > key that emit KEY_WLAN.
> > > > > Please use lshal to monitor your HW bluetooth key and make su=
re it
> > > > > emit KEY_BLUETOOTH.
> > > >=20
> > > > `lshal -m` outputs this:
> > > >=20
> > > > <bluetooth key pressed>
> > > > 20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input co=
ndition
> > > > ButtonPressed =3D bluetooth
> > > > 20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > > property killswitch.state =3D 1 (0x1)
> > > > 20:45:54.678: usb_device_a5c_2101_noserial added
> > > > ...
> > > > <bluetooth key pressed again>
> > > > 20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input co=
ndition
> > > > ButtonPressed =3D brightness-up
> > > > 20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > > property killswitch.state =3D 0 (0x0)
> > > > 20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
> > > > ...
> > > >=20
> > > > Strange is "brightness-up" key, somebody is wrong here.
> > >=20
> > > Yes, brightness-up key is another story, maybe you can enable acp=
i debug
> > > to look at montior which acpi method or _Q event method used:
> > >=20
> > > echo 0xFFFFFFFF >/sys/module/acpi/parameters/debug_layer
> > > echo 0xF >/sys/module/acpi/parameters/debug_level
> > >=20
> > > But, this is not related to our current killswitch issue, let us =
skip
> > > it.
> > >=20
> > > > > > So it looks like the hci0 went blocked even when the acer-b=
luetooth
> > > > > > switch was unblocked. So it looks like the hci0 state is
> > > > > > independent on the initial acer- bluetooth state.
> > > > > >=20
> > > > > > Hopefully I have some time this evening (CET timezone) to a=
dd some
> > > > > > stack traces and logs to see what really happens on my syst=
em.
> > > > > >=20
> > > > > > Cheers,
> > > > > > Old=C5=99ich.
> > > > >=20
> > > > > Still suggest you can disable CONFIG_RFKILL_INPUT then use rf=
kill
> > > > > tool to set acer-wmi bluetooth killswitch for test, must have
> > > > > different result.
> > > >=20
> > > > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look a=
t
> > > > Kconfig in net/rfkill and there is a line "default y if !EXPERT=
" which
> > > > means (I think) that it would be enabled by default for anybody=
 not
> > > > troubles as I have.
> > >=20
> > > I agreed your point, and I don't think rfkill-input need enable f=
or all
> > > non-Expert user because it sometimes have conflict with EC or use=
rland
> > > behavior.
> > >=20
> > > I still suggest you can disable rfkill-input then please try Gary=
 Lin's
> > > urfkill daemon, it can do what does rfkill-input do and more
> > > flexibility.
> > >=20
> > > > I've tried `rfkill unblock <acer-bluetooth number>` with my sec=
ond test
> > > > (enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works pe=
rfectly.
> > > >=20
> > > > Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to so=
me
> > > > degree, because enabling the config switch changes bluetooth HW=
/SW
> > > > switch from working to not-fully-working.
> > > >=20
> > > > Cheers,
> > > > Old=C5=99ich.
> > >=20
> > > The root cause is what I said in the above, it's hard to fix in k=
ernel
> > > module because user only can choice enable/disable rfkill-input i=
n
> > > Kconfig and even cann't choice it when system boot.
> > >=20
> > > I thought we need:
> > >  - set rfkill-input to EXPERT, remove !EXPERT
> > >  - add a kernel option to rfkill for user can choice enable it or=
 not
> > >=20
> > > when system boot.
> > >=20
> > >  - Add comment in Documentation/rfkill.txt for remind user can us=
e
> > >=20
> > > urfkill daemon (or any other userland daemon) to replace rfkill-i=
nput.
> > >=20
> > > Of course need rfkill experts' more professional comments for thi=
s
> > > topic.
> > > I will try to gener> Thank's a lot!
> > > Joey Lee
> >=20
> > Finally, I removed rfkill_init_sw_state and maintain a rfkill_inite=
d
> > flag to workaround issue, please kindly help to test the following
> > acer-wmi patch, it works fine to me on my acer travelmate 8572 mach=
ine.
> >=20
> > Maybe it will be our backup solution after you tested:
>=20

I attached this workaround patch to bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=3D31002#c8

> The patch works more than well - the bluetooth starts-up automaticall=
y during=20
> boot. I don't know who does it, because it looks like the last action=
 done=20
> before any service gets started.
>=20
> ...
> [    4.434293] acer-wmi: Acer Laptop ACPI-WMI Extras
> ...
> [    4.559937] acer-wmi: Brightness must be controlled by generic vid=
eo driver
> ...
> [    6.024186] usb 8-2: new full speed USB device using uhci_hcd and =
address 2
> [    6.183561] usb 8-2: New USB device found, idVendor=3D0a5c, idProd=
uct=3D2101
> ...
> [    9.763265] udev[1947]: starting version 164
>=20
> It looks like the sync work synchronizes the state to "unblocked". I =
don't=20
> have more time to investigate the difference today, so maybe in follo=
wing days=20
> - if it is important.
>=20
> Regards,
> Old=C5=99ich.
>=20

That's good but odd, good is the patch fixed your issue, odd is the
behavior is not what I want and not match with my TravelMate 8572.

Please then me clear up it. On my TravelMate 8572, the BIOS have 2
different behavior for cold boot (shutdown then press HW power button),
and warm boot (reboot). BIOS is:
	- Cold boot: back to default config is WLAN on, BT off, WWAN on
	- Warm boot: keep the devices state before last time reboot.

So, you can see the above, on my machine when cold boot, the BT state i=
s
off, the rfkill list like following:

linux-7y1r:~ # rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: yes		# BIOS default value is disable when cold bo=
ot
        Hard blocked: no
2: acer-threeg: Wireless WAN
        Soft blocked: no
        Hard blocked: no
3: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

Then I did rfkill unblock acer-bluetooth (sorry my machine have no BT H=
W key):

linux-7y1r:~ # rfkill unblock 1
linux-7y1r:~ # rfkill list
0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: acer-threeg: Wireless WAN
        Soft blocked: no
        Hard blocked: no
3: phy0: Wireless4: hci0: Bluetooth
        Soft blocked: no		#fixed by my patch, hci0's rkfill state defau=
lt is unblock
        Hard blocked: no

I am not sure your TravelMate 5730G's behavior is fully the same with
mine. Could you please find a bit time to look at rfkill state when
system cold boot ?

Of course, please enable rfkill-input and remove any other patch but
only keep my workaround patch:
0001-acer-wmi-remove-rfkill_init_sw_state-to-workaround.patch


Thank's a lot!
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
