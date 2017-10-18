From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 18 Oct 2017 17:17:27 +0800
Message-ID: <4b51bd4e-2bf7-3aed-f17c-565b49781009@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
 <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
 <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934284AbdJRJS0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Oct 2017 05:18:26 -0400
In-Reply-To: <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>


On 2017/10/18 17:06, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 01:00:44PM +0800, gengdongjiu wrote:
>> SError is System Error, which is a asynchronous exception in the Internal CPU.
>>
>> In the ARM RAS Extension, there are mainly two type abort for CPU:
>> SEA(Synchronous External Abort)
>> SEI(SError Interrupt)
> And you're not writing it out as "System Error" because ...?

Thanks Borislav, can I write it as asynchronous exception or asynchronous abort?

