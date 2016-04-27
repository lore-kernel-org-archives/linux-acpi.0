From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware revision
Date: Wed, 27 Apr 2016 23:21:37 +0200
Message-ID: <1818106.auxzDWcdFV@vostro.rjw.lan>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com> <2388310.jGjaKS2NDe@vostro.rjw.lan> <AT5PR84MB008340CB53E60CE8C511BEDE9D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53829 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752654AbcD0VSg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Apr 2016 17:18:36 -0400
In-Reply-To: <AT5PR84MB008340CB53E60CE8C511BEDE9D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Dall, Betty" <betty.dall@hpe.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, April 27, 2016 04:19:45 PM Dall, Betty wrote:
> On 04/26/2016 02:39 PM, Rafael J. Wysocki wrote:
> > On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
> >> The ACPI _HRV object on the device is used to supply Linux with
> >> the device's hardware revision. This is an optional object. Add
> >> sysfs support for the _HRV object if it exists on the device.
> >>
> >> Signed-off-by: Betty Dall <betty.dall@hpe.com>
> >> ---
> >>  drivers/acpi/device_sysfs.c | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> >> index b9afb47..bf12dbe 100644
> >> --- a/drivers/acpi/device_sysfs.c
> >> +++ b/drivers/acpi/device_sysfs.c
> >> @@ -473,6 +473,21 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
> >>  }
> >>  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
> >>  
> >> +static ssize_t
> >> +acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
> >> +		     char *buf) {
> >> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> >> +	acpi_status status;
> >> +	unsigned long long hrv;
> >> +
> >> +	status = acpi_evaluate_integer(acpi_dev->handle, "_HRV", NULL, &hrv);
> >> +	if (ACPI_FAILURE(status))
> >> +		return -ENODEV;
> > 
> > Actually, this should be -EIO I think.
> > 
> > Thanks,
> > Rafael
> 
> Hi Rafael,
> 
> I picked -ENODEV because the _SUN and _STA show functions use -ENODEV
> for a return value when the acpi_evaluate_integer() fails.

Which isn't the best choice.

> I checked in the sysfs code what the return value is used for and any
> negative value is treated the same, that is, the sysfs code is not
> looking specifically for -EIO.

But doesn't it pass the return value up the call chain?

> Do you still want me to change it to -EIO?

I may, depending on the answer to the question above.

Thanks,
Rafael

