From: al.stone@linaro.org
Subject: [PATCH v2 0/5] Start deprecating _OSI on new architectures
Date: Tue,  3 Feb 2015 17:21:39 -0700
Message-ID: <1423009304-5007-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:65426 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbbBDAV5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 19:21:57 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so29453275iec.8
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2015 16:21:56 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

From: Al Stone <al.stone@linaro.org>

The use of the ACPI _OSI method in Linux has a long and sordid history.
Instead of perpetuating past complications on new architectures, the 
consensus amongst those writing the ACPI specification and those using
it seems to be to ultimately deprecate the use of _OSI.  A change request
has been submitted (but not yet decided upon) to modify the ACPI specification
accordingly.

In the meantime, these patches rearrange the implementation of _OSI so
that it can be deprecated, or ultimately removed completely, on at least
arm64 platforms.  This is done by separating out the _OSI implementation
and moving it into a new file.  For x86 and ia64, there is no change in
functionality.  But, this allows us to provide a separate implementation
of _OSI for arm64 that generates a warning that it has been deprecated, 
and always returns false; i.e., that the capability being queried for, 
whether OS name or functionality, is not supported.  This is the first
four of the patches.

The final patch changes the default value for the _OS_ method for arm64
only.  Since there is no need to pretend to be older versions of Windows,
or any other OS at all, the _OS_ method will return "Linux" on arm64.
One can still use the acpi_os_name kernel parameter if there is a need
to use some other value.

The first three patches do not depend on arm64 support for ACPI and could
be used independently.  The last two patches make much more sense when used
in conjunction with Hanjun's patches for ACPI 5.1 on arm64 [0].

These have been through some simple testing on two different x86 laptops,
and all seems well (Lenovo t440s and t430s ThinkPads).  The arm64 code has
been tested on an AMD Seattle system.  Unfortunately, for ia64, all I could
do was cross-compile the code; I have no access to hardware to test on.

NB: the first two patches do not pass checkpatch.pl; since this is existing
code being moved, I have not repaired the reported errors for now, but will
do so once the disposition of these patches have been resolved.


Changes in v2:
  -- significant simplification based on Rafael's comments
  -- ACPI spec change request has now been submitted


[0] https://lkml.org/lkml/2015/2/2/261


Al Stone (4):
  ACPI: move acpi_os_handler() so it can be made arch-dependent later
  ACPI: move _OSI support functions to allow arch-dependent
    implementation
  ACPI: add arch-specific compilation for _OSI and the blacklist
  ACPI: arm64: use the arch-specific ACPI _OSI method and ACPI blacklist

Hanjun Guo (1):
  ACPI: arm64: use "Linux" as ACPI_OS_NAME for _OS on arm64

 arch/arm64/Kconfig              |   7 ++
 drivers/acpi/Kconfig            |  22 ++++
 drivers/acpi/Makefile           |  17 +++
 drivers/acpi/blacklist-arm.c    |  20 ++++
 drivers/acpi/blacklist.c        |   9 ++
 drivers/acpi/osi-arm.c          |  25 ++++
 drivers/acpi/osi.c              | 255 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/osl.c              | 217 ----------------------------------
 include/acpi/acconfig.h         |   2 +
 include/acpi/platform/aclinux.h |   4 +
 include/linux/acpi.h            |   4 +-
 11 files changed, 362 insertions(+), 220 deletions(-)
 create mode 100644 drivers/acpi/blacklist-arm.c
 create mode 100644 drivers/acpi/osi-arm.c
 create mode 100644 drivers/acpi/osi.c

-- 
2.1.0

