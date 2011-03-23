From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Wed, 23 Mar 2011 22:38:41 +0100
Message-ID: <201103232238.41761.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <201103212027.01952.oldium.pro@seznam.cz> <1300881488.3790.4.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51515 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab1CWVmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 17:42:44 -0400
In-Reply-To: <1300881488.3790.4.camel@jlt3.sipsolutions.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Joey Lee <jlee@novell.com>, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Johaness,

On Wednesday 23 March 2011 12:58:08 Johannes Berg wrote:
> On Mon, 2011-03-21 at 20:27 +0100, Old=C5=99ich Jedli=C4=8Dka wrote:
> > hci0 doesn't exist when the BT switch is off. The hci0 device and r=
fkill
> > switch appears when you unblock SW rfkill or by pressing the HW swi=
tch.
> > It disappears when you block the switch again. hci0 is set to "bloc=
ked"
> > when it appears, because the acer-wmi driver have registered
> > acpi-bluetooth rfkill switch during boot, which was set to "blocked=
"
> > initially with a call to rfkill_init_sw_state. So what happens actu=
ally
> > is this:
> >=20
> > 1) at boot, BIOS says the bluetooth is disabled, so the not-registe=
red
> > state of acer-bluetooth rfkill is set to "blocked"
> > (rfkill_init_sw_state, sets the "persistent" bit). The acer-bluetoo=
th is
> > then registered, which forces the global bluetooth state to go
> > "blocked". No hci0 exists at this time.
> >=20
> > 2) when you press the button, hci0 appears and the rfkill is set to=
 the
> > global bluetooth state (in rfkill_sync_work), which is "blocked".
> >=20
> > From my understanding acer-wmi reports the change via acer_rfkill_u=
pdate
> > work (executed every second). It just calls rfkill_set_sw_state, bu=
t
> > that doesn't update the global state. I don't know at which time th=
at
> > happens, but generally I didn't find anything that could eventually
> > enable hci0 state or global state to "unblocked".
>=20
> Ah. So I guess when hci0 gets registered, the acer rfkill state hasn'=
t
> been updated yet, hence registering hci0 as blocked.

No, that is not the case. I can play with `rfkill list` immediately aft=
er I=20
press the HW bluetooth switch and show that hci0 is not there (still=20
unregistered) while acer-bluetooth is already "unblocked" - I've tried =
to run=20
`rfkill list` repeatedly manually from console immediately after I pres=
sed the=20
HW BT switch and acer-bluetooth was "unblocked" several runs while the =
hci0=20
wasn't there. When hci0 appeared, it was "blocked".

As I wrote, I didn't find anything changing the global state, which is =
actually=20
used to "block" the newly appearing hci0 (in the rfkill_sync_work metho=
d). It=20
looks like the global state is just "blocked" forever - and it is "bloc=
ked" as=20
a side-effect of the call to rfkill_init_sw_state (changes permanent=3D=
true) and=20
then call to rfkill_register from the acer-wmi driver. I can verify thi=
s in=20
the following days (that the global state stays the same all the time).

Cheers,
Old=C5=99ich.

>=20
> johannes
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
