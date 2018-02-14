From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/5] ACPI: Do not call _STA on battery devices with
 unmet dependencies
Date: Wed, 14 Feb 2018 11:33:06 +0100
Message-ID: <a62364ba-7b79-6bb0-20a3-c66cb166e923@redhat.com>
References: <20180122085135.16732-1-hdegoede@redhat.com>
 <3281375.11fh90aaLK@aspire.rjw.lan>
 <7efce3e1-4cb7-fa68-9024-73fa124b9171@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B7570FA0@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34970 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeBNKdJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2018 05:33:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so21149433wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Feb 2018 02:33:08 -0800 (PST)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7570FA0@ORSMSX110.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Box, David E" <david.e.box@intel.com>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

On 08-02-18 18:34, Moore, Robert wrote:
> 
> 
>>> The last one needs to go in via ACPICA anyway or we'll need to carry a
>>> Linux-specific replacement for acpi_get_object_info().
>>
>> Ack, I'm discussing how to proceed with this with the ACPICA people.
>>
>> Regards,
>>
>> Hans
> 
> 
> I normally don't like to change external interfaces (the biggest reason being the sheer number of different OS vendors that use ACPICA), but in this case, I feel it may be OK. This interface is probably not heavily used, and there is precedent for this when the invocation of _SUB was removed.
> 
> On the other hand, I think I saw it mentioned that Linux calls this interface only once, is this correct?

More or less, Linux calls it once when enumerating all the devices and a few ACPI drivers call it again to get some
extra info they need.

> If so, perhaps it would be easiest to simply remove this call and use direct control method invocations to obtain the desired data.

If we go this route we would probably end up copying the function, since as said several drivers
use it too.

> If we go ahead and make this change to ACPICA: I have not seen the patch, but please make sure that all vestiges of this are removed. This includes all invocations within ACPICA that examine the result of the _STA invocation, the CurrentStatus field of ACPI_DEVICE_INFO, the ACPI_VALID_STA flag, etc.

The patch already does that:

https://patchwork.kernel.org/patch/10186195/

Regards,

Hans


