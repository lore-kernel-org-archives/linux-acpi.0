From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Documentation: acpi: Add an example for PRP0001
Date: Mon, 25 Mar 2019 18:34:23 +0200
Message-ID: <20190325163423.GJ9224@smile.fi.intel.com>
References: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
 <20190325153032.GG9224@smile.fi.intel.com>
 <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 25, 2019 at 03:58:13PM +0000, Thomas Preston wrote:
> On 25/03/2019 15:30, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2019 at 03:12:10PM +0000, Thomas Preston wrote:
> > > Add an example for the magic PRP0001 device ID which allows matching
> > > ACPI devices against drivers using OF Device Tree compatible property.
> > 
> > > It wasn't clear to me that PRP0001 could be used in _CID.
> > 
> > Yes, but it's not necessary to have it if we have defined a _HID.
> > 
> > In that case PRP0001 is a temporary stub until corresponding driver
> > incorporates an official _HID.
> > 
> > On the contrary, when there is no official _HID available, PRP0001 can be used
> > instead directly as a _HID and no _CID is needed.
> > 
> 
> In that case, how do we uniquely identify devices in sysfs?

By their class, etc.

Identifying devices based in instance name is bad idea to start with.

> We have a
> case where sound/soc/soc-core.c generates an i2c codec name i2c-TDA7802:00.
> It is useful to identify that device by part name, rather than some indexed
> generic PRP device i2c-PRP0001:04. I can achieve this with:

If TDA7802 is *official* _HID dedicated for that codec by vendor, add it to the
driver...

> 	_HID("TDA7802")

> 	_CID("PRP0001")
> 	...
> 	compatible = "st,tda7802" // driver I want to load using OF DT

...and these lines become unneeded.

The only case when both are needed is a time between one gets a case and actual
ID appears in the upstream driver. Effectively means product developing stage.

P.S. Yes, I know that sometimes the platform/BIOS vendors abuse specification
and ACPI ID registry and made up IDs, in that case we need to support them as a
"de facto" quirks.

And yes, ASoC subsystem in ACPI case abuses Linux device hierarchy by matching
by instance instead of matching by let say fwnode. It should be fixed there,
not in ACPI table.

> 
> > I would really recommend to look at the examples in meta-acpi repository. There
> > are cases like described above.
> > 
> > This one is good enough, though see below.
> > 
> 
> I will drop the superfluous _CID - I think the example is still useful
> to have. Even if we don't illustrate my special case for _HID/_CID.

Yes, I agree with that.

-- 
With Best Regards,
Andy Shevchenko
