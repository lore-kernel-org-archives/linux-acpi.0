From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] acpi: Fix CPU hot removal problem
Date: Wed, 14 Sep 2011 20:56:58 -0600
Message-ID: <CAErSpo5gV7AspUQp7_JOFuY0c0YnFWxj2TKUX-r6-0dVkj5FPA@mail.gmail.com>
References: <4E714FAA.8060708@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:17982 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1IOC5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2011 22:57:21 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p8F2vJDC017872
	for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 19:57:19 -0700
Received: from gwb19 (gwb19.prod.google.com [10.200.2.19])
	by wpaz37.hot.corp.google.com with ESMTP id p8F2uVEE012051
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 19:57:18 -0700
Received: by gwb19 with SMTP id 19so2180865gwb.32
        for <linux-acpi@vger.kernel.org>; Wed, 14 Sep 2011 19:57:18 -0700 (PDT)
In-Reply-To: <4E714FAA.8060708@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "canquan.shen" <shencanquan@huawei.com>
Cc: len.brown@intel.com, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, linqiangmin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Sep 14, 2011 at 7:06 PM, canquan.shen <shencanquan@huawei.com> =
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
> Signed-off-by:Canquan Shen <shencanquan@huawei.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> =A0drivers/acpi/processor_driver.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c
> b/drivers/acpi/processor_driver.c
> index a4e0f1b..03d92d6 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -641,6 +641,7 @@ static void acpi_processor_hotplug_notify(acpi_ha=
ndle
> handle,
> =A0 =A0 =A0 =A0struct acpi_processor *pr;
> =A0 =A0 =A0 =A0struct acpi_device *device =3D NULL;
> =A0 =A0 =A0 =A0int result;
> + =A0 =A0 =A0 u32 id;
>
>
> =A0 =A0 =A0 =A0switch (event) {
> @@ -677,6 +678,11 @@ static void acpi_processor_hotplug_notify(acpi_h=
andle
> handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"Driver data is NULL, dropping EJECT\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D pr->id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acpi_bus_trim(device, 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR =A0PREF=
IX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "Fail to Remove CPU %d\n", id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> --
> 1.7.6.0
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
