From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: halt does not shut the system down
Date: Tue, 9 Oct 2007 22:04:48 +0200
Message-ID: <3efb10970710091304g30ab5549u84a092d4de40368b@mail.gmail.com>
References: <470A58AF.9080402@free.fr> <470B366F.4030306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.230]:2654 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbXJIUEv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 16:04:51 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1225729qbe
        for <linux-acpi@vger.kernel.org>; Tue, 09 Oct 2007 13:04:50 -0700 (PDT)
In-Reply-To: <470B366F.4030306@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

Hello John,

> John Sigler wrote:
> > When I run 'halt' the kernel prints:
> > Halting.
> > Shutdown: hdc
> > ACPI: PCI interrupt for device 0000:01:05.0 disabled
> > ACPI: PCI interrupt for device 0000:01:04.0 disabled
> > ACPI: PCI interrupt for device 0000:01:03.0 disabled
> > ACPI: PCI interrupt for device 0000:01:02.0 disabled
> > Power down.
> > acpi_power_off called
> >
> > But the system does not shut down. (The fans keep spinning, the LEDs

I have seen this behavior earlier on a system with the SMI interrupt
disabled. I do not know if this the case here, it is just a hint.
By the way, some distros bring the CPU in a halted state on a 'halt'
command, instead of powering off (actually very logical). For real
powering off these distros require the obvious 'poweroff' command.

Some long shots, maybe it helps...

Kind Regards,

Remy
