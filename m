From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Patch needed for ASUS EEEPC 701 2.6.27 (perhaps a regession)
Date: Sat, 11 Oct 2008 15:50:21 +0100
Message-ID: <48F0BD2D.8000001@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:16518 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbYJKOu1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 10:50:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so454194nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 07:50:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Goldner <robert@au-79.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-stable@vger.kernel.org

Robert Goldner wrote:

> Hi,
>
> I am a happy user of an asus eeepc 701 with an self-made kernel 2.6.27.
> Its working quite good, but there is one patch needed to avoid problems
> related to ACPI and Hotkeys.
> After using a few hotkeys there comes a message in syslog like:
> ACPI: EC: GPE storm detected, disabling EC GPE
> and no hotkey event is recognized any more. This is quite bad on a nettop.

Hi, I reported the original bug.  It is a regression, though the issue
has been present for a few kernel versions now.

I recommend that you avoid reproducing the problem.  I now have to add
"noapic" to the boot options on my EeePC, otherwise it randomly hangs /
reboots when I press hotkeys - I think it  damaged the hardware.

BTW you can avoid reproducing the issue on buggy kernels by not pressing
hotkeys quickly - and *never* holding them down; autorepeat is the main
problem.  Wait for the effect of the previous hotkey press to take
effect (e.g. decrementing the screen brightness) before you press a
hotkey again.  But it is safest to just not use them.
 
> The needed patch and the bug description is available at:
> http://bugzilla.kernel.org/show_bug.cgi?id=10919
> The patch is called 'patch vs 2.6.27-rc7'
>
> The patch fits also to 2.6.27 without any problems and works very fine.
> Thanks to everyone who was involved.
>
> I would suggest to include this patch in the mainline kernel very soon
> (e.g. 2.6.28 or if possible in 2.6.27.1).

The patch is part of Len's ACPI patch queue for the current merge
window, so it should appear in 2.6.28.  However it's not marked "CC:
linux-stable@vger.kernel.org", so it will not be automatically included
in 2.6.27.1.

I think it's up to the ACPI maintainers, if they think there's a risk it
might introduce other regressions.  As you say, it's been tested on a
range of problematic laptops, but OTOH this area has been a minefield. 
Maybe it needs to wait, at least until it's been in an -rc release or two.

Alan
