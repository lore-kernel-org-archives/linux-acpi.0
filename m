From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] acpi: Fix CPU hot removal problem
Date: Tue, 13 Sep 2011 09:49:42 -0600
Message-ID: <CAErSpo70vev68-MMfr0VM5eZsOJ0T6sTXWSvZk0r-=rwx-KOPQ@mail.gmail.com>
References: <4E682AC8.7040302@huawei.com> <4E6EF0EB.2040701@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:1997 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab1IMPuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2011 11:50:06 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p8DFo48x015121
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 08:50:04 -0700
Received: from gwm11 (gwm11.prod.google.com [10.200.13.11])
	by wpaz24.hot.corp.google.com with ESMTP id p8DFngZH004868
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 08:50:02 -0700
Received: by gwm11 with SMTP id 11so712887gwm.30
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 08:50:02 -0700 (PDT)
In-Reply-To: <4E6EF0EB.2040701@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Sep 12, 2011 at 11:58 PM, canquan.shen <shencanquan@huawei.com> wrote:
> On 2011/9/8 10:39, canquan.shen wrote:
>>
>> We run Linux as a guest in Xen environment. When used xen tools
>> (xm vcpu-set <n>) to hot add and remove vcpu to and from the guest,
>> we encountered the failure on vcpu removal. We found the reason is
>> that it didn't go to really remove cpu in the cpu removal code path.
>>
>> This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fix
>> this issue. With this patch, it works fine for us.
>>
>> Signed-off-by: Canquan Shen <shencanquan@huawei.com>
>> ---
>> drivers/acpi/processor_driver.c | 5 +++++
>> 1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c
>> b/drivers/acpi/processor_driver.c
>> index a1c564f..114592f 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -678,7 +678,11 @@ static void
>> acpi_processor_hotplug_notify(acpi_handle handle,
>> return;
>> }
>>
>> + if (acpi_bus_trim(device, 1)) {
>> + printk(KERN_ERR PREFIX
>> + "Removing device failed\n");
>> + return;
>> + }
>> break;
>> default:
>> ACPI_DEBUG_PRINT((ACPI_DB_INFO,

I think this patch is OK.  One nit is that kernel printks should never
be constant strings.  There's almost always more information that's
useful in debugging.  This error should at least tell us which driver
is involved, and preferably which specific device (though we have to
be careful in case the device struct is freed by acpi_bus_trim()).

Bjorn
