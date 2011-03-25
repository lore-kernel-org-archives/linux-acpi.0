From: "Joey Lee" <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Fri, 25 Mar 2011 02:13:20 -0600
Message-ID: <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <1300955793.3807.6.camel@jlt3.sipsolutions.net>
 <4D8BDE29020000230002A585@novprvlin0050.provo.novell.com>
 <201103242234.03598.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103242234.03598.oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Content-Disposition: inline
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Gary Lin <GLin-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Old=C5=99ich,=20

Per our log.
It's a interesting and weird situation.

Your log subvert my assumption, the BT HW key only emit one
KEY_BLUETOOTH from ec but not from acer-wmi.

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 22:34 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
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
hich is
> > > > actually used to "block" the newly appearing hci0 (in the
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
> > > Well the global state would be changed by the KEY_BLUETOOTH input=
 event.
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
> > receive the key events twice, that means:
> > 	global BT block (when system boot) -> BT unblock (from EC scancode=
) -> BT
> > block (from acer-wmi)
> >=20
> > Could you please help me to check?
> > 	- If your distro still have HAL, please run:
> > 		+ lshal -l -m
> > 		+ press BT HW key 1 time
> > 		then check does HAL receive KEY_BLUETOOTH twice?
>=20
> I didn't uninstall hal yet, so the output of `lshal -l -m` (only the=20
> monitoring part) when I press once BT HW key is attached. I've also p=
atched=20
> the kernel to have more debug logging (see the attached diff and log)=
 and the=20
> result is that the handler method from rfkill/input.c is not called, =
the=20
> global state is once set to "blocked" and it keeps like that. I don't=
 know why=20
> the rfkill_event isn't called when I press the HW BT switch, it could=
 be part=20
> of my investigations in the following days.
>=20
> I've attached .config too, if you want to check that I missed somethi=
ng that is=20
> needed by Acer WMI.
>=20
> Cheers,
> Old=C5=99ich.
>=20

Per your lshal log, looks like HAL only receive the key event from EC
but didn't have key event from acer-wmi:

*** 22:21:01.310: lshal: device_condition,
udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_logica=
ldev_input
           condition_name=3DButtonPressed
           condition_details=3Dbluetooth			//it's from standard input

*** 22:21:02.076: lshal: property_modified,
udi=3D/org/freedesktop/Hal/devices/platform_acer_wmi_rfkill_acer_blueto=
oth_bluetooth, key=3Dkillswitch.state
           is_removed=3Dfalse, is_added=3Dfalse
*** new value: 1 (0x1)  (int)				//UNBLOCK when you press BT HW key


So, there have only one KEY_BLUETOOTH from ec, acer-wmi didn't emit it.=
 I thought your
machine didn't support Acer ACPI event GUIDs. Please dump the dsdt to m=
e, thank's:
	acpidump > acpidump.dat

Then, if there only have one KEY_BLUETOOTH, why the global BT state did=
n't change by
rfill-input? Technically, rfkill-input must receive this key then chang=
e global state:

your situation:
		initial		press HW key
acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
global		BLOCK		 BLOCK (why didn't changed by rfkill-input?)	=09
hci0		none		 BLOCK (replicate from global)

Like you said, the odd thing is:
	"Why rfkill-input didn't receive KEY_BLUEOOTH from ec on your machine?=
"

We need find out root cause, but I thought my last patch still works to=
 fix your
situation and it make sense for Acer BIOS didn't really persistence dev=
ices state.

applied my patch:
		initial		press HW key
acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
global		UNBLOCK		UNBLOCK (didn't changed by rfkill-input?)	=09
hci0		none		 UNBLOCK (replicate from global)


Conclusion...
please kindly help to provide the following information:

 - Please provide DSDT to me
 	+ I want to double check your BIOS didn't support acer wmi event.

 - Why rfkill-input didn't call by BT HW key?
	+ please remember disable urfkill daemon, it might disabled rfkill-inp=
ut!
	+ please provide dmesg and messages log to me


Thank's a lot!
Joey Lee
