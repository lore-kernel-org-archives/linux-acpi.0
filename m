From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
Date: Mon, 12 Oct 2015 14:51:33 -0500
Message-ID: <561C0F45.8090107@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55F02331.2060001@amd.com> <8172790.rR5Ld4j83C@vostro.rjw.lan>
 <55F0EF79.3090202@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <55F0EF79.3090202@amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 9/9/15 21:48, Suthikulpanit, Suravee wrote:
> Hi Rafael,
>
> On 9/10/2015 3:38 AM, Rafael J. Wysocki wrote:
>> On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee
>> wrote:
>>> >Hi All,
>>> >
>>> >Are there any other concerns about this patch series?
>> I have none, but then it sort of missed the merge window.
>>
>> I can easily queue it up for the next one unless it is super-urgent,
>> but in that case I need to know why that's the case.
>>
>
> This is not urgent. This mainly needed to enable the ACPI PCI supports
> for ARM64 which is still work in progress.
>
> Thanks,
> Suravee
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Just wondering if you are planning to queue this series up for 4.4 as well?

Thank you,
Suravee
