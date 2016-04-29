From: "Dall, Betty" <betty.dall@hpe.com>
Subject: Re: [PATCH v2 3/3] ACPI/device_sysfs: Clean up checkpatch errors
Date: Fri, 29 Apr 2016 21:13:28 +0000
Message-ID: <AT5PR84MB00838E755BEEE2769F1EA5209D660@AT5PR84MB0083.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461957681-6163-1-git-send-email-betty.dall@hpe.com>
	<1461957681-6163-4-git-send-email-betty.dall@hpe.com>
 <CAJZ5v0iAar-AJ8zsf6B0awm-xWT0xr3PQji5zoZeQYt+=+_W0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:36897
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751339AbcD2V21 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2016 17:28:27 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/29/2016 02:19 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 29, 2016 at 9:21 PM, Betty Dall <betty.dall@hpe.com> wrote:
>> Cleaning up five existing checkpatch errors in device_sysfs.c since the
>> file is being changed.
>>
>> Signed-off-by: Betty Dall <betty.dall@hpe.com>
>> ---
>>  drivers/acpi/device_sysfs.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>> index e556a3e..5aaebec 100644
>> --- a/drivers/acpi/device_sysfs.c
>> +++ b/drivers/acpi/device_sysfs.c
>> @@ -35,7 +35,7 @@ static ssize_t acpi_object_path(acpi_handle handle, char *buf)
>>         if (result)
>>                 return result;
>>
>> -       result = sprintf(buf, "%s\n", (char*)path.pointer);
>> +       result = sprintf(buf, "%s\n", (char *)path.pointer);
> 
> OK
> 
>>         kfree(path.pointer);
>>         return result;
>>  }
>> @@ -81,6 +81,7 @@ static const struct sysfs_ops acpi_data_node_sysfs_ops = {
>>  static void acpi_data_node_release(struct kobject *kobj)
>>  {
>>         struct acpi_data_node *dn = to_data_node(kobj);
>> +
> 
> Maybe.

Checkpatch wants a blank line after declarations.

>>         complete(&dn->kobj_done);
>>  }
>>
>> @@ -106,7 +107,8 @@ static void acpi_expose_nondev_subnodes(struct kobject *kobj,
>>                 ret = kobject_init_and_add(&dn->kobj, &acpi_data_node_ktype,
>>                                            kobj, "%s", dn->name);
>>                 if (ret)
>> -                       acpi_handle_err(dn->handle, "Failed to expose (%d)\n", ret);
>> +                       acpi_handle_err(dn->handle,
>> +                               "Failed to expose (%d)\n", ret);
> 
> No.  checkpatch is wrong here.

Ok - that was just an 80 char warning.

>>                 else
>>                         acpi_expose_nondev_subnodes(&dn->kobj, &dn->data);
>>         }
>> @@ -333,7 +335,9 @@ int acpi_device_modalias(struct device *dev, char *buf, int size)
>>  EXPORT_SYMBOL_GPL(acpi_device_modalias);
>>
>>  static ssize_t
>> -acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, char *buf) {
>> +acpi_device_modalias_show(struct device *dev,
>> +                       struct device_attribute *attr, char *buf)
> 
> The brace should go to the new line, but it's better if the header
> takes one line only.

Ok - I was trying to clean up the 80 character warning, but I see your
point.

>> +{
>>         return __acpi_device_modalias(to_acpi_device(dev), buf, 1024);
>>  }
>>  static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
>> @@ -397,7 +401,9 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
>>  static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
>>
>>  static ssize_t
>> -acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf) {
>> +acpi_device_hid_show(struct device *dev,
>> +       struct device_attribute *attr, char *buf)
> 
> Ditto.

OK.

>> +{
>>         struct acpi_device *acpi_dev = to_acpi_device(dev);
>>
>>         return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
>> @@ -568,10 +574,10 @@ int acpi_device_setup_files(struct acpi_device *dev)
>>                         goto end;
>>         }
>>
>> -        /*
>> -         * If device has _EJ0, 'eject' file is created that is used to trigger
>> -         * hot-removal function from userland.
>> -         */
>> +       /*
>> +        * If device has _EJ0, 'eject' file is created that is used to trigger
>> +        * hot-removal function from userland.
>> +        */
> 
> What's the problem with this comment?

They were spaces - not a tab.

> 
>>         if (acpi_has_method(dev->handle, "_EJ0")) {
>>                 result = device_create_file(&dev->dev, &dev_attr_eject);
>>                 if (result)
>> --


