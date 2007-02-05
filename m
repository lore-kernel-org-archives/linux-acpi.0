From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: 2.6.20 poweroff regression on se7525gp2
Date: Mon, 5 Feb 2007 14:00:37 +0800
Message-ID: <3877989d0702042200m16ae9f2cqa74e882f14017172@mail.gmail.com>
References: <200702050012.38485.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:16228 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXBEGAi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 01:00:38 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1105153wri
        for <linux-acpi@vger.kernel.org>; Sun, 04 Feb 2007 22:00:37 -0800 (PST)
In-Reply-To: <200702050012.38485.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Sounds like a regression of patch from linus

ACPI: Allow setting SCI_EN bit in PM1_CONTROL register
Linus Torvalds [Wed, 11 Oct 2006 00:14:44 +0000 (17:14 -0700)]
This is needed by at least the Mac Mini's, which (incorrectly) come back
from suspend with SCI_EN clear.


On 2/5/07, Len Brown <lenb@kernel.org> wrote:
> With 2.6.19.2, init 0 works
> with 2.6.20, it causes this box to reset when it should poweroff, and thus it reboots.
>
> any suggestions on where to look first?
>
> thanks,
> -Len
>
> Success case:
>
> Linux version 2.6.19.2 (lenb@d975xbx2) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #5 SMP Sun Feb
> Command line: root=/dev/sda2 console=tty0 console=ttyS0,115200n8 debug
> ...
> # init 0
> ...
> The system will be halted immediately.
> Synchronizing SCSI cache for disk sda:
> ACPI: PCI interrupt for device 0000:06:03.0 disabled
> ACPI: PCI interrupt for device 0000:05:06.1 disabled
> ACPI: PCI interrupt for device 0000:05:06.0 disabled
> ACPI: PCI interrupt for device 0000:05:04.1 disabled
> ACPI: PCI interrupt for device 0000:05:04.0 disabled
> Power down.
> acpi_power_off called
>  hwsleep-0285 [02] enter_sleep_state     : Entering sleep state [S5]
>
> Failure case:
>
> Linux version 2.6.20 (lenb@d975xbx2) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Sun Feb
> Command line: root=/dev/sda2 console=tty0 console=ttyS0,115200n8 debug
> ...
> # init 0
> ...
> The system will be halted immediately.
> Synchronizing SCSI cache for disk sda:
> ACPI: PCI interrupt for device 0000:06:03.0 disabled
> ACPI: PCI interrupt for device 0000:05:06.1 disabled
> ACPI: PCI interrupt for device 0000:05:06.0 disabled
> ACPI: PCI interrupt for device 0000:05:04.1 disabled
> ACPI: PCI interrupt for device 0000:05:04.0 disabled
> Power down.
> acpi_power_off called
>  hwsleep-0285 [02] enter_sleep_state     : Entering sleep state [S5]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
