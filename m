From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH] usb: optimize acpi companion search for usb port
 devices
Date: Thu, 25 May 2017 18:24:22 +0300
Message-ID: <5926F726.4070302@linux.intel.com>
References: <1495631472-3828-1-git-send-email-mathias.nyman@linux.intel.com>
 <20170524144414.GA13730@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:17556 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758302AbdEYPVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 May 2017 11:21:47 -0400
In-Reply-To: <20170524144414.GA13730@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 24.05.2017 17:44, Greg KH wrote:
> On Wed, May 24, 2017 at 04:11:12PM +0300, Mathias Nyman wrote:
>> This optimization significantly reduces xhci driver load time.
>>
>> In ACPI tables the acpi companion port devices are children of
>> the hub device. The port devices are identified by their port number
>> returned by the ACPI _ADR method.
>> _ADR 0 is reserved for the root hub device.
>>
>> The current implementation to find a acpi companion port device
>> loops through all acpi port devices under that parent hub, calling
>> their _ADR method each time a new port device is added.
>>
>> for a xHC controller with 25 ports under its roothub it
>> will end up invoking ACPI bytecode 625 times before all ports
>> are ready, making it really slow.
>>
>> The _ADR values are already read and cached earler. So instead of
>> running the bytecode again we can check the cached _ADR value first,
>> and then fall back to the old way.
>>
>> As one of the more significant changes, the xhci load time on
>> Intel kabylake reduced by 70%, (28ms) from
>> initcall xhci_pci_init+0x0/0x49 returned 0 after 39537 usecs
>> to
>> initcall xhci_pci_init+0x0/0x49 returned 0 after 11270 usecs
>>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> ---
>>   drivers/usb/core/usb-acpi.c | 26 +++++++++++++++++++++++---
>>   1 file changed, 23 insertions(+), 3 deletions(-)
>
> Why is this RFC?  What's wrong with it as-is?
>

Last minute doubt, nothing should be wrong, but I started to wonder if there is
any particular reason the ACPI part was done the way it was.

Or if maybe other drivers could benefit from checking cached _ADR value first as
well, and this whole thing should be a part of drivers/acpi/glue.c instead?

(adding acpi mailing list, not just Rafael)

Thanks
-Mathias
