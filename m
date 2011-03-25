From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Fri, 25 Mar 2011 20:22:26 +0100
Message-ID: <201103252022.26766.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <201103242234.03598.oldium.pro@seznam.cz> <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59551 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1CYTWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2011 15:22:34 -0400
In-Reply-To: <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Joey Lee,

On Friday 25 March 2011 09:13:20 Joey Lee wrote:
> Hi Old=C5=99ich,
>=20
> Per our log.
> It's a interesting and weird situation.
>=20
> Your log subvert my assumption, the BT HW key only emit one
> KEY_BLUETOOTH from ec but not from acer-wmi.
>=20
> =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 22:34 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > Hi Joey Lee,
> >=20
> > I've done some experiments, here are the results.
> >=20
> > On Thursday 24 March 2011 14:13:29 Joey Lee wrote:
> > > Hi Old=C5=99ich,
> > >=20
> > > Sorry bother you again, but after discuss with Johannes, he remin=
d me
> > > one import thing: maybe your BT HW key emit scancode and wmi even=
t at
> > > the same time.
> > >=20
> > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:36 +0100=EF=BC=
=8CJohannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Old=C5=99ich,
> > > >=20
> > > > > > Ah. So I guess when hci0 gets registered, the acer rfkill s=
tate
> > > > > > hasn't been updated yet, hence registering hci0 as blocked.
> > > > >=20
> > > > > No, that is not the case. I can play with `rfkill list` immed=
iately
> > > > > after I press the HW bluetooth switch and show that hci0 is n=
ot
> > > > > there (still unregistered) while acer-bluetooth is already
> > > > > "unblocked" - I've tried to run `rfkill list` repeatedly manu=
ally
> > > > > from console immediately after I pressed the HW BT switch and
> > > > > acer-bluetooth was "unblocked" several runs while the hci0 wa=
sn't
> > > > > there. When hci0 appeared, it was "blocked".
> > > > >=20
> > > > > As I wrote, I didn't find anything changing the global state,=
 which
> > > > > is actually used to "block" the newly appearing hci0 (in the
> > > > > rfkill_sync_work method). It looks like the global state is j=
ust
> > > > > "blocked" forever - and it is "blocked" as a side-effect of t=
he
> > > > > call to rfkill_init_sw_state (changes permanent=3Dtrue) and t=
hen
> > > > > call to rfkill_register from the acer-wmi driver. I can verif=
y
> > > > > this in the following days (that the global state stays the s=
ame
> > > > > all the time).
> > > >=20
> > > > Well the global state would be changed by the KEY_BLUETOOTH inp=
ut
> > > > event.
> > > >=20
> > > > But like I said, it's tricky in this case because multiple even=
ts
> > > > come from the same event source and race against each other.
> > > >=20
> > > > johannes
> > >=20
> > > My Acer TravelMate 8572 is commercial notebook, it only emit wmi =
event
> > > when press wifi key. But, as I remember, there have some acer con=
sumer
> > > notebook emit both scancode and wmi event.
> > >=20
> > > New acer-wmi driver will transfer wmi event to keycode (e.g.
> > > KEY_BLUETOOTH), if EC also emit KEY_BLUETOOTH, the rfkill-input w=
ill
> > >=20
> > > receive the key events twice, that means:
> > > 	global BT block (when system boot) -> BT unblock (from EC scanco=
de)=20
->
> > > 	BT
> > >=20
> > > block (from acer-wmi)
> > >=20
> > > Could you please help me to check?
> > >=20
> > > 	- If your distro still have HAL, please run:
> > > 		+ lshal -l -m
> > > 		+ press BT HW key 1 time
> > > 		then check does HAL receive KEY_BLUETOOTH twice?
> >=20
> > I didn't uninstall hal yet, so the output of `lshal -l -m` (only th=
e
> > monitoring part) when I press once BT HW key is attached. I've also
> > patched the kernel to have more debug logging (see the attached dif=
f and
> > log) and the result is that the handler method from rfkill/input.c =
is
> > not called, the global state is once set to "blocked" and it keeps =
like
> > that. I don't know why the rfkill_event isn't called when I press t=
he HW
> > BT switch, it could be part of my investigations in the following d=
ays.
> >=20
> > I've attached .config too, if you want to check that I missed somet=
hing
> > that is needed by Acer WMI.
> >=20
> > Cheers,
> > Old=C5=99ich.
>=20
> Per your lshal log, looks like HAL only receive the key event from EC
> but didn't have key event from acer-wmi:
>=20
> *** 22:21:01.310: lshal: device_condition,
> udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_logi=
caldev_i
> nput condition_name=3DButtonPressed
>            condition_details=3Dbluetooth			//it's from standard=20
input
>=20
> *** 22:21:02.076: lshal: property_modified,
> udi=3D/org/freedesktop/Hal/devices/platform_acer_wmi_rfkill_acer_blue=
tooth_bl
> uetooth, key=3Dkillswitch.state is_removed=3Dfalse, is_added=3Dfalse
> *** new value: 1 (0x1)  (int)				//UNBLOCK when you press BT HW=20
key
>=20
>=20
> So, there have only one KEY_BLUETOOTH from ec, acer-wmi didn't emit i=
t. I
> thought your machine didn't support Acer ACPI event GUIDs. Please dum=
p the
> dsdt to me, thank's: acpidump > acpidump.dat
>=20
> Then, if there only have one KEY_BLUETOOTH, why the global BT state d=
idn't
> change by rfill-input? Technically, rfkill-input must receive this ke=
y
> then change global state:
>=20
> your situation:
> 		initial		press HW key
> acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> global		BLOCK		 BLOCK (why didn't changed by rfkill-input?)
> hci0		none		 BLOCK (replicate from global)
>=20
> Like you said, the odd thing is:
> 	"Why rfkill-input didn't receive KEY_BLUEOOTH from ec on your machin=
e?"
>=20
> We need find out root cause, but I thought my last patch still works =
to fix
> your situation and it make sense for Acer BIOS didn't really persiste=
nce
> devices state.
>=20
> applied my patch:
> 		initial		press HW key
> acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> global		UNBLOCK		UNBLOCK (didn't changed by rfkill-input?)
> hci0		none		 UNBLOCK (replicate from global)
>=20
>=20
> Conclusion...
> please kindly help to provide the following information:
>=20
>  - Please provide DSDT to me
>  	+ I want to double check your BIOS didn't support acer wmi event.
>=20
>  - Why rfkill-input didn't call by BT HW key?
> 	+ please remember disable urfkill daemon, it might disabled rfkill-i=
nput!
> 	+ please provide dmesg and messages log to me

Here you are (dmesg, /var/log/messages, acpidump):

  http://others-misc.oldium.net/dump.tar.gz

I hope this finally helps to find something :-)

Cheers,
Old=C5=99ich.

>=20
>=20
> Thank's a lot!
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
