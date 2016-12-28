From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: v4.10-rc1: does not wake up from suspend-to-RAM
Date: Wed, 28 Dec 2016 01:35:11 +0100
Message-ID: <CAJZ5v0jkmSviO0=6NBfiTXg177MN4OeJE_z-34=8z1=0NnLnDw@mail.gmail.com>
References: <20161227130435.GA4535@amd> <20161227203118.GA9658@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34421 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbcL1AfM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Dec 2016 19:35:12 -0500
In-Reply-To: <20161227203118.GA9658@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Tue, Dec 27, 2016 at 9:31 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Machine is plain Intel desktop.
>>
>> Even power light does not turn on. Fun. If I force power off by
>> holding power button down, power light stays off during the next
>> boot. Interesting. I guess EC is confused.
>>
>> Thinkpad X60 with similar kernel config works.
>
> Acer notebook does not work, either. Same config as x60.
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Acer
>  Product Name: Aspire 5732Z
>  Version: V3.07
>
> pavel@half:~$ lspci
> 00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)
> 00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI Express Graphics Port (rev 07)
> 00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 03)
> 00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 03)
> 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
> 00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev 03)
> 00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 2 (rev 03)
> 00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 3 (rev 03)
> 00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03)
> 00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 03)
> 00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 03)
> 00:1d.3 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 03)
> 00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 03)
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
> 00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller (rev 03)
> 00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM (ICH9M/ICH9M-E) 4 port SATA Controller [AHCI mode] (rev 03)
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] RV710/M92 [Mobility Radeon HD 4530/4570/545v]
> 04:00.0 Network controller: Broadcom Corporation BCM43225 802.11b/g/n (rev 01)
> 05:00.0 Ethernet controller: Qualcomm Atheros AR8132 Fast Ethernet (rev c0)
> pavel@half:~$
>
> Any ideas? Does it work for you?

There is a fix in the current mainline on top of -rc1 that should help
(works for me).

Thanks,
Rafael
