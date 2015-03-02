From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI regression with 3.19+
Date: Mon, 02 Mar 2015 23:03:50 +0100
Message-ID: <2682430.9eTeHiC8BR@vostro.rjw.lan>
References: <54F18BD9.8040200@punnoor.de> <1674953.ShOInfAyGW@vostro.rjw.lan> <1425323240.1125.17.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58820 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752896AbbCBVkS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2015 16:40:18 -0500
In-Reply-To: <1425323240.1125.17.camel@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hudd <hedede.l@gmail.com>
Cc: Prakash Punnoor <prakash@punnoor.de>, jiang.liu@linux.intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, March 02, 2015 10:07:20 PM Hudd wrote:
> On Sun, 2015-03-01 at 01:00 +0100, Rafael J. Wysocki wrote:
> > On Saturday, February 28, 2015 10:35:21 AM Prakash Punnoor wrote:
> > > This is a multi-part message in MIME format.
> > > --------------080704070901080904040008
> > > Content-Type: text/plain; charset=3Dutf-8
> > > Content-Transfer-Encoding: 7bit
> > >=20
> > > Hallo,
> > >=20
> > > my system won't boot with current GIT kernel (see attached screen=
shot).
> > > The system seems somewhat frozen (cannot ssh into it), but magic =
sysrq
> > > still works. I bisected the problem to commit
> > > 593669c2ac0fe18baee04a3cd5539a148aa48574.
> >=20
> > Thanks for reporting, we're working on it.
>=20
> Hello folks,
>=20
> I've tried out 4.0-rc1, and it does not boot  on  my  system.   It  j=
ust
> freezes without any messages (The only message I see is =E2=80=9CLoad=
ing initial
> ramdisk=E2=80=9D from GRUB).  I bisected the problem down to the same=
 commit  as
> in this  report.
>=20
> # first bad commit: [593669c2ac0fe18baee04a3cd5539a148aa48574]
> x86/PCI/ACPI: Use common ACPI resource interfaces to simplify impleme=
ntation

So at the moment I'm inclined to revert it.  Clearly, it wasn't thought
through enough, so my suggestion would be to revert it for 4.0 and try =
again
in the next cycle and be more careful this time.

Gerry, would it cause problems to happen if I reverted this one?


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
