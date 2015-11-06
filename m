From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [Patch v7 4/7] PCI/ACPI add interface to acpi_pci
Date: Fri, 6 Nov 2015 11:50:40 -0600
Message-ID: <563CE870.3040901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:46841 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932978AbbKFRur convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Nov 2015 12:50:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jiang.liu@linux.intel.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>

Hello,

I just took a quick look at the discussion about the DwordIO ACPI 
translation, and I have a couple comments (I don't have the whole thread 
available for some reason..).

First, the "secondary bus" referenced in the ACPI specification is the 
processor side, rather than the PCI device side. So the minimum/max base 
address are the MMIO mapped addresses. To get the actual IO address the 
translation must be subtracted. This means AFAIK that the qemu table is 
wrong in two ways for ARM64.

So that said, I will reference the juno DwordIo resource which I 
recently added to the EDK.

DWordIo ( // IO window
	ResourceProducer,
	MinFixed,
	MaxFixed,
	PosDecode,
	EntireRange,
	0x00000000, 	// Granularity
	0x5f800000, 	// Min Base Address
	0x5fffffff,	// Max Base Address
	0x5f800000, 	// Translate
	0x00800000  	// Length
)

Which after reading the specification, I realized should be setting the 
translation type to TypeTranslation. But that really doesn't matter for 
ARM64 because ARM64 doesn't have a processor accessible IO address 
range. AKA the TranslationType controls whether the processor is doing 
an IN/OUT/etc to access the range or actual MMIO read/writes. Since on 
ARM64 the only choice is MMIO, this field should be ignored, the only 
behavior difference should possibly be a warning if someone leaves it 
set to static.

Put another way, the setting of the TranslationType doesn't change the 
way the "translation" is computed, only how its accessed. AKA it doesn't 
affect the math..




