From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / PM: Remove unnecessary error variable from acpi_dev_run_wake()
Date: Wed, 28 Sep 2011 13:27:58 -0600
Message-ID: <CAErSpo4CpEWaKkh280Kb_nNSVWfYKGZ06HQOrpLar=T40TyDZQ@mail.gmail.com>
References: <201109280001.28857.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201109280001.28857.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 27, 2011 at 4:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The error variable in acpi_dev_run_wake() is not really used, so
> remove it.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/pci/pci-acpi.c | =A0 =A03 +--
> =A01 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: linux/drivers/pci/pci-acpi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/pci/pci-acpi.c
> +++ linux/drivers/pci/pci-acpi.c
> @@ -282,7 +282,6 @@ static int acpi_dev_run_wake(struct devi
> =A0{
> =A0 =A0 =A0 =A0struct acpi_device *dev;
> =A0 =A0 =A0 =A0acpi_handle handle;
> - =A0 =A0 =A0 int error =3D -ENODEV;
>
> =A0 =A0 =A0 =A0if (!device_run_wake(phys_dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -302,7 +301,7 @@ static int acpi_dev_run_wake(struct devi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_disable_wakeup_device_power(dev);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static void acpi_pci_propagate_run_wake(struct pci_bus *bus, bool =
enable)

This looks like the right thing to do, but the current changelog
suggests that we're just removing unused code.

But in fact, we'll now return 0 (success) when we used to return
-ENODEV, so the behavior of the callers will change (probably fixing
some bugs).  Do you want to mention that in the changelog as well?

I'm assuming this is for the 3.2 merge window, since it doesn't look
like a regression fix.

Bjorn
