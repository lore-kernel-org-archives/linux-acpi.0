From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V4 4/7] ARM64, ACPI, PCI: I/O Remapping Table (IORT)
 initial support.
Date: Thu, 14 Apr 2016 09:20:45 +0200
Message-ID: <570F44CD.7090605@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-5-git-send-email-tn@semihalf.com>
 <570E645A.9010600@arm.com> <570E6794.4080409@semihalf.com>
 <570E6B2C.3060700@arm.com> <570EB78E.4060705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35749 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbcDNHVH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2016 03:21:07 -0400
Received: by mail-lf0-f53.google.com with SMTP id c126so98326394lfb.2
        for <linux-acpi@vger.kernel.org>; Thu, 14 Apr 2016 00:21:06 -0700 (PDT)
In-Reply-To: <570EB78E.4060705@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 13.04.2016 23:18, Sinan Kaya wrote:
> On 4/13/2016 11:52 AM, Marc Zyngier wrote:
>>>> Sure. Please see:
>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf
>>>> 3.1.1.5 PCI root complex node
>>>> PCI Segment number -> The PCI segment number, as in MCFG and as
>>>> returned by _SEG in the namespace.
>>>>
>>>> So IORT spec states that pci_segment_number corresponds to the segment
>>>> number from MCFG table and _SEG method. Here is my patch which makes
>>>> sure pci_domain_nr(bus) is set properly:
>>>> https://lkml.org/lkml/2016/2/16/418
>> Lovely. So this series is actually dependent on the PCI one. I guess we
>> need to solve that one first, because IORT seems pretty pointless if we
>> don't have PCI support. What's the plan?
>
> Would it be OK to split the PCI specific section of the patch and continue
> review? PCI is a user of the IORT table. Not the other way around.

I need to disagree. What would be the use case for patches w/o "PCI part" ?

Tomasz
