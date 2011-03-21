From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 07:57:29 -0600
Message-ID: <4D87F3F9020000230002A2CA@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103160732.15488.oldium.pro@seznam.cz>
 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
 <201103202109.53484.oldium.pro@seznam.cz>
 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
 <1300707796.4052.7.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1300707796.4052.7.camel@jlt3.sipsolutions.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: johannes@sipsolutions.net
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, mjg59@srcf.ucam.org, alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Johannes,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2011-03-21 =E6=96=BC 12:43 +0100=EF=BC=8CJo=
hannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> [Add Alan, since you're discussing his patch why did you leave him ou=
t?]
>=20

=46irst, I am sorry for I forgot to add Alan and also a bit of late to =
add
Cc. you and other rfkill experts, and thank's for your response.

I will keep it in mind to remember add Cc to patch contributor in the
future.

> On Mon, 2011-03-21 at 05:26 -0600, Joey Lee wrote:
>=20
> > > > -#ifdef CONFIG_RFKILL_INPUT
> > > > -               bool soft_blocked =3D !!(rfkill->state & RFKILL=
_BLOCK_SW);
> > > > -
> > > > -               if (!atomic_read(&rfkill_input_disabled))
> > > > -                       __rfkill_switch_all(rfkill->type, soft_=
blocked);
> > > > -#endif
> > > > -       }
> > > > +       } //else {
> > > > +//#ifdef CONFIG_RFKILL_INPUT
> > > > +//             bool soft_blocked =3D !!(rfkill->state & RFKILL=
_BLOCK_SW);
> > > > +//
> > > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > > +//                     __rfkill_switch_all(rfkill->type, soft_=
blocked);
> > > > +//#endif
> > > > +//     }
> > > >=20
> > > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> > >=20
> > > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second=
 I've tried to=20
> > > enable CONFIG_RFKILL_INPUT, but remove the mentioned block of cod=
e. The result=20
> > > is working bluetooth HW switch.
> > >=20
> >=20
> > Yes, that because the following patch introduce
> > driver with persistent state will affect the global state only if r=
fkill-input
> > is enabled:
> >=20
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommit;h=3Db3fa1329eaf2a7b97124dacf5b663fd51346ac19
>=20
> > It maybe workaround another rfkill-input issue, but causes it repli=
cate acer-wmi's=20
> > bluetooth killswitch initial state (or any driver that used rfkill_=
init_sw_state)=20
> > to any new bluetooth killswitch.
> >=20
> > It's not make sense.
>=20
> I think the reason is that rfkill-input only has a global concept of
> per-device states. The alternative would be to force a newly register=
ed
> rfkill device to the state that was set by rfkill-input.
>=20

Yes

> Is it possible that acer-wmi reports both a hotkey event _and_ an rfk=
ill
> event?
>=20

Emit needlessly KEY_BLUETOOTH when acer-wmi initial may not a good idea
if there have any userland daemon to listen the keycode.

I am trying to remove rfkill_init_sw_state then workaround this issue
in .set_block by maintain a driver initial flag in acer-wmi.

> > > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at =
Kconfig in=20
> > > net/rfkill and there is a line "default y if !EXPERT" which means=
 (I think)=20
> > > that it would be enabled by default for anybody not enabling expe=
rt options.=20
> > > So other non-expert users would have the same troubles as I have.
> >=20
> > I agreed your point, and I don't think rfkill-input need enable for=
 all
> > non-Expert user because it sometimes have conflict with EC or userl=
and
> > behavior.
>=20
> I don't think this makes sense. Until distros routinely ship an rfkil=
l
> daemon, we absolutely need rfkill-input.
>=20
> > The root cause is what I said in the above, it's hard to fix in ker=
nel
> > module because user only can choice enable/disable rfkill-input in
> > Kconfig and even cann't choice it when system boot.
> >=20
> > I thought we need:
> >  - set rfkill-input to EXPERT, remove !EXPERT
> >  - add a kernel option to rfkill for user can choice enable it or n=
ot
> > when system boot.

Does it possible we add this rfkill module option for user can control
disable rfkill-input when rfkill driver probed?

Because, distro was shipped with different company's machine, like: Ace=
r
or MSI, different machines almost have different wifi/bluetooth/wwan ke=
y
use case.
Sometimes, we want to use rfkill-input, but sometimes we have userland
GUI application to provide rfkill control panel to end user. We already
used urfkill daemon to disable rfkill-input by ioctl way, but like this
issue, it was happen on driver probe.

> >  - Ad> > urfkill daemon (or any other userland daemon) to replace r=
fkill-input.
> >=20
> > Of course need rfkill experts' more professional comments for this
> > topic.
> > I will try to generate a patches to implement the above 3 things th=
en
> > send out to rfkill experts for review.
>=20
> I disagree -- let's discuss more first.
>=20
> What really happens on Acer machines when the user presses a button?
> Does it generate more than one event?

Different acer machine have different behavior, but I don't know have
Acer machine emit more then one key event in function key. I know have
some MSI netbook emit more then one key event.

But,=20
this bluetooth killswitch state issue is not relate to emit more then
one event.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
