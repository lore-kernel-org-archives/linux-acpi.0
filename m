From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 18 Oct 2017 18:25:11 +0800
Message-ID: <0ce7476a-8e93-8cb7-ac6f-641f56702659@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
 <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
 <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
 <4b51bd4e-2bf7-3aed-f17c-565b49781009@huawei.com>
 <20171018092547.guf54e6aqbzzfxrq@pd.tnic> <59E72290.6060604@arm.com>
 <20171018100456.4xthv2tfvgckzyk3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8941 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030242AbdJRK22 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Oct 2017 06:28:28 -0400
In-Reply-To: <20171018100456.4xthv2tfvgckzyk3@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, James Morse <james.morse@arm.com>
Cc: tbaicar@codeaurora.org, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>

On 2017/10/18 18:04, Borislav Petkov wrote:
> On Wed, Oct 18, 2017 at 10:44:48AM +0100, James Morse wrote:
>> What should we call this thing?
> My only pet peeve is having abbreviations everywhere and nothing
> explaining them.
> 
> So whatever you guys decide upon and as long as there's an explanation
> what those things mean and you stick with that name, is perfectly fine
> with me.

surely, we will, thanks Borislav's reminder.

