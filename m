From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/3] ACPI,PCI: Notify acpi_pci_drivers when hot-plugging
 PCI root bridges
Date: Wed, 21 Mar 2012 10:04:49 -0700
Message-ID: <CAE9FiQXRg=pBpAJ=+wfqRZysTBLPtATmAsHfdfswyhx1OKW2Yg@mail.gmail.com>
References: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
	<1332346957-10070-3-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45886 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2CUREu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Mar 2012 13:04:50 -0400
In-Reply-To: <1332346957-10070-3-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, chenkeping@huawei.com, Jiang Liu <jiang.liu@huawei.com>

On Wed, Mar 21, 2012 at 9:22 AM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Jiang Liu <liuj97@gmail.com>
>
> When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
> methods should be invoked to notify registered drivers.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> =A0drivers/acpi/pci_root.c | =A0 10 ++++++++++
> =A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c2d2b7b..ff73357 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -445,6 +445,7 @@ static int __devinit acpi_pci_root_add(struct acp=
i_device *device)
> =A0 =A0 =A0 =A0acpi_status status;
> =A0 =A0 =A0 =A0int result;
> =A0 =A0 =A0 =A0struct acpi_pci_root *root;
> + =A0 =A0 =A0 struct acpi_pci_driver *driver;
> =A0 =A0 =A0 =A0acpi_handle handle;
> =A0 =A0 =A0 =A0struct acpi_device *child;
> =A0 =A0 =A0 =A0u32 flags, base_flags;
> @@ -612,6 +613,10 @@ static int __devinit acpi_pci_root_add(struct ac=
pi_device *device)
> =A0 =A0 =A0 =A0if (device->wakeup.flags.run_wake)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_set_run_wake(root->bus->bridge,=
 true);
>
> + =A0 =A0 =A0 list_for_each_entry(driver, &acpi_pci_drivers, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (driver->add)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver->add(device->han=
dle);
> +
> =A0 =A0 =A0 =A0return 0;

if those calling is with acpi_pci_root_start() instead of acpi_pci_root=
_add()

Do you still need patches 3?

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
