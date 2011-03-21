From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Mon, 21 Mar 2011 21:44:27 +0100
Message-ID: <201103212144.28512.oldium.pro@seznam.cz>
References: <4D882B2A020000230002A319@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab1CUUph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Mar 2011 16:45:37 -0400
In-Reply-To: <4D882B2A020000230002A319@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Joey Lee,

On Monday 21 March 2011 18:52:58 Joey Lee wrote:
> Hi Old=C5=99ich,
>=20
> =E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 05:26 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Add Cc. to experts: Johannes Berg, David S. Miller, Marcel Holtmann=
 and
> > Gary Lin
> >=20
> > Hi Old=C5=99ich,
> >=20
> > =E6=96=BC =E6=97=A5=EF=BC=8C2011-03-20 =E6=96=BC 21:09 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Joey Lee,
> > >=20
> > > Finally I've got little time to expriment.
> >=20
> > Thank's for you also reserve time to trace it. And, I also add comm=
ent
> > on bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D31002
> >=20
> > > On Wednesday 16 March 2011 09:59:16 Joey Lee wrote:
> > > > Hi Old=C5=99ich,
> > > >=20
> > > > =E6=96=BC =E4=B8=89=EF=BC=8C2011-03-16 =E6=96=BC 07:32 +0100=EF=
=BC=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > > After trace rfkill-input stuff, I thought this is rfkill-in=
put's
> > > > > > normal behavior but not a bug.
> > > > > >=20
> > > > > > Unfortunately, I didn't find any workaround way when a driv=
er
> > > > > > need to call rfkill_init_sw_state, e.g. acer-wmi driver.
> > > > > >=20
> > > > > > The rfkill-input will sync the rfkill state to all killswit=
chs
> > > > > > that have the same type. For example, acer-wmi set the init=
ial
> > > > > > software switch to _BLOCK_ when driver initial, then
> > > > > > rfkill-input will also set any new bluetooth killswitch sta=
te to
> > > > > > _BLOCK_ .
> > > > >=20
> > > > > The rfkill_sync_work syncs with rfkill_global_states, which i=
s set
> > > > > during intitialization or by rfkill_switch_all, if I read it
> > > > > correctly. This should be independent to acer-bluetooth state=
=2E The
> > > > > rfkill_global_states[BLUETOOTH] should be unblocked initially=
, I
> > > > > need to verify it.
> > > >=20
> > > > Yes!
> > > > Ideally, killswitch state should be independent to different dr=
iver,
> > > > even the killswitch type is the same.
> > > >=20
> > > > But,
> > > > If you enabled CONFIG_RFKILL_INPUT, then rfkill_register will
> > > > replicate state for each killswitch that have the same type:
> > > >=20
> > > > vi net/rfkill/core.c
> > > >=20
> > > > int __must_check rfkill_register(struct rfkill *rfkill)
> > > > {
> > > > ...
> > > >=20
> > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > >        =20
> > > >                 schedule_work(&rfkill->sync_work);
> > > >        =20
> > > >         } else {		/* if rfkill->persistent then set the state=20
to all
> > >=20
> > > the
> > >=20
> > > > same type */ #ifdef CONFIG_RFKILL_INPUT	/* when CONFIG_RFKILL_I=
NPUT =3D
> > > > Y */
> > > >=20
> > > >                 bool soft_blocked =3D !!(rfkill->state &
> > > >                 RFKILL_BLOCK_SW);
> > > >                =20
> > > >                 if (!atomic_read(&rfkill_input_disabled))
> > > >                =20
> > > >                         __rfkill_switch_all(rfkill->type,
> > > >                         soft_blocked);	/*
> > > >=20
> > > > here call switch all to sync state */ #endif
> > > >=20
> > > >         }
> > > >=20
> > > > When any driver call rfkill_init_sw_state for set the initial s=
tate
> > > > to killswitch, this rfkill->persistent will set to true:
> > > >=20
> > > > void rfkill_init_sw_state(struct rfkill *rfkill, bool blocked)	=
/*
> > > > acer-
> > >=20
> > > wmi
> > >=20
> > > > driver used it to set inital killswitch state */ {
> > > > ....
> > > >=20
> > > >         spin_lock_irqsave(&rfkill->lock, flags);
> > > >         __rfkill_set_sw_state(rfkill, blocked);
> > > >         rfkill->persistent =3D true			/* persistent set to=20
true */
> > > >=20
> > > > That's why acer-wmi bluetooth killswitch's state was been repli=
cate
> > > > to hci_core's killswitch state.
> > > >=20
> > > > When CONFIG_RFKILL_INPUT set to Y, and any driver call
> > > > rfkill_init_sw_state before register rfkill, then rfkill_regist=
er
> > > > will try to sync state to the same killswitch type like the abo=
ve.
> > > >=20
> > > > It's make sense,
> > > > because rfkill-input only can block/unblock the same killswitch=
 type
> > > > at the same time, before rfkill-input active, it want all the s=
ame
> > > > type's state is full the same.
> > > >=20
> > > > And,
> > > > rfkill-input also suppose user only can use keycode (maybe Fn k=
ey) to
> > > > control killswitch state, so, direct use rkill tool or echo sta=
te to
> > > > killswitch for change the state will cause killswitchs' state l=
ost
> > > > link. It like we do.
> > > >=20
> > > > > There is some magic in rfkill/input.c that plays with global
> > > > > states, but I don't know if or how that one is used in my cas=
e.
> > > >=20
> > > > Suggest you can disable CONFIG_RFKILL_INPUT or markup the follo=
wing
> > > > code. You will see the new bluetooth killswitch will be unblock=
 when
> > > > it created.
> > > >=20
> > > > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > > > index 0198191..0dec078 100644
> > > > --- a/net/rfkill/core.c
> > > > +++ b/net/rfkill/core.c
> > > > @@ -950,14 +950,14 @@ int __must_check rfkill_register(struct r=
fkill
> > > > *rfkill)
> > > >=20
> > > >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> > > >        =20
> > > >                 schedule_work(&rfkill->sync_work);
> > > >=20
> > > > -       } else {
> > > > -#ifdef CONFIG_RFKILL_INPUT
> > > > -               bool soft_blocked =3D !!(rfkill->state &
> > > > RFKILL_BLOCK_SW); -
> > > > -               if (!atomic_read(&rfkill_input_disabled))
> > > > -                       __rfkill_switch_all(rfkill->type,
> > > > soft_blocked); -#endif
> > > > -       }
> > > > +       } //else {
> > > > +//#ifdef CONFIG_RFKILL_INPUT
> > > > +//             bool soft_blocked =3D !!(rfkill->state &
> > > > RFKILL_BLOCK_SW); +//
> > > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > > +//                     __rfkill_switch_all(rfkill->type,
> > > > soft_blocked); +//#endif
> > > > +//     }
> > > >=20
> > > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> > >=20
> > > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second=
 I've
> > > tried to enable CONFIG_RFKILL_INPUT, but remove the mentioned blo=
ck of
> > > code. The result is working bluetooth HW switch.
> >=20
> > Yes, that because the following patch introduce
> > driver with persistent state will affect the global state only if
> > rfkill-input is enabled:
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit
> > ;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19
> >=20
> > It maybe workaround another rfkill-input issue, but causes it repli=
cate
> > acer-wmi's bluetooth killswitch initial state (or any driver that u=
sed
> > rfkill_init_sw_state) to any new bluetooth killswitch.
> >=20
> > It's not make sense.
> >=20
> > > > > > Acer's BIOS default setup bluetooth's state is disable when
> > > > > > system cold boot, and BIOS also can save the connection dev=
ices'
> > > > > > state when system reboot. Currently, acer-wmi driver have r=
ight
> > > > > > behavior to sync the state with BIOS.
> > > > > >=20
> > > > > > Face to your situation, my suggestion is:
> > > > > >=20
> > > > > > - Use userland application to correct killswitch state.
> > > > > >=20
> > > > > >   highly suggest You can try urfkill daemon:
> > > > > > http://www.freedesktop.org/wiki/Software/urfkill or
> > > > > >=20
> > > > > >   write a startup script to enable bluetooth when system bo=
ot.
> > > > > >=20
> > > > > > - Disable rfkill-input module if you didn't real use it.
> > > > > >=20
> > > > > >   The TravelMate 5730G have wifi hotkey that only emit KEY_=
WLAN,
> > > > > >   but doesn't emit KEY_BLUETOOTH, that means rfkill-input c=
ann't
> > > > > >   help you enable bluetooth killswitch.
> > > > >=20
> > > > > I didn't have time to look at the problem more deeply to iden=
tify
> > > > > who is setting the global state to "blocked" or what really
> > > > > happens. Anyway, I did some testing with pressing the HW blue=
tooth
> > > > > switch and I saw the following immediately _after_ pressing t=
he HW
> > > > > switch to enable bluetooth:
> > > > >=20
> > > > > oldium ~ # rfkill list
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
> > > > > I had this output 3 times immediately after each other. I'm u=
sing
> > > > > keyboard "up" and "enter" to repeat the last shell command, s=
o this
> > > > > is a relatively slow operation. So the state when the
> > > > > acer-bluetooth was unbloc> > > >
> > > > > oldium ~ # rfkill list
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
> > > > >         Hard blocked> > >
> > > > >=20
> > > > > 5: hci0: Bluetooth
> > > > >=20
> > > > >         Soft blocked: yes
> > > > >         Hard blocked: no
> > > >=20
> > > > My Acer machine have no HW bluetooth key but only have one HW W=
LAN
> > > > key that emit KEY_WLAN.
> > > > Please use lshal to monitor your HW bluetooth key and make sure=
 it
> > > > emit KEY_BLUETOOTH.
> > >=20
> > > `lshal -m` outputs this:
> > >=20
> > > <bluetooth key pressed>
> > > 20:45:53.694: platform_i8042_i8042_KBD_port_logicaldev_input cond=
ition
> > > ButtonPressed =3D bluetooth
> > > 20:45:54.666: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > property killswitch.state =3D 1 (0x1)
> > > 20:45:54.678: usb_device_a5c_2101_noserial added
> > > ...
> > > <bluetooth key pressed again>
> > > 20:46:02.435: platform_i8042_i8042_KBD_port_logicaldev_input cond=
ition
> > > ButtonPressed =3D brightness-up
> > > 20:46:02.668: platform_acer_wmi_rfkill_acer_bluetooth_bluetooth
> > > property killswitch.state =3D 0 (0x0)
> > > 20:46:02.919: usb_device_a5c_2101_noserial_if1 removed
> > > ...
> > >=20
> > > Strange is "brightness-up" key, somebody is wrong here.
> >=20
> > Yes, brightness-up key is another story, maybe you can enable acpi =
debug
> > to look at montior which acpi method or _Q event method used:
> >=20
> > echo 0xFFFFFFFF >/sys/module/acpi/parameters/debug_layer
> > echo 0xF >/sys/module/acpi/parameters/debug_level
> >=20
> > But, this is not related to our current killswitch issue, let us sk=
ip
> > it.
> >=20
> > > > > So it looks like the hci0 went blocked even when the acer-blu=
etooth
> > > > > switch was unblocked. So it looks like the hci0 state is
> > > > > independent on the initial acer- bluetooth state.
> > > > >=20
> > > > > Hopefully I have some time this evening (CET timezone) to add=
 some
> > > > > stack traces and logs to see what really happens on my system=
=2E
> > > > >=20
> > > > > Cheers,
> > > > > Old=C5=99ich.
> > > >=20
> > > > Still suggest you can disable CONFIG_RFKILL_INPUT then use rfki=
ll
> > > > tool to set acer-wmi bluetooth killswitch for test, must have
> > > > different result.
> > >=20
> > > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at
> > > Kconfig in net/rfkill and there is a line "default y if !EXPERT" =
which
> > > means (I think) that it would be enabled by default for anybody n=
ot
> > > enabling expert options. So other non-expert users would have the=
 same
> > > troubles as I have.
> >=20
> > I agreed your point, and I don't think rfkill-input need enable for=
 all
> > non-Expert user because it sometimes have conflict with EC or userl=
and
> > behavior.
> >=20
> > I still suggest you can disable rfkill-input then please try Gary L=
in's
> > urfkill daemon, it can do what does rfkill-input do and more
> > flexibility.
> >=20
> > > I've tried `rfkill unblock <acer-bluetooth number>` with my secon=
d test
> > > (enabled CONFIG_RFKILL_INPUT plus patched core.c) - it works perf=
ectly.
> > >=20
> > > Anyway, it looks like using CONFIG_RFKILL_INPUT is broken to some
> > > degree, because enabling the config switch changes bluetooth HW/S=
W
> > > switch from working to not-fully-working.
> > >=20
> > > Cheers,
> > > Old=C5=99ich.
> >=20
> > The root cause is what I said in the above, it's hard to fix in ker=
nel
> > module because user only can choice enable/disable rfkill-input in
> > Kconfig and even cann't choice it when system boot.
> >=20
> > I thought we need:
> >  - set rfkill-input to EXPERT, remove !EXPERT
> >  - add a kernel option to rfkill for user can choice enable it or n=
ot
> >=20
> > when system boot.
> >=20
> >  - Add comment in Documentation/rfkill.txt for remind user can use
> >=20
> > urfkill daemon (or any other userland daemon) to replace rfkill-inp=
ut.
> >=20
> > Of course need rfkill experts' more professional comments for this
> > topic.
> > I will try to gener> Thank's a lot!
> > Joey Lee
>=20
> Finally, I removed rfkill_init_sw_state and maintain a rfkill_inited
> flag to workaround issue, please kindly help to test the following
> acer-wmi patch, it works fine to me on my acer travelmate 8572 machin=
e.
>=20
> Maybe it will be our backup solution after you tested:

The patch works more than well - the bluetooth starts-up automatically =
during=20
boot. I don't know who does it, because it looks like the last action d=
one=20
before any service gets started.

=2E..
[    4.434293] acer-wmi: Acer Laptop ACPI-WMI Extras
=2E..
[    4.559937] acer-wmi: Brightness must be controlled by generic video=
 driver
=2E..
[    6.024186] usb 8-2: new full speed USB device using uhci_hcd and ad=
dress 2
[    6.183561] usb 8-2: New USB device found, idVendor=3D0a5c, idProduc=
t=3D2101
=2E..
[    9.763265] udev[1947]: starting version 164

It looks like the sync work synchronizes the state to "unblocked". I do=
n't=20
have more time to investigate the difference today, so maybe in followi=
ng days=20
- if it is important.

Regards,
Old=C5=99ich.

> >From dd3d9208aa63d9670d24409b4aaaeb619f3137d6 Mon Sep 17 00:00:00 20=
01
>=20
> From: Lee, Chun-Yi <jlee@novell.com>
> Date: Tue, 22 Mar 2011 01:43:11 +0800
> Subject: [PATCH] acer-wmi: remove rfkill_init_sw_state to workaround
> rfkill-input issue
>=20
> acer-wmi: remove rfkill_init_sw_state to workaround issue for bko#310=
02
>=20
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> ---
>  drivers/platform/x86/acer-wmi.c |   19 ++++++++++++++-----
>  1 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c
> b/drivers/platform/x86/acer-wmi.c index 38b34a7..3d3cb46 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -222,6 +222,7 @@ struct acer_debug {
>  static struct rfkill *wireless_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *threeg_rfkill;
> +static int rfkill_inited;
>=20
>  /* Each low-level interface must define at least some of the followi=
ng */
>  struct wmi_interface {
> @@ -1161,9 +1162,13 @@ static int acer_rfkill_set(void *data, bool bl=
ocked)
>  {
>  	acpi_status status;
>  	u32 cap =3D (unsigned long)data;
> -	status =3D set_u32(!blocked, cap);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> +
> +	if (rfkill_inited) {
> +		status =3D set_u32(!blocked, cap);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -1187,14 +1192,16 @@ static struct rfkill *acer_rfkill_register(st=
ruct
> device *dev, return ERR_PTR(-ENOMEM);
>=20
>  	status =3D get_device_status(&state, cap);
> -	if (ACPI_SUCCESS(status))
> -		rfkill_init_sw_state(rfkill_dev, !state);
>=20
>  	err =3D rfkill_register(rfkill_dev);
>  	if (err) {
>  		rfkill_destroy(rfkill_dev);
>  		return ERR_PTR(err);
>  	}
> +
> +	if (ACPI_SUCCESS(status))
> +		rfkill_set_sw_state(rfkill_dev, !state);
> +
>  	return rfkill_dev;
>  }
>=20
> @@ -1229,6 +1236,8 @@ static int acer_rfkill_init(struct device *dev)
>  		}
>  	}
>=20
> +	rfkill_inited =3D 1;
> +
>  	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ)=
);
>=20
>  	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
