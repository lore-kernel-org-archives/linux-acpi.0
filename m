From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / init: Switch over platform to the ACPI mode later
Date: Wed, 03 Jun 2015 11:13:57 -0600
Message-ID: <1433351637.23540.170.camel@misato.fc.hp.com>
References: <12578608.kKCTgirQ6f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:55005 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbFCRde (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jun 2015 13:33:34 -0400
In-Reply-To: <12578608.kKCTgirQ6f@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Marius Tolzmann <tolzmann@molgen.mpg.de>, Matt Fleming <matt@codeblueprint.co.uk>, Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Sat, 2015-05-30 at 14:21 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 73f7d1ca3263 "ACPI / init: Run acpi_early_init() before
> timekeeping_init()" moved the ACPI subsystem initialization,
> including the ACPI mode enabling, to an earlier point in the
> initialization sequence, to allow the timekeeping subsystem
> use ACPI early.  Unfortunately, that resulted in boot regressions
> on some systems and the early ACPI initialization was moved toward
> its original position in the kernel initialization code by commit
> c4e1acbb35e4 "ACPI / init: Invoke early ACPI initialization later".
> 
> However, that turns out to be insufficient, as boot is still broken
> on the Tyan S8812 mainboard.
> 
> To fix that issue, split the ACPI early initialization code into
> two pieces so the majority of it still located in acpi_early_init()
> and the part switching over the platform into the ACPI mode goes into
> a new function, acpi_subsystem_init(), executed at the original early
> ACPI initialization spot.
> 
> That fixes the Tyan S8812 boot problem, but still allows ACPI
> tables to be loaded earlier which is useful to the EFI code in
> efi_enter_virtual_mode().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=97141
> Reported-and-tested-by: Marius Tolzmann <tolzmann@molgen.mpg.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Can you add comments to acpi_early_init() and acpi_subsystem_init() to
clarify what ACPI features are enabled at each phase, and what
dependency they have in the boot sequence?  (The same goes to
early_acpi_boot_init() and acpi_boot_init().)

Otherwise, the change looks good.

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi

