From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/4] ACPI / EC: Fix ECDT and boot_ec support
Date: Mon, 12 Sep 2016 23:55:25 +0200
Message-ID: <5383321.UbK7QLv2A9@vostro.rjw.lan>
References: <cover.1472802172.git.lv.zheng@intel.com> <cover.1473238007.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60816 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751227AbcILVtT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 17:49:19 -0400
In-Reply-To: <cover.1473238007.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, September 07, 2016 04:49:59 PM Lv Zheng wrote:
> Linux uses ECDT only in boot stage (before the namespace is fully
> initialized), but there are cases reported that Windows allows ECDT to be
> used for OSPM runtime, responding EC events by evaluating _Qxx methods
> under the device node indicated in the ECDT.
> 
> This patchset changes Linux ECDT support to follow Windows behavior and
> also fixes related boot_ec support.
> 
> v2:
>  Rebased on top of recent linux-pm.git/linux-next.
>  Addressed 1 comment from Peter Wu.
>  Update patch SOBs.
> 
> Lv Zheng (4):
>   ACPI / EC: Cleanup first_ec/boot_ec code
>   ACPI / EC: Fix a memory leakage issue in acpi_ec_add()
>   ACPI / EC: Fix a gap that ECDT EC cannot handle EC events
>   ACPI / EC: Fix issues related to boot_ec
> 
>  drivers/acpi/ec.c       |  240 +++++++++++++++++++++++++++++++++++++----------
>  drivers/acpi/internal.h |    1 +
>  drivers/acpi/scan.c     |    1 +
>  3 files changed, 195 insertions(+), 47 deletions(-)

Whole series applied.

Thanks,
Rafael

