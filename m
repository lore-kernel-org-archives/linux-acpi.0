From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Mon, 09 Feb 2009 11:42:20 -0800
Message-ID: <4990871C.60605@kernel.org>
References: <1233765552.16414.6.camel@localhost.localdomain>	 <20090204170440.GA31973@elte.hu> <1234207599.16237.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1234207599.16237.6.camel@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Ed Swierk wrote:
> Detect and enable memory-mapped PCI configuration space on the nVidia
> MCP55 southbridge.  Tested against 2.6.27.4 on an Arista Networks
> development board with one MCP55, Coreboot firmware, no ACPI.
> 
> Signed-off-by: Ed Swierk <eswierk@aristanetworks.com>
> 
> ---
> 
> I've tried to incorporate the code style feedback from Ingo.  I'm not
> sure whether this correctly handles boards with more than one MCP55, or
> with an AMD 10h--Yinghai?
> 
> Index: linux-2.6.27.4/arch/x86/pci/mmconfig-shared.c
> ===================================================================
> --- linux-2.6.27.4.orig/arch/x86/pci/mmconfig-shared.c
> +++ linux-2.6.27.4/arch/x86/pci/mmconfig-shared.c
> @@ -166,6 +166,36 @@ static const char __init *pci_mmcfg_amd_
>  	return "AMD Family 10h NB";
>  }
>  
> +static const char __init *pci_mmcfg_nvidia_mcp55(void)
> +{
> +	u32 extcfg;
> +	u64 base;
> +	int end;
> +	static const u32 extcfg_regnum =      0x90;
> +	static const u32 extcfg_regsize =     4;
> +	static const u32 extcfg_enable_mask = 0x80000000;
> +	static const u32 extcfg_end_mask =    0x30000000;
> +	static const int extcfg_end_shift =   28;
> +	static const int extcfg_endbus[] =    { 255, 127, 63, 31 };
> +	static const u32 extcfg_base_mask =   0x00007fff;
> +	static const int extcfg_base_lshift = 25;
> +
> +	raw_pci_ops->read(0, 0, PCI_DEVFN(0, 0), extcfg_regnum, extcfg_regsize,
> +			  &extcfg);
1. mcp55 could one bus1
2. io55 could be on 0x40, 0x80, 0xc0

so it seems we could loop all 0-255 to find those HT in one function and add them one by one.

YH
> +
> +	if (!(extcfg & extcfg_enable_mask))
> +		return NULL;
> +
> +	if (extend_mmcfg(1) == -1)
> +		return NULL;
> +
> +	base = (extcfg & extcfg_base_mask) << extcfg_base_lshift;
> +	end = (extcfg & extcfg_end_mask) >> extcfg_end_shift;
> +	fill_one_mmcfg(base, 0, 0, extcfg_endbus[end]);
> +
> +	return "nVidia MCP55";
> +}
> +
>  struct pci_mmcfg_hostbridge_probe {
>  	u32 bus;
>  	u32 devfn;
> @@ -183,6 +213,8 @@ static struct pci_mmcfg_hostbridge_probe
>  	  0x1200, pci_mmcfg_amd_fam10h },
>  	{ 0xff, PCI_DEVFN(0, 0), PCI_VENDOR_ID_AMD,
>  	  0x1200, pci_mmcfg_amd_fam10h },
> +	{ 0, PCI_DEVFN(0, 0), PCI_VENDOR_ID_NVIDIA,
> +	  0x0369, pci_mmcfg_nvidia_mcp55 },
>  };
>  
>  static int __init pci_mmcfg_check_hostbridge(void)
> 
