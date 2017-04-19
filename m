From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH V3] acpi:apei:handle GSIV and GPIO notification types
Date: Wed, 19 Apr 2017 09:50:14 -0600
Message-ID: <9593090b-ad98-14e1-f06c-61bc9c3fa906@codeaurora.org>
References: <86258A5CC0A3704780874CF6004BA8A62E695201@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937665AbdDSPuT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2017 11:50:19 -0400
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A62E695201@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shiju Jose <shiju.jose@huawei.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On 4/19/2017 6:03 AM, Shiju Jose wrote:
> System Controller Interrupts are received by ACPI's error device,
> which in turn notifies the GHES code. The same is true of
> APEI's GSIV and GPIO notification types.
> Add support for GSIV and GPIO sharing the SCI
> register/unregister/notifier code.Rename the list and notifier
> to show this is no longer just SCI, but anything from the
> Hardware Error Device.
>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> [james.morse@arm.com: rewrote commit log]
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: James Morse <james.morse@arm.com>
> CC: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

