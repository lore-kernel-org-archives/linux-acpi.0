From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/3] ACPI/IORT: Remove leftover
 ACPI_IORT_SMMU_V3_PXM_VALID guard
Date: Tue, 10 Oct 2017 15:59:32 +0800
Message-ID: <59DC7DE4.90409@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7532 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbdJJIB3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2017 04:01:29 -0400
In-Reply-To: <1507038811-23382-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

On 2017/10/3 21:53, Lorenzo Pieralisi wrote:
> The conditional ACPI_IORT_SMMU_V3_PXM_VALID guard around
> arm_smmu_v3_set_proximity() was added to manage a cross tree
> ACPICA merge dependency; with ACPICA changes merged in:
>
> commit c944230064eb ("ACPICA: iasl: Update to IORT SMMUv3
> disassembling")
>
> the guard has become useless. Remove it.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

