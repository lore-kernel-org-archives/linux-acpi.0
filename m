From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/21] ACPICA 20130214 Release
Date: Tue, 26 Mar 2013 14:22:16 +0100
Message-ID: <1547015.kqHDmKcBEz@vostro.rjw.lan>
References: <cover.1361292877.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42990 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933069Ab3CZNOu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:14:50 -0400
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Friday, March 08, 2013 05:19:15 PM Lv Zheng wrote:
> The 20130214 ACPICA linuxized patches are based on the pm/linux-next
> branch.
> The patch set has passed a basic build/boot test on z530.
> No new divergences are introduced by this patch set.
> 
> Bob Moore (14):
>   ACPICA: Resource Mgr: Prevent infinite loops in resource walks
>   ACPICA: Fix a couple warnings detected on FreeBSD build
>   ACPICA: Update error/debug messages for fixed events
>   ACPICA: Add parens within macros around parameter names
>   ACPICA: Update for ACPI 5 hardware-reduced feature
>   ACPICA: Regression fix: reinstate safe exit macros
>   ACPICA: Add macros to exception code definitions
>   ACPICA: Add exception descriptions to exception info table
>   ACPICA: Remove trailing comma in enum declarations
>   ACPICA: Add mechanism for early object repairs on a per-name basis
>   ACPICA: Split object conversion functions to a new file
>   ACPICA: Disassembler: Add warnings for unresolved control methods
>   ACPICA: Object repair: Allow 0-length packages for variable-length
>     packages
>   ACPICA: Update version to 20130214
> 
> Jung-uk Kim (2):
>   ACPICA: Fix a long-standing bug in local cache
>   ACPICA: Add macros to access pointer to next object in the descriptor
>     list
> 
> Lv Zheng (5):
>   ACPICA: Update RASF table definition
>   ACPICA: iASL/Disassembler: Add support for VRTC table
>   ACPICA: iASL/Disassembler: Add support for MTMR table
>   ACPICA: Return object repair: Add string-to-unicode conversion
>   ACPICA: Return object repair: Add resource template repairs

All patches in the series applied to linux-pm.git/linux-next.

Thanks Lv!

Rafael


>  drivers/acpi/acpica/Makefile    |    1 +
>  drivers/acpi/acpica/acglobal.h  |    4 +-
>  drivers/acpi/acpica/aclocal.h   |   16 ++
>  drivers/acpi/acpica/acmacros.h  |    6 +-
>  drivers/acpi/acpica/acnamesp.h  |   25 ++-
>  drivers/acpi/acpica/acutils.h   |    3 +-
>  drivers/acpi/acpica/dsutils.c   |   10 +-
>  drivers/acpi/acpica/evevent.c   |   12 +-
>  drivers/acpi/acpica/evgpe.c     |    6 +-
>  drivers/acpi/acpica/evsci.c     |    4 +-
>  drivers/acpi/acpica/evxface.c   |   21 +-
>  drivers/acpi/acpica/evxfevnt.c  |   12 +
>  drivers/acpi/acpica/exprep.c    |    4 +-
>  drivers/acpi/acpica/exutils.c   |    4 +-
>  drivers/acpi/acpica/hwacpi.c    |   20 +-
>  drivers/acpi/acpica/nsconvert.c |  443 +++++++++++++++++++++++++++++++++++++
>  drivers/acpi/acpica/nspredef.c  |  141 ++++++------
>  drivers/acpi/acpica/nsprepkg.c  |   10 +-
>  drivers/acpi/acpica/nsrepair.c  |  381 ++++++++++++--------------------
>  drivers/acpi/acpica/nsrepair2.c |   16 +-
>  drivers/acpi/acpica/nsutils.c   |    8 +-
>  drivers/acpi/acpica/psargs.c    |    2 +-
>  drivers/acpi/acpica/rscalc.c    |    6 +
>  drivers/acpi/acpica/rsdump.c    |    8 +
>  drivers/acpi/acpica/rslist.c    |    8 +
>  drivers/acpi/acpica/rsxface.c   |    8 +-
>  drivers/acpi/acpica/utaddress.c |    4 +-
>  drivers/acpi/acpica/utcache.c   |   18 +-
>  drivers/acpi/acpica/utexcep.c   |   26 ++-
>  drivers/acpi/acpica/utglobal.c  |    2 +
>  include/acpi/acexcep.h          |  461 +++++++++++++++++++++++----------------
>  include/acpi/acoutput.h         |   53 ++++-
>  include/acpi/acpixf.h           |    2 +-
>  include/acpi/actbl2.h           |   47 ++++
>  include/acpi/actbl3.h           |   55 ++++-
>  include/acpi/actypes.h          |    1 -
>  36 files changed, 1231 insertions(+), 617 deletions(-)
>  create mode 100644 drivers/acpi/acpica/nsconvert.c
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
