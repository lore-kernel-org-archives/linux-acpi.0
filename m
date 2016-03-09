From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
Date: Wed, 9 Mar 2016 10:14:53 +0100
Message-ID: <56DFE98D.5010906@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34101 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbcCIJPE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2016 04:15:04 -0500
Received: by mail-lb0-f175.google.com with SMTP id xr8so54533084lbb.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Mar 2016 01:15:03 -0800 (PST)
In-Reply-To: <56DFE91E.10105@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran Chandrashekaran Nair <jayachandran.chandrashekaran@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, jiang.liu@linux.intel.com, Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>

On 09.03.2016 10:13, Tomasz Nowicki wrote:
>> So I think we should write generic MCFG and ECAM support from scratch
>> for arm64.  Something like this:
>>
>>    - Add an acpi_mcfg_init(), maybe in drivers/acpi/pci_mcfg.c, to be
>>      called from acpi_init() to copy MCFG info to something we can
>>      access after __init.  This would not reserve resources, but
>>      probably does have to ioremap() the regions to support
>>      raw_pci_read().
>
> As said, ECAM and ACPI specific code was isolated in previous patch.

I meant to say, in my previous patch set (V4), sorry.

Tomasz
