From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/07] ACPICA 20130418 Release
Date: Sat, 01 Jun 2013 22:09:18 +0200
Message-ID: <3312883.QlX5oFjIpb@vostro.rjw.lan>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56451 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab3FAUAU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Jun 2013 16:00:20 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, May 29, 2013 10:08:46 AM Lv Zheng wrote:
> The 20130418 ACPICA kernel resident system updates is linuxized based on
> the pm/linux-next branch.
> The patch set has passed basic build/boot tests on i386/x86-64 machines.
> 
> Bob Moore (5):
>   ACPICA: Change an exception code for the ASL UnLoad() operator
>   ACPICA: Add BIOS error interface for predefined name validation
>     support
>   ACPICA: Add argument typechecking for all predefined ACPI names
>   ACPICA: Predefined name support: Remove unused local variable
>   ACPICA: Update version to 20130418
> 
> Lv Zheng (1):
>   ACPICA: Remove unused macros, no functional change
> 
> Zhang Rui (1):
>   ACPICA: Update for "orphan" embedded controller _REG method support

Applied, thanks Lv!

Rafael


>  drivers/acpi/acpica/Makefile      |    1 +
>  drivers/acpi/acpica/aclocal.h     |   17 ---
>  drivers/acpi/acpica/acmacros.h    |   10 +-
>  drivers/acpi/acpica/acnamesp.h    |   43 ++++--
>  drivers/acpi/acpica/acpredef.h    |    4 +-
>  drivers/acpi/acpica/acstruct.h    |   40 +++--
>  drivers/acpi/acpica/acutils.h     |    6 +
>  drivers/acpi/acpica/evgpe.c       |    1 -
>  drivers/acpi/acpica/evregion.c    |   63 +++-----
>  drivers/acpi/acpica/exconfig.c    |    2 +-
>  drivers/acpi/acpica/hwxface.c     |    6 +-
>  drivers/acpi/acpica/nsarguments.c |  294 +++++++++++++++++++++++++++++++++++++
>  drivers/acpi/acpica/nseval.c      |  247 ++++++++++++++++++-------------
>  drivers/acpi/acpica/nsinit.c      |    7 +-
>  drivers/acpi/acpica/nspredef.c    |  202 ++++++-------------------
>  drivers/acpi/acpica/nsprepkg.c    |   76 +++++-----
>  drivers/acpi/acpica/nsrepair.c    |   50 +++----
>  drivers/acpi/acpica/nsrepair2.c   |   87 +++++------
>  drivers/acpi/acpica/nsxfeval.c    |  162 ++++++++++++++++----
>  drivers/acpi/acpica/psxface.c     |   14 +-
>  drivers/acpi/acpica/rsutils.c     |    2 +-
>  drivers/acpi/acpica/uteval.c      |    2 +-
>  drivers/acpi/acpica/utpredef.c    |   16 +-
>  drivers/acpi/acpica/utxferror.c   |   51 ++++++-
>  include/acpi/acconfig.h           |    4 +-
>  include/acpi/acoutput.h           |    8 +-
>  include/acpi/acpixf.h             |    2 +-
>  27 files changed, 882 insertions(+), 535 deletions(-)
>  create mode 100644 drivers/acpi/acpica/nsarguments.c
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
