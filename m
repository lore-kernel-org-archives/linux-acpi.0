From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] ACPI: EC: Fix a regression related to wrong ECDT initialization order
Date: Fri, 18 Aug 2017 01:12:52 +0200
Message-ID: <2095415.pyOK0krZKL@aspire.rjw.lan>
References: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com> <ede92a9abe2f4e6bfd0139078565465eb58fef95.1502936401.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47160 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753326AbdHQXVU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Aug 2017 19:21:20 -0400
In-Reply-To: <ede92a9abe2f4e6bfd0139078565465eb58fef95.1502936401.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Thursday, August 17, 2017 4:21:04 AM CEST Lv Zheng wrote:
> The following commit is bisected out to be a regression culprit:
>  Commit: c712bb58d8278465b1a91f362a08f5c79ad077e4
>  Subject: ACPI / EC: Add support to skip boot stage DSDT probe
> However the problem is actually originated from the following commit:
>  Commit: 2a5708409e4e05446eb1a89ecb48641d6fd5d5a9
>  Subject: ACPI / EC: Fix a gap that ECDT EC cannot handle EC events
> 
> Commit 2a570840 introduces acpi_ec_ecdt_start(), but invokes it too early:
> earlier before acpi_ec_query_init(). Thus when EC event is flagged after
> boot, ec_query_wq is not valid, resulting in a kernel warning:
>  [    3.580017] BUG: unable to handle kernel NULL pointer dereference at 0000000000000102
>  ...
>  [    4.380005] Workqueue: events acpi_ec_event_handler
>  [    4.380005] task: ffff9f539790dac0 task.stack: ffffb437c0e10000
>  [    4.380005] RIP: 0010:__queue_work+0x32/0x430
> 
> Normally DSDT EC should always be valid. Thus acpi_ec_ecdt_start() is
> actually a no-op in most of the cases. While the commit c712bb58 skips
> probing DSDT EC as boot EC when ECDT EC is valid, making this bug
> surfaced.
> 
> This patch fixes this issue by invoking acpi_ec_ecdt_start() after
> acpi_ec_query_init() in acpi_ec_init().
> 
> Link: https://jira01.devtools.intel.com/browse/LCK-4348
> Fixes: 2a5708409e4e ("ACPI / EC: Fix a gap that ECDT EC cannot handle EC events")
> Fixes: c712bb58d827 ("ACPI / EC: Add support to skip boot stage DSDT probe")
> Reported-by: Wang Wendy <wendy.wang@intel.com>
> Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Well, commit c712bb58d827 is a recent one, so this needs to be fixed in 4.13.

For this reason, I'm going to apply https://patchwork.kernel.org/patch/9903127/
and I will rebase my GPEs patches on top of it (they are queued up for 4.14).
Then, I'll apply the [2/2] from this series on top of that.

Thanks,
Rafael

