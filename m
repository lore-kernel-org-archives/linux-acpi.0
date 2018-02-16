From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [PATCH v2 0/7] ACPICA release 20180208v2
Date: Fri, 16 Feb 2018 21:45:15 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED5396F6B94@ORSMSX110.amr.corp.intel.com>
References: <20180215210932.15490-1-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:31590 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbeBPVpS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Feb 2018 16:45:18 -0500
In-Reply-To: <20180215210932.15490-1-erik.schmauss@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Erik Schmauss
> Sent: Thursday, February 15, 2018 1:09 PM
> To: linux-acpi@vger.kernel.org
> Cc: rjw@rjwysocki.net; Schmauss, Erik <erik.schmauss@intel.com>
> Subject: [PATCH v2 0/7] ACPICA release 20180208v2
> 
> v2 of the patch set. Apparently, a patch was left off due to issues with my mail
> client...
> 
> This is the ACPICA20180212 release.
> 
> Notable commits are changes made to integrate package handling with MLC
> and setting the TermList parsing as a default. A small commit was made to
> disable package resolution errors. This reverts the error reporting behavior to
> match the previous behavior (in 4.13)
> 
> Bob Moore (5):
>   ACPICA: Update error message, no functional change
>   ACPICA: Update for some debug output. No functional change
>   ACPICA: Revert "Fix for implicit result conversion for the ToXXXX
>     functions"
>   ACPICA: Add option to disable Package object name resolution errors
>   ACPICA: Update version to 20180209
> 
> Erik Schmauss (2):
>   ACPICA: Restructure ACPI table files
This probably did not send to the mailing list due to its size.
This commit is available here: https://github.com/SchmErik/linux/commit/58f4a9a56fe0789c1c9cd2c48ae45225f85dabdf

>   ACPICA: Integrate package handling with module-level code
> 
>  drivers/acpi/acpica/acopcode.h  |   14 +-
>  drivers/acpi/acpica/amlcode.h   |   20 +-
>  drivers/acpi/acpica/dsargs.c    |    1 +
>  drivers/acpi/acpica/dsopcode.c  |    4 +-
>  drivers/acpi/acpica/dspkginit.c |  164 ++--
>  drivers/acpi/acpica/dswexec.c   |    6 +-
>  drivers/acpi/acpica/dswload.c   |    2 +-
>  drivers/acpi/acpica/exconvrt.c  |    1 +
>  drivers/acpi/acpica/exnames.c   |    7 +-
>  drivers/acpi/acpica/exresop.c   |    1 +
>  drivers/acpi/acpica/nseval.c    |    8 +-
>  drivers/acpi/acpica/nsinit.c    |    7 +-
>  drivers/acpi/acpica/nsnames.c   |    3 +
>  drivers/acpi/acpica/nsparse.c   |   10 +-
>  drivers/acpi/acpica/psloop.c    |    4 +-
>  drivers/acpi/acpica/psparse.c   |    2 +-
>  drivers/acpi/acpica/pstree.c    |    1 +
>  drivers/acpi/acpica/utcache.c   |    7 +-
>  drivers/acpi/acpica/utdelete.c  |   20 +-
>  include/acpi/acpixf.h           |   10 +-
>  include/acpi/actbl1.h           | 1638 ++++++++++++++++----------------
>  include/acpi/actbl2.h           | 1964 +++++++++++++++++++++------------------
>  include/acpi/actbl3.h           | 1016 +++++++++-----------
>  include/acpi/platform/aclinux.h |    1 +
>  24 files changed, 2477 insertions(+), 2434 deletions(-)
> 
> --
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
