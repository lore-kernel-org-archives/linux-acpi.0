From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 10:30:26 -0600
Message-ID: <CAErSpo4LWWFrvRxtm8juQcxnaq8+citS4=1PV0edhLhzm=5yKw@mail.gmail.com>
References: <20110923165946.27079.95660.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110923165946.27079.95660.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 23, 2011 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
> If we're not using _CRS, the host bridge's bus name and resource stru=
ctures
> were allocated but never freed. =A0This patch fixes that.
>
> Patch by Catalin Marinas <catalin.marinas@arm.com>
>
> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> Reported-by: Simon Kirby <sim@hostway.ca>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0arch/x86/pci/acpi.c | =A0 10 +++++-----
> =A01 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index c953302..6fdc90f 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -228,9 +228,6 @@ static void add_resources(struct pci_root_info *i=
nfo)
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0struct resource *res, *root, *conflict;
>
> - =A0 =A0 =A0 if (!pci_use_crs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_MEM);
> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_IO);
>
> @@ -285,8 +282,11 @@ get_current_resources(struct acpi_device *device=
, int busnum,
> =A0 =A0 =A0 =A0acpi_walk_resources(device->handle, METHOD_NAME__CRS, =
setup_resource,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&info)=
;
>
> - =A0 =A0 =A0 add_resources(&info);
> - =A0 =A0 =A0 return;
> + =A0 =A0 =A0 if (pci_use_crs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_resources(&info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(info.name);
>
> =A0name_alloc_fail:
> =A0 =A0 =A0 =A0kfree(info.res);
>
>

Jesse, can you pick this up, or would you prefer it go via a different =
tree?

Bjorn
