From: Ken Xue <ken.xue@amd.com>
Subject: Re: [PATCH 1/1] ACPI: Support D3 COLD device for old BIOS
Date: Tue, 8 Dec 2015 09:37:56 +0800
Message-ID: <1449538676.2175.35.camel@kxue-X58A-UD3R>
References: <1449463473.2175.13.camel@kxue-X58A-UD3R>
	 <3822904.Z6rtg8lMJ5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0065.outbound.protection.outlook.com ([65.55.169.65]:63631
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932193AbbLHBnf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Dec 2015 20:43:35 -0500
In-Reply-To: <3822904.Z6rtg8lMJ5@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com, mika.westerberg@linux.intel.com, Andy Shevchenko <andy.shevchenko@gmail.com>, Ivan.Zheng@amd.com, Alex.Chuang@amd.com

On Mon, 2015-12-07 at 23:48 +0100, Rafael J. Wysocki wrote:
> On Monday, December 07, 2015 12:44:33 PM Ken Xue wrote:
> > D3cold is only regarded as valid if the "_PR3" object is present
> > for the given device after the commit <20dacb71ad28>
> > (ACPI/PM: Reworkdevice power management to follow ACPI 6).
> > 
> > But some old BIOS only defined "_PS3" for the D3COLD device.
> > And old kernel also believes the device has "_PS3" is a
> > D3COLD device.
> > 
> > So, add some logics for supporting D3 COLD device for old BIOS
> > which is compatible with earlier ACPI spec.
> > 
> > Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> > Reported-and-tested-by: Gang Long <Gang.Long@amd.com>
> 
> Well, what really is the problem?

My problem is that
"acpi_device_can_poweroff" is called by "zpodd_init" in libata-zpodd.c. 
And ZPODD feature only can be enabled when D3_COLD is valid.

> 
> acpi_device_set_power() has a special case specifically for D3cold and
> falls back to D3hot if D3cold has been requested but is not "valid".
> 
> > ---
> >  drivers/acpi/scan.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 01136b8..85c16bb 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -979,7 +979,9 @@ static void acpi_bus_get_power_flags(struct acpi_device *device)
> >  		acpi_bus_init_power_state(device, i);
> >  
> >  	INIT_LIST_HEAD(&device->power.states[ACPI_STATE_D3_COLD].resources);
> > -	if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources))
> > +	if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].resources) ||
> > +		((acpi_gbl_FADT.header.revision < 6) &&
> > +		device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set))
> >  		device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
> >  
> >  	/* Set defaults for D0 and D3hot states (always valid) */
> > 
> 


