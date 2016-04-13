From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 4/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
Date: Wed, 13 Apr 2016 17:18:06 -0400
Message-ID: <570EB78E.4060705@codeaurora.org>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-5-git-send-email-tn@semihalf.com>
 <570E645A.9010600@arm.com> <570E6794.4080409@semihalf.com>
 <570E6B2C.3060700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40252 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbcDMVSM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 17:18:12 -0400
In-Reply-To: <570E6B2C.3060700@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 4/13/2016 11:52 AM, Marc Zyngier wrote:
>> > Sure. Please see:
>> > http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
>> > 3.1.1.5 PCI root complex node
>> > PCI Segment number -> The PCI segment number, as in MCFG and as
>> > returned by _SEG in the namespace.
>> > 
>> > So IORT spec states that pci_segment_number corresponds to the segment 
>> > number from MCFG table and _SEG method. Here is my patch which makes 
>> > sure pci_domain_nr(bus) is set properly:
>> > https://lkml.org/lkml/2016/2/16/418
> Lovely. So this series is actually dependent on the PCI one. I guess we
> need to solve that one first, because IORT seems pretty pointless if we
> don't have PCI support. What's the plan?

Would it be OK to split the PCI specific section of the patch and continue
review? PCI is a user of the IORT table. Not the other way around. 

We shouldn't need a two way dependency. 

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
