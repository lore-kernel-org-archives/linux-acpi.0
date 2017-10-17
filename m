From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Tue, 17 Oct 2017 10:06:39 -0400
Message-ID: <9287b646-7673-bf5d-bcde-933c8c98a0dd@codeaurora.org>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbdJQOGn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Oct 2017 10:06:43 -0400
In-Reply-To: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>, bp@suse.de, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.or

On 10/17/2017 4:02 AM, Dongjiu Geng wrote:
> For the SEA notification, the two functions ghes_sea_add() and
> ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
> is defined. If not, it will return errors in the ghes_probe()
> and not continue. If the probe is failed, the ghes_sea_remove()
> also has no chance to be called. Hence, remove the unnecessary
> handling when CONFIG_ACPI_APEI_SEA is not defined.
>
> For the NMI notification, it has the same issue as SEA notification,
> so also remove the unused dead-code for it.
>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

I've verified v5 of this series testing the SEA path.

Thanks,
Tyler
