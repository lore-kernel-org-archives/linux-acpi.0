From: Aaron Durbin <adurbin@google.com>
Subject: Re: ACPI device using sub-resource of PCI device
Date: Tue, 14 Jun 2016 10:04:33 -0700
Message-ID: <CAE2855uR=wkxb2xzM4OcG1czffrBXR=1RX8Ms0AfVJ8hzDnUjQ@mail.gmail.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <CAJZ5v0hh1ve=w590D4XncheNVsrmr7f6k1msdr+dzT4UoUa+JQ@mail.gmail.com> <CAE2855vrhS7gKGFWEjZy-Hp2S8fNuJskG=WWDSuiBLhq_tDh8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33774 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcFNREf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2016 13:04:35 -0400
Received: by mail-io0-f181.google.com with SMTP id d2so241202iof.0
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jun 2016 10:04:35 -0700 (PDT)
In-Reply-To: <CAE2855vrhS7gKGFWEjZy-Hp2S8fNuJskG=WWDSuiBLhq_tDh8A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, May 18, 2016 at 3:32 PM, Aaron Durbin <adurbin@google.com> wrote:
> On Wed, May 18, 2016 at 4:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, May 18, 2016 at 5:54 PM, Aaron Durbin <adurbin@google.com> wrote:
>>> Hi,
>>>
>>> We're currently running into a problem of resource conflicts with a
>>> PCI device and ACPI devices.
>>>
>>> [    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
>>> 0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
>>> 0xd0c00000-0xd0c03fff]
>>>
>>> The PCI BAR covers a large amount mmio resources, however, there are
>>> ACPI devices with their own HID (for probing) which uses resources
>>> that are a subset of the PCI BAR.
>>>
>>> Short of re-structuring the linux driver is there anything that can be
>>> done with ASL to properly have the ACPI device use a sub-resource of
>>> the PCI device during the ACPI/PCI probing?
>>
>> Do you have an ACPI device object corresponding to the PCI device?
>
> I've been debugging this by proxy, and I did request that test. The
> following is the overall structure:
>
> scope (\_SB.PCI0) {
>
> Device (P2S)
> {
>         Name (_ADR, 0x000D0000)
>         Device (GPO0)
>         {
>                 Name (_ADR, 0)
>                 Name (_HID, "INT3452")
>                 Name (_CID, "INT3452")
>         }
> }
> }
>
> There are _STA methods in both Devices. The GP0 device has a _CRS
> method which just returns a ResourceTemplate which is filled in with
> static values. The PCI bar is at a fixed address from the firmware
> which allows the fixed calculations. However there is no specific
> reference to the P2S device's resources proper -- only the parent
> child relationship within the ASL. I'm not sure how to directly say "I
> want this sub-region of this other device's resource for my resource."
> That seems like the right thing, but it's not clear if that's implied
> by hierarchy of the devices.
>
> Lastly, if it helps, the kernel being used is based on v4.4 (no core
> patches on top).
>

Hi Rafael,

I haven't tried a newer kernel yet, but are you of the opinion that
having the Devices as parent-child within the ASL should work? I'm
wondering if there's already a patch in newer kernels that doesn't
report the conflict and works as expected once there are child Devices
under the P2S device.

Thanks for the help.

-Aaron
