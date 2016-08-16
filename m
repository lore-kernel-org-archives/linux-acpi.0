From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] ACPI / sysfs: Cleanup sysfs table handling code
Date: Tue, 16 Aug 2016 13:32:00 +0200
Message-ID: <CAJZ5v0j6eg9YvBrdqn-z0u8Rz1VtTdVcqxHJK+jsGC8DLc2Q_g@mail.gmail.com>
References: <cover.1471337441.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34241 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbcHPLcC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Aug 2016 07:32:02 -0400
In-Reply-To: <cover.1471337441.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Aug 16, 2016 at 10:52 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> There are issues in sysfs table handling code:
> 1. It cannot handle table loaded by LoadTable opcode executed after
>    acpi_sysfs_init();
> 2. It's signature handling code is not correct.
>
> This patchset fixes these issues.
>
> Lv Zheng (5):
>   ACPICA: Tables: Remove acpi_tb_install_fixed_table()
>   ACPICA: Tables: Remove wrong table event macros
>   ACPICA: Tables: Add new table events indicating table
>     installation/uninstallation
>   ACPI / sysfs: Fix an issue for LoadTable opcode
>   ACPI / sysfs: Update sysfs signature handling code
>
>  drivers/acpi/acpica/actables.h |    7 +---
>  drivers/acpi/acpica/tbfadt.c   |   24 +++++++------
>  drivers/acpi/acpica/tbinstal.c |   73 +++++-----------------------------------
>  drivers/acpi/sysfs.c           |   39 ++++++++++-----------
>  include/acpi/actypes.h         |   16 ++++-----
>  5 files changed, 51 insertions(+), 108 deletions(-)

Patches [1-3/5] clearly modify ACPICA.  Have they gone into the
upstream already?

Thanks,
Rafael
