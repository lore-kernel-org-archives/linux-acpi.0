From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 3/3] ACPI/IORT: Make platform devices initialization code
 SMMU agnostic
Date: Tue, 10 Oct 2017 17:27:01 +0800
Message-ID: <59DC9265.3070709@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7535 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdJJJ2M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2017 05:28:12 -0400
In-Reply-To: <1507038811-23382-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>

On 2017/10/3 21:53, Lorenzo Pieralisi wrote:
> The way current IORT code initializes platform devices for SMMU nodes
> is somewhat tied (mostly for naming convention) to the SMMU nodes
> themselves but it need not be in that it is completely generic and
> can easily be made so by structures renaming and code reshuffling.
>
> Rework IORT platform devices initialization code to make the functions
> and data structures SMMU agnostic.
>
> No functional changes intended.

This will be good preparation for PMCG driver support, with my comments
in patch 2/3 fixed,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

