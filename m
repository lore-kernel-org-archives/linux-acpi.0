From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH] usb: optimize acpi companion search for usb port
 devices
Date: Fri, 2 Jun 2017 15:20:20 +0300
Message-ID: <59315804.9020003@linux.intel.com>
References: <1495631472-3828-1-git-send-email-mathias.nyman@linux.intel.com>
 <20170524144414.GA13730@kroah.com> <5926F726.4070302@linux.intel.com>
 <eecdac13-cd08-3521-a57b-b3827ca8d038@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18721 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdFBMRj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 08:17:39 -0400
In-Reply-To: <eecdac13-cd08-3521-a57b-b3827ca8d038@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 01.06.2017 02:01, Rafael J. Wysocki wrote:
> On 5/25/2017 5:24 PM, Mathias Nyman wrote:
>> On 24.05.2017 17:44, Greg KH wrote:
>>> On Wed, May 24, 2017 at 04:11:12PM +0300, Mathias Nyman wrote:
>>>> This optimization significantly reduces xhci driver load time.
>>>>
>>>> In ACPI tables the acpi companion port devices are children of
>>>> the hub device. The port devices are identified by their port number
>>>> returned by the ACPI _ADR method.
>>>> _ADR 0 is reserved for the root hub device.
>>>>
>>>> The current implementation to find a acpi companion port device
>>>> loops through all acpi port devices under that parent hub, calling
>>>> their _ADR method each time a new port device is added.
>>>>
>>>> for a xHC controller with 25 ports under its roothub it
>>>> will end up invoking ACPI bytecode 625 times before all ports
>>>> are ready, making it really slow.
>>>>
>>>> The _ADR values are already read and cached earler. So instead of
>>>> running the bytecode again we can check the cached _ADR value first,
>>>> and then fall back to the old way.
>>>>
>>>> As one of the more significant changes, the xhci load time on
>>>> Intel kabylake reduced by 70%, (28ms) from
>>>> initcall xhci_pci_init+0x0/0x49 returned 0 after 39537 usecs
>>>> to
>>>> initcall xhci_pci_init+0x0/0x49 returned 0 after 11270 usecs
>>>>
>>>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>> ---
>>>>   drivers/usb/core/usb-acpi.c | 26 +++++++++++++++++++++++---
>>>>   1 file changed, 23 insertions(+), 3 deletions(-)
>>>
>>> Why is this RFC?  What's wrong with it as-is?
>>>
>>
>> Last minute doubt, nothing should be wrong, but I started to wonder if there is
>> any particular reason the ACPI part was done the way it was.
>>
>> Or if maybe other drivers could benefit from checking cached _ADR value first as
>> well, and this whole thing should be a part of drivers/acpi/glue.c instead?
>>
>
> That or we should just evaluate _ADR if present during the very initialization and store the value in a filed under struct acpi_device.
>

Yes, that is pretty much done, acpi_init_device_object() will end up evaluating _ADR
and store it in acpi_device.pnp.bus_address

Just considering if there should be something like acpi_get_adr(acpi_device *adev) that
would first check if adev->pnp.bus_address exists, if not, then it would evaluate _ADR.

But really just a thought, I think I'll send this forward as is.

Thanks
Mathias  

