From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/8] Add helper macro for pnp_register_driver boilerplate
Date: Wed, 18 Mar 2015 02:35:25 +0100
Message-ID: <1607591.fOrmNtBKrA@vostro.rjw.lan>
References: <1426538797-28131-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61606 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753778AbbCRBLb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 21:11:31 -0400
In-Reply-To: <1426538797-28131-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Huewe <peterhuewe@gmx.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday, March 16, 2015 09:46:29 PM Peter Huewe wrote:
> This patchset introduces the module_pnp_driver macro which is a
> convenience macro for PNP driver modules similar to module_pci_driver
> and convert the affected drivers to the new helper macro.
> It is intended to be used by drivers which init/exit section does nothing
> but register/unregister the PNP driver. By using this macro it is
> possible to eliminate a few lines of boilerplate code per PNP driver.
> 
> If easier you can pull directly from my tree:
> 
> The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:
> 
>   Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/PeterHuewe/linux-tpmdd.git module_pnp_driver
> 
> for you to fetch changes up to 5bf9cf2fdc9f22c7caa1c17a7eb2e17aab099b51:
> 
>   pnp: tty/serial/8250/8250_fintek: Use module_pnp_driver to register driver (2015-03-16 21:40:05 +0100)
> 
> ----------------------------------------------------------------
> 
> Peter Huewe (8):
>   pnp: Add helper macro for pnp_register_driver boilerplate
>   pnp: tpm/tpm_infineon: Use module_pnp_driver to register driver
>   pnp: ata/pata_isapnp: Use module_pnp_driver to register driver
>   pnp: ide/ide-pnp: Use module_pnp_driver to register driver
>   pnp: media/rc: Use module_pnp_driver to register driver
>   pnp: net/sb1000: Use module_pnp_driver to register driver
>   pnp: platform/x86/apple-gmux: Use module_pnp_driver to register driver
>   pnp: tty/serial/8250/8250_fintek: Use module_pnp_driver to register
>     driver

Makes sense to me.  I'll queue this up for 4.1 if there are no objections.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
