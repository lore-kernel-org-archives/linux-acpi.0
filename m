From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 0/2] arch_timer: acpi: Add workaround for
 hisilicon-161010101 erratum
Date: Tue, 24 Jan 2017 18:49:12 +0800
Message-ID: <41bee749-ff22-1ffc-e428-c4af85229bb0@linaro.org>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35264 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdAXKtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 05:49:24 -0500
Received: by mail-pf0-f177.google.com with SMTP id f144so49616384pfa.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2017 02:49:24 -0800 (PST)
In-Reply-To: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linuxarm@huawei.com, linux-acpi@vger.kernel.org, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-arm-kernel@lists.infradead.org

On 2017/1/24 18:39, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Introduce a general quirk framework for arch timer erratum in ACPI,
> which use the oem information in GTDT table for platform specific
> erratums, then add specific handler and data for hisilicon-161010101
> erratum.

Sorry, forgot to mention that this patch set is based on Mark's git
tree [1] and plus remaining patches for GTDT patch set.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git 
arch-timer/updates

Thanks
Hanjun
