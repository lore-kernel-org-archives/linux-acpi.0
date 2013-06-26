From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Sys backlight is empty since landing of "ACPI / PCI: Make PCI root driver use struct acpi_scan_handler"
Date: Wed, 26 Jun 2013 22:05:38 +0200
Message-ID: <1463901.DnHXCr77ks@vostro.rjw.lan>
References: <117469492.1598370.1372275060043.JavaMail.root@qzdev.se> <2717592.yh25cqipTX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52386 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab3FZT4J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jun 2013 15:56:09 -0400
In-Reply-To: <2717592.yh25cqipTX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cork <kernel@box.qzdev.se>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

On Wednesday, June 26, 2013 09:52:46 PM Rafael J. Wysocki wrote:
> On Wednesday, June 26, 2013 07:31:00 PM Cork wrote:
> > Hello. This is my first time sending a report like this, so please excuse me if I'm missing some vital information.
> > 
> > From updating the kernel in Arch linux to 3.9 the brightness controls stopped working on my Clevo P0150HM. I have tried the acpi_backlight=vendor boot parameter but it makes no difference.
> > 
> > While researching this problem I've found that /sys/class/backlight is empty in the versions where the buttons isn't working. Bisecting points to 00c43b9682507dc622c03172fde1032e2a216e9d [1] as the first commit showing the symptoms.
> > 
> > Attached is the output from journalctl -b _TRANSFORM=kernel for the two versions. Not sure what other useful information I can provide apart from that, so please direct me if there is something missing.
> > 
> > [1] https://github.com/torvalds/linux/commit/00c43b9682507dc622c03172fde1032e2a216e9d
> 
> Interesting.
> 
> Please send the output of acpidump from your machine.

Also please put initcall_debug into the kernel command line and send dmesg from
the working and not working kernels with that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
