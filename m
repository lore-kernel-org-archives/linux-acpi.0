From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] PNPACPI: do ACPI binding directly
Date: Tue, 08 Jul 2014 09:17:09 +0800
Message-ID: <1404782229.2291.78.camel@rzhang1-toshiba>
References: <1404305689.8366.90.camel@rzhang1-toshiba>
	 <1492737.4hRQRGaxEv@vostro.rjw.lan>
	 <1404743246.2291.55.camel@rzhang1-toshiba>
	 <1537876.HDIZBZ0Om4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43306 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbaGHBRN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 21:17:13 -0400
In-Reply-To: <1537876.HDIZBZ0Om4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Prigent, Christophe" <christophe.prigent@intel.com>

On Mon, 2014-07-07 at 22:03 +0200, Rafael J. Wysocki wrote:
> On Monday, July 07, 2014 10:27:26 PM Zhang Rui wrote:
> > On Mon, 2014-07-07 at 14:53 +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, July 02, 2014 08:54:49 PM Zhang Rui wrote:
> > > > From 7daac7fc7cd7b605ccd84f10fc206cedf6170e89 Mon Sep 17 00:00:00 2001
> > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > Date: Fri, 20 Jun 2014 10:14:07 +0800
> > > > Subject: [PATCH] PNPACPI: do ACPI binding directly
> > > > 
> > > > PNPACPI uses acpi_bus_type to do ACPI binding for the PNPACPI devices.
> > > > 
> > > > This is overkill because PNPACPI code already knows which ACPI
> > > > device object to bind during PNPACPI device enumeration.
> > > > 
> > > > This patch removes acpi_pnp_bus and does the binding by invoking
> > > > acpi_bind_one() directly after device enumerated.
> > > > 
> > > > This also fixes a bug in the previous code that some PNPACPI devices failed
> > > > to be bound because
> > > > 1. the ACPI device _HID is not pnpid, e.g. "MSFT0001", but its _CID is,
> > > >    e.g. "PNP0303", thus ACPI _CID is used as the pnp device device id.
> > > > 2. device is bound only if the pnp device id matches the ACPI device _HID.
> > > > 
> > > > Tested-by: Prigent Christophe <christophe.prigent@intel.com>
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > 
> > > Does this fix a regression?
> > 
> > Hmmm, no, the problem exists in all previous kernel versions IMO.
> 
> OK, so it is applicable to -stable too?  Or would it need to be backported?
> 
I don't think we need it in stable kernel, because this is not a
critical issue.
I've seen only two devices with this problem, and all of them don't have
ACPI _PSx/_PRx method. This means that, although pnpacpi_resume() fails
because of this bug, nothing really bad happens because pnpacpi_resume()
is actually a no-op for such devices.

thanks,
rui 
> > >   If so, do we need it in 3.16?
> > > 
> > Not necessarily, but as this is a bug fix, so I think it is reasonable
> > to be shipped in 3.16, right?
> 
> Basically, yes.
> 
> Rafael
> 


