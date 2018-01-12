From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/12] ACPICA 20171215
Date: Fri, 12 Jan 2018 14:26:25 +0100
Message-ID: <2002402.ikpHSYtM3V@aspire.rjw.lan>
References: <erik.schmauss@intel.com> <20180103230631.15939-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:64448 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeALN1j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2018 08:27:39 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday, January 4, 2018 12:06:19 AM CET Erik Schmauss wrote:
> The following are the linuxized patches for ACPICA version 20171215
> 
> Bob Moore (8):
>   ACPICA: Debug output, no functional change
>   ACPICA: Update for a few debug output statements
>   ACPICA: Fix a regression in the acpi_evaluate_object_type interface
>   ACPICA: Cleanup the global variables and update comments. No
>     functional change
>   ACPICA: Create and deploy safe version of strncpy. No functional
>     change
>   ACPICA: Rename a global variable, no functional change
>   ACPICA: Fix a couple memory leaks during package object resolution
>   ACPICA: Update version to 20171215
> 
> Erik Schmauss (3):
>   ACPICA: Debugger: fix slight indentation issue
>   ACPICA: DT compiler: prevent error if optional field at the end of
>     table is not present
>   ACPICA: trivial style fix, no functional change
> 
> Mario Limonciello (1):
>   ACPICA: Recognize the Windows 10 version 1607 and 1703 OSI strings
> 
>  drivers/acpi/acpica/acglobal.h  | 82 ++++++++++++++---------------------------
>  drivers/acpi/acpica/acutils.h   |  2 +
>  drivers/acpi/acpica/dbfileio.c  |  4 +-
>  drivers/acpi/acpica/dspkginit.c | 21 +++++++----
>  drivers/acpi/acpica/exdump.c    | 11 +++---
>  drivers/acpi/acpica/hwvalid.c   | 14 +++----
>  drivers/acpi/acpica/nsxfeval.c  |  9 +++--
>  drivers/acpi/acpica/psutils.c   | 10 +++--
>  drivers/acpi/acpica/utdebug.c   | 18 ++++++++-
>  drivers/acpi/acpica/utnonansi.c |  9 +++++
>  drivers/acpi/acpica/utosi.c     |  2 +
>  drivers/acpi/acpica/uttrack.c   |  4 +-
>  include/acpi/acexcep.h          |  6 ++-
>  include/acpi/acpixf.h           |  2 +-
>  include/acpi/actypes.h          |  2 +
>  15 files changed, 104 insertions(+), 92 deletions(-)

Series applied with the (fixed) v2 of [06/12].

Thanks,
Rafael

