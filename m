From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
Date: Wed, 21 Sep 2016 18:40:47 -0400
Message-ID: <304377c6-554d-60ea-30df-006e557c7279@codeaurora.org>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755315AbcIUWkw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2016 18:40:52 -0400
In-Reply-To: <20160921131107.GB10804@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org, jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bjorn,

On 09/21/2016 09:11 AM, Bjorn Helgaas wrote:
> On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov@codeaurora.org wrote:

>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>> index eb14f74..bb3b8ad 100644
>>> --- a/drivers/acpi/pci_mcfg.c
>>> +++ b/drivers/acpi/pci_mcfg.c
>>> @@ -42,86 +42,59 @@ struct mcfg_fixup {
>>> 	struct resource cfgres;
>>> };
>>>
>>> -#define MCFG_DOM_ANY			(-1)
>>
>> Did you delete this because there were no current users, because you'd
>> prefer users just use "-1", or for some other reason?
> 
> I removed it because there were no users of it and, more importantly,
> the code doesn't implement support for it.

It looks like a stale "First match against PCI topology <domain:bus>..."
comment remains.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
