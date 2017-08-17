From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Thu, 17 Aug 2017 11:25:53 +0200
Message-ID: <20170817092553.xcfbuplana2wbajb@pd.tnic>
References: <1502871290-28137-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751015AbdHQJjE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Aug 2017 05:39:04 -0400
Content-Disposition: inline
In-Reply-To: <1502871290-28137-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

On Wed, Aug 16, 2017 at 04:14:50PM +0800, Dongjiu Geng wrote:
> The revision 0x300 generic error data entry is different
> from the old version, but currently iterating through the
> GHES estatus blocks does not take into account this difference.
> This will lead to failure to get the right data entry if GHES
> has revision 0x300 error data entry.
> 
> Update the GHES estatus iteration to properly increment using

			  iteration macro

> acpi_hest_get_next, and correct the iteration termination condition

Please end function names with parentheses.

> because the status block data length only includes error data length.

<---- newline here.

> Clear the CPER estatus printing iteration logic to use same macro.

s/Clear ... /Convert ... to the same macro./

> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/apei-internal.h |  5 -----
>  drivers/firmware/efi/cper.c       | 12 ++----------
>  include/acpi/ghes.h               |  5 +++++
>  3 files changed, 7 insertions(+), 15 deletions(-)

With those addressed you can add:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
