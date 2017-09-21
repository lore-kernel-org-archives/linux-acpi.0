From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] tee: ACPI support for optee driver
Date: Thu, 21 Sep 2017 15:45:28 +0800
Message-ID: <59C36E18.1050106@huawei.com>
References: <1505977937-25034-1-git-send-email-mchitale@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:6531 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdIUHp7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Sep 2017 03:45:59 -0400
In-Reply-To: <1505977937-25034-1-git-send-email-mchitale@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mayuresh Chitale <mchitale@apm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jens.wiklander@linaro.org
Cc: patches@apm.com

On 2017/9/21 15:12, Mayuresh Chitale wrote:
> This patch modifies the optee driver to add support for parsing
> the conduit method from an ACPI node.

Sorry I didn't involve this earlier, but I think this is a wrong
approach, in ACPI 5.1+ spec, there is a bit in FADT table which
indicates PSCI using SMC or HVC, please see ACPI 6.2 [1],
Table 5-37 Fixed ACPI Description Table ARM Boot Architecture Flags.

Can we just use that to get the conduit method for optee driver too?

[1]: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

Thanks
Hanjun


