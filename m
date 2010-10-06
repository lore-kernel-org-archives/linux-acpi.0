From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/5] ACPI: Allow handlers to be installed at the same
 time as methods
Date: Wed, 6 Oct 2010 12:47:43 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858B4893EB3@orsmsx503.amr.corp.intel.com>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com>
 <4911F71203A09E4D9981D27F9D830858B4893B89@orsmsx503.amr.corp.intel.com>
 <20101006161854.GA30584@srcf.ucam.org> <201010062130.27564.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201010062130.27564.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Yes, I would suggest we add a device object to can_wake. This allows the acpica core to handle this "implicit notify" with no additional overhead from the host.



>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>Sent: Wednesday, October 06, 2010 12:30 PM
>To: Matthew Garrett
>Cc: Moore, Robert; linux-acpi@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-pci@vger.kernel.org
>Subject: Re: [PATCH 1/5] ACPI: Allow handlers to be installed at the same
>time as methods
>
>On Wednesday, October 06, 2010, Matthew Garrett wrote:
>> On Wed, Oct 06, 2010 at 09:14:07AM -0700, Moore, Robert wrote:
>>
>> > Although there exists a single Windows document mentions this behavior
>as a windows "feature", I'm not 100% convinced that this is actually true.
>AFAIK, we've never seen a machine that depends on an "implicit notify" on a
>device when a wake GPE happens.
>>
>> Such behaviour would be irrelevant for system sleep/wake - the only
>> requirement is in runtime power management.
>>
>> > It appears to me that the biggest issue right now is the fact that a
>Notify() must be performed on a Device object, and the problem is how to
>associate the GPE with the device object.
>>
>> The other important aspect of this is that a single GPE may correspond
>> to multiple devices. The methods will generally cope with this by either
>> sending multiple notifies, executing some SMM code to identify the
>> relevant device or reading PCI configuration registers to identify the
>> source of the wakeup. We need to handle that case as well.
>
>So, as I said, we can modify acpi_gpe_can_wake() to pass a device object to
>ACPICA.  Then, the device object will be added to the list of devices to
>Notify()
>if the GPE is signaled.  Plain and simple.
>
>Thanks,
>Rafael
