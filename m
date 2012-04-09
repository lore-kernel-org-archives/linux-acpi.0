From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH V2 6/6] PCI, ACPI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Date: Mon, 9 Apr 2012 11:00:50 -0700
Message-ID: <CAE9FiQWtA+PBsEgd3zakzvdNUgmVR42_yHK0DrM3Tn20jDU0Fg@mail.gmail.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
	<1333988568-11282-7-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35350 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2DISAv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2012 14:00:51 -0400
In-Reply-To: <1333988568-11282-7-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Apr 9, 2012 at 9:22 AM, Jiang Liu <liuj97@gmail.com> wrote:
> This patch enhances pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges on x86 platforms.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> =A0arch/x86/pci/acpi.c =A0 =A0 =A0| =A0 66 ++++++++++++++++++++++++++=
++++++++++++++++++++
> =A0drivers/acpi/pci_root.c =A0| =A0 20 ++++++++++++++
> =A0include/acpi/acnames.h =A0 | =A0 =A01 +
> =A0include/linux/pci-acpi.h | =A0 =A02 +
> =A04 files changed, 89 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index da0149d..e38d9b7 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -488,6 +488,72 @@ struct pci_bus * __devinit pci_acpi_scan_root(st=
ruct acpi_pci_root *root)
> =A0 =A0 =A0 =A0return bus;
> =A0}
>
> +int arch_acpi_pci_root_add(struct acpi_pci_root *root)
> +{
> + =A0 =A0 =A0 int result =3D 0;
> + =A0 =A0 =A0 acpi_status status;
> + =A0 =A0 =A0 unsigned long long base_addr;
> + =A0 =A0 =A0 struct pci_mmcfg_region *cfg;
> +
> + =A0 =A0 =A0 /* MMCONFIG disabled */
> + =A0 =A0 =A0 if ((pci_probe & PCI_PROBE_MMCONF) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

should be

if (!!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
       return 0;

> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Try to insert MMCFG information for host bridges w=
ith _CBA method
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 status =3D acpi_evaluate_integer(root->device->handle, =
METHOD_NAME__CBA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0NULL, &base_addr);
> + =A0 =A0 =A0 if (ACPI_SUCCESS(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D pci_mmconfig_insert(root->se=
gment,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0root->secondary.start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0root->secondary.end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0base_addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* MMCFG information for hot-pluggabl=
e host bridges may have
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* already been added by __pci_mmcfg_=
init();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result =3D=3D -EEXIST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D 0;
> + =A0 =A0 =A0 } else if (status =3D=3D AE_NOT_FOUND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check whether MMCFG information ha=
s been added for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* host bridges without _CBA method.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_lock();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg =3D pci_mmconfig_lookup(root->segme=
nt, root->secondary.start);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cfg || cfg->end_bus < root->second=
ary.end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENODEV;
> +
> + =A0 =A0 =A0 return result;
> +}
> +
> +int arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> + =A0 =A0 =A0 acpi_status status;
> + =A0 =A0 =A0 unsigned long long base_addr;
> +
> + =A0 =A0 =A0 /* MMCONFIG disabled */
> + =A0 =A0 =A0 if ((pci_probe & PCI_PROBE_MMCONF) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;

again should be

if (!!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
       return 0;



> +
> + =A0 =A0 =A0 /* Remove MMCFG information for host bridges with _CBA =
method */
> + =A0 =A0 =A0 status =3D acpi_evaluate_integer(root->device->handle, =
METHOD_NAME__CBA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0NULL, &base_addr);
> + =A0 =A0 =A0 if (ACPI_SUCCESS(status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_mmconfig_delete(root->segmen=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0root->secondary.start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0root->secondary.end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0base_addr);
> + =A0 =A0 =A0 else if (status !=3D AE_NOT_FOUND)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0int __init pci_acpi_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct pci_dev *dev =3D NULL;
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4a7d575..a62bfa8 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -448,6 +448,16 @@ out:
> =A0}
> =A0EXPORT_SYMBOL(acpi_pci_osc_control_set);
>
> +int __weak arch_acpi_pci_root_add(struct acpi_pci_root *root)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int __weak arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static int __devinit acpi_pci_root_add(struct acpi_device *device)
> =A0{
> =A0 =A0 =A0 =A0unsigned long long segment, bus;
> @@ -504,6 +514,14 @@ static int __devinit acpi_pci_root_add(struct ac=
pi_device *device)
> =A0 =A0 =A0 =A0strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS)=
;
> =A0 =A0 =A0 =A0device->driver_data =3D root;
>
> + =A0 =A0 =A0 if (arch_acpi_pci_root_add(root)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR PREFIX
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can't add MMCFG inform=
ation for Bus %04x:%02x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root->segment, (unsigne=
d int)root->secondary.start);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * All supported architectures that use ACPI have supp=
ort for
> =A0 =A0 =A0 =A0 * PCI domains, so we indicate this in _OSC support ca=
pabilities.
> @@ -629,6 +647,7 @@ out_del_root:
> =A0 =A0 =A0 =A0list_del_rcu(&root->node);
> =A0 =A0 =A0 =A0mutex_unlock(&acpi_pci_root_lock);
> =A0 =A0 =A0 =A0synchronize_rcu();
> + =A0 =A0 =A0 arch_acpi_pci_root_remove(root);
> =A0out_free:
> =A0 =A0 =A0 =A0kfree(root);
> =A0 =A0 =A0 =A0return result;
> @@ -679,6 +698,7 @@ out:
> =A0 =A0 =A0 =A0list_del_rcu(&root->node);
> =A0 =A0 =A0 =A0mutex_unlock(&acpi_pci_root_lock);
> =A0 =A0 =A0 =A0synchronize_rcu();
> + =A0 =A0 =A0 arch_acpi_pci_root_remove(root);
> =A0 =A0 =A0 =A0kfree(root);
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 38f5088..99bda75 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -62,6 +62,7 @@
> =A0#define METHOD_NAME__AEI =A0 =A0 =A0 =A0"_AEI"
> =A0#define METHOD_NAME__PRW =A0 =A0 =A0 =A0"_PRW"
> =A0#define METHOD_NAME__SRS =A0 =A0 =A0 =A0"_SRS"
> +#define METHOD_NAME__CBA =A0 =A0 =A0 "_CBA"
>
> =A0/* Method names - these methods must appear at the namespace root =
*/
>
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index ac93634..6e8dd10 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -37,6 +37,8 @@ static inline acpi_handle acpi_pci_get_bridge_handl=
e(struct pci_bus *pbus)
> =A0}
>
> =A0void acpi_pci_root_rescan(void);
> +int arch_acpi_pci_root_add(struct acpi_pci_root *root);
> +int arch_acpi_pci_root_remove(struct acpi_pci_root *root);
>
> =A0#else
>
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
