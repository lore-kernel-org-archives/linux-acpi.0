From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] acpi: apei: fix the wrong iteration of generic error
 status block
Date: Thu, 17 Aug 2017 13:43:49 +0200
Message-ID: <20170817114349.uxtossvvaccuwy5g@pd.tnic>
References: <1502971638-31670-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502971638-31670-1-git-send-email-gengdongjiu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 17, 2017 at 08:07:18PM +0800, Dongjiu Geng wrote:
> The revision 0x300 generic error data entry is different
> from the old version, but currently iterating through the
> GHES estatus blocks does not take into account this difference.
> This will lead to failure to get the right data entry if GHES
> has revision 0x300 error data entry.
> 
> Update the GHES estatus iteration to properly increment using
> iteration macro,

This is not what I meant - I meant:

"Update the GHES estatus iteration macro to properly increment using
acpi_hest_get_next(), and ..."

But you don't need to send another version.

Rafael, please correct that when applying, instead.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
