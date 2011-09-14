From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] acpi: Fix CPU hot removal problem
Date: Wed, 14 Sep 2011 08:14:04 -0600
Message-ID: <CAErSpo4F1oH6uBcbYRf9M49=kk49H==r=Cuh2Mrx2Wq4rmUeVg@mail.gmail.com>
References: <4E700EDA.7090505@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:50323 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1INOO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2011 10:14:27 -0400
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
	by smtp-out.google.com with ESMTP id p8EEEQJw014423
	for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 07:14:27 -0700
Received: from gyc15 (gyc15.prod.google.com [10.243.49.143])
	by hpaq5.eem.corp.google.com with ESMTP id p8EEEOQp026005
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 07:14:25 -0700
Received: by gyc15 with SMTP id 15so1665136gyc.7
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 07:14:24 -0700 (PDT)
In-Reply-To: <4E700EDA.7090505@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Sep 13, 2011 at 8:18 PM, canquan.shen <shencanquan@huawei.com> =
wrote:
> We run linux as a guest in Xen environment. When we used the xen tool=
s
> (xm vcpu-set <n>) to hot add and remove vcpu to and from the guest, w=
e
> encountered the failure on vcpu removal. We found the reason is that =
it
> didn't go to really remove cpu in the cpu removal code path.
>
> This patch adds acpi_bus_trim in acpi_process_hotplug_notify to fix t=
his
> issue. With this patch, it works fine for us.
>
> Signed-off-by: Shen canquan <shencanquan@huawei.com>
> ---
> =A0drivers/acpi/processor_driver.c | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c
> b/drivers/acpi/processor_driver.c
> index a4e0f1b..0856ef8 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -677,6 +677,13 @@ static void acpi_processor_hotplug_notify(acpi_h=
andle
> handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"Driver data is NULL, dropping EJECT\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Hot-removing processor=
 device %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&device->dev))=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acpi_bus_trim(device, 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ACPI: =
Removing device failed!\n");

We can do better than that.  Nobody ever looks at ACPI_DEBUG_PRINT info=
=2E

    u32 id;
    ...
    id =3D pr->id;
    if (acpi_bus_trim(device, 1))
        printk(KERN_ERR PREFIX "Failed to remove CPU %d\n", id);

(No "return" needed here.  In fact, the "return" at the bottom of
acpi_processor_hotplug_notify() is also superfluous.  You could remove
it at the same time.)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
