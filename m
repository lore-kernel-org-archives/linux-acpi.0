From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Mon, 21 Mar 2011 20:27:01 +0100
Message-ID: <201103212027.01952.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com> <1300718135.4052.14.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1300718135.4052.14.camel@jlt3.sipsolutions.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Joey Lee <jlee@novell.com>, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Johaness,

Just a small correction.

On Monday 21 March 2011 15:35:35 Johannes Berg wrote:
> Hi,
>=20
> > > > It maybe workaround another rfkill-input issue, but causes it
> > > > replicate acer-wmi's bluetooth killswitch initial state (or any
> > > > driver that used rfkill_init_sw_state) to any new bluetooth
> > > > killswitch.
> > > >=20
> > > > It's not make sense.
> > >=20
> > > I think the reason is that rfkill-input only has a global concept=
 of
> > > per-device states. The alternative would be to force a newly regi=
stered
> > > rfkill device to the state that was set by rfkill-input.
> >=20
> > Yes
>=20
> I don't know if that works though. Does it make more sense? I'm not
> sure. Why bother with "persistent" then anyway? I think the logic as =
we
> had it was meant to make things follow the persistent state you had
> before you shut down and that was saved in the BIOS or whatever.
>=20
> > > Is it possible that acer-wmi reports both a hotkey event _and_ an
> > > rfkill event?
> >=20
> > Emit needlessly KEY_BLUETOOTH when acer-wmi initial may not a good =
idea
> > if there have any userland daemon to listen the keycode.
> >=20
> > I am trying to remove rfkill_init_sw_state then workaround this iss=
ue
> > in .set_block by maintain a driver initial flag in acer-wmi.
>=20
> No I mean ... it seems that the BIOS reports both a hotkey and an rfk=
ill
> event. Could those be clashing?
>=20
> It seems that what happens is roughly this:
>  1) at boot, all BT is set to soft-killed due to the way the BIOS
>     started up
>  2) when you press the button, it's a toggle, so rfkill-input toggles
>     all BT rfkill instances (acer and hci0)
>  3) now acer _also_ reports, via rfkill_set_sw_state(), that the acer=
 BT
>     rfkill instance is not soft-blocked
>=20
> Then again, even that should work fine? Clearly I don't understand th=
e
> issue yet.

hci0 doesn't exist when the BT switch is off. The hci0 device and rfkil=
l switch=20
appears when you unblock SW rfkill or by pressing the HW switch. It dis=
appears=20
when you block the switch again. hci0 is set to "blocked" when it appea=
rs,=20
because the acer-wmi driver have registered acpi-bluetooth rfkill switc=
h=20
during boot, which was set to "blocked" initially with a call to=20
rfkill_init_sw_state. So what happens actually is this:

1) at boot, BIOS says the bluetooth is disabled, so the not-registered =
state=20
of acer-bluetooth rfkill is set to "blocked" (rfkill_init_sw_state, set=
s the=20
"persistent" bit). The acer-bluetooth is then registered, which forces =
the=20
global bluetooth state to go "blocked". No hci0 exists at this time.

2) when you press the button, hci0 appears and the rfkill is set to the=
 global=20
bluetooth state (in rfkill_sync_work), which is "blocked".

=46rom my understanding acer-wmi reports the change via acer_rfkill_upd=
ate work=20
(executed every second). It just calls rfkill_set_sw_state, but that do=
esn't=20
update the global state. I don't know at which time that happens, but=20
generally I didn't find anything that could eventually enable hci0 stat=
e or=20
global state to "unblocked".

Cheers,
Old=C5=99ich.

>=20
> > Does it possible we add this rfkill module option for user can cont=
rol
> > disable rfkill-input when rfkill driver probed?
> >=20
> > Because, distro was shipped with different company's machine, like:=
 Acer
> > or MSI, different machines almost have different wifi/bluetooth/wwa=
n key
> > use case.
>=20
> Well, I don't think we should require a config to work "out of the bo=
x",
> so I'm not sure that makes sense.
>=20
> > Sometimes, we want to use rfkill-input, but sometimes we have userl=
and
> > GUI application to provide rfkill control panel to end user. We alr=
eady
> > used urfkill daemon to disable rfkill-input by ioctl way, but like =
this
> > issue, it was happen on driver probe.
>=20
> Yeah but when urfkill starts up, it could just force the status it
> thinks things have. Since it can simply override the current status
> there doesn't seem to be a need for disabling the logic first.
>=20
> Still though I don't understand how we arrive at the issue at all.
>=20
> Old=C5=99ich, can you run "rfkill event" while you press the button w=
ith a
> stock kernel that shows the problem and no patches?
>=20
> johannes
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
