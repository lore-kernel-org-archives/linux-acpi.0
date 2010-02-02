From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: ACPI device for ASUS EEEPC 1101HA not added
Date: Tue, 2 Feb 2010 10:17:17 +0800
Message-ID: <8B81FACE836F9248894A7844CC0BA814250B6A0EAF@shzsmsx501.ccr.corp.intel.com>
References: <20100201032554.GZ28972@buzzloop.caiaq.de>
 <1265073562.10648.12.camel@rzhang1-desktop>
 <20100202020938.GH9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58178 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab0BBCTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2010 21:19:24 -0500
In-Reply-To: <20100202020938.GH9007@buzzloop.caiaq.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>



> -----Original Message-----
> From: Daniel Mack [mailto:daniel@caiaq.de]
> Sent: Tuesday, February 02, 2010 10:10 AM
> To: Zhang, Rui
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> acpi4asus-user@lists.sourceforge.net
> Subject: Re: ACPI device for ASUS EEEPC 1101HA not added
> 
> On Tue, Feb 02, 2010 at 09:19:22AM +0800, Zhang Rui wrote:
> > On Mon, 2010-02-01 at 11:25 +0800, Daniel Mack wrote:
> > > On my new 1101HA Eeepc, the special function keys do not work. This
> is
> > > because the asus-laptop driver fails to match the ACPI device named
> > > "ASUS010". However, acpidump tells me a device with that name does
> > > actually exist - the (simplified) disassembly of the DSDT is below.
> > >
> > > It looks like the gigantic parser state machine fails to add that
> > > device for whatever reason. Any ideas how to fix that?
> > >
> > eeepc is handled in eeepci-laptop driver.
> >
> > ~/src/linux-2.6$ grep ASUS010 drivers/platform/*/*
> > drivers/platform/x86/eeepc-laptop.c:#define EEEPC_ACPI_HID
> 	"ASUS010"
> 
> Yes, that I know. The driver was just unable to match the device
> because
> it was not detected by the ACPI core. Works now with the patch Andrej
> sent. I would still like to make sure it's getting merged mainline
> sooner or later.
>
Oh, can you give a link to this patch please?

Thanks,
rui
 
> Thanks,
> Daniel
