From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 00/18] ACPICA 20161222 Release
Date: Tue, 3 Jan 2017 05:23:19 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE1FABA@SHSMSX101.ccr.corp.intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
 <4861890.YlOS97DeY7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1945 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755819AbdACFXY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Jan 2017 00:23:24 -0500
In-Reply-To: <4861890.YlOS97DeY7@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: Re: [PATCH 00/18] ACPICA 20161222 Release
> 
> On Wednesday, December 28, 2016 03:28:00 PM Lv Zheng wrote:
> > The 20161222 ACPICA kernel-resident subsystem updates are linuxized based
> > on the linux-pm/linux-next branch.
> >
> > The patchset has passed the following build/boot tests.
> > Build tests are performed as follows:
> > 1. i386 + allyes
> > 2. i386 + allno
> > 3. i386 + default + ACPI_DEBUGGER=y
> > 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > 5. i386 + default + ACPI_DEBUG=n + ACPI=y
> > 6. i386 + default + ACPI=n
> > 7. x86_64 + allyes
> > 8. x86_64 + allno
> > 9. x86_64 + default + ACPI_DEBUGGER=y
> > 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> > 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
> > 12.x86_64 + default + ACPI=n
> > Boot tests are performed as follows:
> > 1. x86_64 + default + ACPI_DEBUGGER=y
> > Where:
> > 1. i386: machine named as "Dell Inspiron Mini 1010"
> > 2. x86_64: machine named as "Microsoft Surface Pro 3"
> > 3. default: kernel configuration with following items enabled:
> >    All hardware drivers related to the machines of i386/x86_64
> >    All "drivers/acpi" configurations
> >    All "drivers/platform" drivers
> >    All other drivers that link the APIs provided by ACPICA subsystem
> >
> > The divergences checking result:
> > Before applying (20161117 Release):
> >   467 lines
> > After applying (20161222 Release):
> >   369 lines
> >
> > Bob Moore (8):
> >   ACPICA: Macro header: Fix some typos in comments. No functional change
> >   ACPICA: Utilities: Update debug output
> >   ACPICA: Resources: Not a valid resource if buffer length too long
> >   ACPICA: Fix for implicit result conversion for the ToXXXX functions
> >   ACPICA: Parser: Allow method invocations as target operands
> >   ACPICA: Fix a problem with recent extra support for control method
> >     invocations
> >   ACPICA: Parser: Update parse info table for some operators
> >   ACPICA: Update version to 20161222
> >
> > Colin Ian King (1):
> >   ACPICA: Linux-specific header: Add support for s390x compilation.
> >
> > David E. Box (1):
> >   ACPICA: Disassembler: Add Switch/Case disassembly support
> >
> > Lv Zheng (8):
> >   ACPICA: Debugger: Rename debugger OSL names
> >   ACPICA: Hardware: Remove bit_offset masking support
> >   ACPICA: Hardware: Add access_width/bit_offset support in
> >     acpi_hw_write()
> >   ACPICA: Utilities: Add power of two rounding support
> >   ACPICA: Hardware: Sort access bit width algorithm
> >   ACPICA: Hardware: Add sleep register hooks
> >   ACPICA: MSVC: Fix MSVC6 build issues
> >   ACPICA: EFI: Add efihello demo application
> >
> >  drivers/acpi/acpica/aclocal.h                      |   7 +-
> >  drivers/acpi/acpica/acmacros.h                     |  72 +++++++++-
> >  drivers/acpi/acpica/acopcode.h                     |  22 +--
> >  drivers/acpi/acpica/amlcode.h                      |  20 ++-
> >  drivers/acpi/acpica/dbxface.c                      |   4 +-
> >  drivers/acpi/acpica/exconvrt.c                     |   1 -
> >  drivers/acpi/acpica/exresop.c                      |   1 -
> >  drivers/acpi/acpica/hwesleep.c                     |  35 +++--
> >  drivers/acpi/acpica/hwregs.c                       | 153 +++++++++++++++------
> >  drivers/acpi/acpica/hwsleep.c                      |  11 +-
> >  drivers/acpi/acpica/psargs.c                       |  97 +++++++++----
> >  drivers/acpi/acpica/psloop.c                       |   4 +
> >  drivers/acpi/acpica/psobject.c                     |  10 +-
> >  drivers/acpi/acpica/pstree.c                       |  10 +-
> >  drivers/acpi/acpica/utdecode.c                     |   4 +-
> >  drivers/acpi/acpica/utdelete.c                     |   6 +-
> >  drivers/acpi/acpica/utresrc.c                      |  17 ++-
> >  drivers/acpi/osl.c                                 |  27 +++-
> >  include/acpi/acexcep.h                             |   9 +-
> >  include/acpi/acpiosxf.h                            |  12 +-
> >  include/acpi/acpixf.h                              |   2 +-
> >  include/acpi/platform/acenv.h                      |   5 +-
> >  include/acpi/platform/aclinux.h                    |   7 +-
> >  include/acpi/platform/aclinuxex.h                  |   4 +-
> >  .../acpi/os_specific/service_layers/osunixxf.c     |  22 +++
> >  25 files changed, 405 insertions(+), 157 deletions(-)
> 
> Any chance to make patch [14/18] go to any mailing lists or actually any
> outside addresses *at* *all* without being filtered out by spam filters or
> similar?

It seems the ToXXX in the subject "ACPICA: Fix for implicit result conversion for the ToXXXX functions" hit spam filters from 1 of the chained MDAs:

#5.0.0 smtp; 5.3.0 - Other mail system problem 550-'5.7.1 Content-Policy reject msg: The capital Triple-X in subject is way too often associated with junk email, please rephrase.

I'll re-phrase and re-send the PATCH 14/18.

Thanks
Lv

