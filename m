From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Fri, 25 Mar 2011 07:29:12 +0100
Message-ID: <201103250729.13550.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D8BDE29020000230002A585@novprvlin0050.provo.novell.com> <201103242234.03598.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201103242234.03598.oldium.pro@seznam.cz>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

My yesterday's e-mail probably didn't pass through the spam checks of m=
ail=20
server. If anybody needs to look at the missing attachments, I've place=
d them=20
at=20

  http://others-misc.oldium.net/attachments.tar.gz

Cheers,
Old=C5=99ich.

On Thursday 24 March 2011 22:34:03 Old=C5=99ich Jedli=C4=8Dka wrote:
> Hi Joey Lee,
>=20
> I've done some experiments, here are the results.
>=20
> On Thursday 24 March 2011 14:13:29 Joey Lee wrote:
> > Hi Old=C5=99ich,
> >=20
> > Sorry bother you again, but after discuss with Johannes, he remind =
me
> > one import thing: maybe your BT HW key emit scancode and wmi event =
at
> > the same time.
> >=20
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:36 +0100=EF=BC=8C=
Johannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Old=C5=99ich,
> > >=20
> > > > > Ah. So I guess when hci0 gets registered, the acer rfkill sta=
te
> > > > > hasn't been updated yet, hence registering hci0 as blocked.
> > > >=20
> > > > No, that is not the case. I can play with `rfkill list` immedia=
tely
> > > > after I press the HW bluetooth switch and show that hci0 is not=
 there
> > > > (still unregistered) while acer-bluetooth is already "unblocked=
" -
> > > > I've tried to run `rfkill list` repeatedly manually from consol=
e
> > > > immediately after I pressed the HW BT switch and acer-bluetooth=
 was
> > > > "unblocked" several runs while the hci0 wasn't there. When hci0
> > > > appeared, it was "blocked".
> > > >=20
> > > > As I wrote, I didn't find anything changing the global state, w=
hich
> > > > is actually used to "block" the newly appearing hci0 (in the
> > > > rfkill_sync_work method). It looks like the global state is jus=
t
> > > > "blocked" forever - and it is "blocked" as a side-effect of the=
 call
> > > > to rfkill_init_sw_state (changes permanent=3Dtrue) and then cal=
l to
> > > > rfkill_register from the acer-wmi driver. I can verify this in =
the
> > > > following days (that the global state stays the same all the ti=
me).
> > >=20
> > > Well the global state would be changed by the KEY_BLUETOOTH input
> > > event.
> > >=20
> > > But like I said, it's tricky in this case because multiple events=
 come
> > > from the same event source and race against each other.
> > >=20
> > > johannes
> >=20
> > My Acer TravelMate 8572 is commercial notebook, it only emit wmi ev=
ent
> > when press wifi key. But, as I remember, there have some acer consu=
mer
> > notebook emit both scancode and wmi event.
> >=20
> > New acer-wmi driver will transfer wmi event to keycode (e.g.
> > KEY_BLUETOOTH), if EC also emit KEY_BLUETOOTH, the rfkill-input wil=
l
> >=20
> > receive the key events twice, that means:
> > 	global BT block (when system boot) -> BT unblock (from EC scancode=
) ->
> > 	BT
> >=20
> > block (from acer-wmi)
> >=20
> > Could you please help me to check?
> >=20
> > 	- If your distro still have HAL, please run:
> > 		+ lshal -l -m
> > 		+ press BT HW key 1 time
> > 		then check does HAL receive KEY_BLUETOOTH twice?
>=20
> I didn't uninstall hal yet, so the output of `lshal -l -m` (only the
> monitoring part) when I press once BT HW key is attached. I've also p=
atched
> the kernel to have more debug logging (see the attached diff and log)=
 and
> the result is that the handler method from rfkill/input.c is not call=
ed,
> the global state is once set to "blocked" and it keeps like that. I d=
on't
> know why the rfkill_event isn't called when I press the HW BT switch,=
 it
> could be part of my investigations in the following days.
>=20
> I've attached .config too, if you want to check that I missed somethi=
ng
> that is needed by Acer WMI.
>=20
> Cheers,
> Old=C5=99ich.
>=20
> > 	- Or, please try the following patch, it removed
> > =09
> > 	  KEY_BLUETOOTH support in acer-wmi. If removed it but the BT kill=
switch
> > 	  still can reserve when you press BT HW key, that means not just
> >=20
> > 	  acer-wmi emit KEY_BLUETOOTH:
> > Thank's a lot!
> > Joey Lee
> >=20
> > >From 20b3b8ba26cb37c8a44d11645c2d8d1f5344cfd7 Mon Sep 17 00:00:00 =
2001
> >=20
> > From: Lee, Chun-Yi <jlee@novell.com>
> > Date: Thu, 24 Mar 2011 21:07:43 +0800
> > Subject: [PATCH] remove KEY_BLUETOOTH for testing
> >=20
> >=20
> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > ---
> >=20
> >  drivers/platform/x86/acer-wmi.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/acer-wmi.c
> > b/drivers/platform/x86/acer-wmi.c index c978470..554ee12 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -102,7 +102,6 @@ enum acer_wmi_event_ids {
> >=20
> >  static const struct key_entry acer_wmi_keymap[] =3D {
> > =20
> >  	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
> >=20
> > -	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
> >=20
> >  	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
> >  	{KE_KEY, 0x22, {KEY_PROG2} },    /* Arcade */
> >  	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
