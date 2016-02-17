From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V5 07/15] pci, acpi: Provide generic way to assign bus
 domain number.
Date: Wed, 17 Feb 2016 16:35:30 +0100
Message-ID: <56C49342.1070308@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-8-git-send-email-tn@semihalf.com>
 <CAKc_7PU+i2AwOVCyW2VNt4BZCWw=KBMAbV8v9DVQ2Ess3WE=kw@mail.gmail.com>
 <56C47E9A.5010901@semihalf.com>
 <CAKc_7PUiLQhUuJjR8wcuRm7KJdxBYjb+ZBd_cLTtjNPbEro6wA@mail.gmail.com>
 <56C48C45.7050203@semihalf.com>
 <CAKc_7PV=p7kHt73c673L+v=KCaFV8RzoaSHwcH2gd1g-fWGq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36913 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423913AbcBQPfe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 10:35:34 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so33621322wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Feb 2016 07:35:34 -0800 (PST)
In-Reply-To: <CAKc_7PV=p7kHt73c673L+v=KCaFV8RzoaSHwcH2gd1g-fWGq5w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jayachandran Chandrashekaran Nair <jayachandran.chandrashekaran@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, okaya@codeaurora.org, jiang.liu@linux.intel.com, Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com

On 17.02.2016 16:21, Jayachandran Chandrashekaran Nair wrote:
> On Wed, Feb 17, 2016 at 8:35 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> On 17.02.2016 15:21, Jayachandran Chandrashekaran Nair wrote:
>>>
>>> On Wed, Feb 17, 2016 at 7:37 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>>>
>>>> On 17.02.2016 14:44, Jayachandran Chandrashekaran Nair wrote:
>>>>>
>>>>>
>>>>> Tomasz, Lorenzo,
>>>>>
>>>>> On Tue, Feb 16, 2016 at 7:23 PM, Tomasz Nowicki<tn@semihalf.com>  wrote:
>>>>>>
>>>>>>
>>>>>>> As we now have valid PCI host bridge device reference we can
>>>>>>> introduce code that is going to find its bus domain number using
>>>>>>> ACPI _SEG method.
>>>>>>>
>>>>>>> Note that _SEG method is optional, therefore _SEG absence means
>>>>>>> that all PCI buses belong to domain 0.
>>>>>>>
>>>>>>> While at it, for the sake of code clarity we put ACPI and DT domain
>>>>>>> assign methods into the corresponding helpers.
>>>>>
>>>>>
>>>>> In my patchset, I had a slightly different and I think better approach
>>>>> for
>>>>> this without calling the _SEG method again. Please see
>>>>> http://www.spinics.net/lists/arm-kernel/msg478167.html
>>>>> at the last part
>>>>> ofhttp://www.spinics.net/lists/arm-kernel/msg478169.html
>>>>
>>>>
>>>> Relying on NULL parent device to make decision on boot method is really
>>>> ugly
>>>> way. This may hit us again once we want to obtain another firmware
>>>> specific
>>>> info e.g. numa node. IMO we need to fix it this way.
>>>
>>>
>>> I am not relying on NULL there, in the current code parent is NULL
>>> in case of ACPI, and the check is needed not to crash (unless that
>>> has changed).
>>
>>
>> This series passes down valid parent, see [PATCH V5 06/15].
>>
>>>
>>> The main part was the macro acpi_pci_get_segment() and the use
>>> of acpi_pci_root_info from sysdata to do this.
>>
>>
>> Since we can obtain related firmware specific data from valid parent device
>> (without defining another accessors), I do not see the point to use sysdata.
>> Let me know your opinion.
>
> In the patch, you use the parent info and call _SEG method again.
> The segment information is available in the ->root->segment of
> acpi_pci_root_info if you setup the sysdata like in my patch

I know it is in sysdata->root->segment, but the way it is passed down is 
wrong. sysdata is the pointer to unknown content (void *) so we need to 
validate it before we can use it. If we merge this patch we can remove 
first _SEG call.

Tomasz
