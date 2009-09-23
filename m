From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v3 1/8] ACPI: fix synthetic HID for \_SB_
Date: Wed, 23 Sep 2009 10:19:17 -0600
Message-ID: <200909231019.17961.bjorn.helgaas@hp.com>
References: <20090921193417.21656.32718.stgit@bob.kio> <20090921193504.21656.68847.stgit@bob.kio> <1253672506.3609.355.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:28142 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZIWQTT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2009 12:19:19 -0400
In-Reply-To: <1253672506.3609.355.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, "Lin, Ming M" <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Tuesday 22 September 2009 08:21:46 pm ykzhao wrote:
> On Tue, 2009-09-22 at 03:35 +0800, Bjorn Helgaas wrote:
> > This makes \_SB_ show up as /sys/devices/LNXSYSTM:00/LNXSYBUS:00
> > rather than "device:00".  This has been broken for a loooong time
> > (at least since 2.6.13) because device->parent is an acpi_device
> > pointer, not a handle.
> 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> >  drivers/acpi/scan.c |   18 ++++++------------
> >  1 files changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 2c4cac5..e9227ea 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1100,6 +1100,12 @@ static void acpi_device_set_id(struct acpi_device *device)
> >  		if (ACPI_IS_ROOT_DEVICE(device)) {
> >  			hid = ACPI_SYSTEM_HID;
> >  			break;
> > +		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {

> Can we still add the judgement about the device type?
>    device->type == ACPI_BUS_TYPE_DEVICE

We are already checking this because this test is inside the
ACPI_BUS_TYPE_DEVICE case of a switch statement.

> Where can I find the macro definition of ACPI_IS_ROOT_DEVICE?

It's patch 13/17 in the previous "ACPI: cleanups for hotplug" series.
I should have mentioned that this series depends on that one.

Bjorn

> > +			/* \_SB_, the only root-level namespace device */
> > +			hid = ACPI_BUS_HID;
> > +			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > +			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > +			break;
> >  		}
> >  
> >  		status = acpi_get_object_info(device->handle, &info);
> > @@ -1149,18 +1155,6 @@ static void acpi_device_set_id(struct acpi_device *device)
> >  		break;
> >  	}
> >  
> > -	/*
> > -	 * \_SB
> > -	 * ----
> > -	 * Fix for the system root bus device -- the only root-level device.
> > -	 */
> > -	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
> > -	     (device->device_type == ACPI_BUS_TYPE_DEVICE)) {
> > -		hid = ACPI_BUS_HID;
> > -		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > -		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > -	}
> > -
> >  	if (hid) {
> >  		device->pnp.hardware_id = ACPI_ALLOCATE_ZEROED(strlen (hid) + 1);
> >  		if (device->pnp.hardware_id) {
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


