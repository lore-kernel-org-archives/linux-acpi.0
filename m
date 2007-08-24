From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Thu, 23 Aug 2007 23:11:07 -0400
Message-ID: <200708232311.07335.lenb@kernel.org>
References: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au> <20070824013220.GA6242@srcf.ucam.org> <200708232213.19204.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55201 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbXHXDLT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 23:11:19 -0400
In-Reply-To: <200708232213.19204.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

On Thursday 23 August 2007 22:13, Len Brown wrote:
> I agree with everything Matthew wrote.
> 
> Also, please move it to drivers/misc, to keep msi-laptop,
> sony-laptop, asus-laptop, and thinkpad-acpi company.
> 
> toshiba-acpi is in drivers/acpi just because it is being neglected --
> but the new scheme is for platform specific drivers that 
> use ACPI is to put them in drivers/misc; and /drivers/acpi
> is for stuff that implements generic ACPI code.
> 
> You might consider naming it fujitsu-laptop as well,
> since the driver depends on ACPI, but it really exists
> to provide laptop features, not to implement part of the ACPI spec...
> fuj02b1_acpi.c may be accurate, but nobody will know what it is.
> 
> Along those lines, it is generally a good idea to put
>         if (acpi_disabled)
>                 return -ENODEV;
> 
> in the init function if the driver is worthless without ACPI.
> 
> Also, the driver needs somebody to volunteer to be
> its maintainer before it can be merged.
> 
> Finally, please run it through scripts/Lindent before the next edition.

Oh, i forgot to mention also...
There should be no new files created under /proc/acpi
for platform specific drivers.

thanks,
-Len
