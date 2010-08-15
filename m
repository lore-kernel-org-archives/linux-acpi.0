From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [git pull request] ACPI patches for 2.6.36.merge
Date: Sun, 15 Aug 2010 12:41:48 +0200
Message-ID: <AANLkTikV2eVo6KM5dSqfDwAwT=bVxnuWSpBE7F+JQU+_@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

I pulled in release GIT-branch on top of 2.6.35-git16 (commit
5d7cb157025b3b4852f38e6e5e97d06ef12c1d78)

   $ git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.=
git
release

Unfortunately, the build breaks:

[ build.log ]
drivers/acpi/power.c: In function =E2=80=98acpi_power_off_device=E2=80=99=
:
drivers/acpi/power.c:252: error: =E2=80=98ref=E2=80=99 undeclared (firs=
t use in this function)
drivers/acpi/power.c:252: error: (Each undeclared identifier is
reported only once
drivers/acpi/power.c:252: error: for each function it appears in.)
make[5]: *** [drivers/acpi/power.o] Error 1
make[4]: *** [drivers/acpi] Error 2
make[3]: *** [drivers] Error 2


- Sedat -
