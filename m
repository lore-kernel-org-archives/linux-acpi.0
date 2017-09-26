From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v4 0/3] ACPI / EC: Fix EC event handling issues
Date: Tue, 26 Sep 2017 07:52:14 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6BFA7@SHSMSX101.ccr.corp.intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
 <cover.1504166863.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11599 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbdIZHwp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Sep 2017 03:52:45 -0400
In-Reply-To: <cover.1504166863.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Rafael

I'm now working on v5 of this series.
Which
1. splits root causes in a more detailed way,
2. clarifies root causes in patch description with real bugs, and
3. is safer according to the known EC FW behaviors.
So you can discard v3/v4 from the patchwork site.
And I'll post v5 when everything is cleared to me.

Thanks and best regards
Lv

> From: Zheng, Lv
> Subject: [PATCH v4 0/3] ACPI / EC: Fix EC event handling issues
> 
> EC events are special, required to be handled during suspend/resume. But
> there are special logics in Linux causing several issues related to the EC
> event handling:
> 1. During noirq stage, Linux cannot detect EC events which are target
>    driven.
> 2. When EC event handling is enabled later than the other drivers, order
>    problem could be observed.
> When fixing these problems, care should be taken to not to trigger
> regressions to the following problem which has alredy been fixed using
> different approach):
> 3. When EC event handling is enabled before the end of the noirq stage,
>    EC event handling may stuck.
> This patchset fixes these issues.
> 
> v4 of this patch series re-orders the fixes so that the fix of the problem
> 2 could be independent against the fix of the problem 1, this is done by
> refining the fix of the problem 2, making it immune to the problem 3.
> 
> Lv Zheng (3):
>   ACPI / EC: Fix possible driver order issue by moving EC event handling
>     earlier
>   ACPI / EC: Add event detection support for noirq stages
>   ACPI / EC: Enable noirq stage event detection
> 
>  drivers/acpi/ec.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/acpi/internal.h |   1 +
>  2 files changed, 111 insertions(+), 6 deletions(-)
> 
> --
> 2.7.4

