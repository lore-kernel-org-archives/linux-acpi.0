From: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez@opensuse.org>
Subject: Re: ACPI problems, Dell XPS 15z laptop
Date: Sun, 25 Dec 2011 21:20:12 -0300
Message-ID: <4EF7BDBC.9000406@opensuse.org>
References: <4EF79074.90605@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34102 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1LZAUR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Dec 2011 19:20:17 -0500
Received: by yhr47 with SMTP id 47so7069646yhr.19
        for <linux-acpi@vger.kernel.org>; Sun, 25 Dec 2011 16:20:16 -0800 (PST)
In-Reply-To: <4EF79074.90605@opensuse.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, opensuse-kernel@opensuse.org, Thomas Renninger <trenn@suse.de>

On 25/12/11 18:07, Cristian Rodr=EDguez wrote:
> (please CC me your replies, I am not subscribed)
>
> Hi:
>
> The laptop in $SUBJECT freezes at boot time, at random points sometim=
es
> after
>
> [FIRMWARE BUG] ACPI(PEGP) defines _DOD but not _DOS
>
> But in other ocassions, just after udev attempts to mount filesystems=
=2E
>
> Using the following boot options make the system boot and work somewh=
at
> stable.
>
> (these are single options, not combined)
>
> - acpi=3Dnoirq
>
> - pci=3Dnoacpi --> with this option I get warnings telling me to try
> "usepirqmask..."
>
> - nox2apic
>
> - intremap=3Doff
>
> This is a very recent sandy bridge system, the only clues I get from =
the
> log is:
>
> "Not all IO-APIC's listed under remapping hardware
> x2apic not enabled, IRQ remapping init failed"

Heh, today I tested a crazy theory I had about this problem, turned out=
=20
to be somewhat accurate.. it is not that the machine that hangs always,=
=20
but it deceivingly "appears" to hang as I cannot get past the cryptsetu=
p=20
password prompt.. it is the keyboard controller that becomes non=20
responsive, that 's it either before the "prompt" (where it hangs) or=20
right after showing it. (in that scenario the USB port works, as plugin=
=20
and removing a device shows the relevant events in the console)

It is random, let's say, the USB port works twice every three boots.




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
