From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] acpi: apei: fix GHES estatus iteration
Date: Tue, 8 Aug 2017 17:32:20 +0100
Message-ID: <20170808163219.GB2163@arm.com>
References: <1501795945-5331-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbdHHQcS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Aug 2017 12:32:18 -0400
Content-Disposition: inline
In-Reply-To: <1501795945-5331-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org

On Thu, Aug 03, 2017 at 03:32:25PM -0600, Tyler Baicar wrote:
> Currently iterating through the GHES estatus blocks does not
> take into account the new generic data v3 structure size. This
> can result in garbage non-standard trace events to be triggered
> since the loop will not properly iterate through the estatus
> blocks and not properly terminate.
> 
> Update the GHES estatus iteration to properly increment through
> the estatus blocks similar to how the CPER estatus printing
> iterates through them.
> 
> Fixes: bbcc2e7b642e ("ras: acpi/apei: cper: add support for generic data v3 structure")
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Tested-by: Austin Christ <austinwc@codeaurora.org>
> ---
>  drivers/acpi/apei/apei-internal.h | 5 -----
>  drivers/acpi/apei/ghes.c          | 8 +++++++-
>  2 files changed, 7 insertions(+), 6 deletions(-)

Whilst much of the initial code here went through the arm64 tree in the
previous merge window, I'm assuming that Boris will take this fix via his
tree (likewise for "[PATCH V2] acpi: apei: clear error status before
acknowledging the error").

Will
