From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [resend PATCH] driver core: property: support for generic property
Date: Fri, 13 Mar 2015 15:10:38 +0000
Message-ID: <CACxGe6tCJAPJc=Pj7vYiJ-cakvL9EsexGMpOD_G0DEPF3iTguQ@mail.gmail.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <2095371.SrUNK6JsDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36329 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbCMPLF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2015 11:11:05 -0400
Received: by iegc3 with SMTP id c3so112361102ieg.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2015 08:11:04 -0700 (PDT)
In-Reply-To: <2095371.SrUNK6JsDO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thu, Mar 12, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, January 26, 2015 03:17:40 PM Heikki Krogerus wrote:
>> This extends the unified device property interface by adding
>> "Generic Property" to it for cases where device tree or ACPI
>> are not being used.
>>
>> That makes the unified device property interface cover also
>> most of the cases where information is extracted from custom
>> platform_data in the drivers. So if before we had to check
>> separately is there custom platform_data for a driver:
>>
>>       if (pdata)
>>               bar = pdata->bar;
>>       else
>>               device_property_read_u32(dev, "foo", &bar);
>>
>> we can now drop that check and simply always use the unified
>> device property interface.
>>
>> That makes it possible to drop a lot of boiler plate from
>> the drivers, plus quite a few header files under
>> include/linux/ describing those driver specific platform
>> data structures can be removed.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
[...]
>> @@ -704,6 +705,7 @@ struct acpi_dev_node {
>>   * @archdata:        For arch-specific additions.
>>   * @of_node: Associated device tree node.
>>   * @acpi_node:       Associated ACPI device node.
>> + * @gen_prop:        Generic device property
>>   * @devt:    For creating the sysfs "dev".
>>   * @id:              device instance
>>   * @devres_lock: Spinlock to protect the resource of the device.
>> @@ -780,6 +782,7 @@ struct device {
>>
>>       struct device_node      *of_node; /* associated device tree node */
>>       struct acpi_dev_node    acpi_node; /* associated ACPI device node */
>> +     struct dev_gen_prop     *gen_prop; /* generic device property */
>
> That doesn't seem to go in the right direction to be honest.
>
> Actually, having introduced struct fwnode_handle, we should perhaps try to
> replace both of_node and acpi_node with a single struct fwnode_handle pointer
> and then add a new fwnode_type for the "pdata" stuff.

I agree on this, but it will be a lot of work to convert...

> If you don't want to deal with of_node, which I can understand easily, it
> may be worth trying with acpi_node alone at this point and once you have
> the fwnode_handle pointer, you might use it for both ACPI and "pdata"?
>
> Grant, Arnd, I wonder what you think?

That makes sense, and we can populate the fwnode_handle even when
using DT. That will allow a transition period to move everyone over to
the fwnode_handle.

g.
