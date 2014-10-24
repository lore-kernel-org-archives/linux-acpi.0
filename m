From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: Use ACPI companion to match only the first
 physical device
Date: Fri, 24 Oct 2014 16:50:49 +0300
Message-ID: <20141024135049.GS1484@lahna.fi.intel.com>
References: <1414141950-228930-1-git-send-email-mika.westerberg@linux.intel.com>
 <2356721.6lgfg38MC8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8435 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618AbaJXNvE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Oct 2014 09:51:04 -0400
Content-Disposition: inline
In-Reply-To: <2356721.6lgfg38MC8@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 24, 2014 at 03:55:34PM +0200, Rafael J. Wysocki wrote:
> On Friday, October 24, 2014 12:12:30 PM Mika Westerberg wrote:
> > Commit 6ab3430129e2 ("mfd: Add ACPI support") made the MFD subdevices to
> > share the parent MFD ACPI companion device if no _HID/_CID is specified for
> > the subdevice in mfd_cell description. However, since all the subdevices
> > share the ACPI companion, the match and modalias generation logic started
> > to use the ACPI companion as well resulting this:
> > 
> >   # cat /sys/bus/platform/devices/HID-SENSOR-200041.6.auto/modalias
> >   acpi:INT33D1:PNP0C50:
> > 
> > instead of the expected one
> > 
> >   # cat /sys/bus/platform/devices/HID-SENSOR-200041.6.auto/modalias
> >   platform:HID-SENSOR-200041
> > 
> > In other words the subdevice modalias is overwritten by the one taken from
> > ACPI companion. This causes udev not to load the driver anymore.
> > 
> > It is useful to be able to share the ACPI companion so that MFD subdevices
> > (and possibly other devices as well) can access the ACPI resources even if
> > they do not have ACPI representation in the namespace themselves.
> > 
> > An example where this is used is Minnowboard LPC driver that creates GPIO
> > as a subdevice among other things. Without the ACPI companion gpiolib is
> > not is not able to lookup the corresponding GPIO controller from ACPI
> > GpioIo resource.
> > 
> > To fix this we restrict the match and modalias logic to be limited to the
> > first physical device. The secondary devices will still be able to access
> > the ACPI companion but they will be matched using traditional way.
> > 
> > Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> So I've applied it, although it didn't make it to the mailing lists for an
> unknown reason, but I modified it slightly.  My version is below for
> completness (it's in bleeding-edge for now).

Thanks.

I also noticed that it never went to the mailing lists. This was due to
misconfiguration in our new server and should be fixed soon. I can
resend the patch after that.

> I'm a bit concerned that it will break something obscure I can't recall
> ATM, but since I can't recall it may not be that important (or even non-existent
> at all).  In any case, we may need to go back all the way to reverting the
> MFD commit if that happens.

Agreed.
