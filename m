From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 09:36:33 +0100
Message-ID: <1300955793.3807.6.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <201103212027.01952.oldium.pro@seznam.cz>
	 <1300881488.3790.4.camel@jlt3.sipsolutions.net>
	 <201103232238.41761.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201103232238.41761.oldium.pro@seznam.cz>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Cc: Joey Lee <jlee@novell.com>, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Old=C5=99ich,

> > Ah. So I guess when hci0 gets registered, the acer rfkill state has=
n't
> > been updated yet, hence registering hci0 as blocked.
>=20
> No, that is not the case. I can play with `rfkill list` immediately a=
fter I=20
> press the HW bluetooth switch and show that hci0 is not there (still=20
> unregistered) while acer-bluetooth is already "unblocked" - I've trie=
d to run=20
> `rfkill list` repeatedly manually from console immediately after I pr=
essed the=20
> HW BT switch and acer-bluetooth was "unblocked" several runs while th=
e hci0=20
> wasn't there. When hci0 appeared, it was "blocked".
>=20
> As I wrote, I didn't find anything changing the global state, which i=
s actually=20
> used to "block" the newly appearing hci0 (in the rfkill_sync_work met=
hod). It=20
> looks like the global state is just "blocked" forever - and it is "bl=
ocked" as=20
> a side-effect of the call to rfkill_init_sw_state (changes permanent=3D=
true) and=20
> then call to rfkill_register from the acer-wmi driver. I can verify t=
his in=20
> the following days (that the global state stays the same all the time=
).

Well the global state would be changed by the KEY_BLUETOOTH input event=
=2E

But like I said, it's tricky in this case because multiple events come
from the same event source and race against each other.

johannes
