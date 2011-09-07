From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Re : [PATCH] acpi: Fix hot cpu remove problem on acpi subsystem
Date: Tue, 6 Sep 2011 23:57:57 -0700
Message-ID: <CAErSpo7Rf+X3MVgmdYvbEXw-UAU7sEEMq5upBkhEn9Eu0zD-zw@mail.gmail.com>
References: <F1F5DF04259F1B4A82BD6BDE1C479F74098285B0@szxeml527-mbx.china.huawei.com>
 <CAErSpo4JsyHag24SH=zSRHt4c8kYwdcXEnCConGEi2u6dN-pnw@mail.gmail.com>
 <4E65C254.8090107@huawei.com> <CAErSpo5owGuYLP2-JR6uJsM+Pqwna+FUB--p4OhjLVAETqYpcw@mail.gmail.com>
 <4E66D988.9070505@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:50008 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab1IGRPR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Sep 2011 13:15:17 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p87HF95q021470
	for <linux-acpi@vger.kernel.org>; Wed, 7 Sep 2011 10:15:09 -0700
Received: from gyc15 (gyc15.prod.google.com [10.243.49.143])
	by wpaz24.hot.corp.google.com with ESMTP id p876vxTf022777
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 7 Sep 2011 00:00:12 -0700
Received: by gyc15 with SMTP id 15so7049304gyc.25
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2011 23:58:17 -0700 (PDT)
In-Reply-To: <4E66D988.9070505@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linqiangmin@huawei.com, james.chenjiabo@huawei.com

On Tue, Sep 6, 2011 at 7:40 PM, canquan.shen <shencanquan@huawei.com> w=
rote:
> On 2011/9/7 2:38, Bjorn Helgaas wrote:

>> Is acpi_processor_remove() called when you remove a processor? =A0I =
see
>> a path where it will be called via acpi_eject_store():
>>
>> =A0 =A0 acpi_eject_store
>> =A0 =A0 =A0 acpi_os_hotplug_execute(acpi_bus_hot_remove_device)
>> =A0 =A0 =A0 acpi_bus_hot_remove_device
>> =A0 =A0 =A0 =A0 acpi_bus_trim
>> =A0 =A0 =A0 =A0 =A0 acpi_bus_remove
>> =A0 =A0 =A0 =A0 =A0 =A0 device_release_driver
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->driver->remove (acpi_processor_remo=
ve())
>> =A0 =A0 =A0 =A0 =A0 =A0 acpi_device_unregister
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_unregister
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_del
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobject_uevent(KOBJ_REMOVE)
>>
>> but as far as I can tell, this path is only used when we write
>> something to the "eject" sysfs file. =A0I would think we'd want to u=
se
>> most of this same path when we hot remove a CPU via the ACPI SCI
>> mechanism.
>>
>
> Because in my patch will send the KOBJ_REMOVE event to udev module. a=
nd I
> write a udev rule like the following:
> ACTION=3D=3D"remove",DRIVER=3D=3D"processor",SUBSYSTEM=3D=3D"acpi",RU=
N+=3D"/bin/bash -c
> 'echo 1 > /sys%p/eject'"
> This rule will write "1" to the "eject" sysfs file. and then call
> acpi_eject_store function.

Hmmm.  I think I understand your proposal, but it seems like a
convoluted path to me.

I guess the real question is whether we must give userspace a chance
to decide whether to actually do the remove or not.  Is there a
requirement to do that?  Neither the dynamic device removal flow (ACPI
spec 4.0a, sec 6.3) nor the ejection flow example (fig 6-5) mentions
doing that.

I mentioned before that I think the ACPI hotplug code should be ripped
out of the drivers and consolidated in the ACPI core.  I think it's
pretty clear from the spec that the 0-0x7f notifications (Bus Check,
Device Check, Eject Request, etc.) are designed to be handled by the
core, not by individual drivers.  We handle hotplug in the drivers
today, but I think that's mainly because we never implemented support
in the Linux ACPI core.  There are comments in acpi_bus_check_device()
and acpi_bus_check_scope() about what we *should* be doing there.

I am opposed to adding more hotplug support to individual drivers
because I still hope that someday we'll support it in the ACPI core.
Many ACPI drivers don't support hotplug at all, and the ones that do
support hotplug do it in a variety of ways.  It's all quite a mess.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
