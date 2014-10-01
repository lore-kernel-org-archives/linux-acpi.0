From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
Date: Wed, 1 Oct 2014 16:19:37 -0500
Message-ID: <542C6FE9.10903@amd.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
 <20140917012614.GA31214@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0102.outbound.protection.outlook.com ([65.55.169.102]:60672
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751208AbaJAVUB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Oct 2014 17:20:01 -0400
In-Reply-To: <20140917012614.GA31214@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, arnd@arndb.de, graeme.gregory@linaro.org, marc.zyngier@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, astone@redhat.com, grant.likely@linaro.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, olof@lixom.net, jason@lakedaemon.net, "Duran, Leo" <leo.duran@amd.com>, Jon Masters <jcm@redhat.com>

On 9/16/2014 8:26 PM, Matthew Garrett wrote:
> On Mon, Sep 15, 2014 at 07:47:23PM -0500, suravee.suthikulpanit@amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch adds ACPI match table in ahci_platform. The table includes
>> the acpi_device_id to match AMD Seattle SATA controller with following
>> asl structure in DSDT:
>>
>>      Device (SATA0)
>>      {
>>        Name(_HID, "AMDI0600")	// Seattle AHSATA
>
> There really ought to be a well-defined PNPID for AHCI, so you can _HID
> to AMD and _CID to something generic. That way we won't have:
>
>> +#ifdef CONFIG_ATA_ACPI
>> +static const struct acpi_device_id ahci_acpi_match[] = {
>> +	{ "AMDI0600", 0 }, /* AMD Seattle AHCI */
>> +	{ },
>> +};
>
> utter sadness here. Really, please don't end up in a situation where we
> need to add device-specific IDs to a generic driver.
>
Matthew,

Currently, there is no _CID defined for generic AHCI. We will work on 
proposing one, and provide update patches for including the new ID.

Thanks,
Suravee

