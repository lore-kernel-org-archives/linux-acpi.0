From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 00:23:08 -0400
Message-ID: <200708240023.08757.lenb@kernel.org>
References: <200708240315.l7O3FMCI030158@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35961 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbXHXEXV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 00:23:21 -0400
In-Reply-To: <200708240315.l7O3FMCI030158@turbo.physics.adelaide.edu.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Thursday 23 August 2007 23:15, Jonathan Woithe wrote:
> > Oh, i forgot to mention also...
> > There should be no new files created under /proc/acpi
> > for platform specific drivers.
> 
> Sure.  In the case of the backlight control (which is the thing I most care
> about) this will be taken care of by virue of utilising the backlight class
> as per Matthew's email.  If it did prove useful to export the mouse pointer
> control for example (which at this stage is uncertain) what would be the
> most appropriate location for the associated virtual files - something under
> /sys?

yes, certainly something outside of /proc.
ideally something _generic_ under /sys.
If device specific and the device exists in sysfs already, then there.
But there can be platform specific hooks in sysfs too.
thinkpad-acpi stuffs some platform specific junk under /sys/devices/platform/
see Documentation/thinkpad-acpi.txt

your fujitsu driver will probably be a lot like the msi-laptop.c driver
when you're done with it, maybe even simpler.

cheers,
-Len
