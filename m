From: "Joey Lee" <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 07:13:29 -0600
Message-ID: <4D8BDE29020000230002A585@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103212027.01952.oldium.pro@seznam.cz>
 <1300881488.3790.4.camel@jlt3.sipsolutions.net>
 <201103232238.41761.oldium.pro@seznam.cz>
 <1300955793.3807.6.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300955793.3807.6.camel-8upI4CBIZJIJvtFkdXX2HixXY32XiHfO@public.gmane.org>
Content-Disposition: inline
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Gary Lin <GLin-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Old=C5=99ich,

Sorry bother you again, but after discuss with Johannes, he remind me
one import thing: maybe your BT HW key emit scancode and wmi event at
the same time.

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:36 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Old=C5=99ich,
>=20
> > > Ah. So I guess when hci0 gets registered, the acer rfkill state h=
asn't
> > > been updated yet, hence registering hci0 as blocked.
> >=20
> > No, that is not the case. I can play with `rfkill list` immediately=
 after I=20
> > press the HW bluetooth switch and show that hci0 is not there (stil=
l=20
> > unregistered) while acer-bluetooth is already "unblocked" - I've tr=
ied to run=20
> > `rfkill list` repeatedly manually from console immediately after I =
pressed the=20
> > HW BT switch and acer-bluetooth was "unblocked" several runs while =
the hci0=20
> > wasn't there. When hci0 appeared, it was "blocked".
> >=20
> > As I wrote, I didn't find anything changing the global state, which=
 is actually=20
> > used to "block" the newly appearing hci0 (in the rfkill_sync_work m=
ethod). It=20
> > looks like the global state is just "blocked" forever - and it is "=
blocked" as=20
> > a side-effect of the call to rfkill_init_sw_state (changes permanen=
t=3Dtrue) and=20
> > then call to rfkill_register from the acer-wmi driver. I can verify=
 this in=20
> > the following days (that the global state stays the same all the ti=
me).
>=20
> Well the global state would be changed by the KEY_BLUETOOTH input eve=
nt.
>=20
> But like I said, it's tricky in this case because multiple events com=
e
> from the same event source and race against each other.
>=20
> johannes

My Acer TravelMate 8572 is commercial notebook, it only emit wmi event
when press wifi key. But, as I remember, there have some acer consumer
notebook emit both scancode and wmi event.=20

New acer-wmi driver will transfer wmi event to keycode (e.g.
KEY_BLUETOOTH), if EC also emit KEY_BLUETOOTH, the rfkill-input will
receive the key events twice, that means:
	global BT block (when system boot) -> BT unblock (from EC scancode) ->=
 BT block (from acer-wmi)

Could you please help me to check?
	- If your distro still have HAL, please run:
		+ lshal -l -m
		+ press BT HW key 1 time
		then check does HAL receive KEY_BLUETOOTH twice?
	- Or, please try the following patch, it removed
	  KEY_BLUETOOTH support in acer-wmi. If removed it but the BT killswit=
ch
	  still can reserve when you press BT HW key, that means not just
	  acer-wmi emit KEY_BLUETOOTH:


Thank's a lot!
Joey Lee



>From 20b3b8ba26cb37c8a44d11645c2d8d1f5344cfd7 Mon Sep 17 00:00:00 2001
=46rom: Lee, Chun-Yi <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Date: Thu, 24 Mar 2011 21:07:43 +0800
Subject: [PATCH] remove KEY_BLUETOOTH for testing


Signed-off-by: Lee, Chun-Yi <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
---
 drivers/platform/x86/acer-wmi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
index c978470..554ee12 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -102,7 +102,6 @@ enum acer_wmi_event_ids {
=20
 static const struct key_entry acer_wmi_keymap[] =3D {
 	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
-	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
 	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
 	{KE_KEY, 0x22, {KEY_PROG2} },    /* Arcade */
 	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
--=20
1.6.0.2
