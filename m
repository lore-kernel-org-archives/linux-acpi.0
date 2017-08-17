From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v3] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Thu, 17 Aug 2017 18:45:17 +0800
Message-ID: <25f9878c-932e-e400-ba06-6e61af41bbfd@huawei.com>
References: <1502871290-28137-1-git-send-email-gengdongjiu@huawei.com>
 <20170817092553.xcfbuplana2wbajb@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817092553.xcfbuplana2wbajb@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com
List-Id: linux-acpi@vger.kernel.org

Borislav,
  thanks for the review,

On 2017/8/17 17:25, Borislav Petkov wrote:
> On Wed, Aug 16, 2017 at 04:14:50PM +0800, Dongjiu Geng wrote:
>> The revision 0x300 generic error data entry is different
>> from the old version, but currently iterating through the
>> GHES estatus blocks does not take into account this difference.
>> This will lead to failure to get the right data entry if GHES
>> has revision 0x300 error data entry.
>>
>> Update the GHES estatus iteration to properly increment using
> 			  iteration macro
> 
>> acpi_hest_get_next, and correct the iteration termination condition
> Please end function names with parentheses.
> 
>> because the status block data length only includes error data length.
> <---- newline here.
> 
>> Clear the CPER estatus printing iteration logic to use same macro.
> s/Clear ... /Convert ... to the same macro./
> 
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> CC: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>  drivers/acpi/apei/apei-internal.h |  5 -----
>>  drivers/firmware/efi/cper.c       | 12 ++----------
>>  include/acpi/ghes.h               |  5 +++++
>>  3 files changed, 7 insertions(+), 15 deletions(-)
> With those addressed you can add:
  Ok, I will add.

> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> -- 
