From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] ACPI: Support D3 COLD device for old BIOS
Date: Tue, 08 Dec 2015 14:14:17 +0100
Message-ID: <1717488.DiPkR8HF9g@vostro.rjw.lan>
References: <1449463473.2175.13.camel@kxue-X58A-UD3R> <3822904.Z6rtg8lMJ5@vostro.rjw.lan> <1449538676.2175.35.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60790 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932224AbbLHMoT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 07:44:19 -0500
In-Reply-To: <1449538676.2175.35.camel@kxue-X58A-UD3R>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ken Xue <ken.xue@amd.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com, mika.westerberg@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Ivan.Zheng@amd.com, Alex.Chuang@amd.com

On Tuesday, December 08, 2015 09:37:56 AM Ken Xue wrote:
> On Mon, 2015-12-07 at 23:48 +0100, Rafael J. Wysocki wrote:
> > On Monday, December 07, 2015 12:44:33 PM Ken Xue wrote:
> > > D3cold is only regarded as valid if the "_PR3" object is present
> > > for the given device after the commit <20dacb71ad28>
> > > (ACPI/PM: Reworkdevice power management to follow ACPI 6).
> > > 
> > > But some old BIOS only defined "_PS3" for the D3COLD device.
> > > And old kernel also believes the device has "_PS3" is a
> > > D3COLD device.
> > > 
> > > So, add some logics for supporting D3 COLD device for old BIOS
> > > which is compatible with earlier ACPI spec.
> > > 
> > > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > > Reported-and-tested-by: Gang Long <Gang.Long@amd.com>
> > 
> > Well, what really is the problem?
> 
> My problem is that
> "acpi_device_can_poweroff" is called by "zpodd_init" in libata-zpodd.c. 
> And ZPODD feature only can be enabled when D3_COLD is valid.

This means that acpi_device_can_poweroff() needs to be updated.  What about
like this:

static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
{
	return adev->power.states[ACPI_STATE_D3_COLD].flags.valid
		|| adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set;
}

Thanks,
Rafael

