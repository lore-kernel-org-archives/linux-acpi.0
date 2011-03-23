From: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Wed, 23 Mar 2011 12:58:08 +0100
Message-ID: <1300881488.3790.4.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
	 <1300718135.4052.14.camel@jlt3.sipsolutions.net>
	 <201103212027.01952.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201103212027.01952.oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Cc: Joey Lee <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Gary Lin <GLin-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2011-03-21 at 20:27 +0100, Old=C5=99ich Jedli=C4=8Dka wrote:

> hci0 doesn't exist when the BT switch is off. The hci0 device and rfk=
ill switch=20
> appears when you unblock SW rfkill or by pressing the HW switch. It d=
isappears=20
> when you block the switch again. hci0 is set to "blocked" when it app=
ears,=20
> because the acer-wmi driver have registered acpi-bluetooth rfkill swi=
tch=20
> during boot, which was set to "blocked" initially with a call to=20
> rfkill_init_sw_state. So what happens actually is this:
>=20
> 1) at boot, BIOS says the bluetooth is disabled, so the not-registere=
d state=20
> of acer-bluetooth rfkill is set to "blocked" (rfkill_init_sw_state, s=
ets the=20
> "persistent" bit). The acer-bluetooth is then registered, which force=
s the=20
> global bluetooth state to go "blocked". No hci0 exists at this time.
>=20
> 2) when you press the button, hci0 appears and the rfkill is set to t=
he global=20
> bluetooth state (in rfkill_sync_work), which is "blocked".
>=20
> From my understanding acer-wmi reports the change via acer_rfkill_upd=
ate work=20
> (executed every second). It just calls rfkill_set_sw_state, but that =
doesn't=20
> update the global state. I don't know at which time that happens, but=
=20
> generally I didn't find anything that could eventually enable hci0 st=
ate or=20
> global state to "unblocked".

Ah. So I guess when hci0 gets registered, the acer rfkill state hasn't
been updated yet, hence registering hci0 as blocked.

johannes
