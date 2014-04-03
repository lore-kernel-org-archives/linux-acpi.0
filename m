From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Coverity CID 134632: acpi_hw_build_pci_list() memory leak
Date: Thu, 3 Apr 2014 11:27:47 -0600
Message-ID: <CAErSpo7hZUQsLQw7WHes=_Sb-+Hv_aCZTix+NdpjfkEUAartEg@mail.gmail.com>
References: <CAErSpo4-c1Wb-gtaBGrVq557330PHKrB_mB3Hk+xdt_BtBYFVQ@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37C7FF0CD@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50717 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbaDCR2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Apr 2014 13:28:08 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so2182484iec.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2014 10:28:08 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7FF0CD@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Thu, Apr 3, 2014 at 11:03 AM, Moore, Robert <robert.moore@intel.com> wrote:
> On second thought, did you notice that the caller always deletes the list, regardless of the return status?

Hmm, no, I didn't notice that, and obviously Coverity didn't either.
So I guess there's no actual bug, as long as every caller deletes the
list regardless of status.  And there's only one caller.

I wouldn't hold it up as good style, but I guess it's safe :)

>     /* Build a list of PCI devices, from PciRegion up to RootPciDevice */
>
>     Status = AcpiHwBuildPciList (RootPciDevice, PciRegion, &ListHead);
>     if (ACPI_SUCCESS (Status))
>     {
>         /* Walk the list, updating the PCI device/function/bus numbers */
>
>         Status = AcpiHwProcessPciList (PciId, ListHead);
>     }
>
>     /* Always delete the list */
>
>     AcpiHwDeletePciList (ListHead);
>     return_ACPI_STATUS (Status);
>
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Thursday, April 03, 2014 9:22 AM
>> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
>> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> Subject: Coverity CID 134632: acpi_hw_build_pci_list() memory leak
>>
>> Coverity complains that acpi_hw_build_pci_list() leaks memory when it
>> returns here:
>>
>> 201                if (!list_element) {
>>
>> CID 134632 (#1 of 2): Resource leak (RESOURCE_LEAK) 13. leaked_storage:
>> Variable list_head going out of scope leaks the storage it points to.
>> 202                        return (AE_NO_MEMORY);
>> 203                }
>>
>> We're building up a list, and if we fail to allocate another element, we
>> return failure without deallocating the already built-up list.
>>
>> This is CID 134632.
>>
>> Bjorn
