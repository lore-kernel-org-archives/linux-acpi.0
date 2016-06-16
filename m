From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Thu, 16 Jun 2016 16:56:57 +0200
Message-ID: <CAJZ5v0ifNFP5jzPf+zMC3rJ1HKzBmCz1AdhsAsmj75EpndoPTQ@mail.gmail.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com> <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36506 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbcFPO5B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2016 10:57:01 -0400
In-Reply-To: <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>

On Thu, Jun 16, 2016 at 2:12 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 16, 2016 at 12:15 AM, Peter Jones <pjones@redhat.com> wrote:
>> Right now when booting, on many laptops the firmware manages the PCIe
>> bus.  As a result, when we call the _OSC ACPI method, it returns an
>> error code.  Unfortunately the errors are not very articulate.
>
> What exactly do you mean here?
>
>>  As a result, we show:
>>
>> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
>> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
>> \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid UUID
>> _OSC request data: 1 1f 0
>
> So _OSC told us that the UUID was invalid, didn't it?

BTW, the above messages are KERN_DEBUG, so at least in theory they
shouldn't be visible in production runs.

Maybe the bug to fix is that they show up when they aren't supposed to?
