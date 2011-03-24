From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 09:35:25 +0100
Message-ID: <1300955725.3807.5.camel@jlt3.sipsolutions.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:36578 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933713Ab1CXIfc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Mar 2011 04:35:32 -0400
In-Reply-To: <4D8B86FC020000230002A543@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Joey,

> Yes, per Alan's patch, there have another issue need to workaround by
> set the block state to global, and those code might need removed in t=
he
> future:
>=20
> commit b3fa1329eaf2a7b97124dacf5b663fd51346ac19
> Author: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Date:   Mon Jun 8 13:27:27 2009 +0100
>=20
> ....
>=20
>     Drivers with persistent state will affect the global state only i=
f
>     rfkill-input is enabled.  This is required, otherwise booting wit=
h
>     wireless soft-blocked and pressing the wireless-toggle key once w=
ould
>     have no apparent effect.  This special case will be removed in fu=
ture
>     along with rfkill-input, in favour of a more flexible userspace d=
aemon
>     (see Documentation/feature-removal-schedule.txt).

Well, right, that's just hinting that rfkill-input will be removed at
some point, hopefully!

> But,=20
> the above code replicate acer-wmi's initial state to global, then set=
 to hci0's
> BT initial state.

Right.

> > Hmm, that I don't understand. Why would that reproduce the issue? A=
h,
> > ok, that's because __rfkill_switch_all() will set global_states, an=
d it
> > happens during init. So it gets registered with the global state, w=
hich
> > is still blocked since you just unblocked this single thing.
> >=20
>=20
> I have no Bluetooth HW key on my machine, but Old=C5=99ich can reprod=
uce this
> issue by HW key.

Yeah but the hw key doesn't send key events?

> > So, it seems that the design here only works if
>=20
> The "the design" means call rfkill_init_sw_state before rfkill regist=
er?

I mean the whole notion of persistent rfkill state.

> >  a) the bios stores the last state
>=20
> This issue happen when "Bluetooth's initial state is disabled before
> system boot.", maybe user choice disable bluetooth at last time reboo=
t,
> then BIOS keep BT disable.
>=20
> >  b) the driver only reports key inputs, no rfkill inputs
> >=20
> > > If only use bluetooth HW key to control the rfkill, then it shoul=
d be
> > > fine. But, Old=C5=99ich report still have problem cann't enable b=
luetooth
> > > after he press HW key because hci0's bluetooth default set to sof=
t
> > > blocked.
> >=20
> > Yeah that's because the BT hw key seems to generate the wrong event=
?
> >=20
>=20
> No, BT HW key doesn't emit KEY_BLUETOOTH, it emit wmi event, then
> acer-wmi driver transfer to KEY_BLUETOOTH. Then I think rfkill-input =
(if
> enabled) also receive KEY_BLUETOOTH.

But is this WMI event really intended to be a key event? But ok, that
just means the reason is what you said:

> I thought maybe it's a race condition the hci0 rfkill generated befor=
e
> rfkill-input key work for update the global state ?

Yeah, most likely.

> > Well I don't think we want to remove rfkill input, ever, because th=
at
> > just leads to a mess where the user has to take action. I'd rather =
have
> > it work out of the box and be overridden by urfkill which should wo=
rk
> > fine.
>=20
> So, we should remove the following statement in
> Documentation/feature-removal-schedule.txt ?
>=20
> What:   CONFIG_RFKILL_INPUT
> When:   2.6.33
> Why:    Should be implemented in userspace, policy daemon.
> Who:    Johannes Berg <johannes@sipsolutions.net>

Ah, heh, no, although we've not been able to do this I think we still
want it. But until people do routinely use urfkill, I think we can't
remove it because otherwise things just won't work right.

> > But due the the behaviour you outlined earlier, I think your patch =
makes
> > sense... the BIOS doesn't actually seem to _store_ the rfkill state
> > anyway, since it's always off when you cold boot. So why bother usi=
ng
> > that state as the default anyway?
> >=20
>=20
> It's tricky to me for use rfkill_init_sw_state.
>=20
> When rfkill-input disabled, everything works fine, but if rfkill-inpu=
t
> enabled, then I need very careful to know it will change the global
> state and causes the global state replicate to any new rfkill.
>=20
> Honest, I don't know the rfkill_init_sw_state have the above conditio=
n
> before I read rfkill source code.

Right -- I've only come to understand the exact details during this
discussion myself. Alan probably modelled it on Wifi where the
disconnect issue doesn't typically appear.

> > That will work around the problem at hand by making the acer wmi en=
able
> > BT whenever it is loaded, but that doesn't seem so bad either.
> >=20
>=20
> Yes, it's not good idea, BIOS can save device states when system rebo=
ot,
> I don't want erase the state.

So it _does_ store the state? I thought you earlier said it didn't stor=
e
it, and when you cold rebooted it was always disabled?

> I agreed your point or the urfkill daemon, does it possible we add
> urfkill daemon information to Kernel document?

Yeah I guess we can do that, don't think it'll help much though :)

johannes

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
