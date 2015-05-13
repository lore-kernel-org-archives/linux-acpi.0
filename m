From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC v2 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Date: Wed, 13 May 2015 13:36:08 +0800
Message-ID: <5552E2C8.70307@linux.intel.com>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com> <5550B056.2080608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39794 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbbEMFgN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 May 2015 01:36:13 -0400
In-Reply-To: <5550B056.2080608@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Yijing Wang <wangyijing@huawei.com>, Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org

On 2015/5/11 21:36, Hanjun Guo wrote:
> Hi Jiang,
>=20
> I have comments inline.
>=20
> On 2015=E5=B9=B405=E6=9C=8805=E6=97=A5 10:46, Jiang Liu wrote:
>> Introduce common interface acpi_pci_root_create() and related data
>> structures to create PCI root bus for ACPI PCI host bridges. It will
>> be used to kill duplicated arch specific code for IA64 and x86. It m=
ay
>> also help ARM64 in future.
>>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>> +                     struct acpi_pci_root_ops *ops,
>> +                     size_t extra_size)
>> +{
>> +    int ret, busnum =3D root->secondary.start;
>> +    struct acpi_device *device =3D root->device;
>> +    struct acpi_pci_root_info_common *info;
>> +    struct pci_bus *bus;
>> +
>> +    info =3D kzalloc(sizeof(*info) + extra_size, GFP_KERNEL);
>=20
> For x86, the memory is allocated on its local numa node if memory
> is available by using kzalloc_node(), and if
> node =3D acpi_get_node(device->handle) is NUMA_NO_NODE, the code will
> get the numa node info by using x86_pci_root_bus_node() (which you
> consolidate them as a function pci_acpi_root_get_node() in later
> patch).
>=20
> but the code here just ignore that information, so the code
> here has functional change for x86 code since you didn't use numa
> information.
>=20
> I'm not sure how frequently used for the info after init, so
> not sure about the performance impact, but I think we should
> keep consistence with the code behavior as before.
Hi Hanjun,
	Good catch, will change code to respect NUMA node
info when allocating memory.

>=20
> Further more, there is a implicit cast for
> struct acpi_pci_root_info_common *info to arch specific
> struct pci_root_info *info by using extra size, it's not
> easy to understand (at least for me :) ), so how about
> alloc the memory in arch specific function, and pass
> struct acpi_pci_root_info_common *info fr this function?
Good suggestion.
Thanks!
Gerry

> other than that, this code is pretty good, I reworked ARM64
> ACPI based PCI host bridge init code, and this patch simplified
> the coed a lot, will have a test tomorrow and let you know
> the result.
>=20
> Thanks
> Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
