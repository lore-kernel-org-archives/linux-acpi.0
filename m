From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] acpi: Fix CPU hot removal problem
Date: Fri, 23 Sep 2011 08:16:08 -0600
Message-ID: <CAErSpo4KwLfcD0HHh6XQD36rmYbZuHVHrH31wdouWqwFakMdRw@mail.gmail.com>
References: <4E714FAA.8060708@huawei.com> <CAErSpo5gV7AspUQp7_JOFuY0c0YnFWxj2TKUX-r6-0dVkj5FPA@mail.gmail.com>
 <CAErSpo71cC5=K7DXYs+aEnU2J91TX7ys8bpnUSmdob1dgdaBSg@mail.gmail.com> <4E7C39FB.3050707@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:26715 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab1IWOQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 10:16:30 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p8NEGTWH004147
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 07:16:29 -0700
Received: from gxk1 (gxk1.prod.google.com [10.202.11.1])
	by wpaz21.hot.corp.google.com with ESMTP id p8NEGSW7028270
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 07:16:28 -0700
Received: by gxk1 with SMTP id 1so3442085gxk.24
        for <linux-acpi@vger.kernel.org>; Fri, 23 Sep 2011 07:16:28 -0700 (PDT)
In-Reply-To: <4E7C39FB.3050707@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, khalid.aziz@hp.com

On Fri, Sep 23, 2011 at 1:49 AM, canquan.shen <shencanquan@huawei.com> =
wrote:
> On 2011/9/23 0:53, Bjorn Helgaas wrote:
>>
>> On Wed, Sep 14, 2011 at 8:56 PM, Bjorn Helgaas<bhelgaas@google.com>
>> =A0wrote:
>>>
>>> On Wed, Sep 14, 2011 at 7:06 PM, canquan.shen<shencanquan@huawei.co=
m>
>>> =A0wrote:
>>>>
>>>> We run linux as a guest in Xen environment. When we used the xen t=
ools
>>>> (xm vcpu-set<n>) to hot add and remove vcpu to and from the guest,=
 we
>>>> encountered the failure on vcpu removal. We found the reason is th=
at it
>>>> didn't go to really remove cpu in the cpu removal code path.
>>>>
>>>> This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fi=
x this
>>>> issue. With this patch, it works fine for us.
>>>>
>>>> Signed-off-by:Canquan Shen<shencanquan@huawei.com>
>>>
>>> Reviewed-by: Bjorn Helgaas<bhelgaas@google.com>
>>
>> On second thought, let's think about this a bit more.
>>
>> As I mentioned before, I have a long-term goal to move the hotplug
>> flow out of drivers and into the ACPI core. =A0That will be easier i=
f
>> the code in the drivers is as generic as possible.
>>
>> The dock and acpiphp hot-remove code calls acpi_bus_trim(), then
>> evaluates _EJ0. =A0The core acpi_bus_hot_remove_device() function
>> already does both acpi_bus_trim() and _EJ0. =A0This function is
>> currently only used when we write to sysfs "eject" files, but I wond=
er
>> if we should use it in acpi_processor_hotplug_notify() as well.
>>
>> That would get us one step closer to removing this gunk from the
>> drivers and having acpi_bus_notify() look something like this:
>>
>> =A0 =A0 case ACPI_NOTIFY_EJECT_REQUEST:
>> =A0 =A0 =A0 =A0 driver->ops.remove(device);
>> =A0 =A0 =A0 =A0 acpi_bus_hot_remove_device(device);
>> =A0 =A0 =A0 =A0 break;
>>
>> There is a description of a CPU hot-remove that does include _EJ0
>> methods in the "DIG64 Hot-Plug& =A0Partitioning Flows Specification"
>> [1], sec 2.2.4. =A0I know this document is Itanium-oriented, but thi=
s
>> part seems fairly generic and it's the only description of the proce=
ss
>> I've seen so far.
>>
>> So would using acpi_bus_hot_remove_device() instead of acpi_bus_trim=
()
>> also solve your problem, Canquan?
>>
> Yes. It can solve my problem.
> I fully aggree to replace acpi_bus_hot_remove_device() to acpi_bus_tr=
im().
> Initially I insert the acpi_bus_hot_remove_device() in acpi_bus_notif=
y
> function . lately I think I should give a chance for user,and so send
> =A0KOBJ_OFFLINE message to the udvev module.
>
> But why add the =A0driver->ops.remove(device) before
> acpi_bus_hot_remove_device(device). =A0it can be called in
> acpi_bus_hot_remove_device code path as bellowing:
> =A0 =A0acpi_bus_trim
> =A0 =A0 =A0 =A0acpi_bus_remove
> =A0 =A0 =A0 =A0 =A0 =A0device_release_driver
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__device_release_driver
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_device_remove
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_d=
rv->ops.remove

OK.  Maybe the future acpi_bus_notify() code would be even simpler.
The point is that the ACPI core should handle the notification, call
the driver's .remove() method, and do whatever namespace cleanup is
required (i.e., acpi_bus_trim()).  None of this should be in the
driver itself.

Can you re-post your patch, using acpi_bus_hot_remove_device() instead
of acpi_bus_trim()?  Please include Khalid's tweak, too, so we don't
print warnings for CPUs that don't supply _EJ0 methods.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
