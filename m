From: "Joey Lee" <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 24 Mar 2011 01:01:32 -0600
Message-ID: <4D8B86FC020000230002A543@novprvlin0050.provo.novell.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300882647.3790.17.camel-8upI4CBIZJIJvtFkdXX2HixXY32XiHfO@public.gmane.org>
Content-Disposition: inline
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Gary Lin <GLin-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Johannes,=20

=E6=96=BC =E4=B8=89=EF=BC=8C2011-03-23 =E6=96=BC 13:17 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> [remove Alan, his email address no longer works]
>=20
> Hi,
>=20
> > Sorry for I didn't really capture what your mean. Please then me
> > introduce the issue's background:
> >=20
> > For the beginning, I added this patch to acer-wmi driver:
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit;h=3D466449cfe797b8a5d82d25d0e0e08426d8dfba19
> >=20
> > Because Acer notebook's BIOS can keep the devices state when system
> > reboot, so, the above patch add the logic when acer-wmi driver init=
ial
> > to query the devices state by wmi method then set soft-block to
> > acer-wmi's killswitch, including wlan, bluetooth and wwan.
> >=20
> > The acer-wmi used rfkill_init_sw_state to set the initial state bef=
ore
> > rfkill register.
>=20
> Yeah that seems reasonable.
>=20

Yes, use rfill_init_sw_state to set the initial state from BIOS to
killswitch is make sense.

But, it looks like have tricky effect when rfkill-input enabled.

> > There have source code in rfkill_init_sw_state to set rfkill to
> > persistent, then rfkill/core.c replicate acer-wmi's bluetooth state=
 to
> > the same type's rfkill.
> >=20
> >         if (!rfkill->persistent || rfkill_epo_lock_active) {
> >                 schedule_work(&rfkill->sync_work);
> >         } else {
> > #ifdef CONFIG_RFKILL_INPUT
> >                 bool soft_blocked =3D !!(rfkill->state & RFKILL_BLO=
CK_SW);
> >=20
> >                 if (!atomic_read(&rfkill_input_disabled))		//when r=
fkill-input enable
> >                         __rfkill_switch_all(rfkill->type, soft_bloc=
ked);	//set sw block state to the same type
> > #endif
> >         }
>=20
> But that's also required to actually make the persistent state have a=
ny
> impact at all.
>=20

Yes, per Alan's patch, there have another issue need to workaround by
set the block state to global, and those code might need removed in the
future:

commit b3fa1329eaf2a7b97124dacf5b663fd51346ac19
Author: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Date:   Mon Jun 8 13:27:27 2009 +0100

=2E...

    Drivers with persistent state will affect the global state only if
    rfkill-input is enabled.  This is required, otherwise booting with
    wireless soft-blocked and pressing the wireless-toggle key once wou=
ld
    have no apparent effect.  This special case will be removed in futu=
re
    along with rfkill-input, in favour of a more flexible userspace dae=
mon
    (see Documentation/feature-removal-schedule.txt).

But,=20
the above code replicate acer-wmi's initial state to global, then set t=
o hci0's
BT initial state.

> > No, BIOS only emit acpi notify when user press function key, acer-w=
mi
> > driver emit KEY_WLAN to userland after receive the acpi notify. Of
> > course at this moment, acer-wmi driver need to maintain rfkill stat=
e to
> > sync with real device state.
>=20
> So, I'm confused. Why does the driver not use the acer_wmi_notify
> function to update the rfkill status too, but polls it every second?
>=20

I already have a patch to use acer-wmi_notify to set device state:
http://www.spinics.net/lists/platform-driver-x86/msg01645.html

It didn't accept, yet. But, even have this patch, there still have some
old acer machine need use polling way because those machines have no wm=
i
event notify.

> > > It seems that what happens is roughly this:
> > >  1) at boot, all BT is set to soft-killed due to the way the BIOS
> > >     started up
> >=20
> > Yes, acer BIOS's default value is bluetooth disabled. So, when syst=
em
> > boot, there only have acer-wmi's bluetooth killswitch:
> >=20
> > 0: acer-wireless: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
> > 1: acer-bluetooth: Bluetooth
> >         Soft blocked: yes		# default is sw block
> >         Hard blocked: no
> > 2: acer-threeg: Wireless WAN
> >         Soft blocked: no
> >         Hard blocked: no
> > 4: phy0: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
> >=20
> > There have no hci0'> > when system cold boot.
>=20
> Right -- I missed that part.
>=20
> > >  2) when you press the button, it's a toggle, so rfkill-input tog=
gles
> > >     all BT rfkill instances (acer and hci0)
> >=20
> > Per Old=C5=99ich's report, he press bluetooth hardware key then see=
 like the
> > following:
> >=20
> > 4: phy0: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
> > 6: acer-wireless: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
> > 7: acer-bluetooth: Bluetooth
> >         Soft blocked: no
> >         Hard blocked: no
> > 8: acer-threeg: Wirele        Hard blocked: no
> > 9: hci0: Bluetooth
> >         Soft blocked: yes	# create hci0 rfkill but default is soft =
blocked
> >         Hard blocked: no
> >=20
> > I didn't have bluetooth HW key on my Acer machine, but I can unbloc=
k acer-wmi bluetooth
> > rfkill manually to reproduce this issue.
>=20
> Hmm, that I don't understand. Why would that reproduce the issue? Ah,
> ok, that's because __rfkill_switch_all() will set global_states, and =
it
> happens during init. So it gets registered with the global state, whi=
ch
> is still blocked since you just unblocked this single thing.
>=20

I have no Bluetooth HW key on my machine, but Old=C5=99ich can reproduc=
e this
issue by HW key.

> So, it seems that the design here only works if

The "the design" means call rfkill_init_sw_state before rfkill register=
?

>  a) the bios stores the last state

This issue happen when "Bluetooth's initial state is disabled before
system boot.", maybe user choice disable bluetooth at last time reboot,
then BIOS keep BT disable.

>  b) the driver only reports key inputs, no rfkill inputs
>=20
> > If only use bluetooth HW key to control the rfkill, then it should =
be
> > fine. But, Old=C5=99ich report still have problem cann't enable blu=
etooth
> > after he press HW key because hci0's bluetooth default set to soft
> > blocked.
>=20
> Yeah that's because the BT hw key seems to generate the wrong event?
>=20

No, BT HW key doesn't emit KEY_BLUETOOTH, it emit wmi event, then
acer-wmi driver transfer to KEY_BLUETOOTH. Then I think rfkill-input (i=
f
enabled) also receive KEY_BLUETOOTH.

I thought maybe it's a race condition the hci0 rfkill generated before
rfkill-input key work for update the global state ?

> > If we want to remove rfkill-input, then we need re-compiler kernel.=
 Why
> > don't add a option for enable/disable it ?
>=20
> Well I don't think we want to remove rfkill input, ever, because that
> just leads to a mess where the user has to take action. I'd rather ha=
ve
> it work out of the box and be overridden by urfkill which should work
> fine.
>=20

So, we should remove the following statement in
Documentation/feature-removal-schedule.txt ?

What:   CONFIG_RFKILL_INPUT
When:   2.6.33
Why:    Should be implemented in userspace, policy daemon.
Who:    Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>

> Of course, in this particular instance it _doesn't_ work out of the b=
ox,
> but shouldn't we rather fix that?
>=20

Yes, if we want to keep the CONFIG_RFKILL_INPUT is !EXPERT, then I
thought we should try to fix it.

>=20
>=20
> But due the the behaviour you outlined earlier, I think your patch ma=
kes
> sense... the BIOS doesn't actually seem to _store_ the rfkill state
> anyway, since it's always off when you cold boot. So why bother using
> that state as the default anyway?
>=20

It's tricky to me for use rfkill_init_sw_state.

When rfkill-input disabled, everything works fine, but if rfkill-input
enabled, then I need very careful to know it will change the global
state and causes the global state replicate to any new rfkill.

Honest, I don't know the rfkill_init_sw_state have the above condition
before I read rfkill source code.

> That will work around the problem at hand by making the acer wmi enab=
le
> BT whenever it is loaded, but that doesn't seem so bad either.
>=20

Yes, it's not good idea, BIOS can save device states when system reboot=
,
I don't want erase the state.

> As for the more generiI agreed your point or the urfkill daemon, does=
 it possible we add
urfkill daemon information to Kernel document?


Thank's a lot!
Joey Lee
