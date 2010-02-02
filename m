From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ACPI device for ASUS EEEPC 1101HA not added
Date: Tue, 2 Feb 2010 03:31:43 +0100
Message-ID: <20100202023142.GI9007@buzzloop.caiaq.de>
References: <20100201032554.GZ28972@buzzloop.caiaq.de>
 <1265073562.10648.12.camel@rzhang1-desktop>
 <20100202020938.GH9007@buzzloop.caiaq.de>
 <8B81FACE836F9248894A7844CC0BA814250B6A0EAF@shzsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:40085 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0BBCb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 21:31:59 -0500
Content-Disposition: inline
In-Reply-To: <8B81FACE836F9248894A7844CC0BA814250B6A0EAF@shzsmsx501.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>

On Tue, Feb 02, 2010 at 10:17:17AM +0800, Zhang, Rui wrote:
> > On Tue, Feb 02, 2010 at 09:19:22AM +0800, Zhang Rui wrote:
> > > eeepc is handled in eeepci-laptop driver.
> > >
> > > ~/src/linux-2.6$ grep ASUS010 drivers/platform/*/*
> > > drivers/platform/x86/eeepc-laptop.c:#define EEEPC_ACPI_HID
> > 	"ASUS010"
> > 
> > Yes, that I know. The driver was just unable to match the device
> > because
> > it was not detected by the ACPI core. Works now with the patch Andrej
> > sent. I would still like to make sure it's getting merged mainline
> > sooner or later.
> >
> Oh, can you give a link to this patch please?

http://permalink.gmane.org/gmane.linux.acpi.acpi4asus.user/3781

