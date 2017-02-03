From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
Date: Fri, 3 Feb 2017 11:52:34 -0500
Message-ID: <bb65cea2-b849-2197-e52e-b548918fb7af@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
 <fd106be9-836d-8d91-e57c-183ca56b4a49@arm.com>
 <45d4de34-cfd2-06af-93c2-e721bd80ab43@codeaurora.org>
 <8687cb39-bffe-8f4a-76aa-a4d4ed61d30e@arm.com>
 <6eb61900-640d-fd7f-7e7f-9deced1ec71e@codeaurora.org>
 <20170203164032.GA31093@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdBCQwj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 11:52:39 -0500
In-Reply-To: <20170203164032.GA31093@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

On 2/3/2017 11:40 AM, Lorenzo Pieralisi wrote:
> (2) Your HIDMA MSI does not depend on Agustin patch series to work

I confirm that my driver doesn't depend on Agustin's patch.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
