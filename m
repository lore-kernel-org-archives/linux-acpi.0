From: Thomas Renninger <trenn@suse.de>
Subject: Re: linux-next: ACPI I/O resource conflicts warning
Date: Fri, 09 May 2008 16:30:25 +0200
Message-ID: <1210343425.29724.39.camel@queen.suse.de>
References: <4823A6DA.8010502@googlemail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:39541 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYEIOa1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 May 2008 10:30:27 -0400
In-Reply-To: <4823A6DA.8010502@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

On Fri, 2008-05-09 at 03:20 +0200, Gabriel C wrote:
> Hi all ,
> 
> I've noticed on linux-next from today the following ACPI warning:
> 
> ...
> 
> [4294023.308622] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 18
> [4294023.308622] ACPI: I/O resource  [0x400-0x41f] conflicts with ACPI region SMRG [0x400-0x40f]
> [4294023.316478] ACPI: Device needs an ACPI driver

You use libsensors and the sensor you use is also declared and possibly
used via ACPI.

> dsdt.dsl from my motherboard can be found there:
> 
> http://frugalware.org/~crazy/ASUS_P5E-VM_DO/dsdt.dsl
> 
> full dmesg:
> 
> http://frugalware.org/~crazy/dmesg/DMAR/dmesg
> 
> Please let me know if you need more infos.

Maybe you could open a bug report on bugzilla.kernel.org and post
acpidump and dmi output (not only dsdt) there. Then we could collect
affected BIOSes at one central place for further evaluation and
discussion.

Thanks,

   Thomas

