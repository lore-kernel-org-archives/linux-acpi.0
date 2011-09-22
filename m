From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] acpi: Fix CPU hot removal problem
Date: Thu, 22 Sep 2011 10:53:20 -0600
Message-ID: <CAErSpo71cC5=K7DXYs+aEnU2J91TX7ys8bpnUSmdob1dgdaBSg@mail.gmail.com>
References: <4E714FAA.8060708@huawei.com> <CAErSpo5gV7AspUQp7_JOFuY0c0YnFWxj2TKUX-r6-0dVkj5FPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:45873 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab1IVQxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 12:53:47 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p8MGriDu010271
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 09:53:44 -0700
Received: from gwj22 (gwj22.prod.google.com [10.200.10.22])
	by hpaq7.eem.corp.google.com with ESMTP id p8MGrg4p018611
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 09:53:43 -0700
Received: by gwj22 with SMTP id 22so2851534gwj.21
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 09:53:42 -0700 (PDT)
In-Reply-To: <CAErSpo5gV7AspUQp7_JOFuY0c0YnFWxj2TKUX-r6-0dVkj5FPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, khalid.aziz@hp.com

On Wed, Sep 14, 2011 at 8:56 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Wed, Sep 14, 2011 at 7:06 PM, canquan.shen <shencanquan@huawei.com=
> wrote:
>> We run linux as a guest in Xen environment. When we used the xen too=
ls
>> (xm vcpu-set <n>) to hot add and remove vcpu to and from the guest, =
we
>> encountered the failure on vcpu removal. We found the reason is that=
 it
>> didn't go to really remove cpu in the cpu removal code path.
>>
>> This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fix =
this
>> issue. With this patch, it works fine for us.
>>
>> Signed-off-by:Canquan Shen <shencanquan@huawei.com>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

On second thought, let's think about this a bit more.

As I mentioned before, I have a long-term goal to move the hotplug
flow out of drivers and into the ACPI core.  That will be easier if
the code in the drivers is as generic as possible.

The dock and acpiphp hot-remove code calls acpi_bus_trim(), then
evaluates _EJ0.  The core acpi_bus_hot_remove_device() function
already does both acpi_bus_trim() and _EJ0.  This function is
currently only used when we write to sysfs "eject" files, but I wonder
if we should use it in acpi_processor_hotplug_notify() as well.

That would get us one step closer to removing this gunk from the
drivers and having acpi_bus_notify() look something like this:

    case ACPI_NOTIFY_EJECT_REQUEST:
        driver->ops.remove(device);
        acpi_bus_hot_remove_device(device);
        break;

There is a description of a CPU hot-remove that does include _EJ0
methods in the "DIG64 Hot-Plug & Partitioning Flows Specification"
[1], sec 2.2.4.  I know this document is Itanium-oriented, but this
part seems fairly generic and it's the only description of the process
I've seen so far.

So would using acpi_bus_hot_remove_device() instead of acpi_bus_trim()
also solve your problem, Canquan?

Bjorn

[1] http://www.dig64.org/home/DIG64_HPPF_R1_0.pdf

>> ---
>> =A0drivers/acpi/processor_driver.c | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c
>> b/drivers/acpi/processor_driver.c
>> index a4e0f1b..03d92d6 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -641,6 +641,7 @@ static void acpi_processor_hotplug_notify(acpi_h=
andle
>> handle,
>> =A0 =A0 =A0 =A0struct acpi_processor *pr;
>> =A0 =A0 =A0 =A0struct acpi_device *device =3D NULL;
>> =A0 =A0 =A0 =A0int result;
>> + =A0 =A0 =A0 u32 id;
>>
>>
>> =A0 =A0 =A0 =A0switch (event) {
>> @@ -677,6 +678,11 @@ static void acpi_processor_hotplug_notify(acpi_=
handle
>> handle,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"Driver data is NULL, dropping EJECT\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D pr->id;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acpi_bus_trim(device, 1)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR =A0PRE=
=46IX
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "Fail to Remove CPU %d\n", id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>> --
>> 1.7.6.0
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
