From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 5/7] x86/PCI: print resources consistently with %pRt
Date: Wed, 7 Oct 2009 11:43:09 -0700
Message-ID: <86802c440910071143y7ba8b0f8y9efff738eba9d30b@mail.gmail.com>
References: <20091006213259.4272.68068.stgit@bob.kio>
	 <20091006213349.4272.65914.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091006213349.4272.65914.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 6, 2009 at 2:33 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> wr=
ote:
> This uses %pRt to print additional resource information (type, size,
> prefetchability, etc.) consistently.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
> =A0arch/x86/pci/acpi.c | =A0 14 +++++++++++---
> =A0arch/x86/pci/i386.c | =A0 12 +++++-------
> =A02 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 2297280..4d4f1df 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -7,6 +7,7 @@
> =A0#include <asm/pci_x86.h>
>
> =A0struct pci_root_info {
> + =A0 =A0 =A0 struct acpi_device *bridge;
> =A0 =A0 =A0 =A0char *name;
> =A0 =A0 =A0 =A0unsigned int res_num;
> =A0 =A0 =A0 =A0struct resource *res;
> @@ -107,12 +108,18 @@ setup_resource(struct acpi_resource *acpi_res, =
void *data)
> =A0 =A0 =A0 =A0res->child =3D NULL;
>
> =A0 =A0 =A0 =A0if (insert_resource(root, res)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PCI: Failed to allocat=
e 0x%lx-0x%lx "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "from %s for %s\n", (un=
signed long) res->start,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long) res->en=
d, root->name, info->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&info->bridge->dev, "can't allo=
cate %pRt\n", res);

better to keep that root name ?

YH
