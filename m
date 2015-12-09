From: Ken Xue <ken.xue@amd.com>
Subject: Re: [PATCH 1/1] ACPI: Support D3 COLD device for old BIOS
Date: Wed, 9 Dec 2015 09:18:29 +0800
Message-ID: <1449623909.2175.48.camel@kxue-X58A-UD3R>
References: <1449463473.2175.13.camel@kxue-X58A-UD3R>
	 <3822904.Z6rtg8lMJ5@vostro.rjw.lan>
	 <1449538676.2175.35.camel@kxue-X58A-UD3R>
	 <1717488.DiPkR8HF9g@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1717488.DiPkR8HF9g@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com, mika.westerberg@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Ivan.Zheng@amd.com, Alex.Chuang@amd.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 2015-12-08 at 14:14 +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 08, 2015 09:37:56 AM Ken Xue wrote:
> > On Mon, 2015-12-07 at 23:48 +0100, Rafael J. Wysocki wrote:
> > > On Monday, December 07, 2015 12:44:33 PM Ken Xue wrote:
> > > > D3cold is only regarded as valid if the "_PR3" object is present
> > > > for the given device after the commit <20dacb71ad28>
> > > > (ACPI/PM: Reworkdevice power management to follow ACPI 6).
> > > > 
> > > > But some old BIOS only defined "_PS3" for the D3COLD device.
> > > > And old kernel also believes the device has "_PS3" is a
> > > > D3COLD device.
> > > > 
> > > > So, add some logics for supporting D3 COLD device for old BIOS
> > > > which is compatible with earlier ACPI spec.
> > > > 
> > > > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > > > Reported-and-tested-by: Gang Long <Gang.Long@amd.com>
> > > 
> > > Well, what really is the problem?
> > 
> > My problem is that
> > "acpi_device_can_poweroff" is called by "zpodd_init" in libata-zpodd.c. 
> > And ZPODD feature only can be enabled when D3_COLD is valid.
> 
> This means that acpi_device_can_poweroff() needs to be updated.  What about
> like this:
> 
> static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
> {
> 	return adev->power.states[ACPI_STATE_D3_COLD].flags.valid ||
		((acpi_gbl_FADT.header.revision < 6) &&
> 		 adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
> }

It also could work by refining "acpi_device_can_poweroff".
But ZPODD exactly requests D3 Cold support, So, checking ACPI version
should be necessary when D3 hot is explicit_set.
If you do not have other concern, I will submit new Patch later.
