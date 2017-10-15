From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v3 1/2] acpi: apei: remove the unused dead-code for SEA
 notification type
Date: Sun, 15 Oct 2017 16:35:59 +0800
Message-ID: <7a99ceed-850b-caf1-a258-f55624bb9bb3@huawei.com>
References: <1506602498-25752-1-git-send-email-gengdongjiu@huawei.com>
 <20171013132135.ahumafo2grbkiqss@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8046 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdJOIgg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Oct 2017 04:36:36 -0400
In-Reply-To: <20171013132135.ahumafo2grbkiqss@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, tbaicar@codeaurora.org, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

Borislav,
  Thank you for your time to review it.

On 2017/10/13 21:21, Borislav Petkov wrote:
>>  	.notifier_call = ghes_notify_hed,
>>  };
>>  
>> -#ifdef CONFIG_ACPI_APEI_SEA
>>  static LIST_HEAD(ghes_sea);
> But now those get compiled in on x86 where there's no SEA and where we
> don't need them. So no, I don't think this patch is correct.

If have updated the patch for the x86, you can review the version 4 patches.
thanks.


