From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] How to pass I2C platform_data under ACPI
Date: Thu, 03 Apr 2014 15:34:30 +0200
Message-ID: <4539649.rsMWK1FkZ6@wuerfel>
References: <D854C92F57B1B347B57E531E78D05EAD57463568@BGSMSX104.gar.corp.intel.com> <D854C92F57B1B347B57E531E78D05EAD57463D21@BGSMSX104.gar.corp.intel.com> <20140403113832.GD19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140403113832.GD19349@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 April 2014 14:38:33 mika.westerberg@linux.intel.com wrote:
> On Thu, Apr 03, 2014 at 11:25:34AM +0000, Pallala, Ramakrishna wrote:
> > >> In non ACPI environment I used to initialize the platform_data under 
> > >> board or platforms files. Under ACPI how do I do that?
> > >
> > >If you can't extract that information from ACPI namespace, then one option is to pass platform data along with the device ACPI ID:
> > >
> > >static const struct acpi_device_id my_acpi_match[] = {
> > >     { "MYID0001", (kernel_ulong_t)&my_platform_data }
> > >     ...
> > >     { },
> > >};
> > 
> > Thanks for the Quick reply.
> > 
> > So If I  want to use different platform_data for different boards can I
> > do something like below?
> 
> Exactly.
> 
> > And initialize the platform data in either driver or in separate module
> > which gets compiled along with driver?
> 
> Typically it has been done in the same driver but I don't see any problems
> having a separate module as well.
> 
> > static const struct acpi_device_id my_acpi_match[] = {
> >       { "MYID0001", (kernel_ulong_t)&my_platform_data1 }
> >       { "MYID0002", (kernel_ulong_t)&my_platform_data2 }
> >       ...
> >       { },

We definitely don't want per-board match entries, that does not scale.
The driver should be reasonably generic and get all the necessary data
out of well-defined tables. You can have different IDs when there
are only a few cases that are actually relevant, but it has to be
conceivable that the same driver get used on future hardware without
changes.

	Arnd
