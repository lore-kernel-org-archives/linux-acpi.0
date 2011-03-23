From: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Wed, 23 Mar 2011 13:17:27 +0100
Message-ID: <1300882647.3790.17.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <201103160732.15488.oldium.pro@seznam.cz>
	 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
	 <201103202109.53484.oldium.pro@seznam.cz>
	 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
	 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
	 <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
	 <1300718135.4052.14.camel@jlt3.sipsolutions.net>
	 <4D881693020000230002A2FC@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D881693020000230002A2FC-jb/6P8Q/KsjOKUPnnb0SpZ/xhEQF/MHJojBamW5iJbs@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joey Lee <jlee-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, Al Cho <ACho-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Gary Lin <GLin-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, oldium.pro-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[remove Alan, his email address no longer works]

Hi,

> Sorry for I didn't really capture what your mean. Please then me
> introduce the issue's background:
>=20
> For the beginning, I added this patch to acer-wmi driver:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D466449cfe797b8a5d82d25d0e0e08426d8dfba19
>=20
> Because Acer notebook's BIOS can keep the devices state when system
> reboot, so, the above patch add the logic when acer-wmi driver initia=
l
> to query the devices state by wmi method then set soft-block to
> acer-wmi's killswitch, including wlan, bluetooth and wwan.
>=20
> The acer-wmi used rfkill_init_sw_state to set the initial state befor=
e
> rfkill register.

Yeah that seems reasonable.

> There have source code in rfkill_init_sw_state to set rfkill to
> persistent, then rfkill/core.c replicate acer-wmi's bluetooth state t=
o
> the same type's rfkill.
>=20
>         if (!rfkill->persistent || rfkill_epo_lock_active) {
>                 schedule_work(&rfkill->sync_work);
>         } else {
> #ifdef CONFIG_RFKILL_INPUT
>                 bool soft_blocked =3D !!(rfkill->state & RFKILL_BLOCK=
_SW);
>=20
>                 if (!atomic_read(&rfkill_input_disabled))		//when rfk=
ill-input enable
>                         __rfkill_switch_all(rfkill->type, soft_blocke=
d);	//set sw block state to the same type
> #endif
>         }

But that's also required to actually make the persistent state have any
impact at all.

> No, BIOS only emit acpi notify when user press function key, acer-wmi
> driver emit KEY_WLAN to userland after receive the acpi notify. Of
> course at this moment, acer-wmi driver need to maintain rfkill state =
to
> sync with real device state.

So, I'm confused. Why does the driver not use the acer_wmi_notify
function to update the rfkill status too, but polls it every second?

> > It seems that what happens is roughly this:
> >  1) at boot, all BT is set to soft-killed due to the way the BIOS
> >     started up
>=20
> Yes, acer BIOS's default value is bluetooth disabled. So, when system
> boot, there only have acer-wmi's bluetooth killswitch:
>=20
> 0: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 1: acer-bluetooth: Bluetooth
>         Soft blocked: yes		# default is sw block
>         Hard blocked: no
> 2: acer-threeg: Wireless WAN
>         Soft blocked: no
>         Hard blocked: no
> 4: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
>=20
> There have no hci0's killswtich, because BT device power off by BIOS
> when system cold boot.

Right -- I missed that part.

> >  2) when you press the button, it's a toggle, so rfkill-input toggl=
es
> >     all BT rfkill instances (acer and hci0)
>=20
> Per Old=C5=99ich's report, he press bluetooth hardware key then see l=
ike the
> following:
>=20
> 4: phy0: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 6: acer-wireless: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 7: acer-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 8: acer-threeg: Wirele        Hard blocked: no
> 9: hci0: Bluetooth
>         Soft blocked: yes	# create hci0 rfkill but default is soft bl=
ocked
>         Hard blocked: no
>=20
> I didn't have bluetooth HW key on my Acer machine, but I can unblock =
acer-wmi bluetooth
> rfkill manually to reproduce this issue.

Hmm, that I don't understand. Why would that reproduce the issue? Ah,
ok, that's because __rfkill_switch_all() will set global_states, and it
happens during init. So it gets registered with the global state, which
is still blocked since you just unblocked this single thing.

So, it seems that the design here only works if
 a) the bios stores the last state
 b) the driver only reports key inputs, no rfkill inputs

> If only use bluetooth HW key to control the rfkill, then it should be
> fine. But, Old=C5=99ich report still have problem cann't enable bluet=
ooth
> after he press HW key because hci0's bluetooth default set to soft
> blocked.

Yeah that's because the BT hw key seems to generate the wrong event?

> If we want to remove rfkill-input, then we need re-compiler kernel. W=
hy
> don't add a option for enable/disable it ?

Well I don't think we want to remove rfkill input, ever, because that
just leads to a mess where the user has to take action. I'd rather have
it work out of the box and be overridden by urfkill which should work
fine.

Of course, in this particular instance it _doesn't_ work out of the box=
,
but shouldn't we rather fix that?



But due the the behaviour you outlined earlier, I think your patch make=
s
sense... the BIOS doesn't actually seem to _store_ the rfkill state
anyway, since it's always off when you cold boot. So why bother using
that state as the default anyway?

That will work around the problem at hand by making the acer wmi enable
BT whenever it is loaded, but that doesn't seem so bad either.

As for the more generic problem, I'm not sure what to do. I really wish
people would just use urfkill.

johannes
