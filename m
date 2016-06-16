From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: don't show an error when we're not in charge of
 PCIe hotplug.
Date: Thu, 16 Jun 2016 02:12:28 +0200
Message-ID: <CAJZ5v0g5_M=iNLE_P4eOcwJet=jPm_EifAMdDtvG+TR=1AnU2Q@mail.gmail.com>
References: <1466028904-28328-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33209 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcFPAMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 20:12:30 -0400
In-Reply-To: <1466028904-28328-1-git-send-email-pjones@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>

On Thu, Jun 16, 2016 at 12:15 AM, Peter Jones <pjones@redhat.com> wrote=
:
> Right now when booting, on many laptops the firmware manages the PCIe
> bus.  As a result, when we call the _OSC ACPI method, it returns an
> error code.  Unfortunately the errors are not very articulate.

What exactly do you mean here?

>  As a result, we show:
>
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segme=
nts MSI]
> \_SB_.PCI0 (33DB4D5B-1FF7-401C-9657-7441C03DD766): _OSC invalid UUID
> _OSC request data: 1 1f 0

So _OSC told us that the UUID was invalid, didn't it?

According to the spec:

"Bit [2] =E2=80=93 Unrecognized UUID. This bit is set to indicate that =
the
platform firmware does not
recognize the UUID passed in via Arg0. Capabilities bits are preserved.=
"

> acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
>
> But we did get the capabilities mask back;

Right.  As per the spec quoted above.

> the firmware is merely managing this itself.

How can we know that?

> So we really should not be showing the user a
> message that looks like the firmware is broken, since it is working j=
ust
> fine.

Or is it?

> This patch supresses the error message when we're calling _OSC with t=
he
> PCIe host bridge UUID, and replaces it with a relatively innocuous
> looking message that you can find if you're looking for it.

So what happens is that the firmware manages the PCIe stuff itself,
but instead of telling that to us upfront by clearing the mask, it
simply says that the UUID is unknown, because ASL writers can't be
bothered with handling that case correctly, right?

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
