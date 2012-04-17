From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [RFC PATCH] PCIe: Add PCIe runtime D3cold support
Date: Tue, 17 Apr 2012 13:32:20 +0800
Message-ID: <CAC=cRTMk-NTvo+DJ2mAq6_ZeVLbeqiGx+ttZG6Hr_hQyyYkfLw@mail.gmail.com>
References: <4F8790F6.5080408@intel.com>
	<201204132141.58063.rjw@sisk.pl>
	<4F8B828E.9060606@intel.com>
	<201204161907.13806.rjw@sisk.pl>
	<4F8CD18A.5080903@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4F8CD18A.5080903@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 17, 2012 at 10:12 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> On 04/17/2012 01:07 AM, Rafael J. Wysocki wrote:
>
>> BTW, can you please explain to me what the #WAKE signal is and how it is
>> different from PME#?
>
> #WAKE signal is triggered by a pin connected to the root complex or other
> motherboard logic. PME# is triggered by PME message sent to the port.

PME# is a PCI pin, while WAKE# is a PCI Express pin.  In PCI Express,
there is no PME#, PME is delivered between end point device and root
port or root complex event collector via PME message, and the PME
message will trigger IRQ on root port or root complex event collector.
 WAKE# is not used for PCI Express D1, D2 and D3hot, it is just used
by D3cold.  When remote wakeup detected by end point device, it will
assert WAKE# to notify power controller (implemented via ACPI on some
platform), then power controller will turn on power for main link,
after link goes back to L0, PME message will be sent to root port or
root complex event collector by end point device.

Best Regards,
Huang Ying
