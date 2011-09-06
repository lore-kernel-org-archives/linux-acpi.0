From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Re : [PATCH] acpi: Fix hot cpu remove problem on acpi subsystem
Date: Tue, 6 Sep 2011 11:38:39 -0700
Message-ID: <CAErSpo5owGuYLP2-JR6uJsM+Pqwna+FUB--p4OhjLVAETqYpcw@mail.gmail.com>
References: <F1F5DF04259F1B4A82BD6BDE1C479F74098285B0@szxeml527-mbx.china.huawei.com>
 <CAErSpo4JsyHag24SH=zSRHt4c8kYwdcXEnCConGEi2u6dN-pnw@mail.gmail.com> <4E65C254.8090107@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:10090 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab1IFSjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2011 14:39:03 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p86Id0U1005275
	for <linux-acpi@vger.kernel.org>; Tue, 6 Sep 2011 11:39:01 -0700
Received: from ywm3 (ywm3.prod.google.com [10.192.13.3])
	by wpaz33.hot.corp.google.com with ESMTP id p86Icslh022637
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 6 Sep 2011 11:38:59 -0700
Received: by ywm3 with SMTP id 3so6355270ywm.30
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2011 11:38:59 -0700 (PDT)
In-Reply-To: <4E65C254.8090107@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rui.zhao@intel.com" <rui.zhao@intel.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Sep 5, 2011 at 11:48 PM, canquan.shen <shencanquan@huawei.com> =
wrote:
> On 2011/9/6 12:19, Bjorn Helgaas wrote:
>>>
>>> =E4=B8=BB=E9=A2=98: [PATCH] acpi: Fix hot cpu remove problem on acp=
i subsystem
>>>
>>> In Xen virtualization environment, When I used xen tools (xm vcpu-s=
et
>>> vcpu_number ) to test the vcpu add and remove, I found it is failur=
e on vcpu
>>> remove, I found the reason is that nothing to do when cpu remove in
>>> acpi_processor_hotplug_notify function, so I add the code of send t=
he
>>> OFFLINE message to udev and add the rule of udev. it is ok on vcpu =
remove.
>>> Signed-off-by: Shen canquan<shencanquan@huawei.com>
>>> ---
>>> =C2=A0drivers/acpi/processor_driver.c | =C2=A0 =C2=A02 ++
>>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>>> diff --git a/drivers/acpi/processor_driver.c
>>> b/drivers/acpi/processor_driver.c
>>> index a4e0f1b..a1c564f 100644
>>> --- a/drivers/acpi/processor_driver.c
>>> +++ b/drivers/acpi/processor_driver.c
>>> @@ -677,6 +677,8 @@ static void acpi_processor_hotplug_notify(acpi_=
handle
>>> handle,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Driver data i=
s NULL, dropping
>>> EJECT\n");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kobject_uevent(&=
device->dev.kobj, KOBJ_OFFLINE);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_DEBUG_=
PRINT((ACPI_DB_INFO,
>>
>> The processor driver used to generate ONLINE and OFFLINE messages. =C2=
=A0I
>> removed them with c1815e0740. =C2=A0According to the changelog, the =
driver
>> core still generates KOBJ_ADD and KOBJ_REMOVE events.
>
> Thanks for your answer.
> When I used xen tools (xm vcpu-set vcpu_numer) to reduce the cpu numb=
er. I
> don't found any event . I use the following tool to capture the event=
:
> udevadm monitor --env --kernel --udev.
>
> If I used xen tools to add the cpu number , udev module will receive =
the
> KOBJ_ADD event.
>
> In my patch ,It is more fine to replace KOBJ_OFFLINE to KOBJ_REMOVE e=
vent .

I don't think we should emit KOBJ_REMOVE from the ACPI processor
driver.  KOBJ_ADD is emitted by the driver model core
(device_register() -> device_add() path), and I think KOBJ_REMOVE
should also be emitted from the driver model core.

Is acpi_processor_remove() called when you remove a processor?  I see
a path where it will be called via acpi_eject_store():

    acpi_eject_store
      acpi_os_hotplug_execute(acpi_bus_hot_remove_device)
      acpi_bus_hot_remove_device
        acpi_bus_trim
          acpi_bus_remove
            device_release_driver
              dev->driver->remove (acpi_processor_remove())
            acpi_device_unregister
              device_unregister
                device_del
                  kobject_uevent(KOBJ_REMOVE)

but as far as I can tell, this path is only used when we write
something to the "eject" sysfs file.  I would think we'd want to use
most of this same path when we hot remove a CPU via the ACPI SCI
mechanism.

If you change acpi_processor_hotplug_notify() to use acpi_bus_trim()
for the removal case, you should get KOBJ_REMOVE events.  Would that
be enough to make the xen vcpu remove work, or at least get you
closer?

> btw: how to find changelog of the c1815e0740.

git show c1815e0740

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
