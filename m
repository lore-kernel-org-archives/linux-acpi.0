From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Thu, 01 Aug 2013 07:52:22 +0800
Message-ID: <1375314742.20680.128.camel@linux-s257.site>
References: <1373888637-20737-1-git-send-email-oliver@neukum.org>
	 <4740878.DpcUBhhgIN@linux-5eaq.site>
	 <1454582.aQCRT2GPRY@skinner.arch.suse.de>
	 <5649055.6Xlqb8sv3m@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:58517 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3GaXxK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jul 2013 19:53:10 -0400
In-Reply-To: <5649055.6Xlqb8sv3m@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>
Cc: Oliver Neukum <oneukum@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, lenb@kernel.org, linux-acpi@vger.kernel.org

Hi all experts,=20

=E6=96=BC =E5=9B=9B=EF=BC=8C2013-07-18 =E6=96=BC 00:09 +0200=EF=BC=8CRa=
fael J. Wysocki =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wednesday, July 17, 2013 04:58:34 PM Thomas Renninger wrote:
> > On Monday, July 15, 2013 05:35:23 PM Oliver Neukum wrote:
> > > On Monday 15 July 2013 12:06:11 Henrique de Moraes Holschuh wrote=
:
> > > > On Mon, 15 Jul 2013, Thomas Renninger wrote:
> > > > > I would not make it too complicated.
> > > > > Sticking to the latest Windows version should be enough for t=
his one.
> > > > > What bad should happen if we still try to resume and fail...
> > > >=20
> > > > Hmm, why was that check added in the first place?
> > >=20
> > > Safety.
> >=20
> > I expect it is there, because it is stated rather clear in the spec=
s.
> > =20
> > > > If it is useless,
> > > > removing it for good is fine.  If it is _not_ useless, we shoul=
d still do
> > > > the checking when not operating in windows-8 firmware mode.
> > >=20
> > > Firmware will only be tested against Windows 8 pretty soon.
> > > We'd end up with a gigantic list of exceptions.
> >=20
> > Joey found an interessting paper about Win8 behavior:
> > http://bizsupport2.austin.hp.com/bc/docs/support/SupportManual/c036=
54081/c03654081.pdf
> >=20
> > It looks like Win8 behaves rather different compared to Linux and i=
s providing
> > "Hybrid Boot" where the user has to end all his apps. They have no =
big problem=20
> > when resume fails as the user will not lose any data or work he had=
 done=20
> > before.
> >=20
> > Joey also found the rather hidden acpi_sleep=3Ds4_nohwsig boot opti=
on
> > which helps as well.
> > So Linux could do:
> >    1) Invalidate suspend image and reboot  (disadvantage: message i=
s gone)
> >    2) Panic (current behavior) -> above boot param helps
> >    3) Still try to resume with a "not so offending message"
> >    4) ?
> >=20
> > 1. seem to be what Win8 is doing
> > 3. sounds best to me. It could be ugly if suspend fails and
> > it always worked before and all your work/data is gone. So trying
> > hard to resume sounds like a good idea
>=20
> We can also blacklist systems that need acpi_sleep=3Ds4_nohwsig due t=
o idiotic
> hardware/BIOS design choices.
>=20
> In any case, if we remove the panic, we should also drop s4_nohwsig a=
nd since
> we have that (which I forgot about, by bad), the whole issue isn't so=
 urgent,
> so I'm dropping the patch for the time being.
>=20
> Thanks,
> Rafael
>=20
>=20


About the testing on real machine to capture the Windows behavior of
hardware_signature... We confirm the behavior on fast boot and _REAL_ S=
4
are different on Windows.

=46irst, on Windows 8, user could not see S4 option on default UI, they
need enable it in setup UI when user really want to use it. Windows 8's
default shutdown is fast boot but not real S5.

We found a notebook that has a buggy BIOS that changed the
hardware_signature in 3 times S4 cycles. With Linux kernel, normally we
can reproduced the FACS hardware signature fail at second time S4.

My friend, Max Lin help to install Windows 7 and Windows 8 on this bugg=
y
machine to run S4 and fast boot testing, the result as following:

 + Linux v3.10 Kernel:
   Can reproduce error of hardware_signature changed in 3 times S4.=20

 + Windows 8 _REAL_ S4:
   Run more then 10 S4 cycles, always resume like normally. Didn't see
any problem.

 + Windows 8 fast boot:
   Random happened blue screen as the attached picture (sorry for the
chinese message), the error is: PAGE_FAULT_IN_NONPAGED_AREA. Then
Windows 8 reboot and try to recover error.  We are not sure this error
is caused by hardware_signature changed, but it only reproduced on fast
boot but not S4.

 + Windows 7 _REAL_ S4:
   Run more then 10 S4 cycles, always resume like normally. Didn't see
any problem.


Base on the above testing result, our conclusion is:=20

 + The _REAL_ S4 on Windows 7/8 ignored FACS hardware signature change.
It just result like normally, didn't lost any user data.

 + The fast boot resume on Windows 8, happen blue screen, but we are no=
t
sure it reflect to FACS hardware signature change. Even that, Windows 8
didn't lost any user data because user already close all applications
before fast boot shutdown.


Due to Linux kernel is running REAL S4, so I suggest we can just ignore
the FACS hardware signature changed, means accept Oliver's patch. Just
let machine try to restore the S4 snapshot, if lucky, then user can get
their user data back.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
