From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/3] ACPIHP: introduce a framework for ACPI based
 system device hotplug
Date: Thu, 02 Aug 2012 15:07:06 +0800
Message-ID: <501A271A.5030808@cn.fujitsu.com>
References: <1343475772-21345-1-git-send-email-jiang.liu@huawei.com> <1343475772-21345-2-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343475772-21345-2-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luch@intel.com>, Bob Moore <robert.moore@intel.com>, Huang Ying <ying.huang@intel.com>, Yinghai Lu <yinghai@kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <guohanjun@huawei.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Gaohuai Han <hangaohuai@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

A little problem here. :)

On 07/28/2012 07:42 PM, Jiang Liu wrote:
> +int acpihp_register_slot(struct acpihp_slot *slot)
> +{
> +	int ret;
> +	char *name;
> +	size_t off;
> +
> +	if (!slot || !slot->slot_ops)
> +		return -EINVAL;
> +
> +	/* Hook top level hotplug slots under ACPI root device */
> +	if (slot->parent)
> +		slot->dev.parent =3D &slot->parent->dev;
> +	else
> +		slot->dev.parent =3D &acpi_root->dev;
> +
> +	ret =3D device_add(&slot->dev);
> +	if (!ret) {
> +		slot->flags |=3D ACPIHP_SLOT_FLAG_REGISTERED;
> +		name =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +		if (name) {
> +			off =3D acpihp_generate_link_name(slot, name, 0);
> +			name[off - 1] =3D '\0';
> +			sysfs_create_link(&acpihp_slot_kset->kobj,
> +					  &slot->dev.kobj, name);

I got a compiler warning here:
  CC      drivers/acpi/hotplug/core.o
drivers/acpi/hotplug/core.c: In function =91acpihp_register_slot=92:
drivers/acpi/hotplug/core.c:199: warning: ignoring return value of =91s=
ysfs_create_link=92, declared with attribute warn_unused_result

Seems that we need to check the sysfs_create_link()'s return value here=
, and if it fails,=20
shall we at least give a warning message here ?

Thanks. :)


> +			kfree(name);
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpihp_register_slot);

--=20
Best Regards,
Tang chen
