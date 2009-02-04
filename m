From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Wed, 4 Feb 2009 12:12:56 -0800
Message-ID: <86802c440902041212q51f2a444l84e1ac29ee6f702e@mail.gmail.com>
References: <1233765552.16414.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1233765552.16414.6.camel@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 4, 2009 at 8:39 AM, Ed Swierk <eswierk@aristanetworks.com> wrote:
> Detect and enable memory-mapped PCI configuration space on the nVidia
> MCP55 southbridge even if the ACPI MCFG table is missing or wrong.
>
> Signed-off-by: Ed Swierk <eswierk@aristanetworks.com>
>
> ---
> Index: linux-2.6.27.4/arch/x86/pci/mmconfig-shared.c
> ===================================================================
> --- linux-2.6.27.4.orig/arch/x86/pci/mmconfig-shared.c
> +++ linux-2.6.27.4/arch/x86/pci/mmconfig-shared.c
> @@ -155,6 +155,26 @@ static const char __init *pci_mmcfg_amd_
>        return "AMD Family 10h NB";
>  }
>
> +static const char __init *pci_mmcfg_nvidia_mcp55(void)
> +{
> +       u32 extcfg;
> +
> +       raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), 0x90, 4, &extcfg);
> +
> +       if (!(extcfg & 0x80000000))
> +               return NULL;
> +       pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
> +       if (!pci_mmcfg_config)
> +               return NULL;
> +       pci_mmcfg_config[0].address = (extcfg & 0x00007fff) << 25;
> +       pci_mmcfg_config[0].pci_segment = 0;
> +       pci_mmcfg_config[0].start_bus_number = 0;
> +       pci_mmcfg_config[0].end_bus_number = (1 << (8 - ((extcfg >> 28) & 3))) - 1;
> +       pci_mmcfg_config_num = 1;
> +
> +       return "nVidia MCP55";
> +}
> +
>  struct pci_mmcfg_hostbridge_probe {
>        u32 bus;
>        u32 devfn;
> @@ -172,6 +192,8 @@ static struct pci_mmcfg_hostbridge_probe
>          0x1200, pci_mmcfg_amd_fam10h },
>        { 0xff, PCI_DEVFN(0, 0), PCI_VENDOR_ID_AMD,
>          0x1200, pci_mmcfg_amd_fam10h },
> +       { 0, PCI_DEVFN(0, 0), PCI_VENDOR_ID_NVIDIA,
> +         0x0369, pci_mmcfg_nvidia_mcp55 },

may break amd family 10h + mcp55 system. because some system have
setting in AMD cpu and mcp55
it will find setting in CPU nb, and your code will partially overwrite
those setting.

YH
