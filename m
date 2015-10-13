From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH V3 2/4] ACPI/scan: Clean up acpi_check_dma
Date: Tue, 13 Oct 2015 08:52:21 -0700
Message-ID: <561D28B5.7030303@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440597279-11802-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150914163411.GL829@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1bon0055.outbound.protection.outlook.com ([157.56.111.55]:32155
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbbJMPwL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Oct 2015 11:52:11 -0400
In-Reply-To: <20150914163411.GL829@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>

Hi Bjorn,

Thanks for your feedback. And sorry for late response. Some how I didn't 
see this earlier.  Please see my comments below.

On 09/14/2015 09:34 AM, Bjorn Helgaas wrote:
>> [..]
>> So, in order to simplify the function, this patch renames acpi_check_dma()
>> to acpi_check_dma_coherency() to clearly indicate the purpose of this
>> function, and only returns an integer where -1 means DMA not supported,
>> 1 means coherent DMA, and 0 means non-coherent DMA.
>
> I think acpi_check_dma_coherency() is better, but only slightly.  It
> still doesn't give a hint about the *sense* of the return value.  I
> think it'd be easier to read if there were two functions, e.g.,

I have been going back-and-forth between the current version, and the 
two-function-approach in the past. I can definitely go with this route 
if you would prefer. Although, if acpi_dma_is_coherent() == 0, it would 
be ambiguous whether DMA is not supported or non-coherent DMA is 
supported. Then, we would need to call acpi_dma_is_supported() to find 
out. So, that's okay with you?

>> [...]
>> +
>> +	/**
>> +	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
>> +	 * This should be equivalent to specifying dma-coherent for
>> +	 * a device in OF.
>> +	 *
>> +	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
>> +	 * we have two choices:
>> +	 *   1. Do not support and disable DMA.
>
> I know you didn't write this comment, but do we actually *disable* DMA in
> the sense of turning off PCI bus mastering or calling an ACPI method that
> disables DMA by this device?  I suspect we just don't set up DMA ops and
> masks for this device.

Actually, I wrote this comment. When we disable DMA, we basically set 
dma-mask=0 and do not setup DMA ops as you mentioned. We don't actually 
mess with the hardware.

Thanks,
Suravee
