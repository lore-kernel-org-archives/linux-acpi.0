From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Sun, 15 Aug 2010 11:15:51 -0700
Message-ID: <AANLkTi=vngT_5XYz1=3P6GjExFNtCVCdBMhaz4Sc4oEk@mail.gmail.com>
References: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 15, 2010 at 3:41 AM, Sedat Dilek <sedat.dilek@googlemail.co=
m> wrote:
> I pulled in release GIT-branch on top of 2.6.35-git16 (commit
> 5d7cb157025b3b4852f38e6e5e97d06ef12c1d78)
>
> =A0 $ git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2=
=2E6.git
> release
>
> Unfortunately, the build breaks:
>
> [ build.log ]
> drivers/acpi/power.c: In function =91acpi_power_off_device=92:
> drivers/acpi/power.c:252: error: =91ref=92 undeclared (first use in t=
his function)

What the heck is going on? That thing cannot have been tested AT ALL.
It comes from commit cfa806f05980 ("gcc-4.6: ACPI: fix unused but set
variables in ACPI"), and there is no way that code has ever been
compiled. There's no conditional compilation (except for not enabling
ACPI at all), and the declaration of 'ref' that the commit removes is
followed just a few lines later by the use.

So WTF?

I can merge this and fix it up, but I'm not going to. This thing
should never have been sent to me. It clearly had no testing at all. I
even looked at whether it could _possibly_ be some kind of odd "patch
applied with fuzz at the wrong place" issue, but that looks impossible
too (not to mention _still_ not being an excuse for not even trying to
compile the thing).

I understand when people don't notice compile errors that don't happen
for them (due to being architecture- or configuration-specific), but I
really don't see how that could _ever_ have been the case here.

I see Andrew in the sign-off chain, which surprises me. Maybe he just
passed on the patch blindly. But seriously, what the _hell_ is going
on here?

                              Linus
