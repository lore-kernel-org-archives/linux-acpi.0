From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Re : [PATCH] acpi: Fix hot cpu remove problem on acpi subsystem
Date: Mon, 5 Sep 2011 22:19:09 -0600
Message-ID: <CAErSpo4JsyHag24SH=zSRHt4c8kYwdcXEnCConGEi2u6dN-pnw@mail.gmail.com>
References: <F1F5DF04259F1B4A82BD6BDE1C479F74098285B0@szxeml527-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:30349 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1IFETb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2011 00:19:31 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p864JUKl013532
	for <linux-acpi@vger.kernel.org>; Mon, 5 Sep 2011 21:19:30 -0700
Received: from gwj17 (gwj17.prod.google.com [10.200.10.17])
	by wpaz5.hot.corp.google.com with ESMTP id p864JTO4016754
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 5 Sep 2011 21:19:29 -0700
Received: by gwj17 with SMTP id 17so2851731gwj.10
        for <linux-acpi@vger.kernel.org>; Mon, 05 Sep 2011 21:19:29 -0700 (PDT)
In-Reply-To: <F1F5DF04259F1B4A82BD6BDE1C479F74098285B0@szxeml527-mbx.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shen Canquan <shencanquan@huawei.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "rui.zhao@intel.com" <rui.zhao@intel.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, "yakui.zhao@intel.com" <yakui.zhao@intel.com>, "xiaowei.yang@huawei.com" <xiaowei.yang@huawei.com>, hanweidong <hanweidong@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> =E4=B8=BB=E9=A2=98: [PATCH] acpi: Fix hot cpu remove problem on acpi =
subsystem
>
> In Xen virtualization environment, When I used xen tools (xm vcpu-set=
 vcpu_number ) to test the vcpu add and remove, I found it is failure o=
n vcpu remove, I found the reason is that nothing to do when cpu remove=
 in acpi_processor_hotplug_notify function, so I add the code of send t=
he OFFLINE message to udev and add the rule of udev. it is ok on vcpu r=
emove.
> Signed-off-by: Shen canquan <shencanquan@huawei.com>
> ---
> =C2=A0drivers/acpi/processor_driver.c | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index a4e0f1b..a1c564f 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -677,6 +677,8 @@ static void acpi_processor_hotplug_notify(acpi_ha=
ndle handle,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Driver data i=
s NULL, dropping EJECT\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kobject_uevent(&de=
vice->dev.kobj, KOBJ_OFFLINE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACPI_DEBUG_PR=
INT((ACPI_DB_INFO,

The processor driver used to generate ONLINE and OFFLINE messages.  I
removed them with c1815e0740.  According to the changelog, the driver
core still generates KOBJ_ADD and KOBJ_REMOVE events.

Could you fix the Xen vcpu add/remove problem by looking for
ADD/REMOVE events rather than ONLINE/OFFLINE?

I removed ONLINE/OFFLINE because I think hotplug should be handled in
the ACPI core, not in the drivers.  Removing ONLINE/OFFLINE got rid of
one small piece of driver-specific hotplug handling.  Obviously,
there's still a lot to do.

If using ADD/REMOVE is not sufficient, what is the justification for
needing both REMOVE and OFFLINE, and how would they be different?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
