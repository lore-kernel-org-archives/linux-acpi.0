From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Wed, 30 Mar 2011 20:49:36 +0200
Message-ID: <201103302049.36845.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <201103252022.26766.oldium.pro@seznam.cz> <4D90E9D0020000230002A7EC@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52192 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab1C3Stp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2011 14:49:45 -0400
In-Reply-To: <4D90E9D0020000230002A7EC@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Ho Joey Lee,

On Monday 28 March 2011 11:04:32 Joey Lee wrote:
> Hi Old=C5=99ic,
>=20
> =E6=96=BC =E4=BA=94=EF=BC=8C2011-03-25 =E6=96=BC 20:22 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Hi Joey Lee,
> >=20
> > On Friday 25 March 2011 09:13:20 Joey Lee wrote:
> > > Hi Old=C5=99ich,
> > >=20
> > > Per our log.
> > > It's a interesting and weird situation.
> > >=20
> > > Your log subvert my assumption, the BT HW key only emit one
> > > KEY_BLUETOOTH from ec but not from acer-wmi.
> > >=20
> > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 22:34 +0100=EF=BC=
=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Joey Lee,
> > > >=20
> > > > I've done some experiments, here are the results.
> > > >=20
> > > > On Thursday 24 March 2011 14:13:29 Joey Lee wrote:
> > > > > Hi Old=C5=99ich,
> > > > >=20
> > > > > Sorry bother you again, but after discuss with Johannes, he r=
emind
> > > > > me one import thing: maybe your BT HW key emit scancode and w=
mi
> > > > > event at the same time.
> > > > >=20
> > > > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:36 +0100=EF=
=BC=8CJohannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > >=20
> > > > > > Hi Old=C5=99ich,
> > > > > >=20
> > > > > > > > Ah. So I guess when hci0 gets registered, the acer rfki=
ll
> > > > > > > > state hasn't been updated yet, hence registering hci0 a=
s
> > > > > > > > blocked.
> > > > > > >=20
> > > > > > > No, that is not the case. I can play with `rfkill list`
> > > > > > > immediately after I press the HW bluetooth switch and sho=
w
> > > > > > > that hci0 is not there (still unregistered) while
> > > > > > > acer-bluetooth is already "unblocked" - I've tried to run
> > > > > > > `rfkill list` repeatedly manually from console immediatel=
y
> > > > > > > after I pressed the HW BT switch and acer-bluetooth was
> > > > > > > "unblocked" several runs while the hci0 wasn't there. Whe=
n
> > > > > > > hci0 appeared, it was "blocked".
> > > > > > >=20
> > > > > > > As I wrote, I didn't find anything changing the global st=
ate,
> > > > > > > which is actually used to "block" the newly appearing hci=
0 (in
> > > > > > > the rfkill_sync_work method). It looks like the global st=
ate
> > > > > > > is just "blocked" forever - and it is "blocked" as a
> > > > > > > side-effect of the call to rfkill_init_sw_state (changes
> > > > > > > permanent=3Dtrue) and then call to rfkill_register from t=
he
> > > > > > > acer-wmi driver. I can verify this in the following days =
(that
> > > > > > > the global state stays the same all the time).
> > > > > >=20
> > > > > > Well the global state would be changed by the KEY_BLUETOOTH=
 input
> > > > > > event.
> > > > > >=20
> > > > > > But like I said, it's tricky in this case because multiple =
events
> > > > > > come from the same event source and race against each other=
=2E
> > > > > >=20
> > > > > > johannes
> > > > >=20
> > > > > My Acer TravelMate 8572 is commercial notebook, it only emit =
wmi
> > > > > event when press wifi key. But, as I remember, there have som=
e
> > > > > acer consumer notebook emit both scancode and wmi event.
> > > > >=20
> > > > > New acer-wmi driver will transfer wmi event to keycode (e.g.
> > > > > KEY_BLUETOOTH), if EC also emit KEY_BLUETOOTH, the rfkill-inp=
ut
> > > > > will
> > > > >=20
> > > > > receive the key events twice, that means:
> > > > > 	global BT block (when system boot) -> BT unblock (from EC
> > > > > 	scancode)
> >=20
> > ->
> >=20
> > > > > 	BT
> > > > >=20
> > > > > block (from acer-wmi)
> > > > >=20
> > > > > Could you please help me to check?
> > > > >=20
> > > > > 	- If your distro still have HAL, please run:
> > > > > 		+ lshal -l -m
> > > > > 		+ press BT HW key 1 time
> > > > > 		then check does HAL receive KEY_BLUETOOTH twice?
> > > >=20
> > > > I didn't uninstall hal yet, so the output of `lshal -l -m` (onl=
y the
> > > > monitoring part) when I press once BT HW key is attached. I've =
also
> > > > patched the kernel to have more debug logging (see the attached=
 diff
> > > > and log) and the result is that the handler method from
> > > > rfkill/input.c is not called, the global state is once set to
> > > > "blocked" and it keeps like that. I don't know why the rfkill_e=
vent
> > > > isn't called when I press the HW BT switch, it could be part of=
 my
> > > > investigations in the following days.
> > > >=20
> > > > I've attached .config too, if you want to check that I missed
> > > > something that is needed by Acer WMI.
> > > >=20
> > > > Cheers,
> > > > Old=C5=99ich.
> > >=20
> > > Per your lshal log, looks like HAL only receive the key event fro=
m EC
> > > but didn't have key event from acer-wmi:
> > >=20
> > > *** 22:21:01.310: lshal: device_condition,
> > > udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_=
logicald
> > > ev_i nput condition_name=3DButtonPressed
> > >=20
> > >            condition_details=3Dbluetooth			//it's from standard
> >=20
> > input
> >=20
> > > *** 22:21:02.076: lshal: property_modified,
> > > udi=3D/org/freedesktop/Hal/devices/platform_acer_wmi_rfkill_acer_=
bluetoot
> > > h_bl uetooth, key=3Dkillswitch.state is_removed=3Dfalse, is_added=
=3Dfalse ***
> > > new value: 1 (0x1)  (int)				//UNBLOCK when you press BT HW
> >=20
> > key
> >=20
> > > So, there have only one KEY_BLUETOOTH from ec, acer-wmi didn't em=
it it.
> > > I thought your machine didn't support Acer ACPI event GUIDs. Plea=
se
> > > dump the dsdt to me, thank's: acpidump > acpidump.dat
> > >=20
> > > Then, if there only have one KEY_BLUETOOTH, why the global BT sta=
te
> > > didn't change by rfill-input? Technically, rfkill-input must rece=
ive
> > > this key then change global state:
> > >=20
> > > your situation:
> > > 		initial		press HW key
> > >=20
> > > acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> > > global		BLOCK		 BLOCK (why didn't changed by rfkill-input?)
> > > hci0		none		 BLOCK (replicate from global)
> > >=20
> > > Like you said, the odd thing is:
> > > 	"Why rfkill-input didn't receive KEY_BLUEOOTH from ec on your
> > > 	machine?"
> > >=20
> > > We need find out root cause, but I thought my last patch still wo=
rks to
> > > fix your situation and it make sense for Acer BIOS didn't really
> > > persistence devices state.
> > >=20
> > > applied my patch:
> > > 		initial		press HW key
> > >=20
> > > acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> > > global		UNBLOCK		UNBLOCK (didn't changed by rfkill-input?)
> > > hci0		none		 UNBLOCK (replicate from global)
> > >=20
> > >=20
> > > Conclusion...
> > >=20
> > > please kindly help to provide the following information:
> > >  - Please provide DSDT to me
> > > =20
> > >  	+ I want to double check your BIOS didn't support acer wmi even=
t.
> > > =20
> > >  - Why rfkill-input didn't call by BT HW key?
> > > =20
> > > 	+ please remember disable urfkill daemon, it might disabled
> > > 	rfkill-input! + please provide dmesg and messages log to me
> >=20
> > Here you are (dmesg, /var/log/messages, acpidump):
> >   http://others-misc.oldium.net/dump.tar.gz
> >=20
> > I hope this finally helps to find something :-)
> >=20
> > Cheers,
> > Old=C5=99ich.
>=20
> I sand out patch to platform driver group for review:
> 0001-acer-wmi-does-not-set-persistence-state-by-rfkill_i.patch
>=20
> And added comment on bugzilla:
> 	https://bugzilla.kernel.org/show_bug.cgi?id=3D31002#c12

Works for me, I've put a comment on the bugreport.

Cheers,
Old=C5=99ich.

> Thank's
> Joey Lee
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
