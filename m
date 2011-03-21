From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 15:35:35 +0100
Message-ID: <1300718135.4052.14.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <201103160732.15488.oldium.pro@seznam.cz>
	 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
	 <201103202109.53484.oldium.pro@seznam.cz>
	 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
	 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
	 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:40103 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab1CUOfm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Mar 2011 10:35:42 -0400
In-Reply-To: <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi,

> > > It maybe workaround another rfkill-input issue, but causes it rep=
licate acer-wmi's=20
> > > bluetooth killswitch initial state (or any driver that used rfkil=
l_init_sw_state)=20
> > > to any new bluetooth killswitch.
> > >=20
> > > It's not make sense.
> >=20
> > I think the reason is that rfkill-input only has a global concept o=
f
> > per-device states. The alternative would be to force a newly regist=
ered
> > rfkill device to the state that was set by rfkill-input.
>=20
> Yes

I don't know if that works though. Does it make more sense? I'm not
sure. Why bother with "persistent" then anyway? I think the logic as we
had it was meant to make things follow the persistent state you had
before you shut down and that was saved in the BIOS or whatever.

> > Is it possible that acer-wmi reports both a hotkey event _and_ an r=
fkill
> > event?
>=20
> Emit needlessly KEY_BLUETOOTH when acer-wmi initial may not a good id=
ea
> if there have any userland daemon to listen the keycode.
>=20
> I am trying to remove rfkill_init_sw_state then workaround this issue
> in .set_block by maintain a driver initial flag in acer-wmi.

No I mean ... it seems that the BIOS reports both a hotkey and an rfkil=
l
event. Could those be clashing?

It seems that what happens is roughly this:
 1) at boot, all BT is set to soft-killed due to the way the BIOS
    started up
 2) when you press the button, it's a toggle, so rfkill-input toggles
    all BT rfkill instances (acer and hci0)
 3) now acer _also_ reports, via rfkill_set_sw_state(), that the acer B=
T
    rfkill instance is not soft-blocked

Then again, even that should work fine? Clearly I don't understand the
issue yet.

> Does it possible we add this rfkill module option for user can contro=
l
> disable rfkill-input when rfkill driver probed?
>=20
> Because, distro was shipped with different company's machine, like: A=
cer
> or MSI, different machines almost have different wifi/bluetooth/wwan =
key
> use case.

Well, I don't think we should require a config to work "out of the box"=
,
so I'm not sure that makes sense.

> Sometimes, we want to use rfkill-input, but sometimes we have userlan=
d
> GUI application to provide rfkill control panel to end user. We alrea=
dy
> used urfkill daemon to disable rfkill-input by ioctl way, but like th=
is
> issue, it was happen on driver probe.

Yeah but when urfkill starts up, it could just force the status it
thinks things have. Since it can simply override the current status
there doesn't seem to be a need for disabling the logic first.

Still though I don't understand how we arrive at the issue at all.

Old=C5=99ich, can you run "rfkill event" while you press the button wit=
h a
stock kernel that shows the problem and no patches?

johannes


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
