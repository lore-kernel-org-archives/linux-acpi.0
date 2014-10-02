From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Thu, 2 Oct 2014 12:55:36 +0300
Message-ID: <20141002095536.GI1786@lahna.fi.intel.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <2043842.LxdgdYRbIF@wuerfel>
 <20141001140441.GF1786@lahna.fi.intel.com>
 <6852466.Q5TXcWChqW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbaJBJ4N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Oct 2014 05:56:13 -0400
Content-Disposition: inline
In-Reply-To: <6852466.Q5TXcWChqW@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wed, Oct 01, 2014 at 04:14:20PM +0200, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 17:04:41 Mika Westerberg wrote:
> > 
> > > On the question what to put into the name and type fields, that is
> > > unrelated. The type is supposed to be for the 'device_type' property
> > > in DT, which we should never rely on in a driver that supports both
> > > APCI and DT. In Linux we only use that for "pci", "cpu" and "memory",
> > > all of which have their own way of getting probed in ACPI.
> > > The "name" is normally ignored in DT as well, except for backwards
> > > compatibility with old bindings, but I would argue that you should not
> > > just put "prp0001" in there. Either leave it empty like type, or use
> > > the name of the device as it appears in the ACPI tables, such as "DEV0"
> > > or "PWM".
> > 
> > OK, I think it makes sense to leave them empty. I remember I tried that
> > at some point but it didn't work without N and T fields. Is there some
> > example what to put there in case of empty?
> > 
> > Something like "of:N*T*Cgpio-leds" perhaps?
> 
> Sorry, don't know. If I read the code right, the type field in DT ends
> up being "<NULL>" for any device that doesn't set the device_type 
> property, but that seems a bit silly and probably isn't worth copying.

OK, I checked and udev wants to have both N and T but they can be left
empty. If there are no objections the modalias will look like this:

[root@mnw01 ~]# cat /sys/bus/spi/devices/spi-PRP0001\:00/modalias 
of:Nat25TCatmel,at25

In other words name is the ACPI device name (AT25) in lower case, T is
left empty and C is the compatible property.
