From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
Date: Fri, 13 Oct 2017 15:19:44 +0800
Message-ID: <59E06910.40404@huawei.com>
References: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507824047-17045-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJMHVA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Oct 2017 03:21:00 -0400
In-Reply-To: <1507824047-17045-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 2017/10/13 0:00, Lorenzo Pieralisi wrote:
> Some functions definition indentations are using a style that is frowned
> upon with return value type/storage class specifier in a separate line.
>
> Reindent the function definitions to fix them.

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

By the way, I tested this patch set on D05 with no regressions.

Thanks
Hanjun



