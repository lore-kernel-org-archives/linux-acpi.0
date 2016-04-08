From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / tables: Add table upgrade mechanism
Date: Fri, 8 Apr 2016 11:22:04 +0300
Message-ID: <CAHp75Vdec8M+5sBJbRjE8Nt-aOH3XhhAT7WHcDjkZQydvjdNSQ@mail.gmail.com>
References: <cover.1460100857.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36386 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbcDHIWF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2016 04:22:05 -0400
In-Reply-To: <cover.1460100857.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Apr 8, 2016 at 10:35 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> This patch introduces a table upgrade mechanism based on the existing
> initrd table override mechanism.
>

Mika, I think we might take advantage of this change.

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
>  include/linux/acpi.h                         |    6 +-
>  7 files changed, 366 insertions(+), 312 deletions(-)
>
> --
> 1.7.10
>



-- 
With Best Regards,
Andy Shevchenko
