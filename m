From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/3] ACPI / tables: Add table upgrade mechanism
Date: Thu, 21 Apr 2016 02:18:36 +0200
Message-ID: <3948235.FadEB4uYLA@vostro.rjw.lan>
References: <cover.1460340514.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42762 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751369AbcDUAPp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:15:45 -0400
In-Reply-To: <cover.1460340514.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, April 11, 2016 10:13:07 AM Lv Zheng wrote:
> This patch introduces a table upgrade mechanism based on the existing
> initrd table override mechanism.
> 
> Updated due to a build error reported against early_acpi_table_init()
> stub.
> 
> Lv Zheng (3):
>   ACPI / tables: Move table override mechanisms to tables.c
>   ACPI / x86: Cleanup initrd related code
>   ACPI / tables: Convert the initrd table override mechanisms to the
>     table upgrade mechanism
> 
>  Documentation/acpi/initrd_table_override.txt |   65 +++---
>  arch/x86/kernel/setup.c                      |   12 +-
>  drivers/acpi/Kconfig                         |    8 +-
>  drivers/acpi/internal.h                      |    1 -
>  drivers/acpi/osl.c                           |  274 ----------------------
>  drivers/acpi/tables.c                        |  312 +++++++++++++++++++++++++-
>  include/linux/acpi.h                         |   10 +-
>  7 files changed, 365 insertions(+), 317 deletions(-)

All [1-3/3] applied, thanks!

