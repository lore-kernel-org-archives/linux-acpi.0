From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
Date: Tue, 5 Apr 2016 20:07:59 +0200
Message-ID: <5703FEFF.202@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
 <5703C7AB.2000306@semihalf.com> <20160405164122.GA9419@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35077 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759202AbcDESIG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 14:08:06 -0400
Received: by mail-lf0-f49.google.com with SMTP id c126so16560383lfb.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2016 11:08:06 -0700 (PDT)
In-Reply-To: <20160405164122.GA9419@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran Chandrashekaran Nair <jayachandran.chandrashekaran@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, jiang.liu@linux.intel.com, Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>

Hi Bjorn,

On 05.04.2016 18:41, Bjorn Helgaas wrote:
> Hi Tomasz,
>

[...]

>>>>
>>>
>>> As you pointed out raw_pci_{read|write} make things complicated, so IMO
>>> we should either say they are absolutely necessary (and then think how
>>> to simplify it) or just use simple bus-specific accessor (patch 02/15)
>>> e.g. for ARM64.
>>>
>>> Any comments appreciated.
>>
>> Kindly reminder. I would like to move on with this patch set. Can
>> you please comments on it so that we could decide which way to go.
>
> Can you repost your current proposal with a version number higher than
> any previous ones?  It's OK if the content is the same as v4; I just
> think it's confusing if we resurrect v4 and have to follow discussion
> from v3 to v4 to v5 and back to v4.  The archives would be a bit of a
> muddle.
>

Sure I will repost ASAP.

Thanks!
Tomasz
