From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v8 10/15] ACPI: platform-msi: retrieve dev id from IORT
Date: Mon, 17 Apr 2017 21:30:06 -0400
Message-ID: <f6656f75-68f6-99a5-bc65-781d5ed83f48@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
 <838d8504-b6f0-2475-f4b1-9761ecd9f573@codeaurora.org>
 <9556e737-a9d8-f751-2872-6fabce86fa48@codeaurora.org>
 <58F56B81.3090608@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbdDRBaL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2017 21:30:11 -0400
In-Reply-To: <58F56B81.3090608@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

On 4/17/2017 9:27 PM, Hanjun Guo wrote:
> Patches were merged via two trees:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=irq/core
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core&ofs=50
> 
> So please try to merge those two trees and have a try (we tested
> those patches on our platform and works), if any issues please let
> me know.

Yeah, I figure that out eventually. No issues. I finished my testing
today.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
