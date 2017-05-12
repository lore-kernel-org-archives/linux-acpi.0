From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Notifications about ACPI events in userspace?
Date: Fri, 12 May 2017 12:06:52 +0200
Message-ID: <20170512100652.GA22013@wunner.de>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:47883 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757031AbdELKGy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2017 06:06:54 -0400
Content-Disposition: inline
In-Reply-To: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Fri, May 12, 2017 at 10:37:47AM +0200, Florian Echtler wrote:
> I'm currently adding support for the iMac's target display mode (TDM) to
> Linux.

Cool!


> When an external DisplayPort source is added/removed, the following ACPI
> code is invoked:
> 
>     Scope (\_SB.PCI0.LPCB.SMC)
>     {
>         Device (DPPT)
>         {
>             Name (_HID, EisaId ("APP000C"))  // _HID: Hardware ID
>             Name (_CID, "smc-dppt")  // _CID: Compatible ID
>         }
>     }
> 
>    Scope (\_SB.PCI0.LPCB.EC)
>     {
>         Method (_Q30, 0, NotSerialized)  // _Qxx: EC Query
>         {
>             Notify (\_SB.PCI0.LPCB.SMC.DPPT, 0x80) // Status Change
>         }
> 
>         Method (_Q31, 0, NotSerialized)  // _Qxx: EC Query
>         {
>             Notify (\_SB.PCI0.LPCB.SMC.DPPT, 0x81) // Information Change
>         }
>     }
> 
> 
> I've already verified that the method calls do indeed take place, by
> turning on EC debugging. The APP000C device does also exist in /sys.
> 
> However, I'm not seeing anything happening with either acpi_listen or
> kacpimon.
> Does this require any kernel changes, or could I subscribe to these
> events somehow?

You can subscribe to these events by calling acpi_install_notify_handler().
See drivers/platform/x86/apple-gmux.c for an example.  That's a driver for
APP000B, a custom chip found on dual-GPU MacBook Pros dubbed GMUX which is
responsible for multiplexing the panel between the GPUs.

I'm not sure what APP000C is, could be a similar custom controller, I'd have
to do some research first to know what it does.  Surely "DP" stands for
DisplayPort, but what does "PT" stand for?

Perhaps apple-gmux.c could serve as a template for an APP000C driver.
The code should be easy to understand, if you have questions just ask away.

Thanks,

Lukas
