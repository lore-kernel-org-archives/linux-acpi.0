From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
Date: Fri, 3 Feb 2017 09:50:26 -0500
Message-ID: <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdBCOub (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 09:50:31 -0500
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>

On 1/18/2017 7:54 AM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> With platform msi support landed in the kernel, and the introduction
> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
> is ready, this patch set add few patches to enable the ACPI platform
> msi support.
> 
> For platform device connecting to ITS on arm platform, we have IORT
> table with the named componant node to describe the mappings of paltform
> device and ITS, so we can retrieve the dev id and find its parent
> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
> 

I understand that there is a consensus on IORT/SMMUv3 specific pieces
of this series while there is some ongoing work on the MBIgen part in
due to dependency on Agustin's patch vs. ACPI definitions.

Can we merge the IORT/SMMUv3 specific pieces to 4.11 so that the base
implementation comes in place?

Any objections to not doing so?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
