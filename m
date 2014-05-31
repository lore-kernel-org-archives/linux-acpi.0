From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] ACPI: Fix a regression of the table checksum verification.
Date: Sun, 01 Jun 2014 00:49:57 +0200
Message-ID: <26459685.K8HWMtpZlE@vostro.rjw.lan>
References: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com> <cover.1401494652.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51361 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753399AbaEaWcq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 May 2014 18:32:46 -0400
In-Reply-To: <cover.1401494652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <zetalog@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

On Saturday, May 31, 2014 08:14:26 AM Lv Zheng wrote:
> From: Lv Zheng <lv.zheng@intel.com>
> 
> There is a warning message triggered by the early table chekcusm
> verification during boot. Large tables cannot be installed on x86 platforms
> due to this failure. The root cause is the size limitation of the current
> x86 early mapping implementation, it's thus not suitable to be used to map
> ACPI tables.
> 
> This patchset fixes this regression by stopping verifying table checksums
> during the early boot stage.

Both queued up for 3.16.

If they are needed in -stable, please take care of sending an appropriate
inclusion request to stable@vger.kernel.org after they have been merged into
the Linus' tree.

Thanks!

> Lv Zheng (2):
>   ACPICA: Tables: Add mechanism to control early table checksum
>     verification.
>   ACPI: Fix regressions that x86 Linux kernel suffers from early
>     mapping size limitation.
> 
>  Documentation/kernel-parameters.txt |    5 +++
>  drivers/acpi/acpica/actables.h      |    8 +++--
>  drivers/acpi/acpica/tbdata.c        |   67 +++++++++++++++++++++++++++--------
>  drivers/acpi/acpica/tbinstal.c      |    8 ++---
>  drivers/acpi/acpica/tbutils.c       |    4 ---
>  drivers/acpi/bus.c                  |    3 ++
>  drivers/acpi/tables.c               |   23 ++++++++++++
>  include/acpi/acpixf.h               |    9 +++++
>  8 files changed, 101 insertions(+), 26 deletions(-)
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
