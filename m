From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] [git pull request] ACPICA patches for Linux 2.6.36-merge
Date: Fri, 6 Aug 2010 16:58:00 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858AC6DAF5B@orsmsx503.amr.corp.intel.com>
References: <alpine.LFD.2.00.1008051914130.5386@localhost.localdomain>
 <201008070046.10879.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27457 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761278Ab0HFX6D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2010 19:58:03 -0400
In-Reply-To: <201008070046.10879.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Rafael,

We are still working on the integration. Sorry it is taking a bit of time, but we were finishing up the _OSI stuff (and other things) for this month's release. With that out of the way, we can concentrate on the GPE stuff.


>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Rafael J. Wysocki
>Sent: Friday, August 06, 2010 3:46 PM
>To: Len Brown
>Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>Subject: Re: [Devel] [git pull request] ACPICA patches for Linux 2.6.36-
>merge
>
>Hi,
>
>On Friday, August 06, 2010, Len Brown wrote:
>> Hi Linus,
>>
>> please pull from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
>acpica
>>
>> This will update the files shown below.
>>
>> thanks!
>>
>> --
>> Len Brown
>> Intel Open Source Technology Center
>>
>>
>> ps. individual patches are available on linux-acpi@vger.kernel.org
>> and a consolidated plain patch is available here:
>>
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/2.6.35/acpi
>-acpica-20100702-2.6.35-rc4.diff.gz
>>
>>  drivers/acpi/acpica/acevents.h  |    4 +-
>>  drivers/acpi/acpica/acglobal.h  |    7 -
>>  drivers/acpi/acpica/achware.h   |    5 +-
>>  drivers/acpi/acpica/aclocal.h   |    6 +-
>>  drivers/acpi/acpica/acnamesp.h  |    7 -
>>  drivers/acpi/acpica/acobject.h  |   16 ++--
>>  drivers/acpi/acpica/acpredef.h  |   13 +-
>>  drivers/acpi/acpica/acstruct.h  |   32 +++---
>>  drivers/acpi/acpica/dsinit.c    |   14 +-
>>  drivers/acpi/acpica/dsmethod.c  |   20 +++-
>>  drivers/acpi/acpica/dsmthdat.c  |   16 +--
>>  drivers/acpi/acpica/dsobject.c  |   16 +++-
>>  drivers/acpi/acpica/dsopcode.c  |    6 +-
>>  drivers/acpi/acpica/dsutils.c   |    4 +-
>>  drivers/acpi/acpica/evevent.c   |    5 +-
>>  drivers/acpi/acpica/evgpe.c     |   69 +++++++++---
>>  drivers/acpi/acpica/evgpeblk.c  |   70 ++---------
>>  drivers/acpi/acpica/evgpeinit.c |  236 +++------------------------------
>----
>>  drivers/acpi/acpica/evrgnini.c  |   10 +-
>>  drivers/acpi/acpica/evxfevnt.c  |  249 ++++++++++++++++-----------------
>------
>>  drivers/acpi/acpica/exconfig.c  |    2 +-
>>  drivers/acpi/acpica/exdump.c    |    6 +-
>>  drivers/acpi/acpica/exfldio.c   |    4 +-
>>  drivers/acpi/acpica/exprep.c    |   23 +---
>>  drivers/acpi/acpica/exregion.c  |    6 +-
>>  drivers/acpi/acpica/hwgpe.c     |   35 +-----
>>  drivers/acpi/acpica/hwsleep.c   |    2 +-
>>  drivers/acpi/acpica/nsaccess.c  |    9 +-
>>  drivers/acpi/acpica/nsalloc.c   |   94 +++++++--------
>>  drivers/acpi/acpica/nsdump.c    |    2 +-
>>  drivers/acpi/acpica/nsinit.c    |   16 ++--
>>  drivers/acpi/acpica/nsnames.c   |    4 +-
>>  drivers/acpi/acpica/nsparse.c   |    4 +-
>>  drivers/acpi/acpica/nsrepair.c  |    2 +-
>>  drivers/acpi/acpica/nsrepair2.c |    7 +
>>  drivers/acpi/acpica/nssearch.c  |   15 +--
>>  drivers/acpi/acpica/nsutils.c   |  113 ------------------
>>  drivers/acpi/acpica/nswalk.c    |   15 +--
>>  drivers/acpi/acpica/nsxfobj.c   |    2 +-
>>  drivers/acpi/acpica/utglobal.c  |    2 +-
>>  drivers/acpi/acpica/utxface.c   |    8 +-
>>  drivers/acpi/button.c           |    6 +-
>>  drivers/acpi/ec.c               |   39 +-----
>>  drivers/acpi/osl.c              |   20 ---
>>  drivers/acpi/scan.c             |    7 +-
>>  drivers/acpi/sleep.c            |   15 +--
>>  drivers/acpi/system.c           |    6 +-
>>  drivers/acpi/wakeup.c           |   18 ++-
>>  drivers/pci/pci-acpi.c          |    6 +-
>>  include/acpi/acoutput.h         |    3 +-
>>  include/acpi/acpixf.h           |   13 +-
>>  include/acpi/actbl2.h           |   48 ++++++++
>>  include/acpi/actypes.h          |    8 +-
>>  53 files changed, 470 insertions(+), 895 deletions(-)
>>
>> through these commits:
>>
>> Alexey Starikovskiy (3):
>>       ACPICA: Expand initialization counters to 32 bits
>>       ACPICA: Performance enhancement for namespace search and access
>>       ACPICA: Optimization: Reduce the number of namespace walks
>>
>> Bob Moore (13):
>>       ACPICA: Add comment: _BCL cannot be sorted on the fly
>>       ACPICA: iASL/Core: Add support for _WDG/_WED MS methods
>>       ACPICA: Core: Replace all %d format specifiers with %u (unsigned)
>>       ACPICA: Expand device initialization counters to 32 bits
>>       ACPICA: Update flags for operand object
>>       ACPICA: Add signatures for undefined tables: ATKG, GSCI, IEIT
>>       ACPICA: Update version to 20100528
>>       ACPICA: Add support for WDDT - Watchdog Descriptor Table
>>       ACPICA: Update debug output components
>>       ACPICA: Remove obsolete GPE function
>>       ACPICA: Fix lint warning for 64-bit constant
>>       ACPICA: Fix for Alias references within Package objects
>>       ACPICA: Update version to 20100702
>>
>> Lin Ming (1):
>>       ACPICA: Rename acpi_hw_gpe_register_bit
>>
>> Rafael J. Wysocki (10):
>>       ACPICA: Introduce acpi_gpe_wakeup()
>>       ACPICA: Remove wakeup GPE reference counting which is not used
>>       ACPI / EC: Drop suspend and resume routines
>>       ACPI / EC: Do not use acpi_set_gpe
>>       ACPICA: Use low-level GPE enable during GPE block initialization
>>       ACPICA: Drop acpi_set_gpe
>>       ACPI: Fix bogus GPE test in acpi_bus_set_run_wake_flags()
>>       ACPI / ACPICA: Do not execute _PRW methods during initialization
>>       ACPI / ACPICA: Fail acpi_gpe_wakeup() if ACPI_GPE_CAN_WAKE is unset
>>       ACPI / ACPICA: Simplify acpi_ev_initialize_gpe_block()
>
>It looks like https://patchwork.kernel.org/patch/116884/ didn't make it
>into
>the pull request.
>
>Did that happen because it didn't apply or were there any problems with it
>I'm not aware of?
>
>Thanks,
>Rafael
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
