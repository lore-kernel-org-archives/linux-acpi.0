From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 21/37] PCI, ACPI: Make acpi_pci_root_remove remove pci
 root bus too
Date: Mon, 12 Mar 2012 21:11:55 -0600
Message-ID: <CAErSpo4j31natwy0uFO=DL6Wn+w7fgE4k83o_mKb8KePO0FLDA@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-22-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331362837-10740-22-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> It will call new added pci_stop_and_remove_bus() to stop/remove pci r=
oot bus.
>
> Also checking if that pci_root_bus get removed already in bus remove =
in /sys
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/pci_root.c | =A0 14 ++++++++++++++
> =A01 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 7aff631..b38e347 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -643,10 +643,24 @@ static int acpi_pci_root_remove(struct acpi_dev=
ice *device, int type)
> =A0{
> =A0 =A0 =A0 =A0struct acpi_pci_root *root =3D acpi_driver_data(device=
);
>
> + =A0 =A0 =A0 /* that root bus could be removed already */
> + =A0 =A0 =A0 if (!pci_find_bus(root->segment, root->secondary.start)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &device->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "freeing acpi_pci_root, but pci roo=
t bus was removed before");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;

I don't think we should handle the root bus separately from the host
bridge, as I mentioned before.  If we handle them together, checks
like this won't be needed.

> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0device_set_run_wake(root->bus->bridge, false);
> =A0 =A0 =A0 =A0pci_acpi_remove_bus_pm_notifier(device);
>
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &device->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "freeing acpi_pci_root, will remove pci=
 root bus at first");
> + =A0 =A0 =A0 pci_stop_and_remove_bus(root->bus);
> +
> +out:
> + =A0 =A0 =A0 list_del(&root->node);
> =A0 =A0 =A0 =A0kfree(root);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.7
>
