From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 07:36:58 -0600
Message-ID: <4D8BE3AA020000230002A590@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103160732.15488.oldium.pro@seznam.cz>
 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
 <201103202109.53484.oldium.pro@seznam.cz>
 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
 <1300718135.4052.14.camel@jlt3.sipsolutions.net>
 <4D881693020000230002A2FC@novprvlin0050.provo.novell.com>
 <1300882647.3790.17.camel@jlt3.sipsolutions.net>
 <4D8B86FC020000230002A543@novprvlin0050.provo.novell.com>
 <1300955725.3807.5.camel@jlt3.sipsolutions.net>
 <4D8BD9E4020000230002A575@novprvlin0050.provo.novell.com>
 <1300971517.3807.17.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1300971517.3807.17.camel@jlt3.sipsolutions.net>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: johannes@sipsolutions.net
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 13:58 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
>=20
> > > So it _does_ store the state? I thought you earlier said it didn'=
t store
> > > it, and when you cold rebooted it was always disabled?
> > >=20
> >=20
> > There have 2 different behavior on Acer BIOS:
> >  - cold boot (shutdown then power on): BIOS will reset to raw state=
 (WLAN on, BT off, WWAN on)
> >  - warm boot (reboot): BIOS will keep last time's state
>=20
> Yeah but in that case I don't really see the point in making it
> persistent. It's not really persistent anyway, warm reboot just means=
 it

OK, thank's, now I understand the definition to _persistent_.

> was stuck somewhere in memory I guess... I'd not call this persistent=
,
> and making it not persistent also solves the problem, right?
>=20
> johannes
>=20
>=20

Yes, if we don't set the default initial state to persistent, then can
workaround this issue, and it also can fix the issue when user only
control acer-wmi's state by userland application.=20

Just hope Old=C5=99ich can help to double check does his BT HW key also=
 emit
scancode? I thought the success logic like the following:


After applied my solution + rfkill-input
(already confirm works fine by Old=C5=99ich):

		initial		scancode from EC	from wmi event
-----------------------------------------------------------------------=
-------------------------------------------------------------------
acer-wmi	BLOCK		BLOCK(base on global) UNBLOCK
global		UNBLOCK		BLOCK			UNBLOCK


Then it make sense for why Old=C5=99ich saw the hci0's killswitch is UN=
BLOCK.

After confirm that, I will send out patch to mainline and 2.6.38 kernel=
 for
fix BKO#31002.


Thank's a lot!
Joey Lee
