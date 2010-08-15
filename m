From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Sun, 15 Aug 2010 13:30:15 -0700
Message-ID: <20100815133015.883c7069.akpm@linux-foundation.org>
References: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
	<AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55038 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab0HOUat (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Aug 2010 16:30:49 -0400
In-Reply-To: <AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sedat.dilek@gmail.com, Andi Kleen <ak@linux.intel.com>, len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, 15 Aug 2010 11:15:51 -0700 Linus Torvalds <torvalds@linux-found=
ation.org> wrote:

> On Sun, Aug 15, 2010 at 3:41 AM, Sedat Dilek <sedat.dilek@googlemail.=
com> wrote:
> > I pulled in release GIT-branch on top of 2.6.35-git16 (commit
> > 5d7cb157025b3b4852f38e6e5e97d06ef12c1d78)
> >
> > =C2=A0 $ git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-a=
cpi-2.6.git
> > release
> >
> > Unfortunately, the build breaks:
> >
> > [ build.log ]
> > drivers/acpi/power.c: In function =E2=80=98acpi_power_off_device=E2=
=80=99:
> > drivers/acpi/power.c:252: error: =E2=80=98ref=E2=80=99 undeclared (=
first use in this function)
>=20
> What the heck is going on? That thing cannot have been tested AT ALL.
> It comes from commit cfa806f05980 ("gcc-4.6: ACPI: fix unused but set
> variables in ACPI"), and there is no way that code has ever been
> compiled. There's no conditional compilation (except for not enabling
> ACPI at all), and the declaration of 'ref' that the commit removes is
> followed just a few lines later by the use.
>=20
> So WTF?
>=20
> I can merge this and fix it up, but I'm not going to. This thing
> should never have been sent to me. It clearly had no testing at all. =
I
> even looked at whether it could _possibly_ be some kind of odd "patch
> applied with fuzz at the wrong place" issue, but that looks impossibl=
e
> too (not to mention _still_ not being an excuse for not even trying t=
o
> compile the thing).
>=20
> I understand when people don't notice compile errors that don't happe=
n
> for them (due to being architecture- or configuration-specific), but =
I
> really don't see how that could _ever_ have been the case here.
>=20
> I see Andrew in the sign-off chain, which surprises me. Maybe he just
> passed on the patch blindly. But seriously, what the _hell_ is going
> on here?
>=20

I'd be suspecting that we have two patches both of which worked
separately but which broke when combined.  Is there some other patch in
that tree which adds a new reference to `ref' in acpi_power_seq_show()?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
