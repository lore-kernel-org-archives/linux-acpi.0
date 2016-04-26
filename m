From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: OpRegion conflicts for Skylake LPSS
Date: Tue, 26 Apr 2016 18:54:37 +0300
Message-ID: <20160426155437.GA10202@lahna.fi.intel.com>
References: <87lh41nqqq.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27369 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcDZPyn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2016 11:54:43 -0400
Content-Disposition: inline
In-Reply-To: <87lh41nqqq.fsf@smart-cactus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, Apr 26, 2016 at 02:44:13AM +0200, Ben Gamari wrote:
> 
> While trying to troubleshoot some touchpad issues on a Dell Latitude
> E7470 (namely the touchpad being exposed only as a PS/2 device) I
> noticed that the intel-lpss driver (using a 4.6-rc4 kernel) fails to
> load with,
> 
>     ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20160108/utaddress-255)
>     ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
>     intel-lpss: probe of INT3446:00 failed with error -16
> 
> The DSDT OpRegion in question looks like this,
> 
>     Scope (_SB.PCI0)
>     {
>         Device (GEXP)
>         {
>             Name (_ADR, One)  // _ADR: Address
>             Name (_STA, 0x0B)  // _STA: Status
>             OperationRegion (BAR0, SystemMemory, SB04, 0x0208)
>             Field (BAR0, DWordAcc, NoLock, Preserve)
>             {
>                 ICON,   32, 
>                 TAR,    32, 
>                 Offset (0x10), 
>                 DATA,   32, 
>                 HCNT,   32, 
>                 LCNT,   32, 
>                 Offset (0x2C), 
>                     ,   5, 
>                 ABRT,   1, 
>                 Offset (0x40), 
>                 RBCK,   32, 
>                 Offset (0x54), 
>                 CLR,    32, 
>                 Offset (0x6C), 
>                 ENB,    1, 
>                 Offset (0x70), 
>                 ACTV,   1, 
>                 TFNF,   1, 
>                     ,   1, 
>                 RFNE,   1, 
>                 Offset (0x7C), 
>                 HOLD,   32, 
>                 Offset (0x9C), 
>                 ENSB,   1, 
>                 Offset (0x204), 
>                 RST,    32
>             }
> 
> It looks very much like these are describing the same device. Perhaps
> the lpss driver should be binding to this ACPI node? Or perhaps this is
> a firmware issue? Any guidance would be greatly appreciated.

Can you send me full acpidump of that machine?
