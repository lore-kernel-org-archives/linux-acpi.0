From: "canquan.shen" <shencanquan@huawei.com>
Subject: Re: [PATCH v5] acpi: Fix CPU hot removal problem
Date: Thu, 29 Sep 2011 11:41:35 +0800
Message-ID: <4E83E8EF.30806@huawei.com>
References: <4E7D7468.4040506@huawei.com> <4E83E27E.5090608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:64433 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab1I2Dng (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2011 23:43:36 -0400
In-reply-to: <4E83E27E.5090608@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: len.brown@intel.com, Bjorn Helgaas <bhelgaas@google.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, khalid.aziz@hp.com

On 2011/9/29 11:14, Chen Gong wrote:
> =E4=BA=8E 2011/9/24 14:10, canquan.shen =E5=86=99=E9=81=93:
>> We run linux as a guest in Xen environment. When we used the xen too=
ls
>> (xm vcpu-set <n>) to hot add and remove vcpu to and from the guest, =
we
>> encountered the failure on vcpu removal. We found the reason is that=
 it
>> did't go to really remove cpu in the cpu removal code path.
>>
>> This patch adds acpi_bus_hot_remove_device in
>> acpi_process_hotplug_notify to
>> fix this issue. With this patch, it works fine for us.
>>
>> Signed-off-by: Canquan Shen <shencanquan@huawei.com>
>> ---
>> drivers/acpi/processor_driver.c | 13 +------------
>> drivers/acpi/scan.c | 4 ++--
>> include/acpi/acpi_bus.h | 1 +
>> 3 files changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c
>> b/drivers/acpi/processor_driver.c
>> index a4e0f1b..8429688 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -665,18 +665,7 @@ static void
>> acpi_processor_hotplug_notify(acpi_handle handle,
>> case ACPI_NOTIFY_EJECT_REQUEST:
>> ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>> "received ACPI_NOTIFY_EJECT_REQUEST\n"));
>> -
>> - if (acpi_bus_get_device(handle, &device)) {
>> - printk(KERN_ERR PREFIX
>> - "Device don't exist, dropping EJECT\n");
>> - break;
>> - }
>> - pr =3D acpi_driver_data(device);
>> - if (!pr) {
>> - printk(KERN_ERR PREFIX
>> - "Driver data is NULL, dropping EJECT\n");
>> - return;
>> - }
>> + acpi_bus_hot_remove_device(handle);
>
> As the description in __acpi_os_execute(in acpi_os_hotplug_execute),
> /*
> * We can't run hotplug code in keventd_wq/kacpid_wq/kacpid_notify_wq
> * because the hotplug code may call driver .remove() functions,
> * which invoke flush_scheduled_work/acpi_os_wait_events_complete
> * to flush these workqueues.
> */
> If so, why not using following call:
>
> acpi_os_hotplug_execute(acpi_bus_hot_remove_device, acpi_device->hand=
le);
>
>

It is ok if using the acpi_os_hotplug_execute. but it is complex and=20
more time for removal cpu because it is add to queue and some time the=20
work will be called.
I think that it is clear to call directly acpi_bus_hot_remove_device=20
function in acpi_processor_hotplug_notify.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
