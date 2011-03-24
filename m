From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 06:55:16 -0600
Message-ID: <4D8BD9E4020000230002A575@novprvlin0050.provo.novell.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1300955725.3807.5.camel@jlt3.sipsolutions.net>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: johannes@sipsolutions.net
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Johannes,=20

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:35 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > > Hmm, that I don't understand. Why would that reproduce the issue?=
 Ah,
> > > ok, that's because __rfkill_switch_all() will set global_states, =
and it
> > > happens during init. So it gets registered with the global state,=
 which
> > > is still blocked since you just unblocked this single thing.
> > >=20
> >=20
> > I have no Bluetooth HW key on my machine, but Old=C5=99ich can repr=
oduce this
> > issue by HW key.
>=20
> Yeah but the hw key doesn't send key events?
>=20

It's a good question need to check with Old=C5=99ich for his machine.

If talk about my Acer TravelMate 8572, NO! My machine only have wifi
hotkey, but either BIOS/EC raw mode or wmi mode, the key does not emit
any KEY_* keycode.

But, yes, thank's your remind, as I remember, in some Acer consumer
notebook, they also emit scancode when hotkey pressed, like you said,
maybe they emit both wmi event and scancode.

Not on my machine but need check Old=C5=99ich's machine.

> > > So, it seems that the design here only works if
> >=20
> > The "the design" means call rfkill_init_sw_state before rfkill regi=
ster?
>=20
> I mean the whole notion of persistent rfkill state.
>=20
> > >  a) the bios stores the last state
> >=20
> > This issue happen when "Bluetooth's initial state is disabled befor=
e
> > system boot.", maybe user choice disable bluetooth at last time reb=
oot,
> > then BIOS keep BT disable.
> >=20
> > >  b) the driver only reports key inputs, no rfkill inputs
> > >=20
> > > > If only use bluetooth HW key to control the rfkill, then it sho=
uld be
> > > > fine. But, Old=C5=99ich report still have problem cann't enable=
 bluetooth
> > > > after he press HW key because hci0's bluetooth default set to s=
oft
> > > > blocked.
> > >=20
> > > Yeah that's because the BT hw key seems to generate the wrong eve=
nt?
> > >=20
> >=20
> > No, BT HW key doesn't emit KEY_BLUETOOTH, it emit wmi event, then
> > acer-wmi driver transfer to KEY_BLUETOOTH. Then I think rfkill-inpu=
t (if
> > enabled) also receive KEY_BLUETOOTH.
>=20
> But is this WMI event really intended to be a key event? But ok, that
> just means the reason is what you said:
>=20

Yes, the wmi event is must be a KEY_ event on linux platform, because i=
t
was emited by user press hotkey.

> > I thought maybe it's a race condition the hci0 rfkill generated bef=
ore
> > rfkill-input key work for update the global state ?
>=20
> Yeah, most likely.
>=20
> > > Well I don't think we want to remove rfkill input, ever, because =
that
> > > just leads to a mess where the user has to take action. I'd rathe=
r have
> > > it work out of the box and be overridden by urfkill which should =
work
> > > fine.
> >=20
> > So, we should remove the following statement in
> > Documentation/feature-removal-schedule.txt ?
> >=20
> > What:   CONFIG_RFKILL_INPUT
> > When:   2.6.33
> > Why:    Should be implemented in userspace, policy daemon.
> > Who:    Johannes Berg <johannes@sipsolutions.net>
>=20
> Ah, heh, no, although we've not been able to do this I think we still
> want it. But until people do routinely use urfkill, I think we can't
> remove it because otherwise things just won't work right.
>=20

I thought still need time to promote urfkill.

> > > But due the the behaviour you outlined earlier, I think your patc=
h makes
> > > sense... the BIOS doesn't actually seem to _store_ the rfkill sta=
te
> > > anyway, since it's always off when you cold boot. So why bother u=
sing
> > > that state as the default anyway?
> > >=20
> >=20
> > It's tricky to me for use rfkill_init_sw_state.
> >=20
> > When rfkill-input disabled, everything works fine, but if rfkill-in=
put
> > enabled, then I need very careful to know it will change the global
> > state and causes the global state replicate to any new rfkill.
> >=20
> > Honest, I don't know the rfkill_init_sw_state have the above condit=
ion
> > before I read rfkill source code.
>=20
> Right -- I've only come to understand the exact details during this
> discussion myself. Alan probably modelled it o> > > That will work ar=
ound the problem at hand by making the acer wmi enable
> > > BT whenever it is loaded, but that doesn't seem so bad either.
> > >=20
> >=20
> > Yes, it's not good idea, BIOS can save device states when system re=
boot,
> > I don't want erase the state.
>=20
> So it _does_ store the state? I thought you earlier said it didn't st=
ore
> it, and when you cold rebooted it was always disabled?
>=20

There have 2 different behavior on Acer BIOS:
 - cold boot (shutdown then power on): BIOS will reset to raw state (WL=
AN on, BT off, WWAN on)
 - warm boot (reboot): BIOS will keep last time's state

> > I agreed your point or the urfkill daemon, does it possible we add
> > urfkill daemon information to Kernel document?
>=20
> Yeah I guess we can do that, don't think it'll help much though :)
>=20
> johannes
>=20

I thought still have some engineer will look at kernel document, I will
send patch for add urfkill daemon information to kernel document and ad=
d
Cc. to you for review.


Thank's a lot!
Joey Lee
