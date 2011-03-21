From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 10:25:07 -0600
Message-ID: <4D881693020000230002A2FC@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103160732.15488.oldium.pro@seznam.cz>
 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
 <201103202109.53484.oldium.pro@seznam.cz>
 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
 <1300718135.4052.14.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1300718135.4052.14.camel@jlt3.sipsolutions.net>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: johannes@sipsolutions.net
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Johannes,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 15:35 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
> > > > It maybe workaround another rfkill-input issue, but causes it r=
eplicate acer-wmi's=20
> > > > bluetooth killswitch initial state (or any driver that used rfk=
ill_init_sw_state)=20
> > > > to any new bluetooth killswitch.
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

Sorry for I didn't really capture what your mean. Please then me
introduce the issue's background:

=46or the beginning, I added this patch to acer-wmi driver:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D466449cfe797b8a5d82d25d0e0e08426d8dfba19

Because Acer notebook's BIOS can keep the devices state when system
reboot, so, the above patch add the logic when acer-wmi driver initial
to query the devices state by wmi method then set soft-block to
acer-wmi's killswitch, including wlan, bluetooth and wwan.

The acer-wmi used rfkill_init_sw_state to set the initial state before
rfkill register.

There have source code in rfkill_init_sw_state to set rfkill to
persistent, then rfkill/core.c replicate acer-wmi's bluetooth state to
the same type's rfkill.

        if (!rfkill->persistent || rfkill_epo_lock_active) {
                schedule_work(&rfkill->sync_work);
        } else {
#ifdef CONFIG_RFKILL_INPUT
                bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK_S=
W);

                if (!atomic_read(&rfkill_input_disabled))		//when rfkil=
l-input enable
                        __rfkill_switch_all(rfkill->type, soft_blocked)=
;	//set sw block state to the same type
#endif
        }

> > > Is it possible that acer-wmi reports both a hotkey event _and_ an=
 rfkill
> > > event?
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

No, BIOS only emit acpi notify when user press function key, acer-wmi
driver emit KEY_WLAN to userland after receive the acpi notify. Of
course at this moment, acer-wmi driver need to maintain rfkill state to
sync with real device state.

> It seems that what happens is roughly this:
>  1) at boot, all BT is set to soft-killed due to the way the BIOS
>     started up

Yes, acer BIOS's default value is bluetooth disabled. So, when system
boot, there only have acer-wmi's bluetooth killswitch:

0: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: acer-bluetooth: Bluetooth
        Soft blocked: yes		# default is sw block
        Hard blocked: no
2: acer-threeg: Wireless WAN
        Soft blocked: no
        Hard blocked: no
4: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

There have no hci0's killswtich, because BT device power off by BIOS
when system cold boot.

>  2) when you press the button, it's a toggle, so rfkill-input toggles
>     all BT rfkill instances (acer and hci0)

Per Old=C5=99ich's report, he press bluetooth hardware key then see lik=
e the
following:

4: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
6: acer-wireless: Wireless LAN
        Soft blocked: no
        Hard blocked: no
7: acer-bluetooth: Bluetooth
        Soft blocked: no
        Hard blocked: no
8: acer-threeg: Wirele        Hard blocked: no
9: hci0: Bluetooth
        Soft blocked: yes	# create hci0 rfkill but default is soft bloc=
ked
        Hard blocked: no

I didn't have bluetooth HW key on my Acer machine, but I can unblock ac=
er-wmi bluetooth
rfkill manually to reproduce this issue.

>  3) now acer _also_ reports, via rfkill_set_sw_state(), that the acer=
 BT
>     rfkill instance is not soft-blocked
>=20
> Then again, even that should work fine? Clearly I don't understand th=
e
> issue yet.
>=20

If only use bluetooth HW key to control the rfkill, then it should be
fine. But, Old=C5=99ich report still have problem cann't enable bluetoo=
th
after he press HW key because hci0's bluetooth default set to soft
blocked.

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

If we want to remove rfkill-input, then we need re-compiler kernel. Why
don't add a option for enable/disable it ?

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

Yes, fully agreed your point.=20
That's why I highly suggest Old=C5=99ich to use urfkill daemon to corre=
ct
this situation by userland.

> Still though I don't understand how we arrive at the issue at all.
>=20

Old=C5=99ich's point is current Kconfig for rfkill-input is set to !EXP=
ERT,
that mean any normal user will mean the above problem: hci0's rfkill
default value is soft block. It didn't enable by acer'w HW bluetooth
key.
And, like you said, there still didn't have any distro include urfkill
daemon.

> Old=C5=99ich, can you run "rfkill event" while you press the button w=
ith a
> stock kernel that shows the problem and no patches?
>=20
> johannes
>=20

Thank's a lot!
Joey Lee
