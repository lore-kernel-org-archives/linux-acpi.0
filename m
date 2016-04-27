From: "Dall, Betty" <betty.dall@hpe.com>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware
 revision
Date: Wed, 27 Apr 2016 16:19:45 +0000
Message-ID: <AT5PR84MB008340CB53E60CE8C511BEDE9D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
 <2388310.jGjaKS2NDe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0123.outbound.protection.outlook.com ([65.55.169.123]:54432
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753330AbcD0Qea convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Apr 2016 12:34:30 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 04/26/2016 02:39 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
>> The ACPI _HRV object on the device is used to supply Linux with
>> the device's hardware revision. This is an optional object. Add
>> sysfs support for the _HRV object if it exists on the device.
>>
>> Signed-off-by: Betty Dall <betty.dall@hpe.com>
>> ---
>>  drivers/acpi/device_sysfs.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>> index b9afb47..bf12dbe 100644
>> --- a/drivers/acpi/device_sysfs.c
>> +++ b/drivers/acpi/device_sysfs.c
>> @@ -473,6 +473,21 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
>>  
>> +static ssize_t
>> +acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
>> +		     char *buf) {
>> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
>> +	acpi_status status;
>> +	unsigned long long hrv;
>> +
>> +	status = acpi_evaluate_integer(acpi_dev->handle, "_HRV", NULL, &hrv);
>> +	if (ACPI_FAILURE(status))
>> +		return -ENODEV;
> 
> Actually, this should be -EIO I think.
> 
> Thanks,
> Rafael

Hi Rafael,

I picked -ENODEV because the _SUN and _STA show functions use -ENODEV
for a return value when the acpi_evaluate_integer() fails.

I checked in the sysfs code what the return value is used for and any
negative value is treated the same, that is, the sysfs code is not
looking specifically for -EIO.

Do you still want me to change it to -EIO?

-Betty


