From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/7] ACPI / osi: Fix several issues in _OSI handling
Date: Fri, 06 May 2016 01:41:16 +0200
Message-ID: <1984770.JBv4BkVfFk@vostro.rjw.lan>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1462263979.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46008 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755704AbcEEXiE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 19:38:04 -0400
In-Reply-To: <cover.1462263979.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, May 03, 2016 04:48:11 PM Lv Zheng wrote:
> This patchset cleans up _OSI handling code and fixes several issues in it.
> 
> In the v2 version, as one fix has been changed to be a stable material,
> patches originally put before it need to be rebased. The necessary changes
> that are required by this fix are still kept before the fix patch, and the
> unnecessary changes that are not required by this fix are moved after the
> fix patch. So that the back porting of the stable materials could be
> easier. The coding style in the stable materials is kept wrong to be
> consistent to the coding style used by the old code, so checkpatch.pl may
> report warnings on the stable materials.
> In the v3 version, SOB blocks are updated with the tester's information.
> Some pr_xxx(PREFIX) related wrong stuffs are corrected. One bool cleanup
> patch is split out.
> 
> Chen Yu (1):
>   ACPI / osi: Fix default _OSI(Darwin) support
> 
> Lv Zheng (6):
>   ACPI / osi: Fix an issue that acpi_osi=!* cannot disable ACPICA
>     internal strings
>   ACPI / osi: Cleanup _OSI("Linux") related code before introducing new
>     support
>   ACPI / osi: Add acpi_osi=!! to allow reverting acpi_osi=!
>   ACPI / osi: Cleanup OSI handling code to use bool
>   ACPI / osi: Cleanup coding style issues before creating a separate
>     OSI source file
>   ACPI / osi: Collect _OSI handling into one single file
> 
>  Documentation/kernel-parameters.txt |    2 +
>  drivers/acpi/Makefile               |    2 +-
>  drivers/acpi/blacklist.c            |  196 +------------
>  drivers/acpi/internal.h             |    2 +
>  drivers/acpi/osi.c                  |  522 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/osl.c                  |  225 +--------------
>  include/linux/acpi.h                |    1 -
>  7 files changed, 533 insertions(+), 417 deletions(-)
>  create mode 100644 drivers/acpi/osi.c

All [1-7/7] applied, thanks!

