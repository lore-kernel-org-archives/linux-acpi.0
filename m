From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: v2.6.23-rc2 locks up during boot (without acpi=off)
Date: Sun, 12 Aug 2007 10:27:54 -0700
Message-ID: <20070812102754.a785e78a.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0708012131480.1479@kivilampi-30.cs.helsinki.fi>
	<20070812012826.cfc9f5bb.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0708121154150.31747@kivilampi-30.cs.helsinki.fi>
	<20070812092708.23d0c21c.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0708122003590.25605@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37316 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759741AbXHLR3U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Aug 2007 13:29:20 -0400
In-Reply-To: <Pine.LNX.4.64.0708122003590.25605@kivilampi-30.cs.helsinki.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?B?IklscG8gSuRydmluZW4i?= <ilpo.jarvinen@helsinki.fi>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

On Sun, 12 Aug 2007 20:15:51 +0300 (EEST) "Ilpo J=E4rvinen" <ilpo.jarvi=
nen@helsinki.fi> wrote:

> On Sun, 12 Aug 2007, Andrew Morton wrote:
>=20
> > On Sun, 12 Aug 2007 14:20:46 +0300 (EEST) "Ilpo J=E4rvinen" <ilpo.j=
arvinen@helsinki.fi> wrote:
> > > On Sun, 12 Aug 2007, Andrew Morton wrote:
> > > > On Sat, 11 Aug 2007 15:39:30 +0300 (EEST) "Ilpo J=E4rvinen" <il=
po.jarvinen@helsinki.fi> wrote:
> > > >=20
> > > > > I noticed that v2.6.23-rc1 locks up during boot, same thing h=
appens now=20
> > > > > with the latest linus' tree (+net-2.6.24 and tcp-2.6 tree stu=
ff on top=20
> > > > > of it; in -rc1 test they weren't though). The exact location =
of hang
> > > > > varies a bit though. No OOPS, does not respond to sysrq or an=
ything else=20
> > > > > besides reset. Last known bootable one is something like 2.6.=
22-rc4=20
> > > > > (I usually run 2.6.21.5 on this machine, haven't tried any 2.=
6.22 on
> > > > > this after those rcs). Problem seems to start after this line=
:
> > > > >=20
> > > > > Time: acpi_pm clocksource has been installed.
> > > > >=20
> > > > > ...the power led starts blinking (not periodic cycle but more=
 or less=20
> > > > > varying on-off cycle, never seen that led blink before at all=
, didn't know=20
> > > > > that one can make it blink :-)) and the machine gets considea=
bly slower=20
> > > > > too. Never have it been able to complete booting all they way=
 up to login=20
> > > > > prompt before lock up.
> > > > >=20
> > > > > Tried with acpi=3Doff, boots just fine.
> > > >
> > > > It'd be great if you could run a git bisection search please.
> > >=20
> > > [...snip...]
> > >=20
> > > ...didn't bother to go any further as the other one just deals wi=
th printk=20
> > > string... So this is the main suspect:
> > >=20
> > > commit 18eab8550397f1f3d4b8b2c5257c88dae25d58ed
> > > Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > > Date:   Fri Jun 15 19:37:00 2007 -0400
> > >=20
> > >     ACPI: Enable C3 even when PM2_control is zero
> > >    =20
> > >     On systems that do not have pm2_control_block, we cannot real=
ly use
> > >     ARB_DISABLE before C3. We used to disable C3 totally on such =
systems.
> > >    =20
> > >     To be compatible with Windows, we need to enable C3 on such s=
ystems now.
> > >     We just skip ARB_DISABLE step before entering the C3-state an=
d assume
> > >     hardware is handling things correctly. Also, ACPI spec is not=
 clear
> > >     about pm2_control is _needed_ for C3 or not.
> > >    =20
> > >     We have atleast one system that need this to enable C3.
> > >    =20
> > >     Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel=
=2Ecom>
> > >     Signed-off-by: Len Brown <len.brown@intel.com>
> > >=20
> >=20
> > OK, that's great, thanks.  So just to double-check, could you pleas=
e
> > confirm that the below reversion fixes this post-2.6.22 regression?
>=20
> Hmm, it was really worth of it, I did:
> $ git-fetch linus
> $ git-reset --hard linus
> [...make & install & boot...]
>=20
> ...and voila, the problem went away, so something else seems to have
> fixed it between: ac07860264bd and 963c6527e0a0e. As you can notice,
> I didn't even have to revert it (I was just double checking current
> mainline first).
>=20
> Is there a need to get a more detailed view about the cause or someth=
ing,=20
> or are details of this issue clear enough to everyone? I can do some =
more=20
> research if necessary, though expect a bit longer latencies during th=
e=20
> next week...
>=20
> In case none, thanks everyone, this issue seems solved. :-)
>=20

We just had an acpi commit.  Something like ed3110efb538d7acbf635095c13=
82118f7414f75
might have fixed this.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
