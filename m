From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
Date: Tue, 10 Oct 2017 17:03:40 +0800
Message-ID: <59DC8CEC.5070005@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-3-git-send-email-lorenzo.pieralisi@arm.com>
 <59DC7ED6.50204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7958 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdJJJF6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Oct 2017 05:05:58 -0400
In-Reply-To: <59DC7ED6.50204@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 2017/10/10 16:03, Hanjun Guo wrote:
...

>> -static __init
>> -const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
>> +static __init const struct iort_dev_config *iort_get_dev_cfg(

Seems patch rebase issue, this part should be in patch 3/3 :)

Thanks
Hanjun

