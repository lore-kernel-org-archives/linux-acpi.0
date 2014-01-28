From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] ACPI: reduce log level for message "ACPI: \_PR_.CPU4:
 failed to get CPU APIC ID"
Date: Tue, 28 Jan 2014 09:20:20 +0800
Message-ID: <52E705D4.3010806@linux.intel.com>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com> <1390804498-30311-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.02.1401271615580.17114@chino.kir.corp.google.com> <52E6F9B9.1070900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46190 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679AbaA1BUY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jan 2014 20:20:24 -0500
In-Reply-To: <52E6F9B9.1070900@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Rientjes <rientjes@google.com>
Cc: Jorg Otte <jrg.otte@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 2014/1/28 8:28, Rafael J. Wysocki wrote:
> On 1/28/2014 1:18 AM, David Rientjes wrote:
>> On Mon, 27 Jan 2014, Jiang Liu wrote:
>>
>>> diff --git a/drivers/acpi/acpi_processor.c
>>> b/drivers/acpi/acpi_processor.c
>>> index c9311be..c29c2c3 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -261,7 +261,7 @@ static int acpi_processor_get_info(struct
>>> acpi_device *device)
>>>         apic_id = acpi_get_apicid(pr->handle, device_declaration,
>>> pr->acpi_id);
>>>       if (apic_id < 0) {
>>> -        acpi_handle_err(pr->handle, "failed to get CPU APIC ID.\n");
>>> +        acpi_handle_debug(pr->handle, "failed to get CPU APIC ID.\n");
>>>           return -ENODEV;
>>>       }
>> Don't we already leave some artifact in the kernel log at boot about apic
>> ids that don't get registered?  I'm wondering if we should have this
>> warning at all.
> 
> It is useful for knowing that there are potentially broken objects in
> the ACPI tables.
And it's very useful to identify BIOS bug in case of CPU hot-addition.
It caused our test team about 1 week to identify BIOS bug in CPU
hot-addition, so I added this debug message.
Thanks!
Gerry
> 
> 
