From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 09/12] Driver core: Unified interface for firmware node properties
Date: Tue, 21 Oct 2014 00:14:51 +0200
Message-ID: <2924920.AIFmfW74hs@vostro.rjw.lan>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <7821406.D7i8JfDpzX@vostro.rjw.lan> <20141020141818.3DC65C40982@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141020141818.3DC65C40982@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, October 20, 2014 04:18:18 PM Grant Likely wrote:
> On Mon, 20 Oct 2014 01:46 +0200
> , "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  wrote:
> > On Saturday, October 18, 2014 04:55:20 PM Grant Likely wrote:
> > > On Fri, 17 Oct 2014 14:14:53 +0200

[cut]

> > 
> > No, that wouldn't work for ACPI (if I understand your idea correctly), because
> > acpi_dev_prop_read(adev, propname, DEV_PROP_U8, val) will look for a single-value
> > int property, whereas acpi_dev_prop_read_array(adev, propname, DEV_PROP_U8, val, 1)
> > will look for a list (package) property and will attempt to retrieve the first
> > element of that.
> 
> That's a problem. There are certainly cases of DT code that use the
> non-array version to read something that could also be read as an array
> when the code only want the first value. It is a completely valid thing
> to do. The ACPI accessors should be completely okay with either a single
> value, or the first item(s) in a package when doing either a single read or
> an array read.

Yeah.

So I have a new version of the patchset in which that is implemented as
you are describing.  Fortunately, the differences are limited to patches #2,
#3 (for the "compatible" property to behave this way too) and #9 and are not
too big.

I'd prefer that to pass the Mika's tests before posting it, though, which will
take some time I suppose.

> so, if it is encoded as a singl values, then return that value, and the
> largest size of array it will return is 1 element.
> 
> If it is encoded as a package, then a single read should return the
> first element, and an array read should return up to the number of
> values in the package.

Rafael
