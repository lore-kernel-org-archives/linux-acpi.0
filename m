From: "Dall, Betty" <betty.dall@hpe.com>
Subject: Re: [PATCH] ACPI/device_sysfs: Add sysfs support for _HRV hardware
 revision
Date: Fri, 29 Apr 2016 13:55:12 +0000
Message-ID: <CS1PR84MB00855BF52B311516C15B6C5D9D660@CS1PR84MB0085.NAMPRD84.PROD.OUTLOOK.COM>
References: <1460558894-11971-1-git-send-email-betty.dall@hpe.com>
 <2388310.jGjaKS2NDe@vostro.rjw.lan>
 <AT5PR84MB008340CB53E60CE8C511BEDE9D640@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
 <1818106.auxzDWcdFV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 04/27/2016 03:19 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 27, 2016 04:19:45 PM Dall, Betty wrote:
>> On 04/26/2016 02:39 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, April 13, 2016 08:48:14 AM Betty Dall wrote:
>>>> The ACPI _HRV object on the device is used to supply Linux with
>>>> the device's hardware revision. This is an optional object. Add
>>>> sysfs support for the _HRV object if it exists on the device.
>>>>
>>>> Signed-off-by: Betty Dall <betty.dall@hpe.com>
>>>> ---
>>>>  drivers/acpi/device_sysfs.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>>>> index b9afb47..bf12dbe 100644
>>>> --- a/drivers/acpi/device_sysfs.c
>>>> +++ b/drivers/acpi/device_sysfs.c
>>>> @@ -473,6 +473,21 @@ acpi_device_sun_show(struct device *dev, struct device_attribute *attr,
>>>>  }
>>>>  static DEVICE_ATTR(sun, 0444, acpi_device_sun_show, NULL);
>>>>  
>>>> +static ssize_t
>>>> +acpi_device_hrv_show(struct device *dev, struct device_attribute *attr,
>>>> +		     char *buf) {
>>>> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>> +	acpi_status status;
>>>> +	unsigned long long hrv;
>>>> +
>>>> +	status = acpi_evaluate_integer(acpi_dev->handle, "_HRV", NULL, &hrv);
>>>> +	if (ACPI_FAILURE(status))
>>>> +		return -ENODEV;
>>>
>>> Actually, this should be -EIO I think.
>>>
>>> Thanks,
>>> Rafael
>>
>> Hi Rafael,
>>
>> I picked -ENODEV because the _SUN and _STA show functions use -ENODEV
>> for a return value when the acpi_evaluate_integer() fails.
> 
> Which isn't the best choice.
> 
>> I checked in the sysfs code what the return value is used for and any
>> negative value is treated the same, that is, the sysfs code is not
>> looking specifically for -EIO.
> 
> But doesn't it pass the return value up the call chain?

Yes, it passes the return up the call chain. I see ENODEV returned from
the read system call by using strace with a hard coded an error return
in my show function. The kernel call chain is:
	acpi_device_hrv_show+0x1c/0x48
	dev_attr_show+0x20/0x58
	sysfs_kf_seq_show+0xc0/0x158
	kernfs_seq_show+0x28/0x30
	seq_read+0x19c/0x418
	kernfs_fop_read+0x104/0x198
	__vfs_read+0x1c/0xd8
	vfs_read+0x78/0x160
	SyS_read+0x44/0xa0

>> Do you still want me to change it to -EIO?
> 
> I may, depending on the answer to the question above.

I will change it to EIO. ENODEV makes less sense since the "device"
exists or there wouldn't be a sysfs file. I can do the same for _SUN and
_STA.

Thanks,
-Betty
