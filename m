From: Mattia Dongili <malattia@linux.it>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 11:05:13 +0900
Message-ID: <20090623020513.GB22940@kamineko.org>
References: <200906221732.35993.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:57974
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZFWCFM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 22:05:12 -0400
Content-Disposition: inline
In-Reply-To: <200906221732.35993.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

On Mon, Jun 22, 2009 at 05:32:35PM -0600, Bjorn Helgaas wrote:
> [Sorry for the duplicate; I meant to CC: linux-acpi, so I added it here.]
> 
> Why do we have ACPI device drivers evaluating _INI?  That seems
> like something that should be done by Linux/ACPI, not by the driver.
> 
> I see the following drivers using _INI:
>   drivers/hwmon/hp_accel.c
>   drivers/platform/x86/fujitsu-laptop.c
>   drivers/platform/x86/sony-laptop.c
> 
> I looked at the git logs where the _INI usage was introduced in
> these drivers, but none gives enough information for me to understand
> why.
> 
> If running _INI in the driver makes a difference, I think it's
> really telling us about a problem in Linux/ACPI, and we should
> fix that problem rather than sprinkling _INI evaluation around
> in drivers.
> 
> I do see _INI evaluation in this path:
> 
>     acpi_init
>         acpi_bus_init
>             acpi_initialize_objects(ACPI_FULL_INITIALIZATION)
>                 acpi_ns_initialize_devices
>                     acpi_ns_walk_namespace .. acpi_ns_init_one_device
> 
> The spec (section 6.5.1) says OSPM should run _INI when a
> description table is loaded.  I assume the above path does
> this for the DSDT, at least, but I'm not smart enough about
> the ACPI CA to know whether we also handle SSDTs and dynamic
> LoadTables correctly.

well, it was long ago... I was going to say that when I added it it was because
ospm wasn't calling _INI on the SNY6001 device but it doesn't seem to be the
case... it was just my imagination I guess. I'll double check.

Anyway, from a quick look, _STA on the SNY6001 is always returning 0x0F
or 0x0D depending on the device being assigned an irq or not so ospm
should be good.  I think the _INI call can be removed for sony-laptop.

cheers
-- 
mattia
:wq!
