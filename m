From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
Date: Thu, 10 Sep 2015 09:48:25 +0700
Message-ID: <55F0EF79.3090202@amd.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55F02331.2060001@amd.com> <8172790.rR5Ld4j83C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0089.outbound.protection.outlook.com ([65.55.169.89]:52960
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752766AbbIJCsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Sep 2015 22:48:36 -0400
In-Reply-To: <8172790.rR5Ld4j83C@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rafael,

On 9/10/2015 3:38 AM, Rafael J. Wysocki wrote:
> On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee wrote:
>> >Hi All,
>> >
>> >Are there any other concerns about this patch series?
> I have none, but then it sort of missed the merge window.
>
> I can easily queue it up for the next one unless it is super-urgent,
> but in that case I need to know why that's the case.
>

This is not urgent. This mainly needed to enable the ACPI PCI supports 
for ARM64 which is still work in progress.

Thanks,
Suravee
