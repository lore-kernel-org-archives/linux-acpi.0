From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
Date: Tue, 10 Oct 2017 12:17:46 +0100
Message-ID: <20171010111746.GB28096@red-moon>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-3-git-send-email-lorenzo.pieralisi@arm.com>
 <59DC7ED6.50204@huawei.com>
 <59DC8CEC.5070005@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755400AbdJJLRu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Oct 2017 07:17:50 -0400
Content-Disposition: inline
In-Reply-To: <59DC8CEC.5070005@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Tue, Oct 10, 2017 at 05:03:40PM +0800, Hanjun Guo wrote:
> On 2017/10/10 16:03, Hanjun Guo wrote:
> ...
> 
> >> -static __init
> >> -const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
> >> +static __init const struct iort_dev_config *iort_get_dev_cfg(
> 
> Seems patch rebase issue, this part should be in patch 3/3 :)

True, good catch, updated, thanks !

Lorenzo
